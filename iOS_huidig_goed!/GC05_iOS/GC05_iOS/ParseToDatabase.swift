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
    
    // schrijf een nieuwe deelnemer weg naar de database
    static func parseDeelnemerToDatabase(deelnemer: Deelnemer) -> String {
        var deelnemerJSON = PFObject(className: "Deelnemer")
        
        deelnemerJSON.setValue(deelnemer.voornaam, forKey: "voornaam")
        deelnemerJSON.setValue(deelnemer.naam, forKey: "naam")
        deelnemerJSON.setValue(deelnemer.geboortedatum, forKey: "geboortedatum")
        deelnemerJSON.setValue(deelnemer.straat, forKey: "straat")
        deelnemerJSON.setValue(deelnemer.nummer, forKey: "nummer")
        deelnemerJSON.setValue(deelnemer.gemeente, forKey: "gemeente")
        deelnemerJSON.setValue(deelnemer.postcode, forKey: "postcode")
        
        if deelnemer.bus != nil {
            deelnemerJSON.setValue(deelnemer.bus, forKey: "bus")
        }
        
        deelnemerJSON.save()
        deelnemerJSON.fetch()
        
        return deelnemerJSON.objectId
    }
    
    // schrijf een nieuwe contactpersoon in geval van nood weg naar de database
    static func parseContactpersoonNoodToDatabase(contactpersoon: ContactpersoonNood) -> String {
        var contactpersoonJSON = PFObject(className: "ContactpersoonNood")
        
        contactpersoonJSON.setValue(contactpersoon.voornaam, forKey: "voornaam")
        contactpersoonJSON.setValue(contactpersoon.naam, forKey: "naam")
        contactpersoonJSON.setValue(contactpersoon.gsm, forKey: "gsm")
        
        if contactpersoon.telefoon != nil {
            contactpersoonJSON.setValue(contactpersoon.telefoon, forKey: "telefoon")
        }
        
        contactpersoonJSON.save()
        contactpersoonJSON.fetch()
        
        return contactpersoonJSON.objectId
    }
    
    // schrijf een nieuwe vakantie inschrijving weg naar de database
    static func parseInschrijvingVakantieToDatabase(inschrijving: InschrijvingVakantie) {
        var inschrijvingJSON = PFObject(className: "InschrijvingVakantie")
        
        inschrijvingJSON.setValue(inschrijving.vakantie?.id, forKey: "vakantie")
        inschrijvingJSON.setValue(inschrijving.ouder?.id, forKey: "ouder")
        inschrijvingJSON.setValue(inschrijving.deelnemer?.id, forKey: "deelnemer")
        inschrijvingJSON.setValue(inschrijving.contactpersoon1?.id, forKey: "contactpersoon1")
        
        
        if inschrijving.extraInfo != "" {
            inschrijvingJSON.setValue(inschrijving.extraInfo, forKey: "extraInformatie")
        }
        
        if inschrijving.contactpersoon2 != nil {
            inschrijvingJSON.setValue(inschrijving.contactpersoon2?.id, forKey: "contactpersoon2")
        }
        
        inschrijvingJSON.save()
    }
    
    // schrijf een nieuwe vorming inschrijving weg naar de database
    static func parseInschrijvingVormingToDatabase(inschrijving: InschrijvingVorming) {
        var inschrijvingJSON = PFObject(className: "InschrijvingVorming")
        
        inschrijvingJSON.setValue(inschrijving.monitor?.id, forKey: "monitor")
        inschrijvingJSON.setValue(inschrijving.vorming?.id, forKey: "vorming")
        
        inschrijvingJSON.save()
    }
}