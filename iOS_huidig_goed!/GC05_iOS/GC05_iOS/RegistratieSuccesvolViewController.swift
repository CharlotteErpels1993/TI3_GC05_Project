import UIKit

class RegistratieSuccesvolViewController: UIViewController
{
    var ouder: Ouder!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        parseOuderToDatabase(ouder)
    }
    
    private func parseOuderToDatabase(ouder: Ouder) {
        
        var ouderJSON = PFObject(className: "Ouder")
        
        ouderJSON.setValue(ouder.rijksregisterNr, forKey: "rijksregisterNr")
        ouderJSON.setValue(ouder.email, forKey: "email")
        ouderJSON.setValue(ouder.wachtwoord, forKey: "wachtwoord")
        ouderJSON.setValue(ouder.voornaam, forKey: "voornaam")
        ouderJSON.setValue(ouder.naam, forKey: "naam")
        ouderJSON.setValue(ouder.straat, forKey: "straat")
        ouderJSON.setValue(ouder.nummer, forKey: "nummer")
        ouderJSON.setValue(ouder.rijksregisterNr, forKey: "rijksregisterNr")
        ouderJSON.setValue(ouder.bus, forKey: "bus")
        ouderJSON.setValue(ouder.postcode, forKey: "postcode")
        ouderJSON.setValue(ouder.telefoon, forKey: "telefoon")
        ouderJSON.setValue(ouder.gsm, forKey: "gsm")
        ouderJSON.setValue(ouder.aansluitingsNr, forKey: "aansluitingsNr")
        ouderJSON.setValue(ouder.codeGerechtigde, forKey: "codeGerechtigde")
        ouderJSON.setValue(ouder.aansluitingsNrTweedeOuder, forKey: "aansluitingsNrTweedeOuder")
        
        ouderJSON.save()
    }
}