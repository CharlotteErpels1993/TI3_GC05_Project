import UIKit
import QuartzCore

class Registratie3ViewController: /*ResponsiveTextFieldViewController*/ UITableViewController {
    
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtWachtwoord: UITextField!
    @IBOutlet weak var txtBevestigWachtwoord: UITextField!
    
    var ouder: Ouder!
    var foutBox: FoutBox? = nil
    var statusTextFields: [String: String] = [:]
    var redColor: UIColor = UIColor.redColor()
    var emailAlGeregistreerd: Bool = false
    var ww: String = ""
    
    @IBAction func gaTerugNaarInloggen(sender: AnyObject) {
        annuleerControllerRegistratie(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.txtEmail.text = ""
        self.txtWachtwoord.text = ""
        self.txtBevestigWachtwoord.text = ""
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "voltooiRegistratie" {
            let registratieSuccesvolViewController = segue.destinationViewController as RegistratieSuccesvolViewController
            
            if Reachability.isConnectedToNetwork() == false {
                var alert = UIAlertController(title: "Oeps.. U heeft geen internet", message: "U heeft internet nodig voor u te registeren. Ga naar instellingen om dit aan te passen.", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "Annuleer", style: UIAlertActionStyle.Default, handler: nil))
                alert.addAction(UIAlertAction(title: "Ga naar instellingen", style: .Default, handler: { action in
                    switch action.style{
                    default:
                        UIApplication.sharedApplication().openURL(NSURL(string:UIApplicationOpenSettingsURLString)!);
                    }
                    
                }))
                alert.addAction(UIAlertAction(title: "Ga terug naar vakanties", style: .Default, handler: { action in
                    switch action.style{
                    default:
                        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                        var destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("Vakanties") as UIViewController
                        self.sideMenuController()?.setContentViewController(destViewController)
                        self.hideSideMenuView()                    }
                    
                }))
                presentViewController(alert, animated: true, completion: nil)
                txtBevestigWachtwoord.resignFirstResponder()
                txtEmail.resignFirstResponder()
                txtWachtwoord.resignFirstResponder()
                
            }
        
            setStatusTextFields()
            pasLayoutVeldenAan()
            
            if controleerRodeBordersAanwezig() == true {
                if emailAlGeregistreerd == true {
                    foutBoxOproepen("Fout", "Dit e-mailadres (\(self.txtEmail.text!)) is al geregistreerd bij ons!", self)
                    self.txtEmail.text = ""
                } else {
                    foutBoxOproepen("Fout", "Gelieve de velden correct in te vullen!", self)
                }
                self.viewDidLoad()
            } else {
                if wachtwoordenMatch(txtWachtwoord.text, txtBevestigWachtwoord.text) == true {
                    settenGegevens()
                    registratieSuccesvolViewController.ouder = ouder
                    registratieSuccesvolViewController.ww = self.ww
                } else {
                    giveUITextFieldDefaultBorder(txtEmail)
                    giveUITextFieldRedBorder(txtWachtwoord)
                    giveUITextFieldRedBorder(txtBevestigWachtwoord)
                    foutBoxOproepen("Fout", "Wachtwoord en bevestig wachtwoord komen niet overeen.", self)
                }
            }
        }
    }
    
    func setStatusTextFields() {
        if txtEmail.text.isEmpty {
            statusTextFields["email"] = "leeg"
            emailAlGeregistreerd = false
        } else {
            if !checkPatternEmail(txtEmail.text) {
                statusTextFields["email"] = "ongeldig"
                emailAlGeregistreerd = false
                //txtEmail.text = ""
            } else if controleerEmailAlGeregisteerd() == true {
                statusTextFields["email"] = "al geregistreerd"
                emailAlGeregistreerd = true
                //txtEmail.text = ""
            } else {
                statusTextFields["email"] = "geldig"
                emailAlGeregistreerd = false
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
        if statusTextFields["email"] == "leeg" || statusTextFields["email"] == "ongeldig" || statusTextFields["email"] == "al geregistreerd" {
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
    
    func settenGegevens() {
        ouder.email = txtEmail.text
        self.ww = txtWachtwoord.text
    }
    
    func controleerEmailAlGeregisteerd() -> Bool {
        //return ParseData.getEmail(self.txtEmail.text)
        return LocalDatastore.isEmailAlGeregistreerd(self.txtEmail.text)
    }
    
}