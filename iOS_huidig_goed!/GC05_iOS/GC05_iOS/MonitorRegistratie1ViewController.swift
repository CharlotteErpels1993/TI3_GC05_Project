import UIKit

class MonitorRegistratie1ViewController: UIViewController {
    
    @IBOutlet var txtLidNummer: UITextField!
    @IBOutlet var txtRijksregisterNr: UITextField!
    @IBOutlet var txtEmail: UITextField!
    
    var lidNummerAlToegevoegd: Bool = false
    var rijksregisterNrAlToegevoegd: Bool = false
    var emailAlToegevoegd: Bool = false
    var statusTextFields: [String: String] = [:]
    
    
    @IBAction func gaTerugNaarInloggen(sender: AnyObject) {
        annuleerControllerRegistratie(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "volgende" {
            let monitorRegistratie2ViewController = segue.destinationViewController as MonitorRegistratie2ViewController
            
            
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
    
    func controleerLidNummerAlToegevoegd(lidNummer: Int) -> Bool {
        //return ParseData.lidNummerMonitorAlToegevoegd(lidNummer)
        return true
    }
    
    func controleerRijksregisterNrAlToegevoegd(rijksregisterNr: String) -> Bool {
        return true
    }
    
    func controleerEmailAlToegevoegd(email: String) -> Bool {
        return true
    }
}