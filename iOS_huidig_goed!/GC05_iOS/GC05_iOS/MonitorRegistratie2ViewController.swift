import UIKit

class MonitorRegistratie2ViewController: UIViewController {
    
    @IBOutlet var txtHerhaalWachtwoord: UITextField!
    @IBOutlet var txtWachtwoord: UITextField!
    @IBOutlet var txtAansluitingsNr: UITextField!
    @IBOutlet var txtCodeGerechtigde: UITextField!
    
    var monitor: Monitor!
    var statusTextFields: [String: String] = [:]
    var redColor: UIColor = UIColor.redColor()
    var ww: String = ""
    
    @IBAction func gaTerugNaarInloggen(sender: AnyObject) {
        annuleerControllerRegistratie(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "volgende" {
            let monitorRegistratie3ViewController = segue.destinationViewController as MonitorRegistratie3ViewController
            
            setStatusTextFields()
            pasLayoutVeldenAan()
            
            if controleerRodeBordersAanwezig() == true {
                foutBoxOproepen("Fout", "Gelieve de velden correct in te vullen!", self)
                self.viewDidLoad()
            } else {
                if wachtwoordenMatch(txtWachtwoord.text, txtHerhaalWachtwoord.text) == true {
                    settenGegevens()
                    monitorRegistratie3ViewController.monitor = monitor
                    monitorRegistratie3ViewController.ww = self.ww
                } else {
                    giveUITextFieldDefaultBorder(txtAansluitingsNr)
                    giveUITextFieldDefaultBorder(txtCodeGerechtigde)
                    giveUITextFieldRedBorder(txtWachtwoord)
                    giveUITextFieldRedBorder(txtHerhaalWachtwoord)
                    foutBoxOproepen("Fout", "Wachtwoord en herhaal wachtwoord komen niet overeen.", self)
                }
            }
            
        } 
    }
    
    func setStatusTextFields() {
        if txtWachtwoord.text.isEmpty {
            statusTextFields["wachtwoord"] = "leeg"
        } else {
            statusTextFields["wachtwoord"] = "ingevuld"
        }
        
        if txtHerhaalWachtwoord.text.isEmpty {
            statusTextFields["herhaalWachtwoord"] = "leeg"
        } else {
            statusTextFields["herhaalWachtwoord"] = "ingevuld"
        }
        
        if txtAansluitingsNr.text.isEmpty {
            statusTextFields["aansluitingsNr"] = "leeg"
        } else {
            if !controleerGeldigheidNummer(txtAansluitingsNr.text) {
                statusTextFields["aansluitingsNr"] = "ongeldig"
            } else if !checkPatternAansluitingsNr(txtAansluitingsNr.text.toInt()!) {
                statusTextFields["aansluitingsNr"] = "ongeldig"
            } else {
                statusTextFields["aansluitingsNr"] = "geldig"
            }
        }
        
        if txtCodeGerechtigde.text.isEmpty {
            statusTextFields["codeGerechtigde"] = "leeg"
        } else {
            if !controleerGeldigheidNummer(txtCodeGerechtigde.text) {
                statusTextFields["codeGerechtigde"] = "ongeldig"
            } else if !checkPatternCodeGerechtigde(txtCodeGerechtigde.text.toInt()!) {
                statusTextFields["codeGerechtigde"] = "ongeldig"
            } else {
                statusTextFields["codeGerechtigde"] = "geldig"
            }
        }
    }
    
    func pasLayoutVeldenAan() {
        if statusTextFields["wachtwoord"] == "leeg" {
            giveUITextFieldRedBorder(txtWachtwoord)
        } else {
            giveUITextFieldDefaultBorder(txtWachtwoord)
        }
        
        if statusTextFields["herhaalWachtwoord"] == "leeg" {
            giveUITextFieldRedBorder(txtHerhaalWachtwoord)
        } else {
            giveUITextFieldDefaultBorder(txtHerhaalWachtwoord)
        }
        
        if statusTextFields["aansluitingsNr"] == "leeg" || statusTextFields["aansluitingsNr"] == "ongeldig" {
            giveUITextFieldRedBorder(txtAansluitingsNr)
        } else {
            giveUITextFieldDefaultBorder(txtAansluitingsNr)
        }
        
        if statusTextFields["codeGerechtigde"] == "leeg" || statusTextFields["codeGerechtigde"] == "ongeldig" {
            giveUITextFieldRedBorder(txtCodeGerechtigde)
        } else {
            giveUITextFieldDefaultBorder(txtCodeGerechtigde)
        }
    }
    
    func controleerRodeBordersAanwezig() -> Bool {
        if CGColorEqualToColor(txtWachtwoord.layer.borderColor, redColor.CGColor) {
            return true
        } else if CGColorEqualToColor(txtWachtwoord.layer.borderColor, redColor.CGColor) {
            return true
        } else if CGColorEqualToColor(txtAansluitingsNr.layer.borderColor, redColor.CGColor) {
            return true
        } else if CGColorEqualToColor(txtCodeGerechtigde.layer.borderColor, redColor.CGColor) {
            return true
        } else {
            return false
        }
    }
    
    func settenGegevens() {
        self.ww = txtWachtwoord.text
        monitor.aansluitingsNr = txtAansluitingsNr.text.toInt()
        monitor.codeGerechtigde = txtCodeGerechtigde.text.toInt()
    }
}













