import UIKit
import CoreData

class VormingDetailsTableViewController: UITableViewController {

    //var monitor: Monitor!
    var vorming: Vorming!
    var euro: String = "€"
    var fetchedResultController: NSFetchedResultsController = NSFetchedResultsController()
    
    @IBOutlet weak var korteBeschrijvingLabel: UILabel!
    @IBOutlet weak var criteriaDeelnemersLabel: UILabel!
    @IBOutlet weak var locatieLabel: UILabel!
    @IBOutlet weak var websiteLocatieLabel: UILabel!
    @IBOutlet weak var prijsLabel: UILabel!
    @IBOutlet weak var betalingsWijzeLabel: UILabel!
    @IBOutlet weak var periodesLabel: UILabel!
    @IBOutlet weak var tipsLabel: UILabel!
    
    @IBAction func toggle(sender: AnyObject) {
        toggleSideMenuView()
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var activityIndicator = getActivityIndicatorView(self)
        
        navigationItem.title = vorming.titel
        
        korteBeschrijvingLabel.text = vorming.korteBeschrijving
        criteriaDeelnemersLabel.text = vorming.criteriaDeelnemers
        locatieLabel.text = String("Locatie: \(vorming.locatie)")
        websiteLocatieLabel.text = ("Webiste locatie: \(vorming.websiteLocatie)")
        prijsLabel.text = String("Prijs: \(vorming.prijs) " + euro)
        betalingsWijzeLabel.text = String("Betalingswijze: \(vorming.betalingWijze)")
        periodesLabel.text = vorming.periodesToString()
        tipsLabel.text = vorming.tips

        activityIndicator.stopAnimating()
    }
    
    override func viewDidAppear(animated: Bool) {
        tableView.reloadData()
        
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "inschrijven" {
            let inschrijvenVormingViewController = segue.destinationViewController as InschrijvenVormingViewController
            //inschrijvenVormingViewController.monitor = self.monitor
            inschrijvenVormingViewController.vorming = self.vorming
            inschrijvenVormingViewController.pickerData = vorming.periodes
        } else if segue.identifier == "korteBeschrijvingVorming" {
            let extraTekstViewController = segue.destinationViewController as ExtraTekstViewController
            extraTekstViewController.tekst = vorming.korteBeschrijving
            extraTekstViewController.type = 1
        } else if segue.identifier == "criteriaVorming" {
            let extraTekstViewController = segue.destinationViewController as ExtraTekstViewController
            extraTekstViewController.tekst = vorming.criteriaDeelnemers
            extraTekstViewController.type = 3
        } else if segue.identifier == "betalingsWijzeVorming" {
            let extraTekstViewController = segue.destinationViewController as ExtraTekstViewController
            extraTekstViewController.tekst = vorming.betalingWijze
            extraTekstViewController.type = 4
        }
    }
}