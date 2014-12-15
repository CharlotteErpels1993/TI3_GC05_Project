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
        searchBarCancelButtonClicked(zoekbar)
        toggleSideMenuView()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNeedsStatusBarAppearanceUpdate()
        self.navigationController!.toolbarHidden = true
        
        //Parse LocalDatastore
        var tableName: String = ""
        
        if self.favoriet == true {
            //favoriete vakanties
            tableName = "Favoriet"
            self.navigationItem.title = "Favorieten"
        } else {
            tableName = "Vakantie"
            self.navigationItem.title = "Vakanties"
        }
        
        LocalDatastore.getTableInLocalDatastoreReady(tableName)
        LocalDatastore.getTableInLocalDatastoreReady("Feedback")
        LocalDatastore.getTableInLocalDatastoreReady("Afbeelding")
        LocalDatastore.getTableInLocalDatastoreReady("Ouder")
        
        if Reachability.isConnectedToNetwork() == false {
            //er is geen internet
            
            if LocalDatastore.isEmptyInLocalDatastore(tableName) {
                //table is leeg
                //melding tonen
                if tableName == "Favoriet" {
                    foutBoxOproepen("Geen favoriete vakanties", "Er zijn nog geen vakanties als favoriet geselecteerd!", self)
                    //self.tableView.reloadData()
                } else {
                    foutBoxOproepen("Geen vakanties", "Verbind met het internet om alle vakanties te bekijken!", self)
                    //self.tableView.reloadData()
                }
            } else {
                //table is opgevuld
                //opvullen
                self.vakanties = LocalDatastore.getAllObjectsFromLocalDatastore(tableName) as [Vakantie]
                self.vakanties2 = self.vakanties
                self.tableView.reloadData()
            }
        } else {
            self.vakanties = LocalDatastore.getAllObjectsFromLocalDatastore(tableName) as [Vakantie]
            self.vakanties2 = self.vakanties
            self.tableView.reloadData()
        }
        
        //SQLite Charlotte
        /*var tableName: String = ""
        
        if self.favoriet == true {
            //favoriete vakanties
            tableName = "Favoriet"
            self.navigationItem.title = "Favorieten"
        } else {
            tableName = "Vakantie"
            self.navigationItem.title = "Vakanties"
        }
        
        getTableInSQLiteReady(tableName)
        
        if Reachability.isConnectedToNetwork() == false {
            //er is geen internet
            
            if isEmptyInSQLite(tableName) {
                //table is leeg
                //melding tonen
                if tableName == "Favoriet" {
                    //foutBoxOproepen("Geen favoriete vakanties", "Er zijn nog geen vakanties als favoriet geselecteerd!", self)
                    //self.tableView.reloadData()
                } else {
                    //foutBoxOproepen("Geen vakanties", "Verbind met het internet om alle vakanties te bekijken!", self)
                    //self.tableView.reloadData()
                }
            } else {
                //table is opgevuld
                //opvullen
                var vakantiesResponse = ParseData.getAlleVakanties()
                
                if vakantiesResponse.1 != nil {
                    self.vakanties = vakantiesResponse.0
                    self.vakanties2 = vakanties
                    self.tableView.reloadData()
                }
            }
        } else {
            var vakantiesResponse = ParseData.getAlleVakanties()
            
            if vakantiesResponse.1 == nil {
                self.vakanties = vakantiesResponse.0
                self.vakanties2 = vakanties
                self.tableView.reloadData()
            }

        }*/

        
        //WERKEND
        /*checkConnectie()
        ParseData.deleteFavorietTable()
        ParseData.vulFavorietTableOp()
        ParseData.deleteFeedbackTable()
        ParseData.vulFeedbackTableOp()
        
        var responseVakanties: ([Vakantie], Int?)
        if PFUser.currentUser() != nil {
            //er is een gebruiker ingelogd
            var ouderResponse = ParseData.getOuderWithEmail(PFUser.currentUser().email)
            var monitorResponse = ParseData.getMonitorWithEmail(PFUser.currentUser().email)
            if ouderResponse.1 == nil {
                //er is een aangemelde ouder teruggevonden
                if favoriet == false {
                    //het zijn gewone vakanties
                    responseVakanties = ParseData.getAlleVakanties()
                } else  {
                    //het zijn favoriete vakanties
                    responseVakanties = ParseData.getFavorieteVakanties(ouderResponse.0)
                    self.navigationItem.title = "Favorieten"
                }
            } else if monitorResponse.1 == nil {
                //er is een aangemelde monitor teruggevonden
                if favoriet == false {
                    //het zijn gewone vakanties
                    responseVakanties = ParseData.getAlleVakanties()
                } else  {
                    //het zijn favoriete vakanties
                    responseVakanties = ParseData.getFavorieteVakanties(monitorResponse.0)
                    self.navigationItem.title = "Favorieten"
                }
            } else {
                //er is geen gebruiker teruggevonden (niet zo goed in code!)
                responseVakanties = ParseData.getAlleVakanties()
                self.navigationItem.title = "Vakanties"
            }
        } else {
            //er is niemand ingelogd
            responseVakanties = ParseData.getAlleVakanties()
            self.navigationItem.title = "Vakanties"
        }
        
        if responseVakanties.1 == nil {
            //er zijn vakanties gevonden
            self.vakanties = responseVakanties.0
            self.vakanties2 = self.vakanties
            self.tableView.reloadData()
        } else {
            foutBoxOproepen("Oeps", "Er zijn geen vakanties als favoriet geselecteerd.", self)
            vakanties2 = []
            vakanties = []
            self.tableView.reloadData()
        }*/
    
        self.vakanties2.sort({ $0.minLeeftijd < $1.maxLeeftijd })
        self.vakanties.sort({ $0.minLeeftijd < $1.maxLeeftijd})
    
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
        
        //Local Datastore
        var scores: [Int] = []
        var sum = 0
        
        var feedbacks: [Feedback] = LocalDatastore.getAllObjectsFromLocalDatastore("Feedback") as [Feedback]
        
        for feed in feedbacks {
            scores.append(feed.score!)
        }
        
        for score in scores {
            sum += score
        }
        
        var gemiddelde: Double = Double(sum) / Double(scores.count)
        return ceil(gemiddelde)
        
        //WERKEND
        /*var feedbackResponse = ParseData.getFeedbackFromVakantie(vakantie)
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
        return ceil(gemiddelde)*/
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
        hideSideMenuView()
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
        hideSideMenuView()
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
        
        //Local Datastore
        var image = LocalDatastore.getAfbeelding(vakantie.id)
        
        //WERKEND
        //var image = ParseData.getAfbeeldingMetVakantieId(vakantie.id)
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
        /*var parseData = ParseData()
        ParseData.deleteAllTables()
        ParseData.createDatabase()*/
        
        
        
        self.refreshControl?.endRefreshing()
        viewDidLoad()
    }
}

func getTableInSQLiteReady(tableName: String) {
    
    var localTableIsEmpty: Bool = isEmptyInSQLite(tableName)
    
    if localTableIsEmpty == true {
        if Reachability.isConnectedToNetwork() == true {
            fillTableInSQLite(tableName)
        }
    } else {
        if Reachability.isConnectedToNetwork() == true {
            updateObjectsInSQLiteFromParse(tableName)
        }
    }
}

func createTable(tableName: String) {
    var columns: [String: SwiftData.DataType] = [:]
    
    if tableName == VAKANTIE_DB {
        columns = VAKANTIE_COLUMNS_DB
    }
    
    
    if let error = SD.createTable(tableName, withColumnNamesAndTypes: columns) {
        println("ERROR: er was een error tijdens het creëeren van de table " + tableName + " in SQLite database.")
    } else {
        println("SUCCESS: table " + tableName + " is gecreëerd.")
    }
}

func isEmptyInSQLite(tableName: String) -> Bool {
    let (resultSet, error) = SD.executeQuery("SELECT * FROM i?", withArgs: [tableName])
    
    if error != nil {
        println("ERROR: er was een error tijdens het controleren of de tabel " + tableName + " leeg is.")
    } else {
        if resultSet.count == 0 {
            return true
        }
        return false
    }
    
    return true
}

func fillTableInSQLite(tableName: String) {
    var query = PFQuery(className: tableName)
    var queryString: String = ""
    var objects: [PFObject] = []
    var objectId: String = ""
    
    objects = query.findObjects() as [PFObject]
    
    var variabelenTypes: [String: SwiftData.DataType] = [:]
    var variabelenNames: [String: String] = [:]
    var variabelen: [String: AnyObject] = [:]
    
    if tableName == VAKANTIE_DB {
        variabelenTypes = VAKANTIE_COLUMNS_DB
        variabelenNames = VAKANTIE_VALUES
    }
    
    //variabelen aanmaken
    for variabeleName in variabelenNames.keys {
        if variabeleName != OBJECT_ID_DB {
            if variabelenTypes[variabeleName] == .StringVal {
                variabelen[variabeleName] = ""
            } else if variabelenTypes[variabeleName] == .IntVal {
                variabelen[variabeleName] = 0
            } else if variabelenTypes[variabeleName] == .DoubleVal {
                variabelen[variabeleName] = 0.0
            } else if variabelenTypes[variabeleName] == .BoolVal {
                variabelen[variabeleName] = false
            }
        }
    }
    
    for object in objects {
        queryString.removeAll(keepCapacity: true)
        objectId.removeAll(keepCapacity: true)
        
        for v in variabelen.keys {
            if variabelenTypes[v] == .StringVal {
                
                if v == VERTREK_DATUM_DB || v == TERUGKEER_DATUM_DB {
                    var datum = object[v] as NSDate
                    variabelen[v] = datum.toS("dd/MM/yyyy")
                } else {
                    if variabelenNames[v] == OPTIONAL && object[v] == nil {
                        variabelen[v] = ""
                    } else {
                        variabelen[v] = object[v] as String
                    }
                }
            } else if variabelenTypes[v] == .IntVal {
                if variabelenNames[v] == OPTIONAL && object[v] == nil {
                    variabelen[v] = 0
                } else {
                    variabelen[v] = object[v] as Int
                }
            } else if variabelenTypes[v] == .DoubleVal {
                if variabelenNames[v] == OPTIONAL && object[v] == nil {
                    variabelen[v] = 0.0
                } else {
                    variabelen[v] = object[v] as Double
                }
            } else if variabelenTypes[v] == .BoolVal {
                if variabelenNames[v] == OPTIONAL && object[v] == nil {
                    variabelen[v] = false
                } else {
                    variabelen[v] = object[v] as Bool
                }
            }
        }
        
        queryString.extend("INSERT INTO " + VAKANTIE_DB + " ")
        queryString.extend("(")
        queryString.extend("objectId, ")
        
        for variabele in variabelen.keys {
            queryString.extend(variabele)
            queryString.extend(", ")
        }
        
        //laatste 2 characters verwijderen (, )
        queryString.substringToIndex(queryString.endIndex.predecessor())
        queryString.substringToIndex(queryString.endIndex.predecessor())
        
        
        /*var range1: Int = countElements(queryString)
        range1 -= 1
        //queryString.removeAtIndex(range1)
        range1 -= 1
        queryString.removeAtIndex(range1)*/
        
        queryString.extend(")")
        queryString.extend(" VALUES ")
        queryString.extend("(i?, ")
        
        for variabele in variabelen.keys {
            queryString.extend("i?, ")
        }
        
        //laatste 2 characters verwijderen (, )
        queryString.substringToIndex(queryString.endIndex.predecessor())
        queryString.substringToIndex(queryString.endIndex.predecessor())
        
        queryString.extend(")")
        
        var arguments: [AnyObject] = []
        
        for value in variabelen.values {
            arguments.append(value)
        }
        
        if let error = SD.executeChange(queryString, withArgs: arguments) {
            println("ERROR: error tijdens het toevoegen van een nieuw object in de table " + tableName + " in SQLite database.")
        }
    }
}


func updateObjectsInSQLiteFromParse(tableName: String) {
    
    var variabelenTypes: [String: SwiftData.DataType] = [:]
    var variabelenNames: [String: String] = [:]
    var variabelen: [String: AnyObject] = [:]
    
    if tableName == VAKANTIE_DB {
        variabelenTypes = VAKANTIE_COLUMNS_DB
        variabelenNames = VAKANTIE_VALUES
    }
    
    let (resultSet, error) = SD.executeQuery("SELECT * FROM " + tableName)
    
    if error != nil {
        println("ERROR: error tijdens updaten van objecten uit table " + tableName + " uit SQLite database tijdens ophalen van alle objecten uit table " + tableName)
    } else {
        for row in resultSet {
            
        }
    }
    
    
    var query = PFQuery(className: tableName)
    
    query.fromLocalDatastore()
    
    var objectsLocalDatastore: [PFObject] = query.findObjects() as [PFObject]
    
    for object in objectsLocalDatastore {
        object.fetch()
    }
    
    var newObjects: [PFObject] = []
    
    var queryNewObjects = PFQuery(className: tableName)
    query.whereKey("objectId", notContainedIn: objectsLocalDatastore)
    
    newObjects = query.findObjects() as [PFObject]
    
    PFObject.pinAll(newObjects)
}

func updateObject(row: SD.SDRow, tableName: String) {
    var query = PFQuery(className: tableName)
    
    var o = PFObject(className: tableName)
    
    var variabelenTypes: [String: SwiftData.DataType] = [:]
    var variabelenNames: [String: String] = [:]
    var variabelen: [String: AnyObject] = [:]
    
    if tableName == VAKANTIE_DB {
        variabelenTypes = VAKANTIE_COLUMNS_DB
        variabelenNames = VAKANTIE_VALUES
    }
    
    
    if let objectId = row[OBJECT_ID_DB]?.asString() {
        
        var object = query.getObjectWithId(objectId)
        
        o.objectId = objectId
        o.fetch()
        
        var queryString: String = ""
        queryString.extend("UPDATE ")
        queryString.extend(tableName)
        queryString.extend(" SET ")
        
        for variabele in variabelenNames.keys {
            queryString.extend(variabele)
            queryString.extend(" = i?, ")
        }
        
        queryString.substringToIndex(queryString.endIndex.predecessor())
        queryString.substringToIndex(queryString.endIndex.predecessor())
        
        queryString.extend(" WHERE objectId = ?")
        
        var values: [AnyObject] = []
        
        for v in variabelenNames.keys {
            if variabelenTypes[v] == .StringVal {
                
                if v == VERTREK_DATUM_DB || v == TERUGKEER_DATUM_DB {
                    var datum = object[v] as NSDate
                    variabelen[v] = datum.toS("dd/MM/yyyy")
                } else {
                    if variabelenNames[v] == OPTIONAL && object[v] == nil {
                        variabelen[v] = ""
                    } else {
                        variabelen[v] = object[v] as String
                    }
                }
            } else if variabelenTypes[v] == .IntVal {
                if variabelenNames[v] == OPTIONAL && object[v] == nil {
                    variabelen[v] = 0
                } else {
                    variabelen[v] = object[v] as Int
                }
            } else if variabelenTypes[v] == .DoubleVal {
                if variabelenNames[v] == OPTIONAL && object[v] == nil {
                    variabelen[v] = 0.0
                } else {
                    variabelen[v] = object[v] as Double
                }
            } else if variabelenTypes[v] == .BoolVal {
                if variabelenNames[v] == OPTIONAL && object[v] == nil {
                    variabelen[v] = false
                } else {
                    variabelen[v] = object[v] as Bool
                }
            }
        }
        
        //enkel als vakanties
        var arguments = sortVariabelenVakantie(variabelen)
        
        if let err = SD.executeChange(queryString, withArgs: arguments) {
            println("ERROR: error tijdens het updaten van object met id " + objectId + " uit table " + tableName + " uit SQLite database.")
        }
        
    }
}

func sortVariabelenVakantie(variabelen: [String: AnyObject]) -> [AnyObject] {
    var values = [AnyObject]()
    
    values[0] = variabelen[TITEL_DB]!
    values[1] = variabelen[LOCATIE_DB]!
    values[2] = variabelen[KORTE_BESCHRIJVING_DB]!
    values[3] = variabelen[VERTREK_DATUM_DB]!
    values[4] = variabelen[TERUGKEER_DATUM_DB]!
    values[5] = variabelen[AANTAL_DAGEN_NACHTEN_DB]!
    values[6] = variabelen[VERVOERWIJZE_DB]!
    values[7] = variabelen[FORMULE_DB]!
    values[8] = variabelen[LINK_DB]!
    values[9] = variabelen[BASIS_PRIJS_DB]!
    values[10] = variabelen[BOND_MOYSON_LEDEN_PRIJS_DB]!
    values[11] = variabelen[STER_PRIJS_1_OUDER_DB]!
    values[12] = variabelen[STER_PRIJS_2_OUDERS_DB]!
    values[13] = variabelen[INBEGREPEN_PRIJS_DB]!
    values[14] = variabelen[MIN_LEEFTIJD_DB]!
    values[15] = variabelen[MAX_LEEFTIJD_DB]!
    values[16] = variabelen[MAX_AANTAL_DEELNEMERS_DB]!
    
    return values
}

func getVakantie(vakantieObject: PFObject) -> Vakantie {
    var vakantie: Vakantie = Vakantie(id: vakantieObject.objectId)
    
    vakantie.titel = vakantieObject["titel"] as? String
    vakantie.locatie = vakantieObject["locatie"] as? String
    vakantie.korteBeschrijving = vakantieObject["korteBeschrijving"] as? String
    vakantie.vertrekdatum = vakantieObject["vertrekdatum"] as NSDate
    vakantie.terugkeerdatum = vakantieObject["terugkeerdatum"] as NSDate
    vakantie.aantalDagenNachten = vakantieObject["aantalDagenNachten"] as? String
    vakantie.vervoerwijze = vakantieObject["vervoerwijze"] as? String
    vakantie.formule = vakantieObject["formule"] as? String
    vakantie.link = vakantieObject["link"] as? String
    vakantie.basisprijs = vakantieObject["basisPrijs"] as? Double
    vakantie.bondMoysonLedenPrijs = vakantieObject["bondMoysonLedenPrijs"] as? Double
    vakantie.sterPrijs1ouder = vakantieObject["sterPrijs1ouder"] as? Double
    vakantie.sterPrijs2ouders = vakantieObject["sterPrijs2ouders"] as? Double
    vakantie.inbegrepenPrijs = vakantieObject["inbegrepenPrijs"] as? String
    vakantie.minLeeftijd = vakantieObject["minLeeftijd"] as Int
    vakantie.maxLeeftijd = vakantieObject["maxLeeftijd"] as? Int
    vakantie.maxAantalDeelnemers = vakantieObject["maxAantalDeelnemers"] as? Int
    
    return vakantie
}