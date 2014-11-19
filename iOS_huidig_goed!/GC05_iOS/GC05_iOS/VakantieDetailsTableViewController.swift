import UIKit

class VakantieDetailsTableViewController: UITableViewController {
    
    @IBOutlet weak var afbeelding1: UIImageView!
    @IBOutlet weak var afbeelding2: UIImageView!
    @IBOutlet weak var afbeelding3: UIImageView!
    
    
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
    //var ouder: Ouder?
    //var currentUser: PFUser?
    var query = PFQuery(className: "Vakantie")
    var beschrijving: String!
    var sectionToDelete = -1;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var activityIndicator = getActivityIndicatorView(self)
        
        zoekImages()
        hideSideMenuView()
        query.getObjectInBackgroundWithId(vakantie.id) {
            (vakantie: PFObject!, error: NSError!) -> Void in
            if error == nil {
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
        }
        
        var beginDatum: String? = vakantie.beginDatum?.toS("dd/MM/yyyy")
        var terugkeerDatum: String? = vakantie.terugkeerDatum?.toS("dd/MM/yyyy")
        
        navigationItem.title = vakantie.titel
        korteBeschrijvingLabel.text = vakantie.korteBeschrijving
        korteBeschrijvingLabel.sizeToFit()
        doelgroepLabel.text = vakantie.doelgroep
        vertrekdatumLabel.text = "Vertrekdatum: "
        vertrekdatumLabel.text?.extend(beginDatum!)
        aankomstdatumLabel.text = "Aankomstdatum: "
        aankomstdatumLabel.text?.extend(terugkeerDatum!)
        aantalDagenNachtenLabel.text = String("Aantal dagen/nachten: \(vakantie.aantalDagenNachten)")
        locatieLabel.text = String("Locatie: \(vakantie.locatie)")
        maxAantalDeelnemersLabel.text = String("Max aantal deelnemers: \(vakantie.maxAantalDeelnemers)")
        vervoerwijzeLabel.text = String("Vervoerwijze: \(vakantie.vervoerwijze)")
        formuleLabel.text = String("Formule: \(vakantie.formule)")
        
        var euroSymbol: String = "€"
        
        if PFUser.currentUser() != nil {
        var gebruikerPF = PFUser.currentUser()
        var soort: String = gebruikerPF["soort"] as String
        
            if soort == "ouder" {
                basisprijsLabel.text = String("Basisprijs: \(vakantie.basisprijs) " + euroSymbol)
                inbegrepenPrijs.text = String("Inbegrepen prijs: \(vakantie.inbegrepenPrijs) ")
                if (vakantie.bondMoysonLedenPrijs != -1) {
                    bondMoysonPrijsLabel.text = String("Bond moyson prijs: \(vakantie.bondMoysonLedenPrijs) " + euroSymbol)
                } else {
                    bondMoysonPrijsLabel.text = String("Bond moyson prijs: /")
                }
                if (vakantie.sterPrijs1ouder != -1) {
                    sterprijs1Label.text = String("Ster prijs (1 ouder): \(vakantie.sterPrijs1ouder) " + euroSymbol)
                } else {
                    sterprijs1Label.text = String("Ster prijs (1 ouder): /")
                }
                if (vakantie.sterPrijs2ouders != -1) {
                    sterPrijs2Label.text = String("Ster prijs (2 ouders): \(vakantie.sterPrijs2ouders) " + euroSymbol)
                } else {
                    sterPrijs2Label.text = String("Ster prijs (2 ouders): /")
                }
            } else {
                self.navigationItem.rightBarButtonItem = nil
            }
        } else {
            self.sectionToDelete = 5;
            self.tableView.deleteSections(NSIndexSet(index: self.sectionToDelete), withRowAnimation: UITableViewRowAnimation.None)
            self.navigationItem.rightBarButtonItem = nil
        }
        activityIndicator.stopAnimating()
    }
    
    override func viewDidAppear(animated: Bool) {
        //super.viewDidAppear()
        if PFUser.currentUser() == nil {
        /*self.sectionToDelete = 5;
        self.tableView.deleteSections(NSIndexSet(index: self.sectionToDelete), withRowAnimation: UITableViewRowAnimation.None)
        basisprijsLabel = nil
        bondMoysonPrijsLabel = nil
        sterprijs1Label = nil
        sterPrijs2Label = nil
        bondMoysonPrijsLabel = nil
        inbegrepenPrijs = nil*/
        self.tableView.reloadData()
        }
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if sectionToDelete == -1 {
            return 6
        } else {
            return 5
        }
            //return 5 - 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 3 {
            return 3
        } else if section == 4 {
            return 4
        } else if section == 5 {
            if self.sectionToDelete == -1 {
                return 5
            } else {
                return 0
            }
        } else {
            return 1
        }
    }
    
    
    /*override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        //tableView.deleteSelections(NSIndexSet(index: 5), withRowAnimation: UITableViewRowAnimation.None)
        tableView.deleteSections(NSIndexSet(index: 5), withRowAnimation: UITableViewRowAnimation.None)
    }*/
    
    func zoekImages() {
        var query = PFQuery(className: "Afbeelding")
        query.whereKey("VakantieID", equalTo: vakantie.id)
        query.findObjectsInBackgroundWithBlock({(NSArray objects, NSError error) in
            if(error == nil) {
                
                for object in objects {
                    let imageFile = object["Afbeelding"] as PFFile
                    imageFile.getDataInBackgroundWithBlock { (imageData: NSData!, error: NSError!) -> Void in
                        if error == nil {
                            var afb = UIImage(data: imageData)
                            self.images.append(afb!)
                        }
                        
                    }
                }
            }
        })
    }
    
    /*override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        TO DO
    }*/
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "afbeeldingen" {
            /*var afb1 = afbeelding1.image
            var afb2 = afbeelding2.image
            var afb3 = afbeelding3.image*/
            let bekijkAfbeeldingViewController = segue.destinationViewController as AfbeeldingenViewController
            /*bekijkAfbeeldingViewController.afb1 = afb1
            bekijkAfbeeldingViewController.afb2 = afb2
            bekijkAfbeeldingViewController.afb3 = afb3*/
            bekijkAfbeeldingViewController.images = self.images
        } else if segue.identifier == "korteBeschrijvingVakantie" {
            let extraTekstViewController = segue.destinationViewController as ExtraTekstViewController
            extraTekstViewController.tekst = vakantie.korteBeschrijving
            extraTekstViewController.type = 1
        } else if segue.identifier == "inbegrepenPrijs" {
            //let inbegrepenPrijsViewController = segue.destinationViewController as InbegrepenPrijsTableView
            //inbegrepenPrijsViewController.tekst = inbegrepenPrijs.text
            let extraTekstViewController = segue.destinationViewController as ExtraTekstViewController
            extraTekstViewController.tekst = vakantie.inbegrepenPrijs
            extraTekstViewController.type = 2
        } else if segue.identifier == "inschrijven" {
            let inschrijvenVakantie1ViewController = segue.destinationViewController as InschrijvenVakantie1ViewController
            inschrijvenVakantie1ViewController.vakantie = vakantie
            //inschrijvenVakantie1ViewController.ouder = ouder
        }
    }


    
    /*func zoekImage1(vakantie: PFObject!) {
                  let imageFile = vakantie["vakAfbeelding1"] as PFFile
                imageFile.getDataInBackgroundWithBlock {
                    (imageData: NSData!, error: NSError!) -> Void in
                    if error == nil {
                        var afb = UIImage(data: imageData)
                        self.afbeelding1.image = afb
                    } // if - end
                } // getDataInBackgroundWithBlock - end
    }
    
    func zoekImage2(vakantie: PFObject!) {
                let imageFile = vakantie["vakAfbeelding2"] as PFFile
                imageFile.getDataInBackgroundWithBlock {
                    (imageData: NSData!, error: NSError!) -> Void in
                    if error == nil {
                        var afb = UIImage(data: imageData)
                        self.afbeelding2.image = afb
                    } // if - end
                } // getDataInBackgroundWithBlock - end
    }
    
    func zoekImage3(vakantie: PFObject!) {
                let imageFile = vakantie["vakAfbeelding3"] as PFFile
                imageFile.getDataInBackgroundWithBlock {
                    (imageData: NSData!, error: NSError!) -> Void in
                    if error == nil {
                        var afb = UIImage(data: imageData)
                        self.afbeelding3.image = afb
                        print(afb)
                    } // if - end
                } // getDataInBackgroundWithBlock - end
    }*/
}