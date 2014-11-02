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
    @IBOutlet weak var doelgroepLabel: UILabel!
    @IBOutlet weak var maxAantalDeelnemersLabel: UILabel!
    
    var vakantie: Vakantie!
    
    override func viewDidLoad() {
        navigationItem.title = vakantie.titel
        beschrijvingLabel.text = vakantie.korteBeschrijving
        
        // TO DO date -> String
        
        //vertrekdatumLabel.text = vakantie.beginDatum
        // aankomstdatumLabel.text = vakantie.terugkeerDatum
        
        aantalDagenNachtenLabel.text = vakantie.aantalDagenNachten
        locatieLabel.text = vakantie.locatie
        inbegrepenPrijsLabel.text = vakantie.inbegrepenPrijs
        doelgroepLabel.text = vakantie.doelgroep
        
        // TO DO int -> String
        // maxAantalDeelnemersLabel.text = vakantie.maxAantalDeelnemers.
        
        
    }
    
}