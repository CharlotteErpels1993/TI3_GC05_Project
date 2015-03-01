import UIKit
import QuartzCore

class Registratie3ViewController: UITableViewController {
    
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtWachtwoord: UITextField!
    @IBOutlet weak var txtBevestigWachtwoord: UITextField!
    
    var ouder: Ouder!
    var foutBox: FoutBox? = nil
    var statusTextFields: [String: String] = [:]
    var redColor: UIColor = UIColor.redColor()
    var emailAlGeregistreerd: Bool = false
    var wachtwoordOuder: String = ""
    
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
    @IBAction func gaTerugNaarInloggen(sender: AnyObject) {
        annuleerControllerRegistratie(self)
    }
    
    //
    //Naam: viewDidLoad
    //
    //Werking: - zorgt dat alle velden eerst leeg zijn voor het tonen van de view
    //
    //Parameters:
    //
    //Return:
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        self.txtEmail.text = ""
        self.txtWachtwoord.text = ""
        self.txtBevestigWachtwoord.text = ""
    }
    
    //
    //Naam: prepareForSegue
    //
    //Werking: - maakt de volgende view met opgegeven identifier (stelt soms attributen van de volgende view op)
    //         - controleert ook eerste de ingevulde velden op geldigheid, zonee wordt er een foutmelding gegeven
    //
    //Parameters:
    //  - segue: UIStoryboardSegue
    //  - sender: AnyObject?
    //
    //Return:
    //
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "voltooiRegistratie" {
            let registratieSuccesvolViewController = segue.destinationViewController as RegistratieSuccesvolViewController
        
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
                    registratieSuccesvolViewController.wachtwoordOuder = self.wachtwoordOuder
                } else {
                    giveUITextFieldDefaultBorder(txtEmail)
                    giveUITextFieldRedBorder(txtWachtwoord)
                    giveUITextFieldRedBorder(txtBevestigWachtwoord)
                    foutBoxOproepen("Fout", "Wachtwoord en bevestig wachtwoord komen niet overeen.", self)
                }
            }
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
            emailAlGeregistreerd = false
        } else {
            if !checkPatternEmail(txtEmail.text) {
                statusTextFields["email"] = "ongeldig"
                emailAlGeregistreerd = false
            } else if controleerEmailAlGeregisteerd() == true {
                statusTextFields["email"] = "al geregistreerd"
                emailAlGeregistreerd = true
            } else {
                statusTextFields["email"] = "geldig"
                emailAlGeregistreerd = false
            }
        }
        
        if txtWachtwoord.text.isEmpty {
            statusTextFields["wachtwoord"] = "leeg"
        } else {
            statusTextFields["wachtwoord"] = "ingevuld"
        }
        
        if txtBevestigWachtwoord.text.isEmpty {
            statusTextFields["bevestigWachtwoord"] = "leeg"
        } else {
            statusTextFields["bevestigWachtwoord"] = "ingevuld"
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
        } else if CGColorEqualToColor(txtBevestigWachtwoord.layer.borderColor, redColor.CGColor) {
            return true
        } else {
            return false
        }
    }
    
    //
    //Naam: settenGegevens
    //
    //Werking: - afhankelijk van de status van de verplichte velden, worden de gegevens van de ouder ingesteld
    //
    //Parameters:
    //
    //Return:
    //
    func settenGegevens() {
        ouder.email = txtEmail.text
        self.wachtwoordOuder = txtWachtwoord.text
    }
    
    //
    //Naam: controleerEmailAlGeregistreerd
    //
    //Werking: - bekijkt in de databank of er al een ouder zich ingeschreven heeft met die email
    //
    //Parameters:
    //
    //Return: een bool true als het emailadres al geregistreerd is, anders false
    //
    func controleerEmailAlGeregisteerd() -> Bool {
        //return LocalDatastore.isEmailAlGeregistreerd(self.txtEmail.text)
        
        var qOuder = Query(tableName: Constanten.TABLE_OUDER)
        qOuder.addWhereEqualTo(Constanten.COLUMN_EMAIL, value: txtEmail.text)
        
        var qMonitor = Query(tableName: Constanten.TABLE_MONITOR)
        qMonitor.addWhereEqualTo(Constanten.COLUMN_EMAIL, value: txtEmail.text)
        
        var qAdmin = Query(tableName: Constanten.TABLE_USER)
        qAdmin.addWhereEqualTo(Constanten.COLUMN_EMAIL, value: txtEmail.text)
        
        
        if !qOuder.isEmpty() || !qMonitor.isEmpty() || !qAdmin.isEmpty() {
            return true
        } else {
            return false
        }
    }
}