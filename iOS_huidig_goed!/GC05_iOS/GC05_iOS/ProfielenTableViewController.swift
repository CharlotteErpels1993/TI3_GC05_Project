import UIKit

class ProfielenTableViewController: UITableViewController, UISearchBarDelegate, UISearchDisplayDelegate {
    
    var monitoren: [Monitor] = []
    var monitoren2: [Monitor] = []
    var monitorenZelfdeVorming: [Monitor] = []
    var monitorenZelfdeVorming2: [Monitor] = []
    
    @IBOutlet weak var zoekbar: UISearchBar!
    
    @IBAction func toggle(sender: AnyObject) {
        toggleSideMenuView()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideSideMenuView()
        
        ParseData.deleteInschrijvingVormingTable()
        ParseData.deleteMonitorTable()
        
        
        var activityIndicator = getActivityIndicatorView(self)
        
        ParseData.vulInschrijvingVormingTableOp()
        ParseData.vulMonitorTableOp()
        
        var monitor = ParseData.getMonitorWithEmail(PFUser.currentUser().email)
        
        self.monitorenZelfdeVorming = ParseData.getMonitorsMetDezelfdeVormingen(monitor.id!)
        self.monitoren = ParseData.getMonitorsMetAndereVormingen(self.monitorenZelfdeVorming)
        self.monitoren2 = self.monitoren
        self.monitorenZelfdeVorming2 = self.monitorenZelfdeVorming
        
        monitorenZelfdeVorming.sort({ $0.naam < $1.voornaam })
        monitoren.sort({ $0.naam < $1.voornaam })
        
        zoekbar.showsScopeBar = true
        zoekbar.delegate = self
        
        activityIndicator.stopAnimating()
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        zoekGefilterdeVakanties(searchText.lowercaseString)
    }
    
    func zoekGefilterdeVakanties(zoek: String) {
        monitoren2 = monitoren.filter { ($0.naam!.lowercaseString.rangeOfString(zoek) != nil) || ($0.voornaam!.lowercaseString.rangeOfString(zoek)  != nil) }
        monitorenZelfdeVorming2 = monitorenZelfdeVorming.filter { ($0.naam!.lowercaseString.rangeOfString(zoek) != nil) || ($0.voornaam!.lowercaseString.rangeOfString(zoek)  != nil) }
        if zoek.isEmpty {
            self.monitoren2 = monitoren
            self.monitorenZelfdeVorming2 = monitorenZelfdeVorming
        }
        self.tableView.reloadData()
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return monitorenZelfdeVorming2.count
        } else if section == 1 {
            return monitoren2.count
        }
        return 0
    }
    
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return("Monitoren zelfde vorming")
        } else if section == 1 {
            return("Andere monitoren")
        } else {
            return("")
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("monitorCellZelfdeVorming", forIndexPath: indexPath) as UITableViewCell
            let monitor = monitorenZelfdeVorming2[indexPath.row]
            cell.textLabel?.text = monitor.voornaam! + " " + monitor.naam!
            cell.detailTextLabel!.text = "Meer informatie"
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier("monitorCell", forIndexPath: indexPath) as UITableViewCell
            let monitor = monitoren2[indexPath.row]
            cell.textLabel?.text = monitor.voornaam! + " " + monitor.naam!
            cell.detailTextLabel?.text = "Meer informatie"
            return cell
        }
    }
    
    override func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 1 {
            performSegueWithIdentifier("toonProfiel1", sender: indexPath)
        }else {
            performSegueWithIdentifier("toonProfiel2", sender: indexPath)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let monitorDetailsController = segue.destinationViewController as ProfielDetailsTableViewController
        var selectedMonitor: Monitor
        
        if segue.identifier == "toonProfiel1" {
            selectedMonitor = monitorenZelfdeVorming2[tableView.indexPathForSelectedRow()!.row]
        } else {
            selectedMonitor = monitoren2[tableView.indexPathForSelectedRow()!.row]
        }
        
        monitorDetailsController.monitor = selectedMonitor as Monitor
    }
    
}