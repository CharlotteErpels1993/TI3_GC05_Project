import UIKit
import Foundation

class VakantiesTableViewController: UITableViewController, UISearchBarDelegate, UISearchDisplayDelegate {
    
    var vakanties: [Vakantie] = []
    var vakanties2: [Vakantie] = []
    var redColor: UIColor = UIColor(red: CGFloat(232/255.0), green: CGFloat(33/255.0), blue: CGFloat(35/255.0), alpha: CGFloat(1.0))
    var favoriet: Bool = false
    
    @IBOutlet weak var zoekbar: UISearchBar!
    
    @IBAction func toggle(sender: AnyObject) {
        toggleSideMenuView()
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        //var activityIndicator = getActivityIndicatorView(self)
        //activityIndicator.startAnimating()
        //super.viewDidLoad()
        checkConnectie()
        var responseVakanties: ([Vakantie], Int?)
        if PFUser.currentUser() != nil {
            var ouderResponse = ParseData.getOuderWithEmail(PFUser.currentUser().email)
            if ouderResponse.1 == nil {
                if favoriet == false {
                    responseVakanties = ParseData.getAlleVakanties()
                } else  {
                    responseVakanties = ParseData.getFavorieteVakanties(ouderResponse.0)
                }
            } else {
                responseVakanties = ParseData.getAlleVakanties()
            }
        } else {
            responseVakanties = ParseData.getAlleVakanties()
        }
        
        if responseVakanties.1 == nil {
            //er zijn vakanties
            self.vakanties = responseVakanties.0
            self.vakanties2 = self.vakanties
            self.tableView.reloadData()
        }
    
        
        self.vakanties2.sort({ (String($0.minLeeftijd)) < $1.titel})
        self.vakanties.sort({ (String($0.minLeeftijd)) < $1.titel})
    
        /*self.vakanties = responseVakanties.0
        self.vakanties2 = self.vakanties
        self.tableView.reloadData()*/
        
        hideSideMenuView()
        zoekbar.showsScopeBar = true
        zoekbar.delegate = self
        
        if PFUser.currentUser() != nil {
            self.navigationItem.setHidesBackButton(true, animated: true)
            self.navigationItem.rightBarButtonItem = nil   
        }
        
        /*vakanties2.sort({ (String($0.minLeeftijd)) < $1.titel})
        vakanties.sort({ (String($0.minLeeftijd)) < $1.titel})*/
        
        //activityIndicator.stopAnimating()
    }
    
    func checkConnectie() {
        // Connectie check
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
    
    /*func zoekVakanties() {
        vakanties.removeAll(keepCapacity: true)
        var query = PFQuery(className: "Vakantie")
        query.findObjectsInBackgroundWithBlock({(NSArray objects, NSError error) in
            if(error == nil) {
                if let PFObjects = objects as? [PFObject!] {
                    for object in PFObjects {
                        var vakantie = Vakantie(vakantie: object)
                        self.vakanties.append(vakantie)
                    }
                }
                self.vakanties2 = self.vakanties
                self.tableView.reloadData()
            }
        })
    }*/
    
    @IBAction func gaTerugNaarOverzichtVakanties(segue: UIStoryboardSegue) {
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toonVakantie" {
            let vakantieDetailsController = segue.destinationViewController as VakantieDetailsTableViewController
            let selectedVakantie = vakanties[tableView.indexPathForSelectedRow()!.row]
            vakantieDetailsController.vakantie = selectedVakantie as Vakantie
        } else if segue.identifier == "inloggen" {
            let inloggenViewController = segue.destinationViewController as InloggenViewController
        } /*else if segue.identifier == "toonVakantie" {
            let vakantieDetailsController = segue.destinationViewController as VakantieDetailsTableViewController
            let selectedVakantie = vakanties[tableView.indexPathForSelectedRow()!.row]
            vakantieDetailsController.vakantie = selectedVakantie
        }*/
        
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
        return cell
    }
    
    @IBAction func refresh(sender: UIRefreshControl) {
        var parseData = ParseData()
        ParseData.deleteAllTables()
        ParseData.createDatabase()
        self.refreshControl?.endRefreshing()
        viewDidLoad()
        //viewDidLoad()
    }
}

func getActivityIndicatorView(controller: UIViewController) -> UIActivityIndicatorView {
    let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.WhiteLarge)
    
    //var roodJoetz: UIColor = UIColor(red: 232.0, green: 33.0, blue: 35.0, alpha: 1.0)
    //activityIndicator.color = roodJoetz
    
    activityIndicator.color = UIColor.redColor()
    activityIndicator.center = controller.view.center
    activityIndicator.startAnimating()
    controller.view.addSubview(activityIndicator)

    return activityIndicator
}