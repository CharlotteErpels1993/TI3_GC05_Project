import UIKit

class MonitorRegistratie1ViewController: UIViewController {
    
    @IBOutlet var txtLidNummer: UITextField!
    @IBOutlet var txtRijksregisterNr: UITextField!
    @IBOutlet var txtEmail: UITextField!
    
    var statusTextFields: [String: String] = [:]
    var redColor: UIColor = UIColor.redColor()
    var monitor: Monitor = Monitor(id: "test")
    
    @IBAction func gaTerugNaarInloggen(sender: AnyObject) {
        annuleerControllerRegistratie(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "volgende" {
            
            ParseData.deleteNieuweMonitorTable()
            ParseData.vulNieuweMonitorTableOp()
            
            let monitorRegistratie2ViewController = segue.destinationViewController as MonitorRegistratie2ViewController
            
            setStatusTextFields()
            pasLayoutVeldenAan()
            
            if controleerRodeBordersAanwezig() == true {
                foutBoxOproepen("Fout", "Gelieve de velden correct in te vullen!", self)
                self.viewDidLoad()
            } else {
                
                if controleerBestaandeCombinatie(txtLidNummer.text, rijksregisternummer: txtRijksregisterNr.text, email: txtEmail.text) == false {
                    giveUITextFieldRedBorder(txtLidNummer)
                    giveUITextFieldRedBorder(txtRijksregisterNr)
                    giveUITextFieldRedBorder(txtEmail)
                    
                    foutBoxOproepen("Fout", "Er is geen bestaande combinatie van deze gegevens terug gevonden.\nIndien u zeker bent van de ingevoerde gegevens, gelieve Joetz te contacteren op joetz-west@joetz.be", self)
                    
                } else {
                    settenGegevens()
                    monitorRegistratie2ViewController.monitor = self.monitor
                }
            }
            
        }
    }
    
    func setStatusTextFields() {
        if txtLidNummer.text.isEmpty {
            statusTextFields["lidNummer"] = "leeg"
        } else {
            statusTextFields["lidNummer"] = "ingevuld"
        }
        
        if txtRijksregisterNr.text.isEmpty {
            statusTextFields["rijksregisterNr"] = "leeg"
        } else {
            statusTextFields["rijksregisterNr"] = "ingevuld"
        }
        
        if txtEmail.text.isEmpty {
            statusTextFields["email"] = "leeg"
        } else {
            statusTextFields["email"] = "ingevuld"
        }
    }
    
    func pasLayoutVeldenAan() {
        if statusTextFields["lidNummer"] == "leeg" {
            giveUITextFieldRedBorder(txtLidNummer)
        } else {
            if !checkPatternLidnummer(txtLidNummer.text) {
                giveUITextFieldRedBorder(txtLidNummer)
            } else {
                giveUITextFieldDefaultBorder(txtLidNummer)
            }
        }
        
        if statusTextFields["rijksregisterNr"] == "leeg" {
            giveUITextFieldRedBorder(txtRijksregisterNr)
        } else {
            if !checkPatternRijksregisterNr(txtRijksregisterNr.text) {
                giveUITextFieldRedBorder(txtRijksregisterNr)
            } else {
                giveUITextFieldDefaultBorder(txtRijksregisterNr)
            }
        }
        
        if statusTextFields["email"] == "leeg" {
            giveUITextFieldRedBorder(txtEmail)
        } else {
            if !checkPatternEmail(txtEmail.text) {
                giveUITextFieldRedBorder(txtEmail)
            } else {
                giveUITextFieldDefaultBorder(txtEmail)
            }
        }
    }
    
    func controleerBestaandeCombinatie(lidnummer: String, rijksregisternummer: String, email: String) -> Bool {
        return ParseData.bestaatCombinatie(lidnummer, rijksregisternummer: rijksregisternummer, email: email)
    }
    
    func controleerRodeBordersAanwezig() -> Bool {
        if CGColorEqualToColor(txtLidNummer.layer.borderColor, redColor.CGColor) {
            return true
        } else if CGColorEqualToColor(txtRijksregisterNr.layer.borderColor, redColor.CGColor) {
            return true
        } else if CGColorEqualToColor(txtEmail.layer.borderColor, redColor.CGColor) {
            return true
        } else {
            return false
        }
    }
    
    func settenGegevens() {
        monitor.lidNr = txtLidNummer.text
        monitor.rijksregisterNr = txtRijksregisterNr.text
        monitor.email = txtEmail.text
    }
    
    /*func controleerLidNummer(lidNummer: String) -> Bool {
        return ParseData.lidNummerMonitorAlToegevoegd(lidNummer)
    }
    
    func controleerRijksregisterNrAlToegevoegd(rijksregisterNr: String) -> Bool {
        return ParseData.rijksregisterNrMonitorAlToegevoegd(rijksregisterNr)
    }
    
    func controleerEmailAlToegevoegd(email: String) -> Bool {
        return ParseData.emailMonitorAlToegevoegd(email)
    }*/
}