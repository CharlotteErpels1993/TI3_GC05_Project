import UIKit

class RegistratieSuccesvolViewController: UIViewController
{
    var gebruiker: Gebruiker!
    var aansluitingsNrTweedeOuder: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gebruikerWegschrijvenNaarDatabase(gebruiker)
    }
    
    private func gebruikerWegschrijvenNaarDatabase(gebruiker: Gebruiker) {
        if aansluitingsNrTweedeOuder == nil {
            var monitor = PFObject(className: "Monitor")
            
            monitor.setValue(gebruiker.rijksregisterNr, forKey: "rijksregisterNr")
            monitor.setValue(gebruiker.email, forKey: "email")
            monitor.setValue(gebruiker.wachtwoord, forKey: "wachtwoord")
            monitor.setValue(gebruiker.voornaam, forKey: "voornaam")
            monitor.setValue(gebruiker.naam, forKey: "naam")
            monitor.setValue(gebruiker.straat, forKey: "straat")
            monitor.setValue(gebruiker.nummer, forKey: "nummer")
            monitor.setValue(gebruiker.rijksregisterNr, forKey: "rijksregisterNr")
            monitor.setValue(gebruiker.bus, forKey: "bus")
            monitor.setValue(gebruiker.postcode, forKey: "postcode")
            monitor.setValue(gebruiker.telefoon, forKey: "telefoon")
            monitor.setValue(gebruiker.gsm, forKey: "gsm")
            monitor.setValue(gebruiker.aansluitingsNr, forKey: "aansluitingsNr")
            monitor.setValue(gebruiker.codeGerechtigde, forKey: "codeGerechtigde")
            
            monitor.save()
            
        } else {
            //probleem: wat als ouder geen aansluitingsNrTweedeOuder heeft?
            //hoe maken we dan het onderscheid tussen een monitor en een ouder?
            
            var ouder = PFObject(className: "Ouder")
            
            ouder.setValue(gebruiker.rijksregisterNr, forKey: "rijksregisterNr")
            ouder.setValue(gebruiker.email, forKey: "email")
            ouder.setValue(gebruiker.wachtwoord, forKey: "wachtwoord")
            ouder.setValue(gebruiker.voornaam, forKey: "voornaam")
            ouder.setValue(gebruiker.naam, forKey: "naam")
            ouder.setValue(gebruiker.straat, forKey: "straat")
            ouder.setValue(gebruiker.nummer, forKey: "nummer")
            ouder.setValue(gebruiker.rijksregisterNr, forKey: "rijksregisterNr")
            ouder.setValue(gebruiker.bus, forKey: "bus")
            ouder.setValue(gebruiker.postcode, forKey: "postcode")
            ouder.setValue(gebruiker.telefoon, forKey: "telefoon")
            ouder.setValue(gebruiker.gsm, forKey: "gsm")
            ouder.setValue(gebruiker.aansluitingsNr, forKey: "aansluitingsNr")
            ouder.setValue(gebruiker.codeGerechtigde, forKey: "codeGerechtigde")
            ouder.setValue(aansluitingsNrTweedeOuder, forKey: "aansluitingsNrTweedeOuder")
            
            ouder.save()
        }
    }
}