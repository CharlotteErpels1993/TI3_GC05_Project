import UIKit
import Social

class VakantieDetailsTableViewController: UITableViewController {
    
    @IBOutlet weak var afbeelding1: UIImageView!
    @IBOutlet weak var afbeelding2: UIImageView!
    @IBOutlet weak var afbeelding3: UIImageView!
    
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if PFUser.currentUser() != nil {
            var ouderResponse = ParseData.getOuderWithEmail(PFUser.currentUser().email)
            var favorieteVakantie: Favoriet = Favoriet(id: "test")
        
            if ouderResponse.1 == nil {
                favorieteVakantie.ouder = ouderResponse.0
                favorieteVakantie.vakantie = self.vakantie
            }
        
            if ParseData.isFavorieteVakantie(favorieteVakantie) == true {
                heartButton.setImage(self.imageHeartFull, forState: UIControlState.Normal)
                self.favoriet = true
            } else {
                heartButton.setImage(self.imageHeartEmpty, forState: UIControlState.Normal)
                self.favoriet = false
            }
        }
        
        //zoekImages()
        
        var responseImages: ([UIImage], Int?)
        responseImages = ParseData.getAfbeeldingenMetVakantieId(vakantie.id)
        
        //self.images = ParseData.getAfbeeldingenMetVakantieId(vakantie.id)
        
        hideSideMenuView()
        
        if responseImages.1 == nil {
            //er zijn images
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
        }
        
        //self.images = responseImages.0
        
                /*if self.images.count >= 3 {
                    self.afbeelding1.image = self.images[0]
                    self.afbeelding2.image = self.images[1]
                    self.afbeelding3.image = self.images[2]
                } else if self.images.count == 2 {
                    self.afbeelding1.image = self.images[0]
                    self.afbeelding2.image = self.images[1]
                } else if self.images.count == 1 {
                    self.afbeelding1.image = self.images[0]
                }*/
        
        var beginDatum: String? = vakantie.vertrekdatum?.toS("dd/MM/yyyy")
        var terugkeerDatum: String? = vakantie.terugkeerdatum?.toS("dd/MM/yyyy")
        
        //navigationItem.title = vakantie.titel
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
        
        var euroSymbol: String = "€"
        
        if PFUser.currentUser() != nil {
            var gebruikerPF = PFUser.currentUser()
            var soort: String = gebruikerPF["soort"] as String
        
            if soort == "ouder" {
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
            } else {
                self.sectionToDelete = 7 // prijs
                self.tableView.deleteSections(NSIndexSet(index: self.sectionToDelete), withRowAnimation: UITableViewRowAnimation.None)
                self.navigationItem.rightBarButtonItem = nil
                self.heartButton.hidden = true
            }
        } else {
            self.sectionToDelete = 7 // prijs
            self.tableView.deleteSections(NSIndexSet(index: self.sectionToDelete), withRowAnimation: UITableViewRowAnimation.None)
            self.navigationItem.rightBarButtonItem = nil
            self.heartButton.hidden = true
        }
    }
    
    @IBAction func shareToTwitter(sender: AnyObject) {
        var shareToTwitter : SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
        shareToTwitter.setInitialText("Bekijk zeker en vast deze vakantie! \n \(vakantie.link!) \n -gedeeld via Joetz app")
        //shareToTwitter.addImage(UIImage(named: "32.png"))
        self.presentViewController(shareToTwitter, animated: true, completion: nil)
    }
    
    @IBAction func shareToFacebook(sender: AnyObject) {
        var shareToFacebook : SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
        shareToFacebook.setInitialText("Bekijk zeker en vast deze vakantie! \n \(vakantie.link!) \n -gedeeld via Joetz app")
        //shareToFacebook.addImage(UIImage(named: "32.png"))
        self.presentViewController(shareToFacebook, animated: true, completion: nil)
    }
    
    override func viewDidAppear(animated: Bool) {
        if PFUser.currentUser() == nil {
            self.tableView.reloadData()
        }
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if sectionToDelete == -1 {
            return 8
        } else {
            return 7
        }
    }
    @IBAction func switchHeart(sender: AnyObject) {
        
        var favorieteVakantie: Favoriet = Favoriet(id: "test")
        var ouderResponse = ParseData.getOuderWithEmail(PFUser.currentUser().email)
        
        if ouderResponse.1 == nil {
            //er is een ouder gevonden
            favorieteVakantie.ouder = ouderResponse.0
        }
        
        favorieteVakantie.vakantie = self.vakantie
        
        if favoriet == false {
            favoriet = true
            // switch image
            heartButton.setImage(self.imageHeartFull, forState: UIControlState.Normal)
            
            // schrijf naar database
            ParseData.parseFavorietToDatabase(favorieteVakantie)
            
            //ParseData.deleteFavorietTable()
            //ParseData.vulFavorietTableOp()
            
            
            
        } else {
            favoriet = false
            // switch image
            heartButton.setImage(self.imageHeartEmpty, forState: UIControlState.Normal)
            
            // haal terug uit de database
            ParseData.deleteFavorieteVakantie(favorieteVakantie)
        
        
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 5 {
            return 3
        } else if section == 6 {
            return 4
        } else if section == 7 {
            if self.sectionToDelete == -1 {
                return 5
            } else {
                return 0
            }
        } else if section == 0 {
            if self.sectionToDelete == -1 {
                return 1
            } else {
                return 0
            }
        } else {
            return 1
        }
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "afbeeldingen" {
            let bekijkAfbeeldingViewController = segue.destinationViewController as AfbeeldingenViewController
            
            //als er geen images zijn
            if self.images.count != 0 {
                bekijkAfbeeldingViewController.images = self.images
            }
            
            //bekijkAfbeeldingViewController.images = self.images
        } else if segue.identifier == "korteBeschrijvingVakantie" {
            let extraTekstViewController = segue.destinationViewController as ExtraTekstViewController
            extraTekstViewController.tekst = vakantie.korteBeschrijving
            extraTekstViewController.type = 1
        } else if segue.identifier == "inbegrepenPrijs" {
            let extraTekstViewController = segue.destinationViewController as ExtraTekstViewController
            extraTekstViewController.tekst = vakantie.inbegrepenPrijs
            extraTekstViewController.type = 2
        } else if segue.identifier == "inschrijven" {
            let inschrijvenVakantie1ViewController = segue.destinationViewController as InschrijvenVakantie1ViewController
            inschrijvenVakantie1ViewController.vakantie = vakantie
        }
    }
}