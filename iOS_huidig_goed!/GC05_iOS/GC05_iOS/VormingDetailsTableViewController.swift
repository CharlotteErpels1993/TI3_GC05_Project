import UIKit

class VormingDetailsTableViewController: UITableViewController {

    var monitor: Monitor!
    var vorming: Vorming!
    var euro: String = "€"
    
    @IBOutlet weak var korteBeschrijvingLabel: UILabel!
    @IBOutlet weak var criteriaDeelnemersLabel: UILabel!
    @IBOutlet weak var locatieLabel: UILabel!
    @IBOutlet weak var websiteLocatieLabel: UILabel!
    @IBOutlet weak var prijsLabel: UILabel!
    @IBOutlet weak var betalingsWijzeLabel: UILabel!
    @IBOutlet weak var periodesLabel: UILabel!
    @IBOutlet weak var tipsLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        korteBeschrijvingLabel.text = vorming.korteBeschrijving
        criteriaDeelnemersLabel.text = vorming.criteriaDeelnemers
        locatieLabel.text = String("Locatie: \(vorming.locatie)")
        websiteLocatieLabel.text = ("Webiste locatie: \(vorming.websiteLocatie)")
        prijsLabel.text = String("Prijs: \(vorming.prijs) " + euro)
        betalingsWijzeLabel.text = String("Betalingswijze: \(vorming.betalingWijze)")
        periodesLabel.text = vorming.periodes
        tipsLabel.text = vorming.tips
    }
}