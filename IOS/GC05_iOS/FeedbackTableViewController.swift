import UIKit

class FeedbackTableViewController: UITableViewController, UISearchBarDelegate, UISearchDisplayDelegate {
    
    @IBOutlet var zoekbar: UISearchBar!
    @IBOutlet var addButton: UIBarButtonItem!
    
    var feedbacken: [Feedback] = []
    var feedbacken2: [Feedback] = []
    
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
    //Naam: gaTerugNaarFeedback
    //
    //Werking: - zorgt voor een unwind segue
    //
    //Parameters:
    //  - sender: AnyObject
    //
    //Return:
    //
    @IBAction func gaTerugNaarFeedback(segue: UIStoryboardSegue) {}
    
    //
    //Naam: viewDidLoad
    //
    //Werking: - zorgt ervoor dat de side bar menu verborgen is
    //         - zorgt ervoor dat de cell een dynamische grootte heeft
    //         - zorgt ervoor dat de tool bar verborgen is
    //         - als de gebruiker nil is, wordt de right bar button item verborgen (feedback toevoegen)
    //
    //Parameters:
    //
    //Return:
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        hideSideMenuView()
        
        self.tableView.estimatedRowHeight = 44.0
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        self.setNeedsStatusBarAppearanceUpdate()
        self.navigationController!.toolbarHidden = true
        
        /*var isFeedbackTableLeeg = LocalDatastore.isEmpty(Constanten.TABLE_FEEDBACK)
        
        if isFeedbackTableLeeg == false {
            self.feedbacken = LocalDatastore.getLocalObjects(Constanten.TABLE_FEEDBACK) as [Feedback]
            self.feedbacken2 = self.feedbacken
        } else {
            foutBoxOproepen("Oeps", "Er is nog geen feedback.", self)
            self.tableView.reloadData()
            feedbacken2.sort({ $0.vakantie!.titel < (String($1.score!)) })
            feedbacken2.sort({ $0.vakantie!.titel < (String($1.score!)) })
        }*/
        
        var queryFeedback = Query(tableName: Constanten.TABLE_FEEDBACK)
        
        if !queryFeedback.isEmpty() {
            //self.feedbacken = LocalDatastore.getLocalObjects(Constanten.TABLE_FEEDBACK) as [Feedback]
            self.feedbacken = queryFeedback.getObjects() as [Feedback]
            self.feedbacken2 = self.feedbacken
        } else {
            foutBoxOproepen("Oeps", "Er is nog geen feedback.", self)
            self.tableView.reloadData()
            feedbacken2.sort({ $0.vakantie!.titel < (String($1.score!)) })
        }
        
        
        if PFUser.currentUser() == nil {
            self.navigationItem.rightBarButtonItem = nil
        }
        
        zoekbar.showsScopeBar = true
        zoekbar.delegate = self
    }
    
    //
    //Naam: viewDidAppear
    //
    //Werking: - zorgt ervoor dat de tool bar verborgen is
    //         - herladen van de data
    //
    //Parameters:
    //  - animated: Bool
    //
    //Return:
    //
    override func viewDidAppear(animated: Bool) {
        self.setNeedsStatusBarAppearanceUpdate()
        self.navigationController!.toolbarHidden = true
        self.tableView.reloadData()
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
        zoekGefilterdeFeedback(searchBar.text)
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
        zoekGefilterdeFeedback(searchBar.text)
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
    //Naam: zoekGefilterdeFeedback
    //
    //Werking: - filter naargelang de zoek tekst string in de titel van de feedback
    //
    //Parameters:
    //  - zoek: String
    //
    //Return:
    //
    func zoekGefilterdeFeedback(zoek: String) {
        feedbacken2 = feedbacken.filter { $0.vakantie!.titel!.lowercaseString.rangeOfString(zoek) != nil }
        if zoek.isEmpty {
            self.feedbacken2 = feedbacken
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
        if segue.identifier == "add" {
            let geefFeedback1ViewController = segue.destinationViewController as GeefFeedback1ViewController
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
        return feedbacken2.count
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
        let cell = tableView.dequeueReusableCellWithIdentifier("feedbackCell", forIndexPath: indexPath) as FeedbackCell
        let feedback = feedbacken2[indexPath.row]
        cell.vakantieNaam.text = feedback.vakantie!.titel!
        cell.feedback.text = feedback.waardering!
        cell.score.text = "\(feedback.score!)/5"
        
        return cell
    }
    
    //
    //Naam: refresh
    //
    //Werking: - zorgt ervoor wanneer de gebruiker naar beneden scrolt de data opnieuw wordt herladen
    //         - kijkt of er internet aanwezig is, zo nee melding tonen
    //
    //Parameters:
    //  - sender: UIRefreshControl
    //
    //Return:
    //
    @IBAction func refresh(sender: UIRefreshControl) {
        if Reachability.isConnectedToNetwork() == false {
            toonFoutBoxMetKeuzeNaarInstellingen("Verbind met het internet om uw nieuwste feedback te bekijken of ga naar instellingen.", self)
        }
        /*var parseData = ParseData()
        ParseData.deleteAllTables()
        ParseData.createDatabase()*/
        LocalDatastore.getTableReady(Constanten.TABLE_FEEDBACK)
        self.refreshControl?.endRefreshing()
        viewDidLoad()
    }
}