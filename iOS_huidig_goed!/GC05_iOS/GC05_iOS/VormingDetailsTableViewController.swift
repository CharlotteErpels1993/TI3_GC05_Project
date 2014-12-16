import UIKit
import CoreData

class VormingDetailsTableViewController: UITableViewController {

    var vorming: Vorming!
    var euro: String = "€"
    var fetchedResultController: NSFetchedResultsController = NSFetchedResultsController()
    
    /*@IBOutlet weak var korteBeschrijvingLabel: UILabel!
    @IBOutlet weak var criteriaDeelnemersLabel: UILabel!
    @IBOutlet weak var locatieLabel: UILabel!
    @IBOutlet weak var websiteLocatieLabel: UILabel!
    @IBOutlet weak var prijsLabel: UILabel!
    @IBOutlet weak var betalingsWijzeLabel: UILabel!
    @IBOutlet weak var inbegrepenPrijsLabel: UILabel!
    @IBOutlet weak var periodesLabel: UILabel!
    @IBOutlet weak var tipsLabel: UILabel!*/
    
    @IBAction func toggle(sender: AnyObject) {
        toggleSideMenuView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideSideMenuView()
        self.tableView.estimatedRowHeight = 44.0
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        navigationItem.title = vorming.titel
        
        /*korteBeschrijvingLabel.text = vorming.korteBeschrijving
        criteriaDeelnemersLabel.text = vorming.criteriaDeelnemers
        locatieLabel.text = String("Locatie: \(vorming.locatie!)")
        websiteLocatieLabel.text = ("Website locatie: \(vorming.websiteLocatie!)")
        prijsLabel.text = String("Prijs: \(vorming.prijs!) " + euro)
        betalingsWijzeLabel.text = String("Betalingswijze: \(vorming.betalingWijze!)")
        inbegrepenPrijsLabel.text = String("Inbegrepen in de prijs: \(vorming.inbegrepenPrijs!)")*/
        //tipsLabel.text = vorming.tips
        
        var user = PFUser.currentUser()
        var soort = user["soort"] as? String
        
        if soort == "administrator" {
            self.navigationItem.rightBarButtonItem = nil
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        tableView.reloadData()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "inschrijven" {
            let inschrijvenVormingViewController = segue.destinationViewController as InschrijvenVormingViewController
            inschrijvenVormingViewController.vorming = self.vorming
            inschrijvenVormingViewController.pickerData = vorming.periodes!
        } else if segue.identifier == "korteBeschrijvingVorming" {
            let extraTekstViewController = segue.destinationViewController as ExtraTekstViewController
            extraTekstViewController.tekst = self.vorming.korteBeschrijving!
            extraTekstViewController.naam = self.vorming.titel!
            extraTekstViewController.type = 1
        } else if segue.identifier == "criteriaVorming" {
            let extraTekstViewController = segue.destinationViewController as ExtraTekstViewController
            extraTekstViewController.tekst = self.vorming.criteriaDeelnemers!
            extraTekstViewController.type = 3
        } else if segue.identifier == "betalingswijzeVorming" {
            let extraTekstViewController = segue.destinationViewController as ExtraTekstViewController
            extraTekstViewController.tekst = self.vorming.betalingWijze!
            extraTekstViewController.type = 4
        } else if segue.identifier == "tipsVorming" {
            let extraTekstViewController = segue.destinationViewController as ExtraTekstViewController
            extraTekstViewController.tekst = self.vorming.tips!
            extraTekstViewController.type = 5
        }
        /*} else if segue.identifier == "inbegrepenPrijs" {
            let extraTekstViewController = segue.destinationViewController as ExtraTekstViewController
            extraTekstViewController.tekst = self.vorming.inbegrepenPrijs!
            extraTekstViewController.type = 2
        }*/
        /*} else if segue.identifier == "periodes" {
            let extraTekstViewController = segue.destinationViewController as ExtraTekstViewController
            extraTekstViewController.tekst = vorming.periodesToString(vorming.periodes!)
            extraTekstViewController.type = 5
        }*/
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 9
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell: UITableViewCell!
        
        if indexPath.section == 0 {
            cell = tableView.dequeueReusableCellWithIdentifier("KorteBeschrijving", forIndexPath: indexPath) as UITableViewCell
            cell.textLabel?.text = vorming.korteBeschrijving
        } else if indexPath.section == 1 {
           cell = tableView.dequeueReusableCellWithIdentifier("Criteria", forIndexPath: indexPath) as UITableViewCell
            cell.textLabel?.text = vorming.criteriaDeelnemers
        } else if indexPath.section == 2 {
           cell = tableView.dequeueReusableCellWithIdentifier("Locatie", forIndexPath: indexPath) as UITableViewCell
            cell.textLabel?.text = String("Locatie: \(vorming.locatie!)")
        } else if indexPath.section == 3 {
            cell = tableView.dequeueReusableCellWithIdentifier("WebsiteLocatie", forIndexPath: indexPath) as UITableViewCell
            cell.textLabel?.text = String("Website: \(vorming.websiteLocatie!)")
        } else if indexPath.section == 4 {
            cell = tableView.dequeueReusableCellWithIdentifier("Prijs", forIndexPath: indexPath) as UITableViewCell
            cell.textLabel?.text = String("Prijs: \(vorming.prijs!)" + euro)
        } else if indexPath.section == 5 {
            cell = tableView.dequeueReusableCellWithIdentifier("Betalingswijze", forIndexPath: indexPath) as UITableViewCell
            cell.textLabel?.text = String("Betalingswijze: \(vorming.betalingWijze!)")
        } else if indexPath.section == 6 {
            cell = tableView.dequeueReusableCellWithIdentifier("InbegrepenPrijs", forIndexPath: indexPath) as UITableViewCell
            cell.textLabel?.text = String("Inbegrepen in de prijs: \(vorming.inbegrepenPrijs!)")
        } else if indexPath.section == 7 {
            cell = tableView.dequeueReusableCellWithIdentifier("Periodes", forIndexPath: indexPath) as UITableViewCell
            cell.textLabel?.text = vorming.periodesToString(vorming.periodes!)
        } else if indexPath.section == 8 {
            cell = tableView.dequeueReusableCellWithIdentifier("Tips", forIndexPath: indexPath) as UITableViewCell
            cell.textLabel?.text = vorming.tips!
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return ("Korte beschrijving")
        } else if section == 1 {
            return ("Criteria")
        } else if section == 2 {
            return ("Locatie")
        } else if section == 4 {
            return ("Prijs")
        } else if section == 7 {
            return ("Periodes")
        } else if section == 8 {
            return ("Tips")
        }
        return ("")
    }
}