import Foundation
import UIKit
import QuartzCore

class InschrijvenVakantie4ViewController : UITableViewController {
    var inschrijvingVakantie: InschrijvingVakantie!
    var foutBox: FoutBox? = nil
    var redColor: UIColor = UIColor.redColor()
    var statusTextFields: [String: String] = [:]
    var contactpersoon: ContactpersoonNood! = ContactpersoonNood(id: "test")
    
    @IBOutlet weak var txtVoornaam: UITextField!
    @IBOutlet weak var txtNaam: UITextField!
    @IBOutlet weak var txtTelefoon: UITextField!
    @IBOutlet weak var txtGsm: UITextField!
    
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
        let inschrijvenVakantie5ViewController = segue.destinationViewController as InschrijvenVakantie5ViewController
        
        setStatusTextFields()
        pasLayoutVeldenAan()
        
        if controleerRodeBordersAanwezig() == true {
            foutBoxOproepen("Fout", "Gelieve de velden correct in te vullen!", self)
        } else {
            settenVerplichteGegevens()
            
            if statusTextFields["telefoon"] != "leeg" {
                contactpersoon.telefoon = txtTelefoon.text
            }
        
            inschrijvingVakantie.contactpersoon1 = contactpersoon
            inschrijvenVakantie5ViewController.inschrijvingVakantie = inschrijvingVakantie
        }
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
            //TO DO: checken op pattern?
            statusTextFields["voornaam"] = "ingevuld"
        }
        
        if txtNaam.text.isEmpty {
            statusTextFields["naam"] = "leeg"
        } else {
            //TO DO: checken op pattern?
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
    //Werking: - afhankelijk van de status van de verplichte velden, worden de gegevens van de contactpersoon ingesteld
    //
    //Parameters:
    //
    //Return:
    //
    func settenVerplichteGegevens() {
        contactpersoon.voornaam = txtVoornaam.text
        contactpersoon.naam = txtNaam.text
        contactpersoon.gsm = txtGsm.text
    }
}