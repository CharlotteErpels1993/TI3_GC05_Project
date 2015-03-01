import UIKit

class VormingenTableViewController: UITableViewController, UISearchBarDelegate, UISearchDisplayDelegate {
    
    var vormingen: [Vorming] = []
    var vormingen2: [Vorming] = []
    
    @IBOutlet weak var zoekbar: UISearchBar!
    
    //
    //Naam: gaTerugNaarVormingTableView
    //
    //Werking: - zorgt voor een unwind segue
    //
    //Parameters:
    //  - segue: UIStoryboardSegue
    //
    //Return:
    //
    @IBAction func gaTerugNaarVormingTableView(segue: UIStoryboardSegue) {}
    
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
    //         - haalt de vormingen op van de databank
    //
    //Parameters:
    //
    //Return:
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        hideSideMenuView()
        
        //self.vormingen = LocalDatastore.getLocalObjects(Constanten.TABLE_VORMING) as [Vorming]
        var qVormingen = Query(tableName: Constanten.TABLE_VORMING)
        self.vormingen = qVormingen.getObjects() as [Vorming]
        
        self.vormingen2 = self.vormingen
        self.tableView.reloadData()
        
        vormingen2.sort({ $0.titel < $1.titel })
        vormingen.sort({ $0.titel < $1.titel })
        
        zoekbar.showsScopeBar = true
        zoekbar.delegate = self
    }
    
    //
    //Naam: searchBarTextDidBeginEditing
    //
    //Werking: - zorgt ervoor dat de side bar menu wordt verborgen bij het klikken op de search bar
    //         - zet de juiste titel bij annuleren
    //         - roept de methode zoekGefilterdeVormingen op
    //
    //Parameters:
    //  - searchBar: UISearchBar
    //
    //Return:
    //
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        hideSideMenuView()
        setTitleCancelButton(searchBar)
        zoekGefilterdeVormingen(searchBar.text)
    }
    
    //
    //Naam: searchBarCancelButtonClicked
    //
    //Werking: - zorgt ervoor dat bij het klikken op annuleer de tekst weer leeg is
    //         - zorgt ervoor dat het toetsenbord en de cancel button verdwijnd
    //
    //Parameters:
    //  - searchBar: UISearchBar
    //
    //Return:
    //
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchBar.text = ""
        zoekGefilterdeVormingen(searchBar.text)
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
    //Naam: zoekGefilterdeVormingen
    //
    //Werking: - filter naargelang de zoek tekst string in de titel van de vormingen
    //
    //Parameters:
    //  - zoek: String
    //
    //Return:
    //
    func zoekGefilterdeVormingen(zoek: String) {
        vormingen2 = vormingen.filter {$0.titel?.lowercaseString.rangeOfString(zoek) != nil }
        if zoek.isEmpty {
            self.vormingen2 = vormingen
        }
        self.tableView.reloadData()
        
    }
    
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
        if segue.identifier == "toonVorming" {
            let vormingDetailsController = segue.destinationViewController as VormingDetailsTableViewController
            let selectedVorming = vormingen[tableView.indexPathForSelectedRow()!.row]
            vormingDetailsController.vorming = selectedVorming as Vorming
        }
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
        return 1
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
        return vormingen2.count
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
        let cell = tableView.dequeueReusableCellWithIdentifier("vormingCell", forIndexPath: indexPath) as UITableViewCell
        let vorming = vormingen2[indexPath.row]
        cell.textLabel?.text = vorming.titel
        cell.detailTextLabel!.text = "Meer informatie"
        return cell
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
            toonFoutBoxMetKeuzeNaarInstellingen("Verbind met het internet om uw nieuwste vormingen te bekijken of ga naar instellingen.", self)
        }
        LocalDatastore.getTableReady(Constanten.TABLE_VORMING)
        self.refreshControl?.endRefreshing()
        viewDidLoad()
    }
}