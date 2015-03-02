import UIKit
import Social

class VakantieDetailsTableViewController: UITableViewController {
    
    @IBOutlet weak var afbeelding1: UIImageView!
    @IBOutlet weak var afbeelding2: UIImageView!
    @IBOutlet weak var afbeelding3: UIImageView!
    
    @IBOutlet var feedbackButton: UIButton!
    @IBOutlet var heartButton: UIButton!
    @IBOutlet var vakantieNaamLabel: UILabel!
    @IBOutlet weak var korteBeschrijvingLabel: UILabel!
    @IBOutlet weak var doelgroepLabel: UILabel!
    @IBOutlet weak var vertrekdatumLabel: UILabel!
    @IBOutlet weak var aankomstdatumLabel: UILabel!
    @IBOutlet weak var aantalDagenNachtenLabel: UILabel!
    @IBOutlet weak var locatieLabel: UILabel!
    @IBOutlet weak var maxAantalDeelnemersLabel: UILabel!
    @IBOutlet weak var vervoerwijzeLabel: UILabel!
    @IBOutlet weak var formuleLabel: UILabel!
    
    @IBOutlet weak var ster1: UIImageView!
    @IBOutlet weak var ster2: UIImageView!
    @IBOutlet weak var ster3: UIImageView!
    @IBOutlet weak var ster4: UIImageView!
    @IBOutlet weak var ster5: UIImageView!
    
    @IBOutlet weak var basisprijsLabel: UILabel!
    @IBOutlet weak var bondMoysonPrijsLabel: UILabel!
    @IBOutlet weak var sterprijs1Label: UILabel!
    @IBOutlet weak var sterPrijs2Label: UILabel!
    @IBOutlet weak var inbegrepenPrijs: UILabel!
    
    var vakantie: Vakantie!
    var images: [UIImage] = []
    var sectionToDelete = -1
    var isFavoriet: Bool = false
    var imageHeartFull = UIImage(named: "Heart_Full.png")
    var imageHeartEmpty = UIImage(named: "Heart_Empty.png")
    var feedbackScore: Double!
    
    //
    //Naam: viewDidLoad
    //
    //Werking: - zorgt ervoor dat de toolbar verschijnt (share mogelijkheden)
    //         - zoekt welke gebruiker er op dit moment is ingelogd/niet ingelogd en naargelang de gebruiker functies af/aan zetten
    //         - zorgt ervoor dat de side bar menu wordt verborgen
    //         - zet 1, 2 of 3 afbeeldingen in het detail venster 
    //         - zet alle details van de vakantie in de juiste velden (naargelang de ingelogde gebruiker worden sections verwijerd)
    //
    //Parameters:
    //
    //Return:
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        hideSideMenuView()
        self.setNeedsStatusBarAppearanceUpdate()
        self.navigationController!.toolbarHidden = false
        
        if PFUser.currentUser() != nil {
            
            var soort = LocalDatastore.getCurrentUserSoort()
            
            var favorieteVakantie: Favoriet = Favoriet(id: "test")
            
            var queryGebruiker = Query()
            
            favorieteVakantie.gebruiker = queryGebruiker.getGebruiker(soort)
            
            favorieteVakantie.vakantie = self.vakantie
            
            var queryFavoriet = Query(tableName: Constanten.TABLE_FAVORIET)
            queryFavoriet.addWhereEqualTo(Constanten.COLUMN_VAKANTIE, value: favorieteVakantie.vakantie?.id)
            queryFavoriet.addWhereEqualTo(Constanten.COLUMN_GEBRUIKER, value: favorieteVakantie.gebruiker?.id)
            
            if !queryFavoriet.isEmpty() {
                heartButton.setImage(self.imageHeartFull, forState: UIControlState.Normal)
                self.isFavoriet = true
            } else {
                heartButton.setImage(self.imageHeartEmpty, forState: UIControlState.Normal)
                self.isFavoriet = false
            }
        }
        
        var queryImages = Query(tableName: Constanten.TABLE_AFBEELDING)
        queryImages.addWhereEqualTo(Constanten.COLUMN_VAKANTIE, value: vakantie.id)
        self.images = queryImages.getObjects() as [UIImage]
        
        if self.images.count >= 3 {
            self.afbeelding1.image = self.images[0]
            self.afbeelding2.image = self.images[1]
            self.afbeelding3.image = self.images[2]
        } else if self.images.count == 2 {
            self.afbeelding1.image = self.images[0]
            self.afbeelding2.image = self.images[1]
        } else if self.images.count == 1 {
            self.afbeelding1.image = self.images[0]
        }
        
        var beginDatum: String? = vakantie.vertrekdatum?.toS("dd/MM/yyyy")
        var terugkeerDatum: String? = vakantie.terugkeerdatum?.toS("dd/MM/yyyy")
        
        vakantieNaamLabel.text = vakantie.titel
        korteBeschrijvingLabel.text! = vakantie.korteBeschrijving!
        korteBeschrijvingLabel.sizeToFit()
        doelgroepLabel.text! = ("\(vakantie.minLeeftijd!) - \(vakantie.maxLeeftijd!)")
        
        vertrekdatumLabel.text = "Vertrekdatum: "
        vertrekdatumLabel.text!.extend(beginDatum!)
        aankomstdatumLabel.text = "Aankomstdatum: "
        aankomstdatumLabel.text!.extend(terugkeerDatum!)
        aantalDagenNachtenLabel.text! = String("Aantal dagen/nachten: \(vakantie.aantalDagenNachten!)")
        locatieLabel.text! = String("Locatie: \(vakantie.locatie!)")
        maxAantalDeelnemersLabel.text! = String("Max aantal deelnemers: \(vakantie.maxAantalDeelnemers!)")
        vervoerwijzeLabel.text! = String("Vervoerwijze: \(vakantie.vervoerwijze!)")
        formuleLabel.text! = String("Formule: \(vakantie.formule!)")
        zetAantalSterrenGemiddeldeFeedback()
        
        var euroSymbol: String = "€"
        
        
        if PFUser.currentUser() != nil {
            var soort = LocalDatastore.getCurrentUserSoort()
            if soort == "ouder" || soort == "administrator" {
                self.sectionToDelete = -1
                self.heartButton.hidden = false
                basisprijsLabel.text = String("Basisprijs: \(vakantie.basisprijs!) " + euroSymbol)
                inbegrepenPrijs.text = String("Inbegrepen prijs: \(vakantie.inbegrepenPrijs!) ")
                if (vakantie.bondMoysonLedenPrijs == nil || vakantie.bondMoysonLedenPrijs == 0) {
                    bondMoysonPrijsLabel.text = String("Bond moyson prijs: /")
                } else {
                    bondMoysonPrijsLabel.text = String("Bond moyson prijs: \(vakantie.bondMoysonLedenPrijs!) " + euroSymbol)
                }
                if (vakantie.sterPrijs1ouder == 0 || vakantie.sterPrijs1ouder == nil) {
                    sterprijs1Label.text = String("Ster prijs (1 ouder): /")
                } else {
                    sterprijs1Label.text = String("Ster prijs (1 ouder): \(vakantie.sterPrijs1ouder!) " + euroSymbol)
                }
                if (vakantie.sterPrijs2ouders == 0 || vakantie.sterPrijs2ouders == nil) {
                    sterPrijs2Label.text = String("Ster prijs (2 ouders): /")
                } else {
                    sterPrijs2Label.text = String("Ster prijs (2 ouders): \(vakantie.sterPrijs2ouders!) " + euroSymbol)
                }
                if soort == "administrator" {
                    self.navigationItem.rightBarButtonItem = nil
                    self.heartButton.hidden = true
                }
            } else {
                self.sectionToDelete = 6
                self.tableView.deleteSections(NSIndexSet(index: self.sectionToDelete), withRowAnimation: UITableViewRowAnimation.None)
                self.navigationItem.rightBarButtonItem = nil
            }
        } else {
            self.sectionToDelete = 6
            self.tableView.deleteSections(NSIndexSet(index: self.sectionToDelete), withRowAnimation: UITableViewRowAnimation.None)
            self.navigationItem.rightBarButtonItem = nil
            self.heartButton.hidden = true
            self.feedbackButton.hidden = true
        }
    }
    
    //
    //Naam: viewDidAppear
    //
    //Werking: - zorgt ervoor dat de tab bar terug verschijnt (share mogelijkheden)
    //
    //Parameters:
    //  - animated: Bool
    //
    //Return:
    //
    override func viewDidAppear(animated: Bool) {
        self.navigationController?.toolbarHidden = false
    }
    
    //
    //Naam: zetAantalSterrenGemiddeldeFeedback
    //
    //Werking: - vul alle sterren zodaning op naar gelang de gemiddelde feedback van een gekozen vakantie
    //
    //Parameters:
    //
    //Return:
    //
    func zetAantalSterrenGemiddeldeFeedback() {
        var starGevuld: UIImage = UIImage(named: "star")!
        var starLeeg: UIImage = UIImage(named: "star2")!
        
        if self.feedbackScore == 0 {
            ster1.image = starLeeg
            ster2.image = starLeeg
            ster3.image = starLeeg
            ster4.image = starLeeg
            ster5.image = starLeeg
        } else if self.feedbackScore == 1 {
            ster1.image = starGevuld
            ster2.image = starLeeg
            ster3.image = starLeeg
            ster4.image = starLeeg
            ster5.image = starLeeg
        } else if self.feedbackScore == 2 {
            ster1.image = starGevuld
            ster2.image = starGevuld
            ster3.image = starLeeg
            ster4.image = starLeeg
            ster5.image = starLeeg
        } else if self.feedbackScore == 3 {
            ster1.image = starGevuld
            ster2.image = starGevuld
            ster3.image = starGevuld
            ster4.image = starLeeg
            ster5.image = starLeeg
        } else if self.feedbackScore == 4 {
            ster1.image = starGevuld
            ster2.image = starGevuld
            ster3.image = starGevuld
            ster4.image = starGevuld
            ster5.image = starLeeg
        } else if self.feedbackScore == 5 {
            ster1.image = starGevuld
            ster2.image = starGevuld
            ster3.image = starGevuld
            ster4.image = starGevuld
            ster5.image = starGevuld
        }
    }
    
    //
    //Naam: openShareMenu
    //
    //Werking: - zet een vaste tekst voor het delen
    //         - zorgt ervoor dat er wanneer er op de action button wordt geklikt de geïnstalleerde apps worden getoond om te delen
    //
    //Parameters:
    //  - sender: AnyObject
    //
    //Return:
    //
    @IBAction func openShareMenu(sender: AnyObject) {
        var shareText = "Bekijk zeker en vast deze vakantie! \n \(vakantie.link!) \n -gedeeld via Joetz app"
        let activityViewController = UIActivityViewController(activityItems: [shareText], applicationActivities: nil)
        presentViewController(activityViewController, animated: true, completion: nil)
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
            return 7
        } else {
            return 6
        }
    }
    
    //
    //Naam: switchHear
    //
    //Werking: - zorgt ervoor wanneer een ingelogde gebruiker op het hartje (wordt rood hartje) klikt, deze in de favorieten komt
    //         - zorgt ervoor wanneer een ingelogde gebruiker op het hartje (wordt wit hartje) klikt, deze uit de favorieten wordt
    //           verwijderd
    //         - schrijft de gekozen niet favoriete/favoriete vakantie ook naar de database
    //
    //Parameters:
    //  - sender: AnyObject
    //
    //Return:
    //
    @IBAction func switchHeart(sender: AnyObject) {
        var favorieteVakantie: Favoriet = Favoriet(id: "test")
        var user = PFUser.currentUser()
        var soort = user["soort"] as? String
        
        var queryGebruiker = Query()
        favorieteVakantie.gebruiker = queryGebruiker.getGebruiker(soort!)
        
        favorieteVakantie.vakantie = self.vakantie
        
        if self.isFavoriet == false {
            self.isFavoriet = true
            heartButton.setImage(self.imageHeartFull, forState: UIControlState.Normal)
            //ParseToDatabase.parseFavoriet(favorieteVakantie)
            FavorietLD.insert(favorieteVakantie)
            
        } else {
            self.isFavoriet = false
            heartButton.setImage(self.imageHeartEmpty, forState: UIControlState.Normal)
            var queryFavoriet = Query(tableName: Constanten.TABLE_FAVORIET)
            queryFavoriet.addWhereEqualTo(Constanten.COLUMN_VAKANTIE, value: favorieteVakantie.vakantie?.id)
            queryFavoriet.addWhereEqualTo(Constanten.COLUMN_GEBRUIKER, value: favorieteVakantie.gebruiker?.id)
            queryFavoriet.deleteObjects()
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
        if section == 4 {
            return 3
        } else if section == 5 {
            return 4
        } else if section == 6 {
            if self.sectionToDelete == -1 {
                return 5
            } else {
                return 0
            }
        } else if section == 1 {
            return 2
        } else {
            return 1
        }
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
        if segue.identifier == "afbeeldingen" {
            let bekijkAfbeeldingViewController = segue.destinationViewController as AfbeeldingenViewController
            if self.images.count != 0 {
                bekijkAfbeeldingViewController.images = self.images
            }
            bekijkAfbeeldingViewController.hidesBottomBarWhenPushed = true
        } else if segue.identifier == "korteBeschrijvingVakantie" {
            let extraTekstViewController = segue.destinationViewController as ExtraTekstViewController
            extraTekstViewController.tekst = self.vakantie.korteBeschrijving!
            extraTekstViewController.naam = self.vakantie.titel!
            extraTekstViewController.type = 1
            extraTekstViewController.hidesBottomBarWhenPushed = true
        } else if segue.identifier == "inbegrepenPrijs" {
            let extraTekstViewController = segue.destinationViewController as ExtraTekstViewController
            extraTekstViewController.tekst = self.vakantie.inbegrepenPrijs!
            extraTekstViewController.type = 2
            extraTekstViewController.hidesBottomBarWhenPushed = true
        } else if segue.identifier == "inschrijven" {
            let inschrijvenVakantie2ViewController = segue.destinationViewController as InschrijvenVakantie2ViewController
            inschrijvenVakantie2ViewController.vakantie = vakantie
            inschrijvenVakantie2ViewController.hidesBottomBarWhenPushed = true
        } else if segue.identifier == "geefFeedback" {
            let geefFeedback2TableViewController = segue.destinationViewController as GeefFeedback2ViewController
            geefFeedback2TableViewController.vakantie = vakantie
            geefFeedback2TableViewController.titel = "Geef Feedback"
        }
    }
}