import Foundation

class OuderRepository {
    
    var ouders: [Ouder] = []
    
    init() {
        refreshOuders()
    }
    
    func getAllOuders() -> [Ouder] {
        return self.ouders
    }
    
    func getOuderWithEmail(email: String) -> Ouder {
        var ouder: Ouder = Ouder(id: "test")
        
        for o in ouders {
            if o.email == email {
                ouder = o
            }
        }
        
        return ouder
    }
    
    func addOuder(ouder: Ouder) {
        var ouderObject = PFObject(className: "Ouder")
        
        //verplichte gegevens
        ouderObject.setValue(ouder.email, forKey: "email")
        ouderObject.setValue(ouder.wachtwoord, forKey: "wachtwoord")
        ouderObject.setValue(ouder.voornaam, forKey: "voornaam")
        ouderObject.setValue(ouder.naam, forKey: "naam")
        ouderObject.setValue(ouder.straat, forKey: "straat")
        ouderObject.setValue(ouder.nummer, forKey: "nummer")
        ouderObject.setValue(ouder.postcode, forKey: "postcode")
        ouderObject.setValue(ouder.gemeente, forKey: "gemeente")
        ouderObject.setValue(ouder.gsm, forKey: "gsm")
        
        //optionele gegevens
        if ouder.rijksregisterNr != nil {
            ouderObject.setValue(ouder.rijksregisterNr, forKey: "rijksregisterNr")
        }
        
        if ouder.bus != nil {
            ouderObject.setValue(ouder.bus, forKey: "bus")
        }
        
        if ouder.telefoon != nil {
            ouderObject.setValue(ouder.telefoon, forKey: "telefoon")
        }
        
        if ouder.aansluitingsNr != nil {
            ouderObject.setValue(ouder.aansluitingsNr, forKey: "aansluitingsNr")
        }
        
        if ouder.codeGerechtigde != nil {
            ouderObject.setValue(ouder.codeGerechtigde, forKey: "codeGerechtigde")
        }
        
        if ouder.aansluitingsNrTweedeOuder != nil {
            ouderObject.setValue(ouder.aansluitingsNrTweedeOuder, forKey: "aansluitingsNrTweedeOuder")
        }
        
        ouderObject.save()
    }
    
    private func refreshOuders() {
        var query = PFQuery(className: "Ouder")
        self.ouders = query.findObjects() as [Ouder]
    }
}