import UIKit

class Registratie4ViewController: UIViewController
{
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtWachtwoord: UITextField!
    @IBOutlet weak var txtBevestigWachtwoord: UITextField!
    
    var ouder: Ouder!
    var tellerAantalLegeVelden: Int = 0
    var foutBox: FoutBox? = nil
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if segue.identifier == "voltooiRegistratie" {
            let registratieSuccesvolViewController = segue.destinationViewController as RegistratieSuccesvolViewController
     
            isTextVeldEmpty(txtEmail)
            isTextVeldEmpty(txtWachtwoord)
            isTextVeldEmpty(txtBevestigWachtwoord)
            
            if tellerAantalLegeVelden > 0 {
                textVeldenLeegMaken()
                foutBoxOproepen("Fout", "Gelieve alle verplichte velden in te vullen!", self)
            } else {
                controleerEmail(txtEmail.text)
                controleerWachtwoorden(txtWachtwoord.text, bevestigWachtwoord: txtBevestigWachtwoord.text)
                controlerenBestaandeEmail(txtEmail.text)
            }
            
            if foutBox != nil {
                textVeldenLeegMaken()
                foutBoxOproepen(foutBox!, self)
            } else {
                //wachtwoord encrypteren!!!!!
                ouder.email = txtEmail.text
                ouder.wachtwoord = txtWachtwoord.text
                registratieSuccesvolViewController.ouder = ouder
            }
        }
    }
    
    func isTextVeldEmpty(textVeld: UITextField) {
        if textVeld.text.isEmpty {
            tellerAantalLegeVelden += 1
        }
    }
    
    func textVeldenLeegMaken() {
        txtEmail.text = ""
        txtWachtwoord.text = ""
        txtBevestigWachtwoord.text = ""
    }
    
    func controleerEmail(email: String) {
        if !checkPatternEmail(email) {
            if foutBox != nil {
                foutBox?.alert.message?.extend("\n Email is niet geldig.")
            } else {
                foutBox = FoutBox(title: "Ongeldige waarde(s)", message: "Email is niet geldig.")
            }
        }
    }
    
    func checkPatternEmail(email: String) -> Bool {
        if countElements(email) == 0 {
            return false
        } else if Regex(p: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}").test(email) {
            return true
        }
        return false
    }
    
    func controleerWachtwoorden(wachtwoord: String, bevestigWachtwoord: String) {
        if !checkWachtwoorden(wachtwoord, bevestigWachtwoord: bevestigWachtwoord) {
            if foutBox != nil {
                foutBox?.alert.message?.extend("\n Wachtwoord en bevestig wachtwoord komen niet overeen.")
            } else {
                foutBox = FoutBox(title: "Ongeldige waarde(s)", message: "Wachtwoord en bevestig wachtwoord komen niet overeen.")
            }
        }
    }
    
    func checkWachtwoorden(wachtwoord: String, bevestigWachtwoord: String) -> Bool {
        if wachtwoord != bevestigWachtwoord {
            return false
        } else {
            return true
        }
    }
    
    func controlerenBestaandeEmail(email: String) {
        if controleerGekendeEmail(email) {
            if foutBox != nil {
                foutBox?.alert.message?.extend("\n Er bestaat al een gebruiker met dit e-mailadres.")
            } else {
                foutBox = FoutBox(title: "Ongeldige waarde(s)", message: "Er bestaat al een gebruiker met dit e-mailadres.")
            }
        }
    }
    
    //alternatief verloop nog toevoegen in lastenboek!!!! (UC Registreren)
    func controleerGekendeEmail(email: String) -> Bool {
        var ouders: [PFObject] = []
        
        var query = PFQuery(className: "Ouder")
        
        query.whereKey("email", containsString: email)
        
        var aantalOudersMetEmail: Int = query.countObjects()
    
        if aantalOudersMetEmail > 0 {
            return true
        } else {
            return false
        }
    }
}