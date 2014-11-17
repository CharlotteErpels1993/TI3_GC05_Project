import UIKit

class VormingDetailsTableViewController: UITableViewController {

    //var monitor: Monitor!
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
        
        tableView.estimatedRowHeight = 44.0
        //tableView.rowHeight = UITableViewAutomaticDimension
        tableView.rowHeight = UITableViewAutomaticDimension
        
        korteBeschrijvingLabel.text = vorming.korteBeschrijving
        criteriaDeelnemersLabel.text = vorming.criteriaDeelnemers
        locatieLabel.text = String("Locatie: \(vorming.locatie)")
        websiteLocatieLabel.text = ("Webiste locatie: \(vorming.websiteLocatie)")
        prijsLabel.text = String("Prijs: \(vorming.prijs) " + euro)
        betalingsWijzeLabel.text = String("Betalingswijze: \(vorming.betalingWijze)")
        periodesLabel.text = vorming.periodesToString()
        tipsLabel.text = vorming.tips
        

    }
    
    /*override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        var height: CGFloat = 0.0
        
        if indexPath.row == 4 && indexPath.section == 1 {
            var text: NSString = self.description.
        }
        
        return 44.0
    }*/
    
    override func viewDidAppear(animated: Bool) {
        tableView.reloadData()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "inschrijven" {
            let inschrijvenVormingViewController = segue.destinationViewController as InschrijvenVormingViewController
            //inschrijvenVormingViewController.monitor = self.monitor
            inschrijvenVormingViewController.vorming = self.vorming
            inschrijvenVormingViewController.pickerData = vorming.periodes
        }
    }
}