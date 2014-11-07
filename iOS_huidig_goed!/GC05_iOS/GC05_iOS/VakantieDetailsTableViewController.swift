import UIKit

class VakantieDetailsTableViewController: UITableViewController {
    
    @IBOutlet weak var afbeelding1: UIImageView!
    @IBOutlet weak var afbeelding2: UIImageView!
    @IBOutlet weak var afbeelding3: UIImageView!
    
    @IBOutlet weak var beschrijvingLabel: UILabel!
    @IBOutlet weak var vertrekdatumLabel: UILabel!
    @IBOutlet weak var aankomstdatumLabel: UILabel!
    @IBOutlet weak var aantalDagenNachtenLabel: UILabel!
    @IBOutlet weak var locatieLabel: UILabel!
    @IBOutlet weak var inbegrepenPrijsLabel: UILabel!
    @IBOutlet weak var maxAantalDeelnemersLabel: UILabel!
    
    var vakantie: Vakantie!
    var images: [UIImage] = []
    
    override func viewDidLoad() {
        zoekImage1()
        zoekImage2()
        zoekImage3()
        
       // afbeelding1.setValue(vakantie.image1, forKey: "")
       // afbeelding2 = vakantie.image2
       // afbeelding3 = vakantie.image3
        
        /*for var i = 1; i <= 3; i += 1 {
            if i == 1 {
                afbeelding1.image = images[1]
            } else if i == 2 {
                afbeelding2.image = images[2]
            } else if i == 3 {
                afbeelding3.image = images[3]
            }
        }*/
        
        // TO DO afbeelding2
        // TO DO afbeelding3
        navigationItem.title = vakantie.titel
        beschrijvingLabel.text = vakantie.korteBeschrijving
        vertrekdatumLabel.text = String("Vertrekdatum: \(vakantie.beginDatum)")
        aankomstdatumLabel.text = String("Terugkeerdatum: \(vakantie.terugkeerDatum)")
        aantalDagenNachtenLabel.text = "Aantal dagen/nachten: \(vakantie.aantalDagenNachten)"
        locatieLabel.text = vakantie.locatie
        inbegrepenPrijsLabel.text = vakantie.inbegrepenPrijs
        maxAantalDeelnemersLabel.text = String(vakantie.maxAantalDeelnemers)
    }
    
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
                        self.afbeelding1.image = afb
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
                        self.afbeelding1.image = afb
                        print(afb)
                    } // if - end
                } // getDataInBackgroundWithBlock - end
            } //if - end
        } // getObjectInBackgroundWithId - end
    }
}