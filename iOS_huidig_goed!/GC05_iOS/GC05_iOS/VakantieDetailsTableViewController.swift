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
    var query = PFQuery(className: "Vakantie")
    var beschrijving: String!
    var sectionToDelete = -1
    var favoriet: Bool = false
    var imageHeartFull = UIImage(named: "Heart_Full.png")
    var imageHeartEmpty = UIImage(named: "Heart_Empty.png")
    var score: Double!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNeedsStatusBarAppearanceUpdate()
        self.navigationController!.toolbarHidden = false
        
        //Parse Local Datastore Charlotte
        if PFUser.currentUser() != nil {
            var user: PFUser = PFUser.currentUser()
            var soort = user["soort"] as? String
            LocalDatastore.getTableInLocalDatastoreReady("Favoriet")
            var favorieteVakantie: Favoriet = Favoriet(id: "test")
            
            if soort == "ouder" {
                LocalDatastore.getTableInLocalDatastoreReady("Ouder")
                var ouder = LocalDatastore.getGebruikerWithEmail(PFUser.currentUser().email, tableName: "Ouder")
                favorieteVakantie.gebruiker = ouder
            } else if soort == "monitor" {
                LocalDatastore.getTableInLocalDatastoreReady("Monitor")
                var monitor = LocalDatastore.getGebruikerWithEmail(PFUser.currentUser().email, tableName: "Monitor")
                favorieteVakantie.gebruiker = monitor
            }
            
            favorieteVakantie.vakantie = self.vakantie
            
            if LocalDatastore.isFavorieteVakantie(favorieteVakantie) == true {
                heartButton.setImage(self.imageHeartFull, forState: UIControlState.Normal)
                self.favoriet = true
            } else {
                heartButton.setImage(self.imageHeartEmpty, forState: UIControlState.Normal)
                self.favoriet = false
            }
        }
        
        self.images = LocalDatastore.getAfbeeldingenMetVakantie(vakantie.id)
        
        hideSideMenuView()
        
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
        
        //WERKEND STEFANIE
        /*if PFUser.currentUser() != nil {
        var ouderResponse = ParseData.getOuderWithEmail(PFUser.currentUser().email)
        var monitorResponse = ParseData.getMonitorWithEmail(PFUser.currentUser().email)
        var favorieteVakantie: Favoriet = Favoriet(id: "test")
        
        if ouderResponse.1 == nil {
        favorieteVakantie.gebruiker = ouderResponse.0
        /*favorieteVakantie.vakantie = self.vakantie
        
        if ParseData.isFavorieteVakantie(favorieteVakantie) == true {
        heartButton.setImage(self.imageHeartFull, forState: UIControlState.Normal)
        self.favoriet = true
        } else {
        heartButton.setImage(self.imageHeartEmpty, forState: UIControlState.Normal)
        self.favoriet = false
        }*/
        } else {
        favorieteVakantie.gebruiker = monitorResponse.0
        }
        favorieteVakantie.vakantie = self.vakantie
        
        if ParseData.isFavorieteVakantie(favorieteVakantie) == true {
        heartButton.setImage(self.imageHeartFull, forState: UIControlState.Normal)
        self.favoriet = true
        } else {
        heartButton.setImage(self.imageHeartEmpty, forState: UIControlState.Normal)
        self.favoriet = false
        }
        }
        
        var responseImages: ([UIImage], Int?)
        responseImages = ParseData.getAfbeeldingenMetVakantieId(vakantie.id)
        
        hideSideMenuView()
        
        if responseImages.1 == nil {
        self.images = responseImages.0
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
        }*/
        
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
            var gebruikerPF = PFUser.currentUser()
            var soort: String = gebruikerPF["soort"] as String
            
            if soort == "ouder" || soort == "administrator" {
                self.sectionToDelete = -1
                self.heartButton.hidden = false
                basisprijsLabel.text = String("Basisprijs: \(vakantie.basisprijs!) " + euroSymbol)
                inbegrepenPrijs.text = String("Inbegrepen prijs: \(vakantie.inbegrepenPrijs!) ")
                if (vakantie.bondMoysonLedenPrijs != 0) {
                    bondMoysonPrijsLabel.text = String("Bond moyson prijs: \(vakantie.bondMoysonLedenPrijs!) " + euroSymbol)
                } else {
                    bondMoysonPrijsLabel.text = String("Bond moyson prijs: /")
                }
                if (vakantie.sterPrijs1ouder != 0) {
                    sterprijs1Label.text = String("Ster prijs (1 ouder): \(vakantie.sterPrijs1ouder!) " + euroSymbol)
                } else {
                    sterprijs1Label.text = String("Ster prijs (1 ouder): /")
                }
                if (vakantie.sterPrijs2ouders != 0) {
                    sterPrijs2Label.text = String("Ster prijs (2 ouders): \(vakantie.sterPrijs2ouders!) " + euroSymbol)
                } else {
                    sterPrijs2Label.text = String("Ster prijs (2 ouders): /")
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
    
    override func viewWillAppear(animated: Bool) {
        self.setNeedsStatusBarAppearanceUpdate()
        self.navigationController!.toolbarHidden = false
    }
    
    func gemiddeldeFeedback() -> Double {
        
        //Parse LocalDatastore Charlotte
        LocalDatastore.getTableInLocalDatastoreReady("Feedback")
        
        var scores: [Int] = []
        var sum = 0
        
        //var feedback = LocalDatastore.getFeedbackMetVakantie(self.vakantie)
        //var feedback = LocalDatastore.getLocalObjectsWithColumnConstraints("Feedback", column: "vakantie", columnId: self.vakantie.id) as [Feedback]
        
        var feedback = LocalDatastore.getLocalObjectsWithColumnConstraints("Feedback", queryConstraints: ["vakantie": self.vakantie.id]) as [Feedback]
        
        if feedback.count == 0 {
            return 0.0
        } else {
            for feed in feedback {
                scores.append(feed.score!)
            }
            
            for score in scores {
                sum += score
            }
            
            var gemiddelde: Double = Double(sum) / Double(scores.count)
            return ceil(gemiddelde)
        }
        
        
        //WERKEND Stefanie
        /*ParseData.deleteFeedbackTable()
        ParseData.vulFeedbackTableOp()
        var feedbackResponse = ParseData.getFeedbackFromVakantie(self.vakantie)
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
    
    func zetAantalSterrenGemiddeldeFeedback() {
        //var gemiddeldeFeedbackScore: Double = gemiddeldeFeedback()
        var starGevuld: UIImage = UIImage(named: "star")!
        var starLeeg: UIImage = UIImage(named: "star2")!
        
        if self.score == 1 {
            ster1.image = starGevuld
            ster2.image = starLeeg
            ster3.image = starLeeg
            ster4.image = starLeeg
            ster5.image = starLeeg
        } else if self.score == 2 {
            ster1.image = starGevuld
            ster2.image = starGevuld
            ster3.image = starLeeg
            ster4.image = starLeeg
            ster5.image = starLeeg
        } else if self.score == 3 {
            ster1.image = starGevuld
            ster2.image = starGevuld
            ster3.image = starGevuld
            ster4.image = starLeeg
            ster5.image = starLeeg
        } else if self.score == 4 {
            ster1.image = starGevuld
            ster2.image = starGevuld
            ster3.image = starGevuld
            ster4.image = starGevuld
            ster5.image = starLeeg
        } else if self.score == 5 {
            ster1.image = starGevuld
            ster2.image = starGevuld
            ster3.image = starGevuld
            ster4.image = starGevuld
            ster5.image = starGevuld
        }
    }
    
    @IBAction func openShareMenu(sender: AnyObject) {
        var shareText = "Bekijk zeker en vast deze vakantie! \n \(vakantie.link!) \n -gedeeld via Joetz app"
        let activityViewController = UIActivityViewController(activityItems: [shareText], applicationActivities: nil)
        presentViewController(activityViewController, animated: true, completion: nil)
    }
    
    /*@IBAction func shareToTwitter(sender: AnyObject) {
    var shareToTwitter : SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
    shareToTwitter.setInitialText("Bekijk zeker en vast deze vakantie! \n \(vakantie.link!) \n -gedeeld via Joetz app")
    self.presentViewController(shareToTwitter, animated: true, completion: nil)
    }
    
    @IBAction func shareToFacebook(sender: AnyObject) {
    var shareToFacebook : SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
    shareToFacebook.setInitialText("Bekijk zeker en vast deze vakantie! \n \(vakantie.link!) \n -gedeeld via Joetz app")
    self.presentViewController(shareToFacebook, animated: true, completion: nil)
    }*/
    
    override func viewDidAppear(animated: Bool) {
        if PFUser.currentUser() == nil {
            self.tableView.reloadData()
        }
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if sectionToDelete == -1 {
            return 7
        } else {
            return 6
        }
    }
    
    /*@IBAction func toonEnGeefFeedback(sender: AnyObject) {
    let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    var destViewController: FeedbackTableViewController = mainStoryboard.instantiateViewControllerWithIdentifier("Feedback") as FeedbackTableViewController
    destViewController.vakantieId = self.vakantie.id
    sideMenuController()?.setContentViewController(destViewController)
    hideSideMenuView()
    }*/
    
    
    @IBAction func switchHeart(sender: AnyObject) {
        
        //Parse Local Datastore Charlotte
        var favorieteVakantie: Favoriet = Favoriet(id: "test")
        var user = PFUser.currentUser()
        var soort = user["soort"] as? String
        
        if soort == "ouder" {
            LocalDatastore.getTableInLocalDatastoreReady("Ouder")
            favorieteVakantie.gebruiker = LocalDatastore.getGebruikerWithEmail(user.email, tableName: "Ouder")
        } else if soort == "monitor" {
            LocalDatastore.getTableInLocalDatastoreReady("Monitor")
            favorieteVakantie.gebruiker = LocalDatastore.getGebruikerWithEmail(user.email, tableName: "Monitor")
        }
        
        favorieteVakantie.vakantie = self.vakantie
        
        if self.favoriet == false {
            self.favoriet = true
            heartButton.setImage(self.imageHeartFull, forState: UIControlState.Normal)
            LocalDatastore.parseLocalObject(favorieteVakantie, tableName: "Favoriet")
        } else {
            self.favoriet = false
            heartButton.setImage(self.imageHeartEmpty, forState: UIControlState.Normal)
            ParseData.deleteFavorieteVakantie(favorieteVakantie)
        }
        
        
        //WERKEND Stefanie
        /*var favorieteVakantie: Favoriet = Favoriet(id: "test")
        var ouderResponse = ParseData.getOuderWithEmail(PFUser.currentUser().email)
        var monitorResponse = ParseData.getMonitorWithEmail(PFUser.currentUser().email)
        
        if ouderResponse.1 == nil {
        favorieteVakantie.gebruiker = ouderResponse.0
        } else {
        favorieteVakantie.gebruiker = monitorResponse.0
        }
        
        favorieteVakantie.vakantie = self.vakantie
        
        if favoriet == false {
        favoriet = true
        heartButton.setImage(self.imageHeartFull, forState: UIControlState.Normal)
        ParseData.parseFavorietToDatabase(favorieteVakantie)
        } else {
        favoriet = false
        heartButton.setImage(self.imageHeartEmpty, forState: UIControlState.Normal)
        ParseData.deleteFavorieteVakantie(favorieteVakantie)
        }*/
    }
    
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
            let inschrijvenVakantie1ViewController = segue.destinationViewController as InschrijvenVakantie1ViewController
            inschrijvenVakantie1ViewController.vakantie = vakantie
            inschrijvenVakantie1ViewController.hidesBottomBarWhenPushed = true
        } else if segue.identifier == "geefFeedback" {
            let geefFeedback2TableViewController = segue.destinationViewController as GeefFeedback2ViewController
            geefFeedback2TableViewController.vakantie = vakantie
            geefFeedback2TableViewController.titel = "Geef Feedback"
        }
    }
    
    
}