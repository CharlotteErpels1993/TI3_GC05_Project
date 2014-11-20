import UIKit

class ProfielenTableViewController: UITableViewController, UISearchBarDelegate, UISearchDisplayDelegate {
    
    var monitoren: [Monitor] = []
    var vormingen: [InschrijvingVorming] = []
    //var monitoren2: [Monitor] = []
    var monitorenZelfdeVorming: [Monitor] = []
    
    @IBOutlet weak var zoekbar: UISearchBar!
    
    @IBAction func toggle(sender: AnyObject) {
        toggleSideMenuView()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var activityIndicator = getActivityIndicatorView(self)
        
        zoekMonitoren()
        zoekVormingenVanHuidigeMonitor()
        zoekMonitorenMetDezelfdeVormingen()
        
        
        zoekbar.showsScopeBar = true
        zoekbar.delegate = self
        
        activityIndicator.stopAnimating()
    }
    
    //func zoekMonitorenZelfdeVorming() {
        /*PFQuery query = PFQuery(className: "Monitor")
        query.whereKey(")*/
    //}
    
    /*func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        zoekGefilterdeMonitoren(searchText.lowercaseString)
    }
    
    func zoekGefilterdeMonitoren(zoek: String) {
        monitoren2 = monitoren.filter { $0.naam!.rangeOfString(zoek) != nil }
        if zoek.isEmpty {
        self.vakanties2 = vakanties
        }
        self.tableView.reloadData()
        
    }*/
    
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
                println("monitoren: \(self.monitoren)")
                //self.monitoren2 = self.monitoren
                self.tableView.reloadData()
            }
        })
    }
    
    func zoekVormingenVanHuidigeMonitor() {
        var monitor = getCurrentUser()
        var query = PFQuery(className: "InschrijvingVorming")
        query.whereKey("monitor", equalTo: monitor.id)
        query.findObjectsInBackgroundWithBlock({(NSArray objects, NSError error) in
            if(error == nil) {
                if let PFObjects = objects as? [PFObject!] {
                    for object in PFObjects {
                        var vorming = InschrijvingVorming(inschrijving: object)
                        self.vormingen.append(vorming)
                    }
                }
                //self.monitoren2 = self.monitoren
                println("vormoingen: \(self.vormingen)")
                self.tableView.reloadData()
            }
        })
    }
    
    func zoekMonitorenMetDezelfdeVormingen() {
        for vorming in self.vormingen {
            for monitor in self.monitoren {
                zoekMonitorMetDezelfdeVorming(vorming, monitor: monitor)
            }
        }
        println("monitorenZelfdeVorming \(self.monitorenZelfdeVorming)")
    }
    
    func zoekMonitorMetDezelfdeVorming(vorming: InschrijvingVorming, monitor: Monitor) {
        var query = PFQuery(className: "InschrijvenVorming")
        query.whereKey("monitor", equalTo: monitor.id)
        query.whereKey("vorming", equalTo: vorming.id)
        query.findObjectsInBackgroundWithBlock({(NSArray objects, NSError error) in
            if(error == nil) {
                if let PFObjects = objects as? [PFObject!] {
                    for object in PFObjects {
                        var vorming2 = InschrijvingVorming(inschrijving: object)
                        self.monitorenZelfdeVorming.append(monitor)
                    }
                }
                //self.monitoren2 = self.monitoren
                self.tableView.reloadData()
            }
        })
        
        
    }
    
    
    func getCurrentUser() -> Monitor {
        var query = PFQuery(className: "Monitor")
        query.whereKey("email", containsString: PFUser.currentUser().email)
        var monitorPF = query.getFirstObject()
        return Monitor(monitor: monitorPF)
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
            return monitorenZelfdeVorming.count
        } else if section == 2 {
            return monitoren.count
        }
        return 0
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            /* TO DO --> monitoren zelfde kamp/vorming */
            
            let cell = tableView.dequeueReusableCellWithIdentifier("monitorCellZelfdeVorming", forIndexPath: indexPath) as UITableViewCell
            let monitor = monitorenZelfdeVorming[indexPath.row]
            cell.textLabel.text = monitor.voornaam! + " " + monitor.naam!
            cell.detailTextLabel!.text = "Meer informatie"
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier("monitorCell", forIndexPath: indexPath) as UITableViewCell
            let monitor = monitoren[indexPath.row]
            cell.textLabel.text = monitor.voornaam! + " " + monitor.voornaam!
            cell.detailTextLabel?.text = "Meer informatie"
            return cell
        }
    }
}