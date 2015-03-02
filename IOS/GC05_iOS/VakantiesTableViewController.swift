import UIKit
import Foundation

class VakantiesTableViewController: UITableViewController, UISearchBarDelegate, UISearchDisplayDelegate {
    var vakanties: [Vakantie] = []
    var vakanties2: [Vakantie] = []
    var redColor: UIColor = UIColor(red: CGFloat(232/255.0), green: CGFloat(33/255.0), blue: CGFloat(35/255.0), alpha: CGFloat(1.0))
    var isFavoriet: Bool = false
    var feedbackScores: [Double] = []
    
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
    //Naam: gaTerugNaarInloggen
    //
    //Werking: - zorgt voor een unwind segue
    //
    //Parameters:
    //  - sender: AnyObject
    //
    //Return:
    //
    @IBAction func gaTerugNaarOverzichtVakanties(segue: UIStoryboardSegue) {}
    
    //
    //Naam: viewDidLoad
    //
    //Werking: - zorgt ervoor dat de side bar menu verborgen is
    //         - zorgt ervoor dat de tab bar niet aanwezig is
    //         - bekijkt of de gebruiker internet heeft, zoniet geeft hij een gepaste melding
    //         - bekijkt of de view wordt weergeven als favoriet of als vakanties
    //              * als favoriet: titel veranderd naar favoriet en favorieten wordt opgehaald van de ingelogde gebruiker
    //              * als vakanties: titel veranderd naar vakanties en vakanties wordt opgehaald 
    //              * bij geen internet/wel internet steeds nog een gepast melding bij geen vakanties
    //
    //Parameters:
    //
    //Return:
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        hideSideMenuView()
        self.setNeedsStatusBarAppearanceUpdate()
        self.navigationController!.toolbarHidden = true
        
        if Reachability.isConnectedToNetwork() == false {
            toonFoutBoxMetKeuzeNaarInstellingen("Je hebt geen internet verbinding. Ga naar instellingen om dit aan te passen of ga verder.", self)
        }
        
        if isFavoriet == true && PFUser.currentUser() != nil {
            self.navigationItem.title = "Favorieten"
            //self.vakanties = LocalDatastore.getLocalObjects(Constanten.TABLE_FAVORIET) as [Vakantie]
            
            LocalDatastore.getTableReady(Constanten.TABLE_FAVORIET)
            
            var s = LocalDatastore.getCurrentUserSoort()
            var gebruiker: Gebruiker = Gebruiker(id: "test")
            
            /*var whereGebruiker : [String : AnyObject] = [:]
            whereGebruiker[Constanten.COLUMN_EMAIL] = PFUser.currentUser().email*/
            
            
            if s == "ouder" || s == "monitor" {
                var queryGebruiker = Query()
                queryGebruiker.addWhereEqualTo(Constanten.COLUMN_EMAIL, value: PFUser.currentUser().email)
                
                if s == "ouder" {
                    
                    queryGebruiker.setTableName(Constanten.TABLE_OUDER)
                    
                    /*var queryOuder = LocalDatastore.query(Constanten.TABLE_OUDER, whereArgs: whereGebruiker)
                    gebruiker = LocalDatastore.getFirstObject(Constanten.TABLE_OUDER, query: queryOuder) as Ouder*/
                    
                    
                    //gebruiker = LocalDatastore.getLocalObjectWithColumnConstraints(Constanten.TABLE_OUDER, soortConstraints: [Constanten.COLUMN_EMAIL: Constanten.CONSTRAINT_EQUALTO], equalToConstraints: [Constanten.COLUMN_EMAIL: PFUser.currentUser().email]) as Ouder
                } else if s == "monitor" {
                    
                    queryGebruiker.setTableName(Constanten.TABLE_MONITOR)
                    
                    /*var queryMonitor = LocalDatastore.query(Constanten.TABLE_MONITOR, whereArgs: whereGebruiker)
                    gebruiker = LocalDatastore.getFirstObject(Constanten.TABLE_MONITOR, query: queryMonitor) as Monitor*/
                    
                    //gebruiker = LocalDatastore.getLocalObjectWithColumnConstraints(Constanten.TABLE_MONITOR, soortConstraints: [Constanten.COLUMN_EMAIL: Constanten.CONSTRAINT_EQUALTO], equalToConstraints: [Constanten.COLUMN_EMAIL: PFUser.currentUser().email]) as Monitor
                    
                }
                
                gebruiker = queryGebruiker.getFirstObject() as Gebruiker
            }
            
            /*var whereFavorieten : [String : AnyObject] = [:]
            whereFavorieten[Constanten.COLUMN_GEBRUIKER] = gebruiker.id
            
            var queryFavorieten = LocalDatastore.query(Constanten.TABLE_FAVORIET, whereArgs: whereFavorieten)
            
            var favorieten = LocalDatastore.getObjecten(Constanten.TABLE_FAVORIET, query: queryFavorieten) as [Favoriet]*/
            
            var queryFavorieten = Query(tableName: Constanten.TABLE_FAVORIET)
            queryFavorieten.addWhereEqualTo(Constanten.COLUMN_GEBRUIKER, value: gebruiker.id)
            var favorieten = queryFavorieten.getObjects() as [Favoriet]
            
            
            
            /*var query = PFQuery(className: "Favoriet")
            query.whereKey("gebruiker", equalTo: gebruiker.id)
            query.fromLocalDatastore()
            
            var objecten = query.findObjects() as [PFObject]*/
            //var favorieten: [Favoriet] = []
            
            /*for object in objecten {
                
                //favorieten.append(LocalDatastore.getFavoriet(object) as Favoriet)
            }*/
            
            if favorieten.isEmpty {
                foutBoxOproepen("Oeps...", "Er zijn geen vakanties geselecteerd als favorieten. Ga naar vakanties en selecteer een vakantie als favoriet door middel van op het hartje te klikken.", self)
            }
            
            
            for favoriet in favorieten {
                self.vakanties.append(favoriet.vakantie!)
            }
            
            
            //foutBoxOproepen("Oeps...", "Er zijn geen vakanties geselecteerd als favorieten. Ga naar vakanties en selecteer een vakantie als favoriet door middel van op het hartje te klikken.", self)
        } else {
            self.navigationItem.title = "Vakanties"
            
            var queryVakanties = Query(tableName: Constanten.TABLE_VAKANTIE)
            self.vakanties = queryVakanties.getObjects() as [Vakantie]
            //self.vakanties = LocalDatastore.getAll(Constanten.TABLE_VAKANTIE) as [Vakantie]
            //self.vakanties = LocalDatastore.getLocalObjects(Constanten.TABLE_VAKANTIE) as [Vakantie]
            
            if vakanties.count == 0 && Reachability.isConnectedToNetwork() == false {
                foutBoxOproepen("Oeps...", "Er zijn geen vakanties gevonden. Verbind met het internet om de nieuwste vakanties te bekijken.", self)
            } else if vakanties.count == 0 {
                foutBoxOproepen("Oeps...", "Sorry, er zijn momenteel geen vakanties in onze databank.", self)
            }
        }
        
        self.vakanties2 = vakanties
        self.tableView.reloadData()

        self.vakanties2.sort({ $0.minLeeftijd < $1.minLeeftijd })
        self.vakanties.sort({ $0.minLeeftijd < $1.minLeeftijd})
    
        zoekbar.showsScopeBar = true
        zoekbar.delegate = self
    }
    
    //
    //Naam: viewWillAppear
    //
    //Werking: - zorgt ervoor dat de tab bar niet aanwezig is
    //         - herlaadt de view
    //
    //Parameters:
    //  - animated: Bool
    //
    //Return:
    //
    override func viewWillAppear(animated: Bool) {
        self.setNeedsStatusBarAppearanceUpdate()
        self.navigationController!.toolbarHidden = true
        self.tableView.reloadData()
    }
    
    //
    //Naam: gemiddeldeFeedback
    //
    //Werking: - haalt de feedback op van de meegegeven vakantie
    //         - berekent de gemiddelde score van feedback
    //
    //Parameters:
    //  - vakantie: Vakantie
    //
    //Return: een nummer met de gemiddeldeFeedback van 1 vakantie
    //
    func gemiddeldeFeedback(vakantie: Vakantie) -> Double {
        var feedbackScores: [Int] = []
        var sum = 0
        
        /*var whereFeedbacks : [String : AnyObject] = [:]
        whereFeedbacks[Constanten.COLUMN_VAKANTIE] = vakantie.id
        
        var queryFeedbacks = LocalDatastore.query(Constanten.TABLE_FEEDBACK, whereArgs: whereFeedbacks)
        var feedbacks = LocalDatastore.getObjecten(Constanten.TABLE_FEEDBACK, query: queryFeedbacks) as [Feedback]*/
        
        var queryFeedback = Query(tableName: Constanten.TABLE_FEEDBACK)
        queryFeedback.addWhereEqualTo(Constanten.COLUMN_VAKANTIE, value: vakantie.id)
        var feedbacks = queryFeedback.getObjects() as [Feedback]
        
        /*var arrayFeedback = LocalDatastore.getLocalObjectsWithColumnConstraints(Constanten.TABLE_FEEDBACK, soortConstraints: [Constanten.COLUMN_VAKANTIE: Constanten.CONSTRAINT_EQUALTO], equalToConstraints: [Constanten.COLUMN_VAKANTIE: vakantie.id]) as [Feedback]*/
        
        for var i = 0; i < feedbacks.count; i += 1 {
            var f = feedbacks[i]
            
            if f.goedgekeurd == false {
                feedbacks.removeAtIndex(i)
            }
        }
        
        if feedbacks.count == 0 {
            return 0.0
        } else {
            for feedback in feedbacks {
                feedbackScores.append(feedback.score!)
            }
            
            for feedbackScore in feedbackScores {
                sum += feedbackScore
            }
            
            var gemiddelde: Double = Double(sum) / Double(feedbackScores.count)
            return ceil(gemiddelde)

        }
    }
    
    //
    //Naam: zetAantalSterrenGemiddeldeFeedback
    //
    //Werking: - zet de sterren naargelang de gemiddelde feedback van 1 vakantie (door middel van de methode gemiddeldeFeedback)
    //         - voegt de gemiddelde feedback ook toe aan de array feedbackScores (voor mee te geven naar vakantie detail)
    //
    //Parameters:
    //  - vakantie: Vakantie
    //  - ster1: UIImageView
    //  - ster2: UIImageView
    //  - ster3: UIImageView
    //  - ster4: UIImageView
    //  - ster5: UIImageView
    //
    //Return:
    //
    func zetAantalSterrenGemiddeldeFeedback(vakantie: Vakantie, ster1: UIImageView, ster2: UIImageView, ster3: UIImageView, ster4: UIImageView, ster5: UIImageView) {
        var gemiddeldeFeedbackScore: Double = gemiddeldeFeedback(vakantie)
        var starGevuld: UIImage = UIImage(named: "star")!
        var starLeeg: UIImage = UIImage(named: "star2")!
        
        if gemiddeldeFeedbackScore == 0 {
            ster1.image = starLeeg
            ster2.image = starLeeg
            ster3.image = starLeeg
            ster4.image = starLeeg
            ster5.image = starLeeg
        } else if gemiddeldeFeedbackScore == 1 {
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
        
        feedbackScores.append(gemiddeldeFeedbackScore)
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
        zoekGefilterdeVakanties(searchBar.text)
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
        zoekGefilterdeVakanties(searchBar.text)
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
    //Naam: zoekGefilterdeVakanties
    //
    //Werking: - filter naargelang de zoek tekst string in de titel van de vakanties
    //
    //Parameters:
    //  - zoek: String
    //
    //Return:
    //
    func zoekGefilterdeVakanties(zoek: String) {
        vakanties2 = vakanties.filter { $0.titel!.lowercaseString.rangeOfString(zoek) != nil }
        if zoek.isEmpty {
            self.vakanties2 = vakanties
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
        if segue.identifier == "toonVakantie" {
            let vakantieDetailsController = segue.destinationViewController as VakantieDetailsTableViewController
            let selectedVakantie = vakanties[tableView.indexPathForSelectedRow()!.row]
            vakantieDetailsController.vakantie = selectedVakantie as Vakantie
            vakantieDetailsController.feedbackScore = self.feedbackScores[tableView.indexPathForSelectedRow()!.row]
            vakantieDetailsController.hidesBottomBarWhenPushed = true
        } else if segue.identifier == "inloggen" {
            let inloggenViewController = segue.destinationViewController as InloggenViewController
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
        return vakanties2.count
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
        let cell = tableView.dequeueReusableCellWithIdentifier("vakantieCell", forIndexPath: indexPath) as VakantieCell
        let vakantie = vakanties2[indexPath.row]
        
        //var image = LocalDatastore.getHoofdAfbeelding(vakantie.id)
        var queryImage = Query(tableName: Constanten.TABLE_AFBEELDING)
        queryImage.addWhereEqualTo(Constanten.COLUMN_VAKANTIE, value: vakantie.id)
        var image = queryImage.getFirstObject() as UIImage
        
        
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
    
    //
    //Naam: tableView
    //
    //Werking: - zorgt ervoor wanneer de view wordt geladen als favoriet, de gebruiker de kans heeft op links de slide en zo de vakantie
    //           te verwijderen
    //         - delete de vakantie ook in de databank
    //
    //Parameters:
    //  - tableView: UITableView
    //  - commitEditingStyle editingStyle: UITableViewCellEditingStyle
    //  - forRowAtIndexPath indexPath: NSIndexPath
    //
    //Return:
    //
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if isFavoriet == true {
            if editingStyle == UITableViewCellEditingStyle.Delete {
                vakanties2.removeAtIndex(indexPath.row)
                tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
                
                var favorieteVakantie: Favoriet = Favoriet(id: "test")
                //var user = PFUser.currentUser()
                var soort = PFUser.currentUser()["soort"] as? String
                
                /*if soort == "ouder" || soort == "monitor" {
                    
                    var queryGebruiker = Query()
                    queryGebruiker.addWhere(Constanten.COLUMN_EMAIL, value: PFUser.currentUser().email)
                    
                    if soort == "ouder" {
                        favorieteVakantie.vakantie = vakanties[indexPath.row]
                        queryGebruiker.setTableName(Constanten.TABLE_OUDER)
                        /*var ouder = LocalDatastore.getLocalObjectWithColumnConstraints(Constanten.TABLE_OUDER, soortConstraints: [Constanten.COLUMN_EMAIL: Constanten.CONSTRAINT_EQUALTO], equalToConstraints: [Constanten.COLUMN_EMAIL: PFUser.currentUser().email]) as Ouder
                        favorieteVakantie.gebruiker = ouder*/
                    } else if soort == "monitor" {
                        favorieteVakantie.vakantie = vakanties[indexPath.row]
                        queryGebruiker.setTableName(Constanten.TABLE_MONITOR)
                        /*var monitor = LocalDatastore.getLocalObjectWithColumnConstraints(Constanten.TABLE_MONITOR, soortConstraints: [Constanten.COLUMN_EMAIL: Constanten.CONSTRAINT_EQUALTO], equalToConstraints: [Constanten.COLUMN_EMAIL: PFUser.currentUser().email]) as Monitor
                        favorieteVakantie.gebruiker = monitor*/
                    }*/
                
                    var queryGebruiker = Query()
                    //favorieteVakantie.gebruiker = queryGebruiker.getFirstObject() as? Gebruiker
                    favorieteVakantie.gebruiker = queryGebruiker.getGebruiker(soort!)
                
                
                    //LocalDatastore.deleteFavorieteVakantie(favorieteVakantie)
                    var queryFavoVakantie = Query(tableName: Constanten.TABLE_FAVORIET)
                    queryFavoVakantie.addWhereEqualTo(Constanten.COLUMN_VAKANTIE, value: favorieteVakantie.vakantie?.id)
                    queryFavoVakantie.addWhereEqualTo(Constanten.COLUMN_GEBRUIKER, value: favorieteVakantie.gebruiker?.id)
                    queryFavoVakantie.deleteObjects()
                //}
                
                
            }
        }
    }
    
    //
    //Naam: tableView
    //
    //Werking: - zorgt ervoor wanneer de view wordt geladen als favoriet, de gebruiker de kans heeft op links de slide en zo de vakantie
    //           te verwijderen
    //
    //Parameters:
    //  - tableView: UITableView
    //  - editingStyleForRowAtIndexPath indexPath: NSIndexPath
    //
    //Return: een UITableViewCellEditingStyle naargelang de view wordt geladen als favoriet of als vakantie
    //
    override func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        if isFavoriet == true {
            return .Delete
        } else {
            return .None
        }
    }
    
    //
    //Naam: refresh
    //
    //Werking: - zorgt ervoor wanneer de gebruiker naar beneden scrolt de data opnieuw wordt herladen
    //         - kijk of er internet aanwezig is, zo nee melding tonen (afhankelijk van isFavoriet)
    //
    //Parameters:
    //  - sender: UIRefreshControl
    //
    //Return:
    //
    @IBAction func refresh(sender: UIRefreshControl) {
        if Reachability.isConnectedToNetwork() == false {
            if isFavoriet == true {
                toonFoutBoxMetKeuzeNaarInstellingen("Verbind met het internet om uw nieuwste favorieten te bekijken of ga naar instellingen.", self)
            } else {
                toonFoutBoxMetKeuzeNaarInstellingen("Verbind met het internet om de nieuwste vakanties te bekijken of ga naar instellingen.", self)
            }
        }
        
        LocalDatastore.getTableReady(Constanten.TABLE_VAKANTIE)
        LocalDatastore.getTableReady(Constanten.TABLE_AFBEELDING)
        LocalDatastore.getTableReady(Constanten.TABLE_FEEDBACK)
        LocalDatastore.getTableReady(Constanten.TABLE_OUDER)
        LocalDatastore.getTableReady(Constanten.TABLE_FAVORIET)
        LocalDatastore.getTableReady(Constanten.TABLE_MONITOR)
        
        self.refreshControl?.endRefreshing()
        viewDidLoad()
    }
}