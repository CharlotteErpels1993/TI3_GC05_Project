import Foundation
import UIKit
import QuartzCore

class InschrijvenVakantie3ViewController : UIViewController {
    var deelnemer: Deelnemer!
    var foutBox: FoutBox? = nil
    var redColor: UIColor = UIColor.redColor()
    var statusTextFields: [String: String] = [:]
    var contactpersoon: ContactpersoonNood! = ContactpersoonNood(id: "test")
    var ouder: Ouder!
    
    @IBOutlet weak var txtVoornaam: UITextField!
    @IBOutlet weak var txtNaam: UITextField!
    @IBOutlet weak var txtTelefoon: UITextField!
    @IBOutlet weak var txtGsm: UITextField!
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let inschrijvenVakantie4ViewController = segue.destinationViewController as InschrijvenVakantie4ViewController
        
        setStatusTextFields()
        pasLayoutVeldenAan()
        
        if controleerRodeBordersAanwezig() == true {
            foutBoxOproepen("Fout", "Gelieve de velden correct in te vullen!", self)
        } else {
            settenVerplichteGegevens()
            
            if statusTextFields["telefoon"] != "leeg" {
                contactpersoon.telefoon = txtTelefoon.text
            }
        
            inschrijvenVakantie4ViewController.contactpersoon1 = contactpersoon
            inschrijvenVakantie4ViewController.deelnemer = deelnemer
            inschrijvenVakantie4ViewController.ouder = ouder
        }
    }
    
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
    
    func settenVerplichteGegevens() {
        contactpersoon.voornaam = txtVoornaam.text
        contactpersoon.naam = txtNaam.text
        contactpersoon.gsm = txtGsm.text
    }
}