import Foundation

struct OuderLD {
    
    //
    //Function: getOuders
    //
    //Deze functie zet een array van PFObject om naar een array van Ouder.
    //
    //Parameters: - objecten: [PFObject]
    //
    //Return: een array van Ouder
    //
    static func getOuders(objecten: [PFObject]) -> [Ouder] {
        var ouders: [Ouder] = []
        
        for object in objecten {
            ouders.append(getOuder(object))
        }
        
        return ouders
    }
    
    //
    //Function: getOuder
    //
    //Deze functie zet een  PFObject om naar een Ouder.
    //
    //Parameters: - object: PFObject
    //
    //Return: een Ouder
    //
    static func getOuder(object: PFObject) -> Ouder {
        var ouder: Ouder = Ouder(id: object.objectId)
        
        ouder.rijksregisterNr = object[Constanten.COLUMN_RIJKSREGISTERNUMMER] as? String
        ouder.email = object[Constanten.COLUMN_EMAIL] as? String
        ouder.voornaam = object[Constanten.COLUMN_VOORNAAM] as? String
        ouder.naam = object[Constanten.COLUMN_NAAM] as? String
        ouder.straat = object[Constanten.COLUMN_STRAAT] as? String
        ouder.nummer = object[Constanten.COLUMN_NUMMER] as? Int
        ouder.postcode = object[Constanten.COLUMN_POSTCODE] as? Int
        ouder.gemeente = object[Constanten.COLUMN_GEMEENTE] as? String
        ouder.gsm = object[Constanten.COLUMN_GSM] as? String
        
        if object[Constanten.COLUMN_BUS] != nil {
            ouder.bus = object[Constanten.COLUMN_BUS] as? String
        } else {
            ouder.bus = ""
        }
        
        if object[Constanten.COLUMN_TELEFOON] != nil {
            ouder.telefoon = object[Constanten.COLUMN_TELEFOON] as? String
        } else {
            ouder.telefoon = ""
        }
        
        if object[Constanten.COLUMN_AANSLUITINGSNUMMER] != nil {
            ouder.aansluitingsNr = object[Constanten.COLUMN_AANSLUITINGSNUMMER] as? Int
        } else {
            ouder.aansluitingsNr = 0
        }
        
        if object[Constanten.COLUMN_CODEGERECHTIGDE] != nil {
            ouder.codeGerechtigde = object[Constanten.COLUMN_CODEGERECHTIGDE] as? Int
        } else {
            ouder.codeGerechtigde = 0
        }
        
        if object[Constanten.COLUMN_CODEGERECHTIGDE] != nil {
            ouder.aansluitingsNrTweedeOuder = object[Constanten.COLUMN_AANSLUITINGSNUMMERTWEEDEOUDER] as? Int
        } else {
            ouder.aansluitingsNrTweedeOuder = 0
        }
        
        return ouder
    }
}