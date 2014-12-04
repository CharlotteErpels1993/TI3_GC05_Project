import UIKit

class MonitorRegistratie1ViewController: UIViewController {
    
    @IBOutlet var txtLidNummer: UITextField!
    @IBOutlet var txtRijksregisterNr: UITextField!
    @IBOutlet var txtEmail: UITextField!
    
    var lidNummerAlToegevoegd: Bool = false
    var rijksregisterNrAlToegevoegd: Bool = false
    var emailAlToegevoegd: Bool = false
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
            let monitorRegistratie2ViewController = segue.destinationViewController as MonitorRegistratie2ViewController
            
            setStatusTextFields()
            pasLayoutVeldenAan()
            
            if controleerRodeBordersAanwezig() == true {
                if lidNummerAlToegevoegd == false {
                    foutBoxOproepen("Fout", "Dit lidnummer is nog niet toegevoegd door Joetz!", self)
                } else if rijksregisterNrAlToegevoegd == false {
                    foutBoxOproepen("Fout", "Dit rijksregisternummer is nog niet toegevoegd door Joetz!", self)
                } else if emailAlToegevoegd == false {
                    foutBoxOproepen("Fout", "Dit e-mailadres is nog niet toegevoegd door Joetz!", self)
                } else {
                    foutBoxOproepen("Fout", "Gelieve de velden correct in te vullen!", self)
                }
                self.viewDidLoad()
                
            } else {
                settenGegevens()
                monitorRegistratie2ViewController.monitor = self.monitor
            }
            
        }
    }
    
    func setStatusTextFields() {
        if txtLidNummer.text.isEmpty {
            statusTextFields["lidNummer"] = "leeg"
            lidNummerAlToegevoegd = false
        } else {
            if !controleerGeldigheidNummer(txtLidNummer.text) {
                statusTextFields["lidNummer"] = "ongeldig"
            } else if controleerLidNummerAlToegevoegd(txtLidNummer.text.toInt()!) == true {
                statusTextFields["lidNummer"] = "geldig"
                self.lidNummerAlToegevoegd = true
            } else {
                statusTextFields["lidNummer"] = "ongeldig"
            }
        }
        
        if txtRijksregisterNr.text.isEmpty {
            statusTextFields["rijksregisterNr"] = "leeg"
            self.rijksregisterNrAlToegevoegd = false
        } else {
            if !checkPatternRijksregisterNr(txtRijksregisterNr.text) {
                statusTextFields["rijksregisterNr"] = "ongeldig"
                self.rijksregisterNrAlToegevoegd = false
            } else {
                if controleerRijksregisterNrAlToegevoegd(txtRijksregisterNr.text) == true {
                    statusTextFields["rijksregisterNr"] = "geldig"
                    self.rijksregisterNrAlToegevoegd = true
                } else {
                    statusTextFields["rijksregisterNr"] = "ongeldig"
                    self.rijksregisterNrAlToegevoegd = false
                }
            }
        }
        
        if txtEmail.text.isEmpty {
            statusTextFields["email"] = "leeg"
            emailAlToegevoegd = false
        } else {
            if !checkPatternEmail(txtEmail.text) {
                statusTextFields["email"] = "ongeldig"
                emailAlToegevoegd = false
            } else if controleerEmailAlToegevoegd(txtEmail.text) == true {
                statusTextFields["email"] = "geldig"
                emailAlToegevoegd = true
            } else {
                statusTextFields["email"] = "ongeldig"
                emailAlToegevoegd = false
            }
        }
    }
    
    func pasLayoutVeldenAan() {
        if statusTextFields["lidNummer"] == "leeg" || statusTextFields["lidNummer"] == "ongeldig" {
            giveUITextFieldRedBorder(txtLidNummer)
        } else {
            giveUITextFieldDefaultBorder(txtLidNummer)
        }
        
        if statusTextFields["rijksregisterNr"] == "leeg" || statusTextFields["rijksregisterNr"] == "ongeldig"{
            giveUITextFieldRedBorder(txtRijksregisterNr)
        } else {
            giveUITextFieldDefaultBorder(txtRijksregisterNr)
        }
        
        if statusTextFields["email"] == "leeg" || statusTextFields["email"] == "ongeldig" {
            giveUITextFieldRedBorder(txtEmail)
        } else {
            giveUITextFieldDefaultBorder(txtEmail)
        }
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
        monitor.lidNr = txtLidNummer.text.toInt()
        monitor.rijksregisterNr = txtRijksregisterNr.text
        monitor.email = txtEmail.text
    }
    
    func controleerLidNummerAlToegevoegd(lidNummer: Int) -> Bool {
        return ParseData.lidNummerMonitorAlToegevoegd(lidNummer)
    }
    
    func controleerRijksregisterNrAlToegevoegd(rijksregisterNr: String) -> Bool {
        return ParseData.rijksregisterNrMonitorAlToegevoegd(rijksregisterNr)
    }
    
    func controleerEmailAlToegevoegd(email: String) -> Bool {
        return ParseData.emailMonitorAlToegevoegd(email)
    }
}