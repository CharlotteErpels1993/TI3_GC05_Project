import UIKit
import QuartzCore

class Registratie1ViewController: ResponsiveTextFieldViewController {
    var ouder: Ouder! = Ouder(id: "test")
    var gebruikerIsLid: Bool? = true
    var foutBox: FoutBox? = nil
    var redColor: UIColor = UIColor.redColor()
    var statusTextFields: [String: String] = [:]
    var rijksregisterNrAlGeregistreerd: Bool = false
    
    @IBOutlet weak var isLid: UISwitch!
    @IBOutlet weak var lblAansluitingsNr: UILabel!
    @IBOutlet weak var txtAansluitingsNr: UITextField!
    @IBOutlet weak var lblCodeGerechtigde: UILabel!
    @IBOutlet weak var txtCodeGerechtigde: UITextField!
    @IBOutlet weak var lblRijksregisterNr: UILabel!
    @IBOutlet weak var txtRijksregisterNr: UITextField!
    @IBOutlet weak var lblAansluitingsNrTweedeOuder: UILabel!
    @IBOutlet weak var txtAansluitingsNrTweedeOuder: UITextField!
    @IBOutlet weak var buttonNummers: UIButton!
    @IBOutlet weak var buttonRegisterenMonitor: UIButton!
    @IBOutlet weak var labelVerplichtInTevullen: UILabel!
    
    @IBAction func toggle(sender: AnyObject) {
        toggleSideMenuView()
    }
    @IBAction func gaTerugNaarInloggen(sender: AnyObject) {
        annuleerControllerRegistratie(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideSideMenuView()
        self.txtRijksregisterNr.text = ""
        self.txtCodeGerechtigde.text = ""
        self.txtAansluitingsNr.text = ""
        self.txtAansluitingsNrTweedeOuder.text = ""
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        ParseData.deleteOuderTable()
        ParseData.vulOuderTableOp()
        ParseData.deleteMonitorTable()
        ParseData.vulMonitorTableOp()
    }
    
    
    @IBAction func gaTerugNaarRegistreren(segue: UIStoryboard) {
    }
    
    @IBAction func switched(sender: UISwitch) {
        if sender.on {
            gebruikerIsLid = true
            
            lblAansluitingsNr.hidden = false
            lblCodeGerechtigde.hidden = false
            lblAansluitingsNrTweedeOuder.hidden = false
            txtAansluitingsNr.hidden = false
            txtCodeGerechtigde.hidden = false
            txtAansluitingsNrTweedeOuder.hidden = false
            buttonNummers.hidden = false
            buttonRegisterenMonitor.hidden = false
            labelVerplichtInTevullen.hidden = false
        } else {
            gebruikerIsLid = false
            
            lblAansluitingsNr.hidden = true
            lblCodeGerechtigde.hidden = true
            lblAansluitingsNrTweedeOuder.hidden = true
            txtAansluitingsNr.hidden = true
            txtCodeGerechtigde.hidden = true
            txtAansluitingsNrTweedeOuder.hidden = true
            buttonNummers.hidden = true
            buttonRegisterenMonitor.hidden = true
            labelVerplichtInTevullen.hidden = true
        }
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "volgende" {
            let registratie2ViewController = segue.destinationViewController as Registratie2ViewController
            setStatusTextFields()
            pasLayoutVeldenAan()
            
            if controleerRodeBordersAanwezig() == true {
                if rijksregisterNrAlGeregistreerd == true {
                    foutBoxOproepen("Fout", "Dit rijksregisternummer (\(self.txtRijksregisterNr.text)) is al geregistreerd!", self)
                } else {
                    foutBoxOproepen("Fout", "Gelieve de velden correct in te vullen!", self)
                }
                self.viewDidLoad()
            } else {
                ouder.rijksregisterNr = txtRijksregisterNr.text
                settenOptioneleGegevens()
                registratie2ViewController.ouder = ouder
            }
        } else if segue.identifier == "gaTerug" {
            let vakantiesViewController = segue.destinationViewController as VakantiesTableViewController
        }
    }
    
    func setStatusTextFields() {
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
        
        if txtRijksregisterNr.text.isEmpty {
            statusTextFields["rijksregisterNr"] = "leeg"
            self.rijksregisterNrAlGeregistreerd = false
        } else {
            if !checkPatternRijksregisterNr(txtRijksregisterNr.text) {
                statusTextFields["rijksregisterNr"] = "ongeldig"
                self.rijksregisterNrAlGeregistreerd = false
            } else {
                if controleerRijksregisterNummerAlGeregisteerd() == true {
                    statusTextFields["rijksregisterNr"] = "al geregistreerd"
                    self.rijksregisterNrAlGeregistreerd = true
                } else {
                    statusTextFields["rijksregisterNr"] = "geldig"
                    self.rijksregisterNrAlGeregistreerd = false
                }
            }
        }
        
        if txtAansluitingsNrTweedeOuder.text.isEmpty {
            statusTextFields["aansluitingsNrTweedeOuder"] = "leeg"
        } else {
            if !controleerGeldigheidNummer(txtAansluitingsNrTweedeOuder.text) {
                statusTextFields["aansluitingsNrTweedeOuder"] = "ongeldig"
            } else if !checkPatternAansluitingsNr(txtAansluitingsNrTweedeOuder.text.toInt()!) {
                statusTextFields["aansluitingsNrTweedeOuder"] = "ongeldig"
            } else {
                statusTextFields["aansluitingsNrTweedeOuder"] = "geldig"
            }
        }
    }
    
    func pasLayoutVeldenAan() {
        
        if statusTextFields["rijksregisterNr"] == "leeg" || statusTextFields["rijksregisterNr"] == "ongeldig" || statusTextFields["rijksregisterNr"] == "al geregistreerd" {
            giveUITextFieldRedBorder(txtRijksregisterNr)
        } else {
            giveUITextFieldDefaultBorder(txtRijksregisterNr)
        }
        
        if gebruikerIsLid == true {
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
            
            if statusTextFields["aansluitingsNrTweedeOuder"] == "ongeldig" {
                giveUITextFieldRedBorder(txtAansluitingsNrTweedeOuder)
            }  else {
                giveUITextFieldDefaultBorder(txtAansluitingsNrTweedeOuder)
            }
        } else {
            giveUITextFieldDefaultBorder(txtAansluitingsNr)
            giveUITextFieldDefaultBorder(txtCodeGerechtigde)
            giveUITextFieldDefaultBorder(txtAansluitingsNrTweedeOuder)
        }
    }
    
    func controleerRodeBordersAanwezig() -> Bool {
        
        if CGColorEqualToColor(txtAansluitingsNr.layer.borderColor, redColor.CGColor) {
            return true
        } else if CGColorEqualToColor(txtCodeGerechtigde.layer.borderColor, redColor.CGColor) {
            return true
        } else if CGColorEqualToColor(txtRijksregisterNr.layer.borderColor, redColor.CGColor) {
            return true
        } else if CGColorEqualToColor(txtAansluitingsNrTweedeOuder.layer.borderColor, redColor.CGColor) {
            return true
        } else {
            return false
        }
    }
    
    func settenOptioneleGegevens() {
        
        if gebruikerIsLid == true {
            ouder.aansluitingsNr = txtAansluitingsNr.text.toInt()!
            ouder.codeGerechtigde = txtCodeGerechtigde.text.toInt()!
            
            if statusTextFields["aansluitingsNrTweedeouder"] != "leeg" {
                ouder.aansluitingsNrTweedeOuder = txtAansluitingsNrTweedeOuder.text.toInt()!
            }
        }
        
    }
    
    func controleerRijksregisterNummerAlGeregisteerd() -> Bool {
        return ParseData.getRijksregisterNummers(self.txtRijksregisterNr.text)
    }
}

