import Foundation
import UIKit
import QuartzCore

class InschrijvenVakantie5ViewController : UITableViewController {
    var wilTweedeContactpersoon: Bool! = true
    var inschrijvingVakantie: InschrijvingVakantie!
    var contactpersoon2: ContactpersoonNood! = ContactpersoonNood(id: "test")
    var statusTextFields: [String: String] = [:]
    var redColor: UIColor = UIColor.redColor()
    
    @IBOutlet weak var switchTweedeContactpersoon: UISwitch!
    @IBOutlet weak var txtVoornaam: UITextField!
    @IBOutlet weak var txtNaam: UITextField!
    @IBOutlet weak var txtTelefoon: UITextField!
    @IBOutlet weak var txtGsm: UITextField!
    @IBOutlet var labelVerplicht: UILabel!
    
    //
    //Naam: annuleer
    //
    //Werking: - zorgt ervoor wanneer de gebruiker op annuleer drukt, er een melding komt of de gebruiker zeker is van zijn beslissing
    //
    //Parameters:
    //  - sender: AnyObject
    //
    //Return:
    //
    @IBAction func annuleer(sender: AnyObject) {
        annuleerControllerInschrijvenVakantieVorming(self)
    }
    
    //
    //Naam: switched
    //
    //Werking: - kijkt of de switch aan staat:
    //              * switch aan: bool wilTweedeContactpersoon op true en toon labelVerplicht
    //              * switch uit: bool wilTweedeContactpersoon op false en verberg labelVerplicht
    //
    //Parameters:
    //  - sender: UISwitch
    //
    //Return:
    //
    @IBAction func switched(sender: UISwitch) {
        if sender.on {
            wilTweedeContactpersoon = true
            labelVerplicht.hidden = false
            viewDidLoad()
            self.tableView.reloadData()
            
        } else {
            wilTweedeContactpersoon = false
            self.tableView.deleteSections(NSIndexSet(index: 1), withRowAnimation: UITableViewRowAnimation.None)
            labelVerplicht.hidden = true
        }
    }
    
    //
    //Naam: viewDidLoad
    //
    //Werking: - geeft de text field een default border
    //
    //Parameters:
    //
    //Return:
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        giveUITextFieldDefaultBorder(txtVoornaam)
        giveUITextFieldDefaultBorder(txtNaam)
        giveUITextFieldDefaultBorder(txtTelefoon)
        giveUITextFieldDefaultBorder(txtGsm)
    }
    
    //
    //Naam: numbersOfSectionsInTableView
    //
    //Werking: - zorgt dat het aantal sections zich aanpast naargelang de switch aan of uit staat
    //
    //Parameters:
    //  - tableView: UITableView
    //
    //Return: een int met de hoeveelheid sections
    //
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if wilTweedeContactpersoon == false {
            return 2
        } else {
            return 3
        }
    }
    
    //
    //Naam: tableView
    //
    //Werking: - zorgt dat het aantal rijen in een section aangepast wordt naargelang de switch aan of uit staat
    //
    //Parameters:
    //  - tableView: UITableView
    //  - numbersOfRowsInSection section: Int
    //
    //Return: een int met de hoeveelheid rijen per section
    //
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if wilTweedeContactpersoon == false {
            return 1
        } else {
            if section == 1 {
                return 4
            } else {
                return 1
            }
        }
    }
    
    //
    //Naam: prepareForSegue
    //
    //Werking: - maakt de volgende view met opgegeven identifier (stelt soms attributen van de volgende view op)
    //         - controleert ook eerste de ingevulde velden op geldigheid, zonee wordt er een foutmelding gegeven
    //
    //Parameters:
    //  - segue: UIStoryboardSegue
    //  - sender: AnyObject?
    //
    //Return:
    //
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "volgende" {
            let inschrijvenVakantie6ViewController = segue.destinationViewController as InschrijvenVakantie6ViewController
    
            if wilTweedeContactpersoon == true {
                setStatusTextFields()
                pasLayoutVeldenAan()
        
                if controleerRodeBordersAanwezig() == true {
                    foutBoxOproepen("Fout", "Gelieve de velden correct in te vullen!", self)
                } else {
                    settenVerplichteGegevens()
                
                    if statusTextFields["telefoon"] != "leeg" {
                        contactpersoon2.telefoon = txtTelefoon.text
                    }
                    inschrijvingVakantie.contactpersoon2 = contactpersoon2
                    inschrijvenVakantie6ViewController.inschrijvingVakantie = inschrijvingVakantie
                }
            }
            inschrijvenVakantie6ViewController.inschrijvingVakantie = inschrijvingVakantie
        } else if segue.identifier == "gaTerug" {
            let vakantiesTableViewController = segue.destinationViewController as VakantiesTableViewController
        }
    }
    
    //
    //Naam: setStatusTextFields
    //
    //Werking: - zet de status van de text fields in
    //              * controleert of de velden leeg zijn
    //              * controleert of andere validatiemethoden geldig zijn
    //              * wanneer een text field ongeldig is krijgt deze de status "leeg" of "ongeldig"
    //
    //Parameters:
    //
    //Return:
    //
    func setStatusTextFields() {
        if txtVoornaam.text.isEmpty {
            statusTextFields["voornaam"] = "leeg"
        } else {
            statusTextFields["voornaam"] = "ingevuld"
        }
        
        if txtNaam.text.isEmpty {
            statusTextFields["naam"] = "leeg"
        } else {
            statusTextFields["naam"] = "ingevuld"
        }
        
        if txtTelefoon.text.isEmpty {
            statusTextFields["telefoon"] = "leeg"
        } else {
            if !checkPatternTelefoon(txtTelefoon.text) {
                statusTextFields["telefoon"] = "ongeldig"
            } else {
                statusTextFields["telefoon"] = "geldig"
            }
        }
        
        if txtGsm.text.isEmpty {
            statusTextFields["gsm"] = "leeg"
        } else {
            if !checkPatternGsm(txtGsm.text) {
                statusTextFields["gsm"] = "ongeldig"
            } else {
                statusTextFields["gsm"] = "geldig"
            }
        }
    }
    
    //
    //Naam: pasLayoutVeldenAan
    //
    //Werking: - zorgt ervoor dat de text field, wanneer status "ongeldig" of "leeg" is, een rode border krijgt
    //         - als deze status niet "leeg" of "ongeldig" is wordt deze border terug op default gezet
    //
    //Parameters:
    //
    //Return:
    //
    func pasLayoutVeldenAan() {
        if statusTextFields["voornaam"] == "leeg" {
            giveUITextFieldRedBorder(txtVoornaam)
        } else {
            giveUITextFieldDefaultBorder(txtVoornaam)
        }
        
        if statusTextFields["naam"] == "leeg" {
            giveUITextFieldRedBorder(txtNaam)
        } else {
            giveUITextFieldDefaultBorder(txtNaam)
        }
        
        if statusTextFields["telefoon"] == "ongeldig" {
            giveUITextFieldRedBorder(txtTelefoon)
        } else {
            giveUITextFieldDefaultBorder(txtTelefoon)
        }
        
        if statusTextFields["gsm"] == "leeg" || statusTextFields["gsm"] == "ongeldig" {
            giveUITextFieldRedBorder(txtGsm)
        } else {
            giveUITextFieldDefaultBorder(txtGsm)
        }
    }
    
    //
    //Naam: controleerRodeBordersAanwezig
    //
    //Werking: - bekijkt of de text field borders een rode border hebben
    //
    //Parameters:
    //
    //Return: een bool true als er een rode border aanwezig is, anders false
    //
    func controleerRodeBordersAanwezig() -> Bool {
        if CGColorEqualToColor(txtVoornaam.layer.borderColor, redColor.CGColor) {
            return true
        } else if CGColorEqualToColor(txtNaam.layer.borderColor, redColor.CGColor) {
            return true
        } else if CGColorEqualToColor(txtTelefoon.layer.borderColor, redColor.CGColor) {
            return true
        } else if CGColorEqualToColor(txtGsm.layer.borderColor, redColor.CGColor) {
            return true
        } else {
            return false
        }
    }
    
    //
    //Naam: settenVerplichteGegevens
    //
    //Werking: - afhankelijk van de status van de verplichte velden, worden de gegevens van de contactpersoon2 ingesteld
    //
    //Parameters:
    //
    //Return:
    //
    func settenVerplichteGegevens() {
        contactpersoon2.voornaam = txtVoornaam.text
        contactpersoon2.naam = txtNaam.text
        contactpersoon2.gsm = txtGsm.text
    }
}