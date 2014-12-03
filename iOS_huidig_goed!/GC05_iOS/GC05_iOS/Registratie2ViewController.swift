import UIKit
import QuartzCore

class Registratie2ViewController: ResponsiveTextFieldViewController
{
    @IBOutlet weak var txtVoornaam: UITextField!
    @IBOutlet weak var txtNaam: UITextField!
    @IBOutlet weak var txtStraat: UITextField!
    @IBOutlet weak var txtNummer: UITextField!
    @IBOutlet weak var txtBus: UITextField!
    @IBOutlet weak var txtGemeente: UITextField!
    @IBOutlet weak var txtPostcode: UITextField!
    @IBOutlet weak var txtTelefoon: UITextField!
    @IBOutlet weak var txtGsm: UITextField!
    
    var ouder: Ouder!
    var foutBox: FoutBox? = nil
    var statusTextFields: [String: String] = [:]
    var redColor: UIColor = UIColor.redColor()
    var gsmAlGeregistreerd: Bool = false
    
    @IBAction func gaTerugNaarInloggen(sender: AnyObject) {
        annuleerControllerRegistratie(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.txtGsm.text = ""
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "volgende" {
            let registratie3ViewController = segue.destinationViewController as Registratie3ViewController
        
            //nieuw: Charlotte
            setStatusTextFields()
            pasLayoutVeldenAan()
            
            if controleerRodeBordersAanwezig() == true {
                if gsmAlGeregistreerd == true {
                    foutBoxOproepen("Fout", "Deze GSM-nummer (\(self.txtGsm.text)) is al geregistreerd bij ons!", self)
                } else {
                    foutBoxOproepen("Fout", "Gelieve de velden correct in te vullen!", self)
                }
                self.viewDidLoad()
            } else {
                settenVerplichteGegevens()
                settenOptioneleGegevens()
                registratie3ViewController.ouder = ouder
            }
            
        /*setStatusTextFields()
        pasLayoutVeldenAan()
        
        if controleerRodeBordersAanwezig() == true {
            foutBoxOproepen("Fout", "Gelieve de velden correct in te vullen!", self)
        } else {
            settenVerplichteGegevens()
            settenOptioneleGegevens()
            
            if controleerGSMAlGeregisteerd() == true {
                giveUITextFieldRedBorder(self.txtGsm)
                let alertController = UIAlertController(title: "Fout", message: "Deze gsm bestaat al", preferredStyle: .Alert)
                let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: {
                    action in
                    self.viewDidLoad()
                })
                alertController.addAction(okAction)
                self.presentViewController(alertController, animated: true, completion: nil)
                
            } else {
                registratie3ViewController.ouder = ouder
            }
        }*/
        } else if segue.identifier == "gaTerug" {
            let vakantiesViewController = segue.destinationViewController as VakantiesTableViewController
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
        
        if txtStraat.text.isEmpty {
            statusTextFields["straat"] = "leeg"
        } else {
            //TO DO: checken op pattern?
            statusTextFields["straat"] = "ingevuld"
        }
        
        if txtNummer.text.isEmpty {
            statusTextFields["nummer"] = "leeg"
        } else {
            if !controleerGeldigheidNummer(txtNummer.text) {
                statusTextFields["nummer"] = "ongeldig"
            } else if !checkPatternNummer(txtNummer.text.toInt()!) {
                statusTextFields["nummer"] = "ongeldig"
            } else {
                statusTextFields["nummer"] = "geldig"
            }
        }
        
        if txtBus.text.isEmpty {
            statusTextFields["bus"] = "leeg"
        } else {
            //TO DO: checken op pattern?
            statusTextFields["bus"] = "ingevuld"
        }
        
        if txtGemeente.text.isEmpty {
            statusTextFields["gemeente"] = "leeg"
        } else {
            //TO DO: checken op pattern?
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
            gsmAlGeregistreerd = false
        } else {
            if !checkPatternGsm(txtGsm.text) {
                statusTextFields["gsm"] = "ongeldig"
                gsmAlGeregistreerd = false
            } else if controleerGSMAlGeregisteerd() == true {
                statusTextFields["gsm"] = "al geregistreerd"
                gsmAlGeregistreerd = true
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
            giveUITextFieldRedBorder(txtNummer)
        } else {
            giveUITextFieldDefaultBorder(txtNummer)
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
        } else if CGColorEqualToColor(txtNummer.layer.borderColor, redColor.CGColor) {
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
        ouder.voornaam = txtVoornaam.text
        ouder.naam = txtNaam.text
        ouder.straat = txtStraat.text
        ouder.nummer = txtNummer.text.toInt()
        ouder.gemeente = txtGemeente.text
        ouder.postcode = txtPostcode.text.toInt()
        ouder.gsm = txtGsm.text
    }
    
    func settenOptioneleGegevens() {
        if statusTextFields["bus"] != "leeg" {
            ouder.bus = txtBus.text
        }
        
        if statusTextFields["telefoon"] != "leeg" {
            ouder.telefoon = txtTelefoon.text
        }
    }
    
    func controleerGSMAlGeregisteerd() -> Bool {
        return ParseData.getGSM(self.txtGsm.text)
    }
}