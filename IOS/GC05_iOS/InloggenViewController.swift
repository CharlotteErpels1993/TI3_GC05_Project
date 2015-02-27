import UIKit
import QuartzCore

class InloggenViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtWachtwoord: UITextField!
    
    var statusTextFields: [String: String] = [:]
    var redColor: UIColor = UIColor.redColor()
    
    //
    //Naam: toggle
    //
    //Werking: - zorgt ervoor dat de side bar menu wordt weergegeven
    //         - zorgt er ook voor dat alle toestenborden gesloten zijn
    //
    //Parameters:
    //  - sender: AnyObject
    //
    //Return:
    //
    @IBAction func toggle(sender: AnyObject) {
        txtEmail.resignFirstResponder()
        txtWachtwoord.resignFirstResponder()
        toggleSideMenuView()
    }
    
    //
    //Naam: gaTerugNaarInloggen
    //
    //Werking: - zorgt voor een unwind segue
    //         - geeft ook een melding bij het verlaten van het scherm (of de gebruiker dit effectief wilt)
    //
    //Parameters:
    //  - sender: AnyObject
    //
    //Return:
    //
    @IBAction func gaTerugNaarInloggen(segue: UIStoryboardSegue) {}
    
    //
    //Naam: inloggen
    //
    //Werking: - maakt de volgende view klaar (naargelang welke role de gebruiker is ingelogd)
    //         - controleert ook eerste de ingevulde velden op geldigheid, zo nee wordt er een foutmelding gegeven
    //
    //Parameters:
    //  - sender: AnyObject
    //
    //Return:
    //
    @IBAction func inloggen(sender: AnyObject) {
        var email: String = txtEmail.text
        var wachtwoord: String = txtWachtwoord.text
        
        setStatusTextFields()
        pasLayoutVeldenAan()
        
        if controleerRodeBordersAanwezig() == true {
            foutBoxOproepen("Fout", "Gelieve de velden correct in te vullen!", self)
            self.txtEmail.text = ""
            self.txtWachtwoord.text = ""
        } else {
            var user = PFUser.logInWithUsername(txtEmail.text, password: txtWachtwoord.text)
            
            if user == nil {
                giveUITextFieldRedBorder(self.txtEmail)
                giveUITextFieldRedBorder(self.txtWachtwoord)
                txtEmail.text = ""
                txtWachtwoord.text = ""
                foutBoxOproepen("Fout", "Foutieve combinatie e-mail & wachtwoord", self)
            } else {
                var type: String = user["soort"] as String
                
                if type == "monitor" {
                    LocalDatastore.getTableReady("Vorming")
                    LocalDatastore.getTableReady("InschrijvingVorming")
                    performSegueWithIdentifier("overzichtMonitor", sender: self)
                } else if type == "ouder" {
                    performSegueWithIdentifier("ouderOverzicht", sender: self)
                } else if type == "administrator" {
                    performSegueWithIdentifier("administratorOverzicht", sender: self)
                }
            }
        }
    }
    
    //
    //Naam: viewDidLoad
    //
    //Werking: - zorgt ervoor dat de side bar menu verborgen is
    //         - verbergt de toolbar (afkomstig van vakantie detail)
    //         - zorgt ervoor dat er geen autocorrect is op de text fields email adres en wachtwoord
    //         - bekijkt of de gebruiker internet heeft, zoniet geeft hij een gepaste melding
    //
    //Parameters:
    //
    //Return:
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        hideSideMenuView()
        self.setNeedsStatusBarAppearanceUpdate()
        self.navigationController!.toolbarHidden = true
        txtEmail.autocorrectionType = UITextAutocorrectionType.No
        txtWachtwoord.autocorrectionType = UITextAutocorrectionType.No
        
        txtEmail.delegate = self
        txtWachtwoord.delegate = self
        
        if Reachability.isConnectedToNetwork() == false {
            var alert = UIAlertController(title: "Oeps.. U heeft geen internet", message: "U heeft internet nodig voor u in te loggen. Ga naar instellingen om dit aan te passen.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Annuleer", style: UIAlertActionStyle.Default, handler: nil))
            alert.addAction(UIAlertAction(title: "Ga naar instellingen", style: .Default, handler: { action in
                switch action.style{
                default:
                    UIApplication.sharedApplication().openURL(NSURL(string:UIApplicationOpenSettingsURLString)!);
                }
                
            }))
            presentViewController(alert, animated: true, completion: nil)
            txtEmail.resignFirstResponder()
            txtWachtwoord.resignFirstResponder()
        }
    }
    
    //
    //Naam: setStatusTextFields
    //
    //Werking: - zet de status van de text fields in
    //              * controleert of de velden leeg zijn
    //              * controleert of andere validatiemethoden geldig zijn
    //              * wanneer een text field ongeldig is krijgt deze de status "leeg" of "ongeldig"
    //
    //Parameters:
    //
    //Return:
    //
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
            statusTextFields["wachtwoord"] = "ingevuld"
        }
    }
    
    //
    //Naam: pasLayoutVeldenAan
    //
    //Werking: - zorgt ervoor dat de text field, wanneer status "ongeldig" of "leeg" is, een rode border krijgt
    //         - als deze status niet "leeg" of "ongeldig" is wordt deze border terug op default gezet
    //
    //Parameters:
    //
    //Return:
    //
    func pasLayoutVeldenAan() {
        if statusTextFields["email"] == "leeg" || statusTextFields["email"] == "ongeldig" {
            giveUITextFieldRedBorder(txtEmail)
        } else {
            giveUITextFieldDefaultBorder(txtEmail)
        }
        
        if statusTextFields["wachtwoord"] == "leeg" {
            giveUITextFieldRedBorder(txtWachtwoord)
        } else {
            giveUITextFieldDefaultBorder(txtWachtwoord)
        }
    }
    
    //
    //Naam: controleerRodeBordersAanwezig
    //
    //Werking: - bekijkt of de text field borders een rode border hebben
    //
    //Parameters:
    //
    //Return: een bool true als er een rode border aanwezig is, anders false
    //
    func controleerRodeBordersAanwezig() -> Bool {
        if CGColorEqualToColor(txtEmail.layer.borderColor, redColor.CGColor) {
            return true
        } else if CGColorEqualToColor(txtWachtwoord.layer.borderColor, redColor.CGColor) {
            return true
        } else {
            return false
        }
    }
    
    //
    //Naam: prepareForSegue
    //
    //Werking: - maakt de volgende view met opgegeven identifier (stelt soms attributen van de volgende view op)
    //         - controleert ook eerste de ingevulde velden op geldigheid, zo nee wordt er een foutmelding gegeven
    //
    //Parameters:
    //  - segue: UIStoryboardSegue
    //  - sender: AnyObject?
    //
    //Return:
    //
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "nieuwWachtwoord" {
            let nieuwWachtwoordController = segue.destinationViewController as NieuwWachtwoordViewController
        } else if segue.identifier == "registreren" {
            let registrerenController = segue.destinationViewController as Registratie1ViewController
        } else if segue.identifier == "ouderOverzicht" {
            let ouderOverzichtController = segue.destinationViewController as VakantiesTableViewController
        } else if segue.identifier == "overzichtMonitor" {
            LocalDatastore.getTableReady(Constanten.TABLE_INSCHRIJVINGVORMING)
            LocalDatastore.getTableReady(Constanten.TABLE_VOORKEUR)
            let vormingenTableViewController = segue.destinationViewController as VormingenTableViewController
        } else if segue.identifier == "administratorOverzicht" {
            let overzichtAdministrator = segue.destinationViewController as VakantiesTableViewController
        } else {
            var alert = UIAlertController(title: "Fout", message: "U hebt niet alle velden ingevuld!", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ga terug", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    //
    //Naam: veldenZijnIngevuld
    //
    //Werking: - controleert of de velden, emailadres en wachtwoord, ingevuld zijn
    //
    //Parameters:
    //  - email: String
    //  - wachtwoord: String
    //
    //Return: een bool true als de velden ingevuld zijn, zo nee false
    //
    private func veldenZijnIngevuld(email: String, wachtwoord: String) -> Bool {
        if !email.isEmpty && !wachtwoord.isEmpty {
            return true
        } else {
            return false
        }
    }
    
    //
    //Naam: textFieldShouldReturn
    //
    //Werking: - zorgt ervoor als er op volgende wordt geklikt bij text field email, de cursor naar text field wachtwoord gaat
    //         - zorgt ervoor als er op ga wordt geklik bij text field wachtwoord, de gebruiker ingelogd wordt
    //         - toetsenbord bij na drukken op ga verborgen
    //
    //Parameters:
    //  - textField: UITextField
    //  - sender: AnyObject?
    //
    //Return: een bool
    //
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == txtEmail {
            txtWachtwoord.becomeFirstResponder()
        } else if textField == txtWachtwoord {
            inloggen(self)
            txtWachtwoord.resignFirstResponder()
        }
        return true
    }
}