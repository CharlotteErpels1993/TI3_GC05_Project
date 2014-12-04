import UIKit

class MonitorRegistratie3ViewController: UIViewController {
    
    @IBOutlet var txtVoornaam: UITextField!
    @IBOutlet var txtNaam: UITextField!
    @IBOutlet var txtStraat: UITextField!
    @IBOutlet var txtHuisnummer: UITextField!
    @IBOutlet var txtBus: UITextField!
    @IBOutlet var txtGemeente: UITextField!
    @IBOutlet var txtPostcode: UITextField!
    @IBOutlet var txtTelefoon: UITextField!
    @IBOutlet var txtGsm: UITextField!
    
    var monitor: Monitor!
    var ww: String!
    var statusTextFields: [String: String] = [:]
    var redColor: UIColor = UIColor.redColor()
    
    @IBAction func gaTerugNaarInloggen(sender: AnyObject) {
        annuleerControllerRegistratie(self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "volgende" {
            let monitorRegistratieSuccesvolViewController = segue.destinationViewController as MonitorRegistratieSuccesvolViewController
            
            setStatusTextFields()
            pasLayoutVeldenAan()
            
            if controleerRodeBordersAanwezig() == true {
                foutBoxOproepen("Fout", "Gelieve de velden correct in te vullen!", self)
                self.viewDidLoad()
            } else {
                settenVerplichteGegevens()
                settenOptioneleGegevens()
                monitorRegistratieSuccesvolViewController.monitor = self.monitor
                monitorRegistratieSuccesvolViewController.ww = self.ww
            }
        }
    }
    
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
        
        if txtStraat.text.isEmpty {
            statusTextFields["straat"] = "leeg"
        } else {
            statusTextFields["straat"] = "ingevuld"
        }
        
        if txtHuisnummer.text.isEmpty {
            statusTextFields["nummer"] = "leeg"
        } else {
            if !controleerGeldigheidNummer(txtHuisnummer.text) {
                statusTextFields["nummer"] = "ongeldig"
            } else if !checkPatternNummer(txtHuisnummer.text.toInt()!) {
                statusTextFields["nummer"] = "ongeldig"
            } else {
                statusTextFields["nummer"] = "geldig"
            }
        }
        
        if txtBus.text.isEmpty {
            statusTextFields["bus"] = "leeg"
        } else {
            statusTextFields["bus"] = "ingevuld"
        }
        
        if txtGemeente.text.isEmpty {
            statusTextFields["gemeente"] = "leeg"
        } else {
            statusTextFields["gemeente"] = "ingevuld"
        }
        
        if txtPostcode.text.isEmpty {
            statusTextFields["postcode"] = "leeg"
        } else {
            if !controleerGeldigheidNummer(txtPostcode.text) {
                statusTextFields["postcode"] = "ongeldig"
            } else if !checkPatternPostcode(txtPostcode.text.toInt()!) {
                statusTextFields["postcode"] = "ongeldig"
            } else {
                statusTextFields["postcode"] = "geldig"
            }
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
        
        if statusTextFields["straat"] == "leeg" {
            giveUITextFieldRedBorder(txtStraat)
        } else {
            giveUITextFieldDefaultBorder(txtStraat)
        }
        
        if statusTextFields["nummer"] == "leeg" || statusTextFields["nummer"] == "ongeldig"{
            giveUITextFieldRedBorder(txtHuisnummer)
        } else {
            giveUITextFieldDefaultBorder(txtHuisnummer)
        }
        
        if statusTextFields["bus"] == "ongeldig"{
            giveUITextFieldRedBorder(txtBus)
        } else {
            giveUITextFieldDefaultBorder(txtBus)
        }
        
        if statusTextFields["gemeente"] == "leeg" {
            giveUITextFieldRedBorder(txtGemeente)
        } else {
            giveUITextFieldDefaultBorder(txtGemeente)
        }
        
        if statusTextFields["postcode"] == "leeg" || statusTextFields["postcode"] == "ongeldig"{
            giveUITextFieldRedBorder(txtPostcode)
        } else {
            giveUITextFieldDefaultBorder(txtPostcode)
        }
        
        if statusTextFields["telefoon"] == "ongeldig"{
            giveUITextFieldRedBorder(txtTelefoon)
        } else {
            giveUITextFieldDefaultBorder(txtTelefoon)
        }
        
        if statusTextFields["gsm"] == "leeg" || statusTextFields["gsm"] == "ongeldig" || statusTextFields["gsm"] == "al geregistreerd" {
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
        } else if CGColorEqualToColor(txtStraat.layer.borderColor, redColor.CGColor) {
            return true
        } else if CGColorEqualToColor(txtHuisnummer.layer.borderColor, redColor.CGColor) {
            return true
        } else if CGColorEqualToColor(txtBus.layer.borderColor, redColor.CGColor) {
            return true
        } else if CGColorEqualToColor(txtGemeente.layer.borderColor, redColor.CGColor) {
            return true
        } else if CGColorEqualToColor(txtPostcode.layer.borderColor, redColor.CGColor) {
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
        monitor.voornaam = txtVoornaam.text
        monitor.naam = txtNaam.text
        monitor.straat = txtStraat.text
        monitor.nummer = txtHuisnummer.text.toInt()
        monitor.gemeente = txtGemeente.text
        monitor.postcode = txtPostcode.text.toInt()
        monitor.gsm = txtGsm.text
    }
    
    func settenOptioneleGegevens() {
        if statusTextFields["bus"] != "leeg" {
            monitor.bus = txtBus.text
        }
        
        if statusTextFields["telefoon"] != "leeg" {
            monitor.telefoon = txtTelefoon.text
        }
    }
    
    
    
}
















