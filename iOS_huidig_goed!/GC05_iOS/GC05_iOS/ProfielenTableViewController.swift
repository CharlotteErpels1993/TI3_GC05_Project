import UIKit

class ProfielenTableViewController: UITableViewController, UISearchBarDelegate, UISearchDisplayDelegate {
    
    var monitoren: [Monitor] = []
    var monitoren2: [Monitor] = []
    var monitorenZelfdeVorming: [Monitor] = []
    var monitorenZelfdeVorming2: [Monitor] = []
    var sectionToDelete: Int = -1
    
    @IBOutlet weak var zoekbar: UISearchBar!
    
    @IBAction func toggle(sender: AnyObject) {
        toggleSideMenuView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideSideMenuView()
        
        ParseData.deleteInschrijvingVormingTable()
        ParseData.deleteMonitorTable()
        ParseData.vulInschrijvingVormingTableOp()
        ParseData.vulMonitorTableOp()
        
        var monitorResponse = ParseData.getMonitorWithEmail(PFUser.currentUser().email)
        
        var monitor = monitorResponse.0
        
        var monitorenZelfdeVormingResponse = ParseData.getMonitorsMetDezelfdeVormingen(monitor.id!)
        
        if monitorenZelfdeVormingResponse.1 == nil {
            self.monitorenZelfdeVorming = monitorenZelfdeVormingResponse.0
            var monitorenResponse = ParseData.getMonitorsMetAndereVormingen(self.monitorenZelfdeVorming)
            
            if monitorenResponse.1 == nil {
                self.monitoren = monitorenResponse.0
                self.monitoren2 = self.monitoren
                self.monitorenZelfdeVorming2 = self.monitorenZelfdeVorming
            }
        } else {
            var monitorsResponse = ParseData.getAlleMonitors()
            
            if monitorsResponse.1 == nil {
                for var i = 0; i < monitorsResponse.0.count; i += 1 {
                    if monitorsResponse.0[i].email == PFUser.currentUser().email {
                        monitorsResponse.0.removeAtIndex(i)
                    }
                }
                self.monitoren = monitorsResponse.0
                self.monitoren2 = self.monitoren
            }
        }
        
        if monitorenZelfdeVorming2.count == 0 {
            sectionToDelete = 1
            self.tableView.deleteSections(NSIndexSet(index: sectionToDelete), withRowAnimation: UITableViewRowAnimation.None)
        } else if monitorenZelfdeVorming2.count != 0 {
            sectionToDelete = 0
            self.tableView.deleteSections(NSIndexSet(index: sectionToDelete), withRowAnimation: UITableViewRowAnimation.None)
        } else {
            sectionToDelete = -1
        }
        
        monitorenZelfdeVorming.sort({ $0.naam < $1.voornaam })
        monitoren.sort({ $0.naam < $1.voornaam })
        
        zoekbar.showsScopeBar = true
        zoekbar.delegate = self
    }
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        setTitleCancelButton(searchBar)
        zoekGefilterdeMonitoren(searchBar.text)
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchBar.text = ""
        zoekGefilterdeMonitoren(searchBar.text)
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
        zoekGefilterdeMonitoren(searchText.lowercaseString)
    }
    
    func zoekGefilterdeMonitoren(zoek: String) {
        monitoren2 = monitoren.filter { ($0.naam!.lowercaseString.rangeOfString(zoek) != nil) || ($0.voornaam!.lowercaseString.rangeOfString(zoek)  != nil) }
        monitorenZelfdeVorming2 = monitorenZelfdeVorming.filter { ($0.naam!.lowercaseString.rangeOfString(zoek) != nil) || ($0.voornaam!.lowercaseString.rangeOfString(zoek)  != nil) }
        if zoek.isEmpty {
            self.monitoren2 = monitoren
            self.monitorenZelfdeVorming2 = monitorenZelfdeVorming
        }
        self.tableView.reloadData()
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if sectionToDelete == -1 {
            return 3
        } else {
            return 2
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if sectionToDelete == 0 {
            if section == 0 {
                return monitorenZelfdeVorming2.count
            } else if section == 1 {
                return monitoren2.count
            }
        } else if sectionToDelete == -1 {
            if section == 1 {
                return monitorenZelfdeVorming2.count
            } else if section == 2 {
                return monitoren2.count
            }
        } else if sectionToDelete == 1 {
            if section == 0 {
                return 1
            } else if section == 1 {
                return monitoren2.count
            }
        }
        return 0
    }
    
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if sectionToDelete == 0 {
            if section == 0 {
                return ("Monitoren zelfde vorming")
            } else if section == 1 {
                return ("Andere monitoren")
            }
        } else if sectionToDelete == -1 {
            if section == 1 {
                 return("Monitoren zelfde vorming")
            } else if section == 2 {
                return ("Andere monitoren")
            }
        } else if sectionToDelete == 1 {
            if section == 0 {
                return ("Monitoren zelfde vorming")
            } else if section == 1 {
                return ("Andere monitoren")
            }
        }
        return ("")
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell: UITableViewCell!
        
        if self.sectionToDelete == 1  {
            if indexPath.section == 0 {
                cell = tableView.dequeueReusableCellWithIdentifier("geenMonitorCell", forIndexPath: indexPath) as UITableViewCell
            } else if indexPath.section == 1 {
                cell = tableView.dequeueReusableCellWithIdentifier("monitorCell", forIndexPath: indexPath) as UITableViewCell
                let monitor = monitoren2[indexPath.row]
                cell.textLabel?.text = monitor.voornaam! + " " + monitor.naam!
                cell.detailTextLabel?.text = "Meer informatie"
            }
        } else {
            if indexPath.section == 0 {
                cell = tableView.dequeueReusableCellWithIdentifier("monitorCellZelfdeVorming", forIndexPath: indexPath) as UITableViewCell
                let monitor = monitorenZelfdeVorming2[indexPath.row]
                cell.textLabel?.text = monitor.voornaam! + " " + monitor.naam!
                cell.detailTextLabel!.text = "Meer informatie"
            } else if indexPath.section == 1 {
                cell = tableView.dequeueReusableCellWithIdentifier("monitorCell", forIndexPath: indexPath) as UITableViewCell
                let monitor = monitoren2[indexPath.row]
                cell.textLabel?.text = monitor.voornaam! + " " + monitor.naam!
                cell.detailTextLabel?.text = "Meer informatie"
            }
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 1 {
            performSegueWithIdentifier("toonProfiel1", sender: indexPath)
        }else if indexPath.section == 2 {
            performSegueWithIdentifier("toonProfiel2", sender: indexPath)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let monitorDetailsController = segue.destinationViewController as ProfielDetailsTableViewController
        var selectedMonitor: Monitor?
        
        if segue.identifier == "toonProfiel1" {
            selectedMonitor = monitorenZelfdeVorming2[tableView.indexPathForSelectedRow()!.row]
        } else if segue.identifier == "toonProfiel2" {
            selectedMonitor = monitoren2[tableView.indexPathForSelectedRow()!.row]
        }
        
        monitorDetailsController.monitor = selectedMonitor! as Monitor
    }
    
}