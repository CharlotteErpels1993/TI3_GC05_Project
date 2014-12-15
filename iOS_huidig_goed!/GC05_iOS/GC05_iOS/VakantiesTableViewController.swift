import UIKit
import Foundation

class VakantiesTableViewController: UITableViewController, UISearchBarDelegate, UISearchDisplayDelegate {
    
    var vakanties: [Vakantie] = []
    var vakanties2: [Vakantie] = []
    var redColor: UIColor = UIColor(red: CGFloat(232/255.0), green: CGFloat(33/255.0), blue: CGFloat(35/255.0), alpha: CGFloat(1.0))
    var favoriet: Bool = false
    var score: [Double] = []
    
    @IBOutlet weak var zoekbar: UISearchBar!
    
    @IBAction func toggle(sender: AnyObject) {
        toggleSideMenuView()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNeedsStatusBarAppearanceUpdate()
        self.navigationController!.toolbarHidden = true
        checkConnectie()
        ParseData.deleteFavorietTable()
        ParseData.vulFavorietTableOp()
        ParseData.deleteFeedbackTable()
        ParseData.vulFeedbackTableOp()
        
        var responseVakanties: ([Vakantie], Int?)
        if PFUser.currentUser() != nil {
            var ouderResponse = ParseData.getOuderWithEmail(PFUser.currentUser().email)
            var monitorResponse = ParseData.getMonitorWithEmail(PFUser.currentUser().email)
            if ouderResponse.1 == nil {
                if favoriet == false {
                    responseVakanties = ParseData.getAlleVakanties()
                } else  {
                    responseVakanties = ParseData.getFavorieteVakanties(ouderResponse.0)
                    self.navigationItem.title = "Favorieten"
                }
            } else if monitorResponse.1 == nil {
                if favoriet == false {
                    responseVakanties = ParseData.getAlleVakanties()
                } else  {
                    responseVakanties = ParseData.getFavorieteVakanties(monitorResponse.0)
                    self.navigationItem.title = "Favorieten"
                }
            } else {
                responseVakanties = ParseData.getAlleVakanties()
                self.navigationItem.title = "Vakanties"
            }
        } else {
            responseVakanties = ParseData.getAlleVakanties()
            self.navigationItem.title = "Vakanties"
        }
        
        if responseVakanties.1 == nil {
            self.vakanties = responseVakanties.0
            self.vakanties2 = self.vakanties
            self.tableView.reloadData()
        } else {
            foutBoxOproepen("Oeps", "Er zijn geen vakanties als favoriet geselecteerd.", self)
            vakanties2 = []
            vakanties = []
            self.tableView.reloadData()
        }
    
        self.vakanties2.sort({ (String($0.minLeeftijd)) < $1.titel})
        self.vakanties.sort({ (String($0.minLeeftijd)) < $1.titel})
    
        hideSideMenuView()
        zoekbar.showsScopeBar = true
        zoekbar.delegate = self
        
        if PFUser.currentUser() != nil {
            self.navigationItem.setHidesBackButton(true, animated: true)
            self.navigationItem.rightBarButtonItem = nil   
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        self.setNeedsStatusBarAppearanceUpdate()
        self.navigationController!.toolbarHidden = true
        refresh(self.refreshControl!)
        self.tableView.reloadData()
    }
    
    func gemiddeldeFeedback(vakantie: Vakantie) -> Double {
        var feedbackResponse = ParseData.getFeedbackFromVakantie(vakantie)
        var scores: [Int] = []
        var sum = 0
        
        if feedbackResponse.1 == nil {
            for feed in feedbackResponse.0 {
                scores.append(feed.score!)
            }
        }
        
        for score in scores {
            sum += score
        }
        
        var gemiddelde: Double = Double(sum) / Double(scores.count)
        return ceil(gemiddelde)
    }
    
    func zetAantalSterrenGemiddeldeFeedback(vakantie: Vakantie, ster1: UIImageView, ster2: UIImageView, ster3: UIImageView, ster4: UIImageView, ster5: UIImageView) {
        var gemiddeldeFeedbackScore: Double = gemiddeldeFeedback(vakantie)
        var starGevuld: UIImage = UIImage(named: "star")!
        var starLeeg: UIImage = UIImage(named: "star2")!
        
        if gemiddeldeFeedbackScore == 1 {
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
        
        score.append(gemiddeldeFeedbackScore)
    }
    
    func checkConnectie() {
        if !(Reachability.isConnectedToNetwork()) {
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
    }
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
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
    
    @IBAction func gaTerugNaarOverzichtVakanties(segue: UIStoryboardSegue) {
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toonVakantie" {
            let vakantieDetailsController = segue.destinationViewController as VakantieDetailsTableViewController
            let selectedVakantie = vakanties[tableView.indexPathForSelectedRow()!.row]
            vakantieDetailsController.vakantie = selectedVakantie as Vakantie
            vakantieDetailsController.score = self.score[tableView.indexPathForSelectedRow()!.row]
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
        var image = ParseData.getAfbeeldingMetVakantieId(vakantie.id)
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
        if favoriet == true {
            if editingStyle == UITableViewCellEditingStyle.Delete {
                vakanties2.removeAtIndex(indexPath.row)
                tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
                var ouderResponse = ParseData.getOuderWithEmail(PFUser.currentUser().email)
                var monitorResponse = ParseData.getOuderWithEmail(PFUser.currentUser().email)
                var favorieteVakantie: Favoriet = Favoriet(id: "test")
                if ouderResponse.1 == nil {
                    favorieteVakantie.vakantie = vakanties[indexPath.row]
                    favorieteVakantie.gebruiker = ouderResponse.0
                } else if monitorResponse.1 == nil {
                    favorieteVakantie.vakantie = vakanties[indexPath.row]
                    favorieteVakantie.gebruiker = monitorResponse.0
                }
                ParseData.deleteFavorieteVakantie(favorieteVakantie)
            }
        }
    }
    
    override func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        if favoriet == true {
            return .Delete
        } else {
            return .None
        }
    }
    
    @IBAction func refresh(sender: UIRefreshControl) {
        var parseData = ParseData()
        ParseData.deleteAllTables()
        ParseData.createDatabase()
        self.refreshControl?.endRefreshing()
        viewDidLoad()
    }
}