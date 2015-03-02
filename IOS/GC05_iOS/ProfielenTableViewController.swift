import UIKit

class ProfielenTableViewController: UITableViewController, UISearchBarDelegate, UISearchDisplayDelegate {
    
    var ingelogdeMonitor: Monitor!
    var monitoren: [Monitor] = []
    var monitoren2: [Monitor] = []
    var monitorenZelfdeVorming: [Monitor] = []
    var monitorenZelfdeVorming2: [Monitor] = []
    var sectionToDelete: Int = -1
    
    @IBOutlet weak var zoekbar: UISearchBar!
    
    //
    //Naam: toggle
    //
    //Werking: - zorgt ervoor dat de side bar menu wordt weergegeven
    //         - zorgt er ook voor dat alle toestenborden gesloten zijn
    //
    //Parameters:
    //  - sender: AnyObject
    //
    //Return:
    //
    @IBAction func toggle(sender: AnyObject) {
        searchBarCancelButtonClicked(zoekbar)
        toggleSideMenuView()
    }
    
    //
    //Naam: viewDidLoad
    //
    //Werking: - zorgt ervoor dat de side bar menu verborgen is
    //         - haalt alle tabellen op (eigen profiel monitor, monitoren zelfde vorming en andere monitoren)
    //         - sections worden aangepast naargelang... :
    //              * er een administrator is ingelogd
    //              * er geen monitoren zijn met dezelfde vorming
    //
    //Parameters:
    //
    //Return:
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        hideSideMenuView()
        
        /*/*self.ingelogdeMonitor = LocalDatastore.getLocalObjectWithColumnConstraints(Constanten.TABLE_MONITOR, soortConstraints: [Constanten.COLUMN_EMAIL: Constanten.CONSTRAINT_EQUALTO], equalToConstraints: [Constanten.COLUMN_EMAIL: PFUser.currentUser().email]) as Monitor*/
        var queryMonitor = Query(tableName: Constanten.TABLE_MONITOR)
        queryMonitor.addWhereEqualTo(Constanten.COLUMN_EMAIL, value: PFUser.currentUser().email)
        self.ingelogdeMonitor = queryMonitor.getFirstObject() as Monitor
        
        var soort = LocalDatastore.getCurrentUserSoort()
        
        if soort == "monitor" {
            //var monitor = LocalDatastore.getLocalObjectWithColumnConstraints(Constanten.TABLE_MONITOR, soortConstraints: [Constanten.COLUMN_EMAIL: Constanten.CONSTRAINT_EQUALTO], equalToConstraints: [Constanten.COLUMN_EMAIL: PFUser.currentUser().email]) as Monitor
            
            var qInschrijvingenIngelogdeMonitor = Query(tableName: Constanten.TABLE_INSCHRIJVINGVORMING)
            qInschrijvingenIngelogdeMonitor.addWhereEqualTo(Constanten.COLUMN_MONITOR, value: ingelogdeMonitor.id)
            var inschrijvingenIngelogdeMonitor = qInschrijvingenIngelogdeMonitor.getObjects() as [InschrijvingVorming]
            
            var keysVormingen : [String] = []
            
            for inschrijving in inschrijvingenIngelogdeMonitor {
                var id = inschrijving.vorming?.id
                keysVormingen.append(id!)
            }
            
            var qInschrijvingenVanVormingen = Query(tableName: Constanten.TABLE_INSCHRIJVINGVORMING)
            qInschrijvingenVanVormingen.addWhereContainedIn(Constanten.COLUMN_VORMING, objects: keysVormingen)
            
            var inschrijvingenVormingen = qInschrijvingenVanVormingen.getObjects() as [InschrijvingVorming]
            
            for var i=0; i<inschrijvingenVormingen.count; i++ {
                if inschrijvingenVormingen[i].monitor?.id == ingelogdeMonitor.id {
                    inschrijvingenVormingen.removeAtIndex(i)
                }
            }
            
            var monitorenIds: [String] = []
            
            for inschrijvingVorming in inschrijvingenVormingen {
                var monitorId = inschrijvingVorming.monitor?.id
                monitorenIds.append(monitorId!)
            }
            
            var qMonitorenZelfdeVorming = Query(tableName: Constanten.TABLE_MONITOR)
            qMonitorenZelfdeVorming.addWhereContainedIn(Constanten.COLUMN_OBJECTID, objects:monitorenIds)
            
            //var monitorenZelfdeVorming = LocalDatastore.getMonitorenMetDezelfdeVormingen(monitor.id!)
            var monitorenZelfdeVorming = qMonitorenZelfdeVorming.getObjects() as [Monitor]
            
            if monitorenZelfdeVorming.count != 0 {
                self.monitorenZelfdeVorming = monitorenZelfdeVorming
                
                //var monitorenAndereVormingen = LocalDatastore.getAndereMonitoren(monitorenZelfdeVorming)
                
                var qMonitorenAndereVormingen = Query(tableName: Constanten.TABLE_MONITOR)
                qMonitorenAndereVormingen.addWhereNotContainedIn(Constanten.COLUMN_OBJECTID, objects: monitorenIds)
                
                var monitorenAndereVormingen = qMonitorenAndereVormingen.getObjects() as [Monitor]
                
                if monitorenAndereVormingen.count != 0 {
                    self.monitoren = monitorenAndereVormingen
                    self.monitoren2 = self.monitoren
                    self.monitorenZelfdeVorming2 = self.monitorenZelfdeVorming
                }
            } else {
                //var alleMonitoren = LocalDatastore.getLocalObjects(Constanten.TABLE_MONITOR) as [Monitor]
                
                var qAlleMonitoren = Query(tableName: Constanten.TABLE_MONITOR)
                var alleMonitoren = qAlleMonitoren.getObjects() as [Monitor]
                
                if alleMonitoren.count != 0 {
                    for var i = 0; i < alleMonitoren.count; i += 1 {
                        if alleMonitoren[i].email == PFUser.currentUser().email {
                            alleMonitoren.removeAtIndex(i)
                        }
                    }
                    self.monitoren = alleMonitoren
                }
            }
        } else {
            //var alleMonitoren = LocalDatastore.getLocalObjects(Constanten.TABLE_MONITOR) as [Monitor]
            var qAlleMonitoren = Query(tableName: Constanten.TABLE_MONITOR)
            var alleMonitoren = qAlleMonitoren.getObjects() as [Monitor]
            self.monitoren = alleMonitoren
        }
        
        self.monitoren2 = self.monitoren*/
        
        haalProfielenOp()
        
        var soort = LocalDatastore.getCurrentUserSoort()
        
        if soort == "administrator" {
            sectionToDelete = 9
            self.tableView.deleteSections(NSIndexSet(index: 0), withRowAnimation: UITableViewRowAnimation.None)
        }
        
        if monitorenZelfdeVorming2.count == 0 {
            if soort == "administrator" {
                sectionToDelete = 9
            } else {
                sectionToDelete = 2
                self.tableView.deleteSections(NSIndexSet(index: sectionToDelete), withRowAnimation: UITableViewRowAnimation.None)
            }
        } else if monitorenZelfdeVorming2.count != 0 {
            if soort == "administrator" {
                sectionToDelete = 9
            } else {
                sectionToDelete = -1
                self.tableView.deleteSections(NSIndexSet(index: 1), withRowAnimation: UITableViewRowAnimation.None)
            }
        } else {
            sectionToDelete = -1
        }
        
        monitorenZelfdeVorming.sort({ $0.naam < $1.voornaam })
        monitoren.sort({ $0.naam < $1.voornaam })
        
        zoekbar.showsScopeBar = true
        zoekbar.delegate = self
    }
    
    //
    //Naam: searchBarTextDidBeginEditing
    //
    //Werking: - zorgt ervoor dat de side bar menu wordt verborgen bij het klikken op de search bar
    //         - zet de juiste titel bij annuleren
    //         - roept de methode zoekGefilterde vakanties op
    //
    //Parameters:
    //  - searchBar: UISearchBar
    //
    //Return:
    //
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        hideSideMenuView()
        setTitleCancelButton(searchBar)
        zoekGefilterdeMonitoren(searchBar.text)
    }
    
    //
    //Naam: searchBarCancelButtonClicked
    //
    //Werking: - zorgt ervoor dat bij het klikken op annuleer de tekst weer leeg is
    //         - zorgt ervoor dat het toetsenbord en de cancel button verdwijnt
    //
    //Parameters:
    //  - searchBar: UISearchBar
    //
    //Return:
    //
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchBar.text = ""
        zoekGefilterdeMonitoren(searchBar.text)
        searchBar.showsCancelButton = false
        searchBar.resignFirstResponder()
    }
    
    //
    //Naam: setTitleCancelButton
    //
    //Werking: - veranderd de "cancel" naar "annuleren"
    //
    //Parameters:
    //  - searchBar: UISearchBar
    //
    //Return:
    //
    func setTitleCancelButton(searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
        var cancelButton: UIButton?
        var topView: UIView = searchBar.subviews[0] as UIView
        for subView in topView.subviews {
            cancelButton = subView as? UIButton
        }
        
        cancelButton?.setTitle("Annuleer", forState: UIControlState.Normal)
    }
    
    //
    //Naam: zoekGefilterdeMonitoren
    //
    //Werking: - filter naargelang de zoek tekst string in de naam van de monitoren
    //
    //Parameters:
    //  - zoek: String
    //
    //Return:
    //
    func zoekGefilterdeMonitoren(zoek: String) {
        monitoren2 = monitoren.filter { ($0.naam!.lowercaseString.rangeOfString(zoek) != nil) || ($0.voornaam!.lowercaseString.rangeOfString(zoek)  != nil) }
        monitorenZelfdeVorming2 = monitorenZelfdeVorming.filter { ($0.naam!.lowercaseString.rangeOfString(zoek) != nil) || ($0.voornaam!.lowercaseString.rangeOfString(zoek)  != nil) }
        if zoek.isEmpty {
            self.monitoren2 = monitoren
            self.monitorenZelfdeVorming2 = monitorenZelfdeVorming
        }
        self.tableView.reloadData()
    }
    
    //
    //Naam: numbersOfSectionsInTableView
    //
    //Werking: - zorgt dat het aantal sections zich aanpast naargelang er een section wordt verwijderd
    //
    //Parameters:
    //  - tableView: UITableView
    //
    //Return: een int met de hoeveelheid sections
    //
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if sectionToDelete == -1 {
            return 4
        } else  if sectionToDelete == 9 {
            return 1
        } else {
            return 3
        }
    }
    
    //
    //Naam: tableView
    //
    //Werking: - zorgt dat het aantal rijen in een section aangepast wordt naargelang er een section wordt verwijderd
    //
    //Parameters:
    //  - tableView: UITableView
    //  - numbersOfRowsInSection section: Int
    //
    //Return: een int met de hoeveelheid rijen per section
    //
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if sectionToDelete == 0 {
            if section == 1 {
                return monitorenZelfdeVorming2.count
            } else if section == 1 {
                return monitoren2.count
            }
        } else if sectionToDelete == -1 {
            if section == 2 {
                return monitorenZelfdeVorming2.count
            } else if section == 3 {
                return monitoren2.count
            } else if section == 0 {
                return 1
            }
        } else if sectionToDelete == 2 {
            if section == 1 {
                return 1
            } else if section == 2 {
                return monitoren2.count
            } else if section == 0 {
                return 1
            }
        } else if sectionToDelete == 9 {
            return monitoren2.count
        }
        return 0
    }
    
    //
    //Naam: tableView
    //
    //Werking: - zorgt ervoor dat elke section de gepaste header krijgt
    //
    //Parameters:
    //  - tableView: UITableView
    //  - titleForHeaderInSection section: Int
    //
    //Return: een titel voor een bepaalde section
    //
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if sectionToDelete == 1 {
            if section == 0 {
                return ("Uw profiel")
            } else if section == 1 {
                return ("Monitoren zelfde vorming")
            } else if section == 2 {
                return ("Andere monitoren")
            }
        } else if sectionToDelete == -1 {
            if section == 2 {
                 return("Monitoren zelfde vorming")
            } else if section == 3 {
                return ("Andere monitoren")
            } else if section == 0 {
                return ("Uw profiel")
            }
        } else if sectionToDelete == 2 {
            if section == 1 {
                return ("Monitoren zelfde vorming")
            } else if section == 2 {
                return ("Andere monitoren")
            } else if section == 0 {
                return ("Uw profiel")
            }
        } else if sectionToDelete == 9 {
            return ("Monitoren")
        }
        
        return ("")
    }
    
    //
    //Naam: tableView
    //
    //Werking: - zorgt ervoor dat elke cell wordt ingevuld met de juiste gegevens
    //
    //Parameters:
    //  - tableView: UITableView
    //  - cellForRowAtIndexPath indexPath: NSIndexPath
    //
    //Return: een UITableViewCell met de juiste ingevulde gegevens
    //
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell: UITableViewCell!
        
        if self.sectionToDelete == 2  {
            if indexPath.section == 1 {
               cell = tableView.dequeueReusableCellWithIdentifier("geenMonitorCell", forIndexPath: indexPath) as UITableViewCell
            } else if indexPath.section == 2 {
                cell = tableView.dequeueReusableCellWithIdentifier("monitorCell", forIndexPath: indexPath) as UITableViewCell
                let monitor = monitoren2[indexPath.row]
                cell.textLabel?.text = monitor.voornaam! + " " + monitor.naam!
                cell.detailTextLabel?.text = "Meer informatie"
            } else if indexPath.section == 0 {
                cell = tableView.dequeueReusableCellWithIdentifier("eigenMonitorCell", forIndexPath: indexPath) as UITableViewCell
                cell.textLabel?.text = self.ingelogdeMonitor.voornaam! + " " + self.ingelogdeMonitor.naam!
                cell.detailTextLabel?.text = "Meer informatie"
            }
        } else if self.sectionToDelete == 9 {
            cell = tableView.dequeueReusableCellWithIdentifier("monitorCell", forIndexPath: indexPath) as UITableViewCell
            let monitor = monitoren2[indexPath.row]
            cell.textLabel?.text = monitor.voornaam! + " " + monitor.naam!
            cell.detailTextLabel?.text = "Meer informatie"
        } else if self.sectionToDelete == -1 {
            if indexPath.section == 0 {
                cell = tableView.dequeueReusableCellWithIdentifier("eigenMonitorCell", forIndexPath: indexPath) as UITableViewCell
                cell.textLabel?.text = self.ingelogdeMonitor.voornaam! + " " + self.ingelogdeMonitor.naam!
                cell.detailTextLabel?.text = "Meer informatie"
            } else if indexPath.section == 2 {
                cell = tableView.dequeueReusableCellWithIdentifier("monitorCellZelfdeVorming", forIndexPath: indexPath) as UITableViewCell
                let monitor = monitorenZelfdeVorming2[indexPath.row]
                cell.textLabel?.text = monitor.voornaam! + " " + monitor.naam!
                cell.detailTextLabel!.text = "Meer informatie"
            } else if indexPath.section == 3 {
                cell = tableView.dequeueReusableCellWithIdentifier("monitorCell", forIndexPath: indexPath) as UITableViewCell
                let monitor = monitoren2[indexPath.row]
                cell.textLabel?.text = monitor.voornaam! + " " + monitor.naam!
                cell.detailTextLabel?.text = "Meer informatie"
            }
        }
        return cell
    }
    
    /*override func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 2 {
            performSegueWithIdentifier("toonProfiel1", sender: indexPath)
        }else if indexPath.section == 3 {
            performSegueWithIdentifier("toonProfiel2", sender: indexPath)
        } else if indexPath.section == 0 {
            performSegueWithIdentifier("toonProfiel3", sender: indexPath)
        }
    }*/
    
    //
    //Naam: prepareForSegue
    //
    //Werking: - maakt de volgende view met opgegeven identifier (stelt soms attributen van de volgende view op)
    //
    //Parameters:
    //  - segue: UIStoryboardSegue
    //  - sender: AnyObject?
    //
    //Return:
    //
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let monitorDetailsController = segue.destinationViewController as ProfielDetailsTableViewController
        var selectedMonitor: Monitor?
        
        if segue.identifier == "toonProfiel1" {
            selectedMonitor = monitorenZelfdeVorming2[tableView.indexPathForSelectedRow()!.row]
        } else if segue.identifier == "toonProfiel2" {
            selectedMonitor = monitoren2[tableView.indexPathForSelectedRow()!.row]
        } else if segue.identifier == "toonProfiel3" {
            selectedMonitor = self.ingelogdeMonitor
            monitorDetailsController.eigenProfiel = true
        }
        
        monitorDetailsController.monitor = selectedMonitor! as Monitor
    }
    
    //
    //Naam: refresh
    //
    //Werking: - zorgt ervoor wanneer de gebruiker naar beneden scrolt de data opnieuw wordt herladen
    //
    //Parameters:
    //  - sender: UIRefreshControl
    //
    //Return:
    //
    @IBAction func refresh(sender: UIRefreshControl) {
        if Reachability.isConnectedToNetwork() == false {
            toonFoutBoxMetKeuzeNaarInstellingen("Verbind met het internet om uw nieuwste profielen te bekijken of ga naar instellingen.", self)
        }
        LocalDatastore.getTableReady(Constanten.TABLE_MONITOR)
        self.refreshControl?.endRefreshing()
        //viewDidLoad()
        haalProfielenOp()
    }
    
    func haalProfielenOp() {
        
        self.monitoren.removeAll(keepCapacity: true)
        self.monitoren2.removeAll(keepCapacity: true)
        self.monitorenZelfdeVorming.removeAll(keepCapacity: true)
        self.monitorenZelfdeVorming2.removeAll(keepCapacity: true)
        
        /*self.ingelogdeMonitor = LocalDatastore.getLocalObjectWithColumnConstraints(Constanten.TABLE_MONITOR, soortConstraints: [Constanten.COLUMN_EMAIL: Constanten.CONSTRAINT_EQUALTO], equalToConstraints: [Constanten.COLUMN_EMAIL: PFUser.currentUser().email]) as Monitor*/
        var queryMonitor = Query(tableName: Constanten.TABLE_MONITOR)
        queryMonitor.addWhereEqualTo(Constanten.COLUMN_EMAIL, value: PFUser.currentUser().email)
        self.ingelogdeMonitor = queryMonitor.getFirstObject() as Monitor
        
        var soort = LocalDatastore.getCurrentUserSoort()
        
        if soort == "monitor" {
            //var monitor = LocalDatastore.getLocalObjectWithColumnConstraints(Constanten.TABLE_MONITOR, soortConstraints: [Constanten.COLUMN_EMAIL: Constanten.CONSTRAINT_EQUALTO], equalToConstraints: [Constanten.COLUMN_EMAIL: PFUser.currentUser().email]) as Monitor
            
            var qInschrijvingenIngelogdeMonitor = Query(tableName: Constanten.TABLE_INSCHRIJVINGVORMING)
            qInschrijvingenIngelogdeMonitor.addWhereEqualTo(Constanten.COLUMN_MONITOR, value: ingelogdeMonitor.id)
            var inschrijvingenIngelogdeMonitor = qInschrijvingenIngelogdeMonitor.getObjects() as [InschrijvingVorming]
            
            var keysVormingen : [String] = []
            
            for inschrijving in inschrijvingenIngelogdeMonitor {
                var id = inschrijving.vorming?.id
                keysVormingen.append(id!)
            }
            
            var qInschrijvingenVanVormingen = Query(tableName: Constanten.TABLE_INSCHRIJVINGVORMING)
            qInschrijvingenVanVormingen.addWhereContainedIn(Constanten.COLUMN_VORMING, objects: keysVormingen)
            
            var inschrijvingenVormingen = qInschrijvingenVanVormingen.getObjects() as [InschrijvingVorming]
            
            for var i=0; i<inschrijvingenVormingen.count; i++ {
                if inschrijvingenVormingen[i].monitor?.id == ingelogdeMonitor.id {
                    inschrijvingenVormingen.removeAtIndex(i)
                }
            }
            
            var monitorenIds: [String] = []
            
            for inschrijvingVorming in inschrijvingenVormingen {
                var monitorId = inschrijvingVorming.monitor?.id
                monitorenIds.append(monitorId!)
            }
            
            var qMonitorenZelfdeVorming = Query(tableName: Constanten.TABLE_MONITOR)
            qMonitorenZelfdeVorming.addWhereContainedIn(Constanten.COLUMN_OBJECTID, objects:monitorenIds)
            
            //var monitorenZelfdeVorming = LocalDatastore.getMonitorenMetDezelfdeVormingen(monitor.id!)
            var monitorenZelfdeVorming = qMonitorenZelfdeVorming.getObjects() as [Monitor]
            
            if monitorenZelfdeVorming.count != 0 {
                self.monitorenZelfdeVorming = monitorenZelfdeVorming
                
                //var monitorenAndereVormingen = LocalDatastore.getAndereMonitoren(monitorenZelfdeVorming)
                
                var qMonitorenAndereVormingen = Query(tableName: Constanten.TABLE_MONITOR)
                qMonitorenAndereVormingen.addWhereNotContainedIn(Constanten.COLUMN_OBJECTID, objects: monitorenIds)
                
                var monitorenAndereVormingen = qMonitorenAndereVormingen.getObjects() as [Monitor]
                
                if monitorenAndereVormingen.count != 0 {
                    self.monitoren = monitorenAndereVormingen
                    self.monitoren2 = self.monitoren
                    self.monitorenZelfdeVorming2 = self.monitorenZelfdeVorming
                }
            } else {
                //var alleMonitoren = LocalDatastore.getLocalObjects(Constanten.TABLE_MONITOR) as [Monitor]
                
                var qAlleMonitoren = Query(tableName: Constanten.TABLE_MONITOR)
                var alleMonitoren = qAlleMonitoren.getObjects() as [Monitor]
                
                if alleMonitoren.count != 0 {
                    for var i = 0; i < alleMonitoren.count; i += 1 {
                        if alleMonitoren[i].email == PFUser.currentUser().email {
                            alleMonitoren.removeAtIndex(i)
                        }
                    }
                    self.monitoren = alleMonitoren
                }
            }
        } else {
            //var alleMonitoren = LocalDatastore.getLocalObjects(Constanten.TABLE_MONITOR) as [Monitor]
            var qAlleMonitoren = Query(tableName: Constanten.TABLE_MONITOR)
            var alleMonitoren = qAlleMonitoren.getObjects() as [Monitor]
            self.monitoren = alleMonitoren
        }
        
        for (var i=0; i < self.monitoren.count; i++) {
            if self.monitoren[i].id == self.ingelogdeMonitor.id {
                self.monitoren.removeAtIndex(i)
            }
        }
        
        self.monitoren2 = self.monitoren
    }
    
    
}