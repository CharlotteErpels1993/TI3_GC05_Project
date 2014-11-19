import Foundation
import UIKit
import QuartzCore

class InschrijvenVakantie4ViewController : ResponsiveTextFieldViewController {
    var wilTweedeContactpersoon: Bool! = true
    var deelnemer: Deelnemer!
    var contactpersoon1: ContactpersoonNood!
    var contactpersoon2: ContactpersoonNood! = ContactpersoonNood(id: "test")
    var statusTextFields: [String: String] = [:]
    var redColor: UIColor = UIColor.redColor()
    //var ouder: Ouder!
    
    @IBOutlet weak var switchTweedeContactpersoon: UISwitch!
    
    @IBOutlet weak var lblVoornaam: UILabel!
    @IBOutlet weak var txtVoornaam: UITextField!
    @IBOutlet weak var lblNaam: UILabel!
    @IBOutlet weak var txtNaam: UITextField!
    @IBOutlet weak var lblTelefoon: UILabel!
    @IBOutlet weak var txtTelefoon: UITextField!
    @IBOutlet weak var lblGsm: UILabel!
    @IBOutlet weak var txtGsm: UITextField!
    
    
    @IBAction func switched(sender: UISwitch) {
        if sender.on {
            wilTweedeContactpersoon = true
            
            lblVoornaam.hidden = false
            lblNaam.hidden = false
            lblTelefoon.hidden = false
            lblGsm.hidden = false
            
            txtVoornaam.hidden = false
            txtNaam.hidden = false
            txtTelefoon.hidden = false
            txtGsm.hidden = false
            
        } else {
            wilTweedeContactpersoon = false
            
            lblVoornaam.hidden = true
            lblNaam.hidden = true
            lblTelefoon.hidden = true
            lblGsm.hidden = true
            
            txtVoornaam.hidden = true
            txtNaam.hidden = true
            txtTelefoon.hidden = true
            txtGsm.hidden = true
        }
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "volgende" {
        let inschrijvenVakantie5ViewController = segue.destinationViewController as InschrijvenVakantie5ViewController
    
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
                inschrijvenVakantie5ViewController.contactpersoon2 = contactpersoon2
            }
        }
        inschrijvenVakantie5ViewController.deelnemer = deelnemer
        inschrijvenVakantie5ViewController.contactpersoon1 = contactpersoon1
        //inschrijvenVakantie5ViewController.ouder = ouder
        } else if segue.identifier == "gaTerug" {
            let vakantiesTableViewController = segue.destinationViewController as VakantiesTableViewController
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
        contactpersoon2.voornaam = txtVoornaam.text
        contactpersoon2.naam = txtNaam.text
        contactpersoon2.gsm = txtGsm.text
    }
    
}