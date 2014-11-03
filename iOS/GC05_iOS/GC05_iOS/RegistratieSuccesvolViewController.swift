import UIKit

class RegistratieSuccesvolViewController: UIViewController
{
    var gebruiker: Gebruiker!
    var aansluitingsNrTweedeOuder: Int?
    
    private func gebruikerWegschrijvenNaarDatabase(gebruiker: Gebruiker) {
        if aansluitingsNrTweedeOuder == nil {
            var monitor = PFObject(className: "Monitor")
            
            monitor["rijksregisterNr"] = gebruiker.rijksregisterNr
            monitor["email"] = gebruiker.email
            monitor["wachtwoord"] = gebruiker.wachtwoord
            monitor["voornaam"] = gebruiker.voornaam
            monitor["naam"] = gebruiker.naam
            monitor["straat"] = gebruiker.straat
            monitor["nummer"] = gebruiker.nummer
            monitor["bus"] = gebruiker.bus
            monitor["gemeente"] = gebruiker.gemeente
            monitor["postcode"] = gebruiker.postcode
            monitor["telefoon"] = gebruiker.telefoon
            monitor["gsm"] = gebruiker.gsm
            monitor["aansluitingsNr"] = gebruiker.aansluitingsNr
            monitor["codeGerechtigde"] = gebruiker.codeGerechtigde
            
            monitor.save()
            
        } else {
            //probleem: wat als ouder geen aansluitingsNrTweedeOuder heeft?
            //hoe maken we dan het onderscheid tussen een monitor en een ouder?
            
            var ouder = PFObject(className: "Ouder")
            
            ouder["rijksregisterNr"] = gebruiker.rijksregisterNr
            ouder["email"] = gebruiker.email
            ouder["wachtwoord"] = gebruiker.wachtwoord
            ouder["voornaam"] = gebruiker.voornaam
            ouder["naam"] = gebruiker.naam
            ouder["straat"] = gebruiker.straat
            ouder["nummer"] = gebruiker.nummer
            ouder["bus"] = gebruiker.bus
            ouder["gemeente"] = gebruiker.gemeente
            ouder["postcode"] = gebruiker.postcode
            ouder["telefoon"] = gebruiker.telefoon
            ouder["gsm"] = gebruiker.gsm
            ouder["aansluitingsNr"] = gebruiker.aansluitingsNr
            ouder["codeGerechtigde"] = gebruiker.codeGerechtigde
            ouder["aansluitingsNrTweedeOuder"] = aansluitingsNrTweedeOuder
            
            ouder.save()
            
            // test
        }
    }
    
    
    
    
}