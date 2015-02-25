import Foundation

struct GebruikerLD {
    
    //
    //Function: getGebruikers
    //
    //Deze functie zet een array van PFObject om naar een array van Gebruiker.
    //
    //Parameters: - objecten: [PFObject]
    //
    //Return: een array van Gebruiker
    //
    static func getGebruikers(objecten: [PFObject]) -> [Gebruiker] {
        var gebruikers: [Gebruiker] = []
        
        for object in objecten {
            gebruikers.append(getGebruiker(object))
        }
        
        return gebruikers
    }
    
    //
    //Function: getGebruiker
    //
    //Deze functie zet een PFObject om naar een Gebruiker.
    //
    //Parameters: - object: PFObject
    //
    //Return: een Gebruiker
    //
    static private func getGebruiker(object: PFObject) -> Gebruiker {
        var gebruiker: Gebruiker = Gebruiker(id: object.objectId)
        
        gebruiker.rijksregisterNr = object[Constanten.COLUMN_RIJKSREGISTERNUMMER] as? String
        gebruiker.email = object[Constanten.COLUMN_EMAIL] as? String
        gebruiker.voornaam = object[Constanten.COLUMN_VOORNAAM] as? String
        gebruiker.naam = object[Constanten.COLUMN_NAAM] as? String
        gebruiker.straat = object[Constanten.COLUMN_STRAAT] as? String
        gebruiker.nummer = object[Constanten.COLUMN_NUMMER] as? Int
        gebruiker.postcode = object[Constanten.COLUMN_POSTCODE] as? Int
        gebruiker.gemeente = object[Constanten.COLUMN_GEMEENTE] as? String
        gebruiker.gsm = object[Constanten.COLUMN_GSM] as? String
        
        if object[Constanten.COLUMN_BUS] != nil {
            gebruiker.bus = object[Constanten.COLUMN_BUS] as? String
        } else {
            gebruiker.bus = ""
        }
        
        if object[Constanten.COLUMN_TELEFOON] != nil {
            gebruiker.telefoon = object[Constanten.COLUMN_TELEFOON] as? String
        } else {
            gebruiker.telefoon = ""
        }
        
        if object[Constanten.COLUMN_AANSLUITINGSNUMMER] != nil {
            gebruiker.aansluitingsNr = object[Constanten.COLUMN_AANSLUITINGSNUMMER] as? Int
        } else {
            gebruiker.aansluitingsNr = 0
        }
        
        if object[Constanten.COLUMN_CODEGERECHTIGDE] != nil {
            gebruiker.codeGerechtigde = object[Constanten.COLUMN_CODEGERECHTIGDE] as? Int
        } else {
            gebruiker.codeGerechtigde = 0
        }
        
        return gebruiker
    }
}