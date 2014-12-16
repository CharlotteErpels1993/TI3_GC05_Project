import UIKit
import Foundation

class VakantiesTableViewController: UITableViewController, UISearchBarDelegate, UISearchDisplayDelegate {
    var vakanties: [Vakantie] = []
    var vakanties2: [Vakantie] = []
    var redColor: UIColor = UIColor(red: CGFloat(232/255.0), green: CGFloat(33/255.0), blue: CGFloat(35/255.0), alpha: CGFloat(1.0))
    var isFavoriet: Bool = false
    var feedbackScores: [Double] = []
    
    @IBOutlet weak var zoekbar: UISearchBar!
    
    @IBAction func toggle(sender: AnyObject) {
        searchBarCancelButtonClicked(zoekbar)
        toggleSideMenuView()
    }
    
    @IBAction func gaTerugNaarOverzichtVakanties(segue: UIStoryboardSegue) {}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNeedsStatusBarAppearanceUpdate()
        self.navigationController!.toolbarHidden = true
        
        if PFUser.currentUser() != nil {
            self.navigationItem.setHidesBackButton(true, animated: true)
            self.navigationItem.rightBarButtonItem = nil
        }
        
        if Reachability.isConnectedToNetwork() == false {
            var alert = UIAlertController(title: "Oeps..", message: "Je hebt geen internet verbinding. Ga naar instellingen om dit aan te passen.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default, handler: { action in
                exit(0)
            }))
            alert.addAction(UIAlertAction(title: "Ga naar instellingen", style: .Default, handler: { action in
                switch action.style{
                default:
                    UIApplication.sharedApplication().openURL(NSURL(string:UIApplicationOpenSettingsURLString)!);
                }
                
            }))
            presentViewController(alert, animated: true, completion: nil)
        }
        
        if isFavoriet == true && PFUser.currentUser() != nil {
            self.navigationItem.title = "Favorieten"
            self.vakanties = LocalDatastore.getLocalObjects("Favoriet") as [Vakantie]
            
            foutBoxOproepen("Oeps...", "Er zijn geen vakanties geselecteerd als favorieten. Ga naar vakanties en selecteer een vakantie als favoriet door middel van op het hartje te klikken.", self)
        } else {
            self.navigationItem.title = "Vakanties"
            self.vakanties = LocalDatastore.getLocalObjects("Vakantie") as [Vakantie]
            
            if vakanties.count == 0 && Reachability.isConnectedToNetwork() == false {
                foutBoxOproepen("Oeps...", "Er zijn geen vakanties gevonden. Verbind met het internet om de nieuwste vakanties te bekijken.", self)
            } else if vakanties.count == 0 {
                foutBoxOproepen("Oeps...", "Sorry, er zijn momenteel geen vakanties in onze databank.", self)
            }
        }
        
        self.vakanties2 = vakanties
        self.tableView.reloadData()

        self.vakanties2.sort({ $0.minLeeftijd < $1.minLeeftijd })
        self.vakanties.sort({ $0.minLeeftijd < $1.minLeeftijd})
    
        hideSideMenuView()
        zoekbar.showsScopeBar = true
        zoekbar.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        self.setNeedsStatusBarAppearanceUpdate()
        self.navigationController!.toolbarHidden = true
        self.tableView.reloadData()
    }
    
    func gemiddeldeFeedback(vakantie: Vakantie) -> Double {
        var feedbackScores: [Int] = []
        var sum = 0
        
        var arrayFeedback = LocalDatastore.getLocalObjectsWithColumnConstraints("Feedback", queryConstraints: ["vakantie": vakantie.id]) as [Feedback]
        
        for feedback in arrayFeedback {
            feedbackScores.append(feedback.score!)
        }
        
        for feedbackScore in feedbackScores {
            sum += feedbackScore
        }
        
        var gemiddelde: Double = Double(sum) / Double(feedbackScores.count)
        return ceil(gemiddelde)
    }
    
    func zetAantalSterrenGemiddeldeFeedback(vakantie: Vakantie, ster1: UIImageView, ster2: UIImageView, ster3: UIImageView, ster4: UIImageView, ster5: UIImageView) {
        var gemiddeldeFeedbackScore: Double = gemiddeldeFeedback(vakantie)
        var starGevuld: UIImage = UIImage(named: "star")!
        var starLeeg: UIImage = UIImage(named: "star2")!
        
        if gemiddeldeFeedbackScore == 0 {
            ster1.image = starLeeg
            ster2.image = starLeeg
            ster3.image = starLeeg
            ster4.image = starLeeg
            ster5.image = starLeeg
        } else if gemiddeldeFeedbackScore == 1 {
            ster1.image = starGevuld
            ster2.image = starLeeg
            ster3.image = starLeeg
            ster4.image = starLeeg
            ster5.image = starLeeg
        } else if gemiddeldeFeedbackScore == 2 {
            ster1.image = starGevuld
            ster2.image = starGevuld
            ster3.image = starLeeg
            ster4.image = starLeeg
            ster5.image = starLeeg
        } else if gemiddeldeFeedbackScore == 3 {
            ster1.image = starGevuld
            ster2.image = starGevuld
            ster3.image = starGevuld
            ster4.image = starLeeg
            ster5.image = starLeeg
        } else if gemiddeldeFeedbackScore == 4 {
            ster1.image = starGevuld
            ster2.image = starGevuld
            ster3.image = starGevuld
            ster4.image = starGevuld
            ster5.image = starLeeg
        } else if gemiddeldeFeedbackScore == 5 {
            ster1.image = starGevuld
            ster2.image = starGevuld
            ster3.image = starGevuld
            ster4.image = starGevuld
            ster5.image = starGevuld
        }
        
        feedbackScores.append(gemiddeldeFeedbackScore)
    }
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        hideSideMenuView()
        setTitleCancelButton(searchBar)
        zoekGefilterdeVakanties(searchBar.text)
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchBar.text = ""
        zoekGefilterdeVakanties(searchBar.text)
        searchBar.showsCancelButton = false
        searchBar.resignFirstResponder()
    }
    
    func setTitleCancelButton(searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
        var cancelButton: UIButton?
        var topView: UIView = searchBar.subviews[0] as UIView
        for subView in topView.subviews {
            cancelButton = subView as? UIButton
        }
        
        cancelButton?.setTitle("Annuleer", forState: UIControlState.Normal)
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        hideSideMenuView()
        searchBar.showsCancelButton = true
        setTitleCancelButton(searchBar)
        zoekGefilterdeVakanties(searchText.lowercaseString)
    }
    
    func zoekGefilterdeVakanties(zoek: String) {
        vakanties2 = vakanties.filter { $0.titel!.lowercaseString.rangeOfString(zoek) != nil }
        if zoek.isEmpty {
            self.vakanties2 = vakanties
        }
        self.tableView.reloadData()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toonVakantie" {
            let vakantieDetailsController = segue.destinationViewController as VakantieDetailsTableViewController
            let selectedVakantie = vakanties[tableView.indexPathForSelectedRow()!.row]
            vakantieDetailsController.vakantie = selectedVakantie as Vakantie
            vakantieDetailsController.feedbackScore = self.feedbackScores[tableView.indexPathForSelectedRow()!.row]
            vakantieDetailsController.hidesBottomBarWhenPushed = true
        } else if segue.identifier == "inloggen" {
            let inloggenViewController = segue.destinationViewController as InloggenViewController
        }
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vakanties2.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("vakantieCell", forIndexPath: indexPath) as VakantieCell
        let vakantie = vakanties2[indexPath.row]
        
        //Local Datastore
        var image = LocalDatastore.getAfbeelding(vakantie.id)
        
        //WERKEND
        //var image = ParseData.getAfbeeldingMetVakantieId(vakantie.id)
        cell.afbeelding.image = image
        cell.locatieLabel.text = vakantie.locatie
        cell.doelgroepLabel.layer.borderColor = self.redColor.CGColor
        cell.doelgroepLabel.layer.borderWidth = 1.0
        cell.doelgroepLabel.layer.cornerRadius = 5.0
        cell.vakantieNaamLabel.text = vakantie.titel
        cell.doelgroepLabel.text! = " \(vakantie.minLeeftijd!) - \(vakantie.maxLeeftijd!) jaar "
        zetAantalSterrenGemiddeldeFeedback(vakantie, ster1: cell.ster1, ster2: cell.ster2, ster3: cell.ster3, ster4: cell.ster4, ster5: cell.ster5)
        return cell
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if isFavoriet == true {
            if editingStyle == UITableViewCellEditingStyle.Delete {
                vakanties2.removeAtIndex(indexPath.row)
                tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
                
                //Parse Local Datastore
                var favorieteVakantie: Favoriet = Favoriet(id: "test")
                var user = PFUser.currentUser()
                var soort = user["soort"] as? String
                
                if soort == "ouder" {
                    favorieteVakantie.vakantie = vakanties[indexPath.row]
                    var ouder = LocalDatastore.getGebruikerWithEmail(PFUser.currentUser().email, tableName: "Ouder")
                    favorieteVakantie.gebruiker = ouder
                } else if soort == "monitor" {
                    favorieteVakantie.vakantie = vakanties[indexPath.row]
                    var monitor = LocalDatastore.getGebruikerWithEmail(PFUser.currentUser().email, tableName: "Monitor")
                    favorieteVakantie.gebruiker = monitor
                }
                LocalDatastore.deleteFavorieteVakantie(favorieteVakantie)
            }
        }
    }
    
    override func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        if isFavoriet == true {
            return .Delete
        } else {
            return .None
        }
    }
    
    @IBAction func refresh(sender: UIRefreshControl) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        LocalDatastore.getTableReady("Vakantie")
        LocalDatastore.getTableReady("Afbeelding")
        LocalDatastore.getTableReady("Feedback")
        LocalDatastore.getTableReady("Ouder")
        LocalDatastore.getTableReady("Favoriet")
        
        self.refreshControl?.endRefreshing()
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        viewDidLoad()
    }
}