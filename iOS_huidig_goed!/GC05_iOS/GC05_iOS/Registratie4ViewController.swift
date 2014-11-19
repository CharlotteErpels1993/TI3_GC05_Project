import UIKit
import QuartzCore

class Registratie4ViewController: UIViewController
{
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtWachtwoord: UITextField!
    @IBOutlet weak var txtBevestigWachtwoord: UITextField!
    
    var ouder: Ouder!
    var foutBox: FoutBox? = nil
    var statusTextFields: [String: String] = [:]
    var redColor: UIColor = UIColor.redColor()
    
    @IBAction func gaTerugNaarInloggen(sender: AnyObject) {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        var destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("Inloggen") as UIViewController
        sideMenuController()?.setContentViewController(destViewController)
        hideSideMenuView()
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "voltooiRegistratie" {
        let registratieSuccesvolViewController = segue.destinationViewController as RegistratieSuccesvolViewController
        
        //TO DO: controleren op formaat van ingevulde text! (String, int, ...)
        
        setStatusTextFields()
        pasLayoutVeldenAan()
        
        if controleerRodeBordersAanwezig() == true {
            foutBoxOproepen("Fout", "Gelieve de velden correct in te vullen!", self)
        } else {
            if emailBestaatAl() == true {
                giveUITextFieldRedBorder(txtEmail)
                giveUITextFieldDefaultBorder(txtWachtwoord)
                giveUITextFieldDefaultBorder(txtBevestigWachtwoord)
                foutBoxOproepen("Fout", "Er is al een gebruiker met dit e-mailadres geregistreerd.", self)
            } else {
                if wachtwoordenMatch() == true {
                    settenGegevens()
                    registratieSuccesvolViewController.ouder = ouder
                } else {
                    giveUITextFieldDefaultBorder(txtEmail)
                    giveUITextFieldRedBorder(txtWachtwoord)
                    giveUITextFieldRedBorder(txtBevestigWachtwoord)
                    foutBoxOproepen("Fout", "Wachtwoord en bevestig wachtwoord komen niet overeen.", self)
                }
            }
        }
        } else if segue.identifier == "gaTerug" {
            let vakantiesTableViewController = segue.destinationViewController as VakantiesTableViewController
        }
    }
    
    func setStatusTextFields() {
        if txtEmail.text.isEmpty {
            statusTextFields["email"] = "leeg"
        } else {
            if !checkPatternEmail(txtEmail.text) {
                statusTextFields["email"] = "ongeldig"
            } else {
                statusTextFields["email"] = "geldig"
            }
        }
        
        if txtWachtwoord.text.isEmpty {
            statusTextFields["wachtwoord"] = "leeg"
        } else {
            //TO DO: checken op pattern?
            statusTextFields["wachtwoord"] = "ingevuld"
        }
        
        if txtBevestigWachtwoord.text.isEmpty {
            statusTextFields["bevestigWachtwoord"] = "leeg"
        } else {
            //TO DO: checken op pattern?
            statusTextFields["bevestigWachtwoord"] = "ingevuld"
        }
    }
    
    func pasLayoutVeldenAan() {
        if statusTextFields["email"] == "leeg" || statusTextFields["email"] == "ongeldig" {
            giveUITextFieldRedBorder(txtEmail)
        } else {
            giveUITextFieldDefaultBorder(txtEmail)
        }
        
        if statusTextFields["wachtwoord"] == "leeg" || statusTextFields["wachtwoord"] == "ongeldig" {
            giveUITextFieldRedBorder(txtWachtwoord)
        } else {
            giveUITextFieldDefaultBorder(txtWachtwoord)
        }
        
        if statusTextFields["bevestigWachtwoord"] == "leeg" ||
            statusTextFields["bevestigWachtwoord"] == "ongeldig" {
                giveUITextFieldRedBorder(txtBevestigWachtwoord)
        } else {
            giveUITextFieldDefaultBorder(txtBevestigWachtwoord)
        }
    }
    
    func controleerRodeBordersAanwezig() -> Bool {
        if CGColorEqualToColor(txtEmail.layer.borderColor, redColor.CGColor) {
            return true
        } else if CGColorEqualToColor(txtWachtwoord.layer.borderColor, redColor.CGColor) {
            return true
        } else if CGColorEqualToColor(txtBevestigWachtwoord.layer.borderColor, redColor.CGColor) {
            return true
        } else {
            return false
        }
    }
    
    func wachtwoordenMatch() -> Bool {
        if txtWachtwoord.text == txtBevestigWachtwoord.text {
            return true
        } else {
            return false
        }
    }
    
    func settenGegevens() {
        ouder.email = txtEmail.text
        ouder.wachtwoord = txtWachtwoord.text
    }
    
    func checkPatternEmail(email: String) -> Bool {
        if countElements(email) == 0 {
            return false
        } else if Regex(p: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}").test(email) {
            return true
        }
        return false
    }
    
    //alternatief verloop nog toevoegen in lastenboek!!!! (UC Registreren)
    func emailBestaatAl() -> Bool {
        var ouders: [PFObject] = []
        
        var query = PFQuery(className: "Ouder")
        
        query.whereKey("email", containsString: txtEmail.text)
        
        var aantalOudersMetEmail: Int = query.countObjects()
        
        if aantalOudersMetEmail > 0 {
            return true
        } else {
            return false
        }
    }
}