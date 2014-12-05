import UIKit

class NieuweMonitorViewController: UIViewController {
    
    @IBOutlet var txtLidnummer: UITextField!
    @IBOutlet var txtRijksregisterNr: UITextField!
    @IBOutlet var txtEmail: UITextField!
    
    var nieuweMonitor: NieuweMonitor = NieuweMonitor(id: "test")
    var statusTextFields: [String: String] = [:]
    var redColor: UIColor = UIColor.redColor()
    
    @IBAction func toggle(sender: AnyObject) {
        toggleSideMenuView()
    }
    
    @IBAction func gaTerugNaarNieuweMonitor(segue: UIStoryboardSegue) {}
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "nieuweMonitor" {
            let nieuweMonitorSuccesvolViewController = segue.destinationViewController as NieuweMonitorSuccesvolViewController
            
            ParseData.deleteNieuweMonitorTable()
            ParseData.vulNieuweMonitorTableOp()
            ParseData.deleteMonitorTable()
            ParseData.vulMonitorTableOp()
            
            
            setStatusTextFields()
            pasLayoutVeldenAan()
            
            if controleerRodeBordersAanwezig() == true {
                foutBoxOproepen("Fout", "Gelieve de velden correct in te vullen!", self)
                self.viewDidLoad()
            } else {
                
                if ParseData.bestaatLidnummerNieuweMonitorAlMonitor(txtLidnummer.text) {
                    foutBoxOproepen("Fout", "Er is al een geregistreerde monitor met dit lidnummer", self)
                    giveUITextFieldRedBorder(txtLidnummer)
                } else if ParseData.bestaatLidnummerNieuweMonitorAlNieuweMonitor(txtLidnummer.text) {
                    foutBoxOproepen("Fout", "Er is al een nieuwe monitor met dit lidnummer", self)
                    giveUITextFieldRedBorder(txtLidnummer)
                } else if ParseData.bestaatRijksregisternummerNieuweMonitorAlMonitor(txtRijksregisterNr.text) {
                    foutBoxOproepen("Fout", "Er is al een geregistreerde monitor met dit rijksregisternummer", self)
                    giveUITextFieldRedBorder(txtRijksregisterNr)
                } else if ParseData.bestaatRijksregisternummerNieuweMonitorAlNieuweMonitor(txtLidnummer.text) {
                    foutBoxOproepen("Fout", "Er is al een nieuwe monitor met dit rijksregisternummer", self)
                    giveUITextFieldRedBorder(txtRijksregisterNr)
                } else if ParseData.bestaatEmailNieuweMonitorAlMonitor(txtEmail.text) {
                    foutBoxOproepen("Fout", "Er is al een geregistreerde monitor met dit e-mailadres", self)
                    giveUITextFieldRedBorder(txtEmail)
                } else if ParseData.bestaatEmailNieuweMonitorAlNieuweMonitor(txtEmail.text) {
                    foutBoxOproepen("Fout", "Er is al een nieuwe monitor met dit e-mailadres", self)
                    giveUITextFieldRedBorder(txtEmail)
                } else {
                    settenGegevens()
                    nieuweMonitorSuccesvolViewController.nieuweMonitor = self.nieuweMonitor
                }
            }
            
            
        }
    }
    
    func setStatusTextFields() {
        if txtLidnummer.text.isEmpty {
            statusTextFields["lidnummer"] = "leeg"
        } else {
            statusTextFields["lidnummer"] = "ingevuld"
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
        if statusTextFields["lidnummer"] == "leeg" {
            giveUITextFieldRedBorder(txtLidnummer)
        } else {
            if !checkPatternLidnummer(txtLidnummer.text) {
                giveUITextFieldRedBorder(txtLidnummer)
            } else {
                giveUITextFieldDefaultBorder(txtLidnummer)
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
    
    func controleerRodeBordersAanwezig() -> Bool {
        if CGColorEqualToColor(txtLidnummer.layer.borderColor, redColor.CGColor) {
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
        self.nieuweMonitor.lidnummer = txtLidnummer.text
        self.nieuweMonitor.rijksregisternummer = txtRijksregisterNr.text
        self.nieuweMonitor.email = txtEmail.text
    }
}