import UIKit

class ProfielenTableViewController: UITableViewController, UISearchBarDelegate, UISearchDisplayDelegate {
    
    //moet nog static klasse worden!
    //var parseData: ParseData = ParseData()
    
    var monitoren: [Monitor] = []
    var monitoren2: [Monitor] = []
    var monitorenZelfdeVorming: [Monitor] = []
    
    @IBOutlet weak var zoekbar: UISearchBar!
    
    @IBAction func toggle(sender: AnyObject) {
        toggleSideMenuView()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ParseData.deleteInschrijvingVormingTable()
        
        var activityIndicator = getActivityIndicatorView(self)
        
        ParseData.vulInschrijvingVormingTableOp()
        
        var monitor = ParseData.getMonitorWithEmail(PFUser.currentUser().email)
        
        self.monitorenZelfdeVorming = ParseData.getMonitorsMetDezelfdeVormingen(monitor.id!)
        self.monitoren = ParseData.getMonitorsMetAndereVormingen(self.monitorenZelfdeVorming)
        
        monitorenZelfdeVorming.sort({ $0.naam < $1.voornaam })
        monitoren.sort({ $0.naam < $1.voornaam })
        
        zoekbar.showsScopeBar = true
        zoekbar.delegate = self
        
        activityIndicator.stopAnimating()
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return monitorenZelfdeVorming.count
        } else if section == 1 {
            return monitoren.count
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
            let monitor = monitorenZelfdeVorming[indexPath.row]
            cell.textLabel.text = monitor.voornaam! + " " + monitor.naam!
            cell.detailTextLabel!.text = "Meer informatie"
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier("monitorCell", forIndexPath: indexPath) as UITableViewCell
            let monitor = monitoren[indexPath.row]
            cell.textLabel.text = monitor.voornaam! + " " + monitor.naam!
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
            selectedMonitor = monitorenZelfdeVorming[tableView.indexPathForSelectedRow()!.row]
        } else {
            selectedMonitor = monitoren[tableView.indexPathForSelectedRow()!.row]
        }
        
        monitorDetailsController.monitor = selectedMonitor as Monitor
    }

}