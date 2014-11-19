import UIKit
import Foundation

class VakantiesTableViewController: UITableViewController, UISearchBarDelegate, UISearchDisplayDelegate {
    var vakanties: [Vakantie] = []
    var vakanties2: [Vakantie] = []
    //var ouder: Ouder?
    //var currentUser: PFUser?
    
    @IBOutlet var activityIndicatorView: UIActivityIndicatorView!
    
    @IBOutlet weak var zoekbar: UISearchBar!
    
    @IBAction func toggle(sender: AnyObject) {
        toggleSideMenuView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var activityIndicator = getActivityIndicatorView(self)
        
        //activityIndicatorView.startAnimating()
        zoekVakanties()
        hideSideMenuView()
        zoekbar.showsScopeBar = true
        zoekbar.delegate = self
        
        //if ouder != nil {
        if PFUser.currentUser() != nil {
            self.navigationItem.setHidesBackButton(true, animated: true)
            self.navigationItem.rightBarButtonItem = nil   
        }
        
        activityIndicator.stopAnimating()
        
        //self.navigationItem.rightBarButtonItem.
    }
    
    /*override func viewDidAppear(animated: Bool) {
        currentUser = PFUser.currentUser()
    }*/
    
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        zoekGefilterdeVakanties(searchText.lowercaseString)
    }
    
    func zoekGefilterdeVakanties(zoek: String) {
        vakanties2 = vakanties.filter { $0.titel?.lowercaseString.rangeOfString(zoek) != nil }
        self.tableView.reloadData()
            
    }
    
    func zoekVakanties() {
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
    }
    
    @IBAction func gaTerugNaarOverzichtVakanties(segue: UIStoryboardSegue) {
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toonVakantie" {
            let vakantieDetailsController = segue.destinationViewController as VakantieDetailsTableViewController
            let selectedVakantie = vakanties[tableView.indexPathForSelectedRow()!.row]
            vakantieDetailsController.vakantie = selectedVakantie as Vakantie
            //vakantieDetailsController.ouder = ouder
        } else if segue.identifier == "inloggen" {
            let inloggenViewController = segue.destinationViewController as InloggenViewController
        } else if segue.identifier == "toonVakantie" {
            let vakantieDetailsController = segue.destinationViewController as VakantieDetailsTableViewController
            let selectedVakantie = vakanties[tableView.indexPathForSelectedRow()!.row]
            vakantieDetailsController.vakantie = selectedVakantie
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
        cell.gaVerderLabel.text = "Meer details"
        cell.vakantieNaamLabel.text = vakantie.titel
        cell.doelgroepLabel.text! = " \(vakantie.doelgroep!) jaar "
        return cell
    }
}

func getActivityIndicatorView(controller: UIViewController) -> UIActivityIndicatorView {
    let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.WhiteLarge)
    activityIndicator.color = UIColor.redColor()
    activityIndicator.frame = CGRectMake(100, 100, 100, 100)
    activityIndicator.startAnimating()
    controller.view.addSubview(activityIndicator)
    return activityIndicator
}