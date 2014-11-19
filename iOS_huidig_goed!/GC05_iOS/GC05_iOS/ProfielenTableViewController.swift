import UIKit

class ProfielenTableViewController: UITableViewController, UISearchBarDelegate, UISearchDisplayDelegate {
    
    var monitoren: [Monitor] = []
    var monitoren2: [Monitor] = []
    
    @IBOutlet weak var zoekbar: UISearchBar!
    
    @IBAction func toggle(sender: AnyObject) {
        toggleSideMenuView()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var activityIndicator = getActivityIndicatorView(self)
        
        zoekMonitoren()
        zoekbar.showsScopeBar = true
        zoekbar.delegate = self
        
        activityIndicator.stopAnimating()
    }
    
    func zoekMonitorenZelfdeKamp() {
        //PFQuery query = PFQuery(className: "Monitor")
        //query.whereKey(")
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        zoekGefilterdeMonitoren(searchText.lowercaseString)
    }
    
    func zoekGefilterdeMonitoren(zoek: String) {
        monitoren2 = monitoren.filter { $0.naam!.rangeOfString(zoek) != nil }
        self.tableView.reloadData()
        
    }
    
    func zoekMonitoren() {
        monitoren.removeAll(keepCapacity: true)
        var query = PFQuery(className: "Monitor")
        query.findObjectsInBackgroundWithBlock({(NSArray objects, NSError error) in
            if(error == nil) {
                if let PFObjects = objects as? [PFObject!] {
                    for object in PFObjects {
                        var monitor = Monitor(monitor: object)
                        self.monitoren.append(monitor)
                    }
                }
                self.monitoren2 = self.monitoren
                self.tableView.reloadData()
            }
        })
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        /*if segue.identifier == "toonVorming" {
            let vormingDetailsController = segue.destinationViewController as VormingDetailsTableViewController
            let selectedVorming = vormingen[tableView.indexPathForSelectedRow()!.row]
            vormingDetailsController.vorming = selectedVorming as Vorming
            //vormingDetailsController.monitor = self.monitor
        }*/
        
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            // TO DO --> monitoren zelfde kamp/vorming
            return monitoren2.count
        } else if section == 2 {
            return monitoren2.count
        }
        return 0
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            /* TO DO --> monitoren zelfde kamp/vorming */
            
            let cell = tableView.dequeueReusableCellWithIdentifier("monitorCellZelfdeKamp", forIndexPath: indexPath) as UITableViewCell
            return cell
            
            /*let cell = tableView.dequeueReusableCellWithIdentifier("vormingCell", forIndexPath: indexPath) as UITableViewCell
            //let cell = tableView.dequeueReusableCellWithIdentifier("vormingCell")? as UITableViewCell
            let profiel = vormingen2[indexPath.row]
        
            cell.textLabel.text = vorming.titel
            cell.detailTextLabel!.text = "Meer informatie"
            return cell*/
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier("monitorCell", forIndexPath: indexPath) as UITableViewCell
            let monitor = monitoren2[indexPath.row]
            cell.textLabel.text = monitor.voornaam! + " " + monitor.voornaam!
            cell.detailTextLabel?.text = "Meer informatie"
            return cell
        }
    }
}