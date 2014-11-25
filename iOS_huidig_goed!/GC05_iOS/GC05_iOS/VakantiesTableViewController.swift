import UIKit
import Foundation

class VakantiesTableViewController: UITableViewController, UISearchBarDelegate, UISearchDisplayDelegate {
    
    var vakanties: [Vakantie] = []
    var vakanties2: [Vakantie] = []
    
    @IBOutlet weak var zoekbar: UISearchBar!
    
    @IBAction func toggle(sender: AnyObject) {
        toggleSideMenuView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkConnectie()
        var activityIndicator = getActivityIndicatorView(self)
        
        vakanties = ParseData.getAlleVakanties()
        self.vakanties2 = self.vakanties
        self.tableView.reloadData()
        
        hideSideMenuView()
        zoekbar.showsScopeBar = true
        zoekbar.delegate = self
        
        if PFUser.currentUser() != nil {
            self.navigationItem.setHidesBackButton(true, animated: true)
            self.navigationItem.rightBarButtonItem = nil   
        }
        
        vakanties2.sort({ $0.doelgroep < $1.titel })
        vakanties.sort({ $0.doelgroep < $1.titel })
        
        activityIndicator.stopAnimating()
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
    
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
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
        cell.gaVerderLabel.text = "Meer details"
        cell.vakantieNaamLabel.text = vakantie.titel
        cell.doelgroepLabel.text! = " \(vakantie.doelgroep!) jaar "
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
    activityIndicator.color = UIColor.redColor()
    activityIndicator.center = controller.view.center
    //activityIndicator.startAnimating()
    controller.view.addSubview(activityIndicator)

    return activityIndicator
}