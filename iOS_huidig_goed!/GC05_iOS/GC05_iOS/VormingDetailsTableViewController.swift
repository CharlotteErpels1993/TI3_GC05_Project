import UIKit
import CoreData

class VormingDetailsTableViewController: UITableViewController {

    var vorming: Vorming!
    var euro: String = "€"
    
    //
    //Naam: toggle
    //
    //Werking: - zorgt ervoor dat de side bar menu wordt weergegeven
    //         - zorgt er ook voor dat alle toestenborden gesloten zijn
    //
    //Parameters:
    //  - sender: AnyObject
    //
    //Return:
    //
    @IBAction func toggle(sender: AnyObject) {
        toggleSideMenuView()
    }
    
    //
    //Naam: viewDidLoad
    //
    //Werking: - zorgt ervoor dat de side bar menu verborgen is
    //         - zorgt ervoor dat de cell een dynamische grootte heeft
    //         - als de ingelogde gebruiker een administrator is wordt de rechter bar button item verborgen
    //
    //Parameters:
    //
    //Return:
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        hideSideMenuView()
        self.tableView.estimatedRowHeight = 44.0
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        navigationItem.title = vorming.titel
        
        var user = PFUser.currentUser()
        var soort = user["soort"] as? String
        
        if soort == "administrator" {
            self.navigationItem.rightBarButtonItem = nil
        }
    }
    
    //
    //Naam: prepareForSegue
    //
    //Werking: - maakt de volgende view met opgegeven identifier (stelt soms attributen van de volgende view op)
    //
    //Parameters:
    //  - segue: UIStoryboardSegue
    //  - sender: AnyObject?
    //
    //Return:
    //
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
    }
    
    //
    //Naam: numbersOfSectionsInTableView
    //
    //Werking: - zorgt dat het aantal sections zich aanpast naargelang er een section wordt verwijderd
    //
    //Parameters:
    //  - tableView: UITableView
    //
    //Return: een int met de hoeveelheid sections
    //
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 9
    }
    
    //
    //Naam: tableView
    //
    //Werking: - zorgt dat het aantal rijen in een section aangepast wordt naargelang er een section wordt verwijderd
    //
    //Parameters:
    //  - tableView: UITableView
    //  - numbersOfRowsInSection section: Int
    //
    //Return: een int met de hoeveelheid rijen per section
    //
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    //
    //Naam: tableView
    //
    //Werking: - zorgt ervoor dat elke cell wordt ingevuld met de juiste gegevens
    //
    //Parameters:
    //  - tableView: UITableView
    //  - cellForRowAtIndexPath indexPath: NSIndexPath
    //
    //Return: een UITableViewCell met de juiste ingevulde gegevens
    //
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
    
    //
    //Naam: tableView
    //
    //Werking: - zorgt ervoor dat elke section de gepaste header krijgt
    //
    //Parameters:
    //  - tableView: UITableView
    //  - titleForHeaderInSection section: Int
    //
    //Return: een titel voor een bepaalde section
    //
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