import Foundation

struct ParseToDatabase {
    
    // schrijf een nieuwe ouder bij het registeren weg naar de database
    static func parseOuderToDatabase(ouder: Ouder, wachtwoord: String) {
        var ouderJSON = PFObject(className: "Ouder")
        
        ouderJSON.setValue(ouder.email, forKey: "email")
        ouderJSON.setValue(ouder.voornaam, forKey: "voornaam")
        ouderJSON.setValue(ouder.naam, forKey: "naam")
        ouderJSON.setValue(ouder.straat, forKey: "straat")
        ouderJSON.setValue(ouder.nummer, forKey: "nummer")
        ouderJSON.setValue(ouder.postcode, forKey: "postcode")
        ouderJSON.setValue(ouder.gemeente, forKey: "gemeente")
        ouderJSON.setValue(ouder.gsm, forKey: "gsm")
        ouderJSON.setValue(ouder.rijksregisterNr, forKey: "rijksregisterNr")
        
        if ouder.aansluitingsNr != nil {
            ouderJSON.setValue(ouder.aansluitingsNr, forKey: "aansluitingsNr")
            ouderJSON.setValue(ouder.codeGerechtigde, forKey: "codeGerechtigde")
            
            if ouder.aansluitingsNrTweedeOuder != nil {
                ouderJSON.setValue(ouder.aansluitingsNrTweedeOuder, forKey: "aansluitingsNrTweedeOuder")
            }
        }
        
        if ouder.bus != nil {
            ouderJSON.setValue(ouder.bus, forKey: "bus")
        }
        
        if ouder.telefoon != nil {
            ouderJSON.setValue(ouder.telefoon, forKey: "telefoon")
        }
        
        ouderJSON.save()
        
        createPFUser(ouder, wachtwoord: wachtwoord)
        logIn(ouder, wachtwoord: wachtwoord)
    }
    
    // maak een nieuwe PFUser (Parse)
    static private func createPFUser(ouder: Ouder, wachtwoord: String) {
        var user = PFUser()
        user.username = ouder.email
        user.password = wachtwoord
        user.email = ouder.email
        user["soort"] = "ouder"
        
        user.signUp()
    }
    
    // log de geregistreerde ouder direct in
    static private func logIn(ouder: Ouder, wachtwoord: String) {
        PFUser.logInWithUsername(ouder.email, password: wachtwoord)
    }
}