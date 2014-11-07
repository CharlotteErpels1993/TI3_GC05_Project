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
    @IBOutlet weak var prijsInbegrepenLabel: UILabel!
    @IBOutlet weak var maxAantalDeelnemersLabel: UILabel!
    @IBOutlet weak var vervoerwijzeLabel: UILabel!
    @IBOutlet weak var formuleLabel: UILabel!
    
    @IBOutlet weak var basisprijsLabel: UILabel!
    @IBOutlet weak var bondMoysonPrijsLabel: UILabel!
    @IBOutlet weak var sterprijs1Label: UILabel!
    @IBOutlet weak var sterPrijs2Label: UILabel!
    
    var vakantie: Vakantie!
    var images: [UIImage] = []
    var ouder: Ouder?
    
    override func viewDidLoad() {
        zoekImage1()
        zoekImage2()
        zoekImage3()
        
        navigationItem.title = vakantie.titel
        korteBeschrijvingLabel.text = vakantie.korteBeschrijving
        doelgroepLabel.text = vakantie.doelgroep
        vertrekdatumLabel.text = String("Vertrekdatum: \(vakantie.beginDatum)")
        aankomstdatumLabel.text = String("Aankomstdatum: \(vakantie.terugkeerDatum)")
        aantalDagenNachtenLabel.text = String("Aantal dagen/nachten: \(vakantie.aantalDagenNachten)")
        locatieLabel.text = String("Locatie: \(vakantie.locatie)")
        prijsInbegrepenLabel.text = String("Inbegrepen in de prijs: \(vakantie.inbegrepenPrijs)")
        maxAantalDeelnemersLabel.text = String("Max aantal deelnemers: \(vakantie.maxAantalDeelnemers)")
        vervoerwijzeLabel.text = String("Vervoerwijze: \(vakantie.vervoerwijze)")
        formuleLabel.text = String("Formule: \(vakantie.formule)")
        
        if ouder != nil {
            basisprijsLabel.text = String("Basisprijs: \(vakantie.basisprijs)")
            if (vakantie.bondMoysonLedenPrijs != -1) {
                bondMoysonPrijsLabel.text = String("Bond moyson prijs: \(vakantie.bondMoysonLedenPrijs)")
            } else { bondMoysonPrijsLabel.hidden = true }
            if (vakantie.sterPrijs1ouder != -1) {
                sterprijs1Label.text = String("Ster prijs (1 ouder): \(vakantie.sterPrijs1ouder)")
            } else { bondMoysonPrijsLabel.hidden = true }
            if (vakantie.sterPrijs2ouders != -1) {
                sterPrijs2Label.text = String("Ster prijs (2 ouders): \(vakantie.sterPrijs2ouders)")
            } else { bondMoysonPrijsLabel.hidden = true }
        }
    }
    
    /*override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        TO DO 
    }*/
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "bekijkAfbeelding" {
            let bekijkAfbeeldingViewController = segue.destinationViewController as BekijkAfbeeldingViewController
            bekijkAfbeeldingViewController.afbeeldingId = afbeelding1.image
        }
    }


    
    func zoekImage1() {
        var query = PFQuery(className: "Vakantie")
        query.getObjectInBackgroundWithId(vakantie.id) {
            (vakantie: PFObject!, error: NSError!) -> Void in
            if error == nil {
                let imageFile = vakantie["vakAfbeelding1"] as PFFile
                imageFile.getDataInBackgroundWithBlock {
                    (imageData: NSData!, error: NSError!) -> Void in
                    if error == nil {
                        var afb = UIImage(data: imageData)
                        self.afbeelding1.image = afb
                    } // if - end
                } // getDataInBackgroundWithBlock - end
            } //if - end
        } // getObjectInBackgroundWithId - end
    }
    
    func zoekImage2() {
        var query = PFQuery(className: "Vakantie")
        query.getObjectInBackgroundWithId(vakantie.id) {
            (vakantie: PFObject!, error: NSError!) -> Void in
            if error == nil {
                let imageFile = vakantie["vakAfbeelding2"] as PFFile
                imageFile.getDataInBackgroundWithBlock {
                    (imageData: NSData!, error: NSError!) -> Void in
                    if error == nil {
                        var afb = UIImage(data: imageData)
                        self.afbeelding2.image = afb
                    } // if - end
                } // getDataInBackgroundWithBlock - end
            } //if - end
        } // getObjectInBackgroundWithId - end
    }
    
    func zoekImage3() {
        var query = PFQuery(className: "Vakantie")
        query.getObjectInBackgroundWithId(vakantie.id) {
            (vakantie: PFObject!, error: NSError!) -> Void in
            if error == nil {
                let imageFile = vakantie["vakAfbeelding3"] as PFFile
                imageFile.getDataInBackgroundWithBlock {
                    (imageData: NSData!, error: NSError!) -> Void in
                    if error == nil {
                        var afb = UIImage(data: imageData)
                        self.afbeelding3.image = afb
                        print(afb)
                    } // if - end
                } // getDataInBackgroundWithBlock - end
            } //if - end
        } // getObjectInBackgroundWithId - end
    }
}