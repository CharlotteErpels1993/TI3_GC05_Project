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
    
    override func viewDidLoad() {
        // TO DO afbeelding1
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
}