import Foundation

struct ParseToDatabase {
    
    //
    //Naam: parseOuder
    //
    //Werking: - schrijft een nieuwe ouder bij het registreren weg naar de database
    //
    //Parameters:
    //  - ouder: Ouder
    //  - wachtwoord: String
    //
    //Return:
    //
    /*static func parseOuder(ouder: Ouder, wachtwoord: String) {
        var ouderJSON = PFObject(className: Constanten.TABLE_OUDER)
        
        ouderJSON.setValue(ouder.email, forKey: Constanten.COLUMN_EMAIL)
        ouderJSON.setValue(ouder.voornaam, forKey: Constanten.COLUMN_VOORNAAM)
        ouderJSON.setValue(ouder.naam, forKey: Constanten.COLUMN_NAAM)
        ouderJSON.setValue(ouder.straat, forKey: Constanten.COLUMN_STRAAT)
        ouderJSON.setValue(ouder.nummer, forKey: Constanten.COLUMN_NUMMER)
        ouderJSON.setValue(ouder.postcode, forKey: Constanten.COLUMN_POSTCODE)
        ouderJSON.setValue(ouder.gemeente, forKey: Constanten.COLUMN_GEMEENTE)
        ouderJSON.setValue(ouder.gsm, forKey: Constanten.COLUMN_GSM)
        ouderJSON.setValue(ouder.rijksregisterNr, forKey: Constanten.COLUMN_RIJKSREGISTERNUMMER)
        
        if ouder.aansluitingsNr != nil {
            ouderJSON.setValue(ouder.aansluitingsNr, forKey: Constanten.COLUMN_AANSLUITINGSNUMMER)
            ouderJSON.setValue(ouder.codeGerechtigde, forKey: Constanten.COLUMN_CODEGERECHTIGDE)
            
            if ouder.aansluitingsNrTweedeOuder != nil {
                ouderJSON.setValue(ouder.aansluitingsNrTweedeOuder, forKey: Constanten.COLUMN_AANSLUITINGSNUMMERTWEEDEOUDER)
            }
        }
        
        if ouder.bus != nil {
            ouderJSON.setValue(ouder.bus, forKey: Constanten.COLUMN_BUS)
        }
        
        if ouder.telefoon != nil {
            ouderJSON.setValue(ouder.telefoon, forKey: Constanten.COLUMN_TELEFOON)
        }
        
        ouderJSON.save()
        
        createPFUser(ouder, wachtwoord: wachtwoord)
        logIn(ouder, wachtwoord: wachtwoord)
    }*/
    
    //
    //Naam: createPFUser
    //
    //Werking: - maakt een nieuwe ouder in Parse table User
    //
    //Parameters:
    //  - ouder: Ouder
    //  - wachtwoord: String
    //
    //Return:
    //
    /*static private func createPFUser(ouder: Ouder, wachtwoord: String) {
        var user = PFUser()
        user.username = ouder.email
        user.password = wachtwoord
        user.email = ouder.email
        user["soort"] = "ouder"
        
        user.signUp()
    }*/
    
    //
    //Naam: logIn
    //
    //Werking: - logt de geregistreerde ouder direct in
    //
    //Parameters:
    //  - ouder: Ouder
    //  - wachtwoord: String
    //
    //Return:
    //
    static private func logIn(ouder: Ouder, wachtwoord: String) {
        PFUser.logInWithUsername(ouder.email, password: wachtwoord)
    }
    
    //
    //Naam: parseDeelnemer
    //
    //Werking: - schrijft een nieuwe deelnemer weg naar de database
    //
    //Parameters:
    //  - deelnemer: Deelnemer
    //
    //Return: het objectId van de deelnemer
    //
    /*static func parseDeelnemer(deelnemer: Deelnemer) -> String {
        var deelnemerJSON = PFObject(className: Constanten.TABLE_DEELNEMER)
        
        deelnemerJSON.setValue(deelnemer.voornaam, forKey: Constanten.COLUMN_VOORNAAM)
        deelnemerJSON.setValue(deelnemer.naam, forKey: Constanten.COLUMN_NAAM)
        deelnemerJSON.setValue(deelnemer.geboortedatum, forKey: Constanten.COLUMN_GEBOORTEDATUM)
        deelnemerJSON.setValue(deelnemer.straat, forKey: Constanten.COLUMN_STRAAT)
        deelnemerJSON.setValue(deelnemer.nummer, forKey: Constanten.COLUMN_NUMMER)
        deelnemerJSON.setValue(deelnemer.gemeente, forKey: Constanten.COLUMN_GEMEENTE)
        deelnemerJSON.setValue(deelnemer.postcode, forKey: Constanten.COLUMN_POSTCODE)
        
        if deelnemer.bus != nil {
            deelnemerJSON.setValue(deelnemer.bus, forKey: Constanten.COLUMN_BUS)
        }
        
        deelnemerJSON.save()
        deelnemerJSON.fetch()
        
        return deelnemerJSON.objectId
    }
    
    //
    //Naam: parseContactpersoonNood
    //
    //Werking: - schrijft een nieuwe contactpersoon in geval van nood weg naar de database
    //
    //Parameters:
    //  - contactpersoon: ContactpersoonNood
    //
    //Return: het objectId van de contactpersoon
    //
    static func parseContactpersoonNood(contactpersoon: ContactpersoonNood) -> String {
        var contactpersoonJSON = PFObject(className: Constanten.TABLE_CONTACTPERSOON)
        
        contactpersoonJSON.setValue(contactpersoon.voornaam, forKey: Constanten.COLUMN_VOORNAAM)
        contactpersoonJSON.setValue(contactpersoon.naam, forKey: Constanten.COLUMN_NAAM)
        contactpersoonJSON.setValue(contactpersoon.gsm, forKey: Constanten.COLUMN_GSM)
        
        if contactpersoon.telefoon != nil {
            contactpersoonJSON.setValue(contactpersoon.telefoon, forKey: Constanten.COLUMN_TELEFOON)
        }
        
        contactpersoonJSON.save()
        contactpersoonJSON.fetch()
        
        return contactpersoonJSON.objectId
    }
    
    //
    //Naam: parseInschrijvingVakantie
    //
    //Werking: - schrijft een nieuwe vakantie inschrijving weg naar de database
    //
    //Parameters:
    //  - inschrijving: InschrijvingVakantie
    //
    //Return:
    //
    static func parseInschrijvingVakantie(inschrijving: InschrijvingVakantie) {
        var inschrijvingJSON = PFObject(className: Constanten.TABLE_INSCHRIJVINGVAKANTIE)
        
        inschrijvingJSON.setValue(inschrijving.vakantie?.id, forKey: Constanten.COLUMN_VAKANTIE)
        inschrijvingJSON.setValue(inschrijving.ouder?.id, forKey: Constanten.COLUMN_OUDER)
        inschrijvingJSON.setValue(inschrijving.deelnemer?.id, forKey: Constanten.COLUMN_DEELNEMER)
        inschrijvingJSON.setValue(inschrijving.contactpersoon1?.id, forKey: Constanten.COLUMN_CONTACTPERSOON1)
        
        
        if inschrijving.extraInfo != "" {
            inschrijvingJSON.setValue(inschrijving.extraInfo, forKey: Constanten.COLUMN_EXTRAINFORMATIE)
        }
        
        if inschrijving.contactpersoon2 != nil {
            inschrijvingJSON.setValue(inschrijving.contactpersoon2?.id, forKey: Constanten.COLUMN_CONTACTPERSOON2)
        }
        
        inschrijvingJSON.save()
    }
    
    //
    //Naam: parseInschrijvingVorming
    //
    //Werking: - schrijft een nieuwe vorming inschrijving weg naar de database
    //
    //Parameters:
    //  - inschrijving: InschrijvingVorming
    //
    //Return:
    //
    static func parseInschrijvingVorming(inschrijving: InschrijvingVorming) {
        var inschrijvingJSON = PFObject(className: Constanten.TABLE_INSCHRIJVINGVORMING)
        
        inschrijvingJSON.setValue(inschrijving.monitor?.id, forKey: Constanten.COLUMN_MONITOR)
        inschrijvingJSON.setValue(inschrijving.vorming?.id, forKey: Constanten.COLUMN_VORMING)
        inschrijvingJSON.setValue(inschrijving.periode, forKey: Constanten.COLUMN_PERIODE)
        
        inschrijvingJSON.save()
    }

    //
    //Naam: parseFavoriet
    //
    //Werking: - schrijft een nieuwe favoriete vakantie weg naar de database
    //
    //Parameters:
    //  - favoriet: Favoriet
    //
    //Return:
    //
    static func parseFavoriet(favoriet: Favoriet) {
        var favorietJSON = PFObject(className: Constanten.TABLE_FAVORIET)
        
        favorietJSON.setValue(favoriet.vakantie?.id, forKey: Constanten.COLUMN_VAKANTIE)
        favorietJSON.setValue(favoriet.gebruiker?.id, forKey: Constanten.COLUMN_GEBRUIKER)
        
        favorietJSON.save()
        LocalDatastore.getTableReady(Constanten.TABLE_FAVORIET)
    }

    //
    //Naam: parseVoorkeur
    //
    //Werking: - schrijft een nieuwe voorkeur weg naar de database
    //
    //Parameters:
    //  - voorkeur: Voorkeur
    //
    //Return:
    //
    static func parseVoorkeur(voorkeur: Voorkeur) {
        var voorkeurJSON = PFObject(className: Constanten.TABLE_VOORKEUR)
        
        voorkeurJSON.setValue(voorkeur.monitor?.id, forKey: Constanten.COLUMN_MONITOR)
        voorkeurJSON.setValue(voorkeur.vakantie?.id, forKey: Constanten.COLUMN_VAKANTIE)
        
        voorkeurJSON.save()
    }
    
    //
    //Naam: parseFeedback
    //
    //Werking: - schrijft een nieuwe feedback weg naar de database
    //
    //Parameters:
    //  - feedback: Feedback
    //
    //Return:
    //
    static func parseFeedback(feedback: Feedback) {
        var feedbackJSON = PFObject(className: Constanten.TABLE_FEEDBACK)
        
        feedbackJSON.setValue(feedback.datum, forKey: Constanten.COLUMN_DATUM)
        feedbackJSON.setValue(feedback.goedgekeurd, forKey: Constanten.COLUMN_GOEDGEKEURD)
        feedbackJSON.setValue(feedback.vakantie?.id, forKey: Constanten.COLUMN_VAKANTIE)
        feedbackJSON.setValue(feedback.gebruiker?.id, forKey: Constanten.COLUMN_GEBRUIKER)
        feedbackJSON.setValue(feedback.waardering, forKey: Constanten.COLUMN_WAARDERING)
        feedbackJSON.setValue(feedback.score, forKey: Constanten.COLUMN_SCORE)
        
        feedbackJSON.save()
    }*/
    
}