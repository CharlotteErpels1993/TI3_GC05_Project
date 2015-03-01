import Foundation

struct ContactpersoonNoodLD {
    
    //
    //Function: getContactpersonen
    //
    //Deze functie zet een array van PFObject om naar een array van ContactpersoonNood.
    //
    //Parameters: - objecten: [PFObject]
    //
    //Return: een array van ContactpersoonNood
    //
    static func getContactpersonen(objecten: [PFObject]) -> [ContactpersoonNood] {
        var contactpersonen: [ContactpersoonNood] = []
        
        for object in objecten {
            contactpersonen.append(getContactpersoon(object))
        }
        
        return contactpersonen
    }
    
    //
    //Function: getContactpersoon
    //
    //Deze functie zet een  PFObject om naar een ContactpersoonNood.
    //
    //Parameters: - object: PFObject
    //
    //Return: een ContactpersoonNood
    //
    static func getContactpersoon(object: PFObject) -> ContactpersoonNood {
        var contactpersoon: ContactpersoonNood = ContactpersoonNood(id: object.objectId)
        
        contactpersoon.voornaam = object[Constanten.COLUMN_VOORNAAM] as? String
        contactpersoon.naam = object[Constanten.COLUMN_NAAM] as? String
        contactpersoon.gsm = object[Constanten.COLUMN_GSM] as? String
        
        if object[Constanten.COLUMN_TELEFOON] != nil {
            contactpersoon.telefoon = object[Constanten.COLUMN_TELEFOON] as? String
        } else {
            contactpersoon.telefoon = ""
        }
        
        return contactpersoon
    }
    
    //
    //Function: insert
    //
    //Deze functie insert een Ouder object in de local datastore en
    //synct deze verandering dan naar de online database.
    //
    //Parameters: - ouder: Ouder
    //
    /*static func insert(ouder: Ouder) {
        
        let object = PFObject(className: Constanten.TABLE_OUDER)
        
        object[Constanten.COLUMN_RIJKSREGISTERNUMMER] = ouder.rijksregisterNr
        object[Constanten.COLUMN_EMAIL] = ouder.email
        object[Constanten.COLUMN_VOORNAAM] = ouder.voornaam
        object[Constanten.COLUMN_NAAM] = ouder.naam
        object[Constanten.COLUMN_STRAAT] = ouder.straat
        object[Constanten.COLUMN_NUMMER] = ouder.nummer
        object[Constanten.COLUMN_POSTCODE] = ouder.postcode
        object[Constanten.COLUMN_GEMEENTE] = ouder.gemeente
        object[Constanten.COLUMN_GSM] = ouder.gsm
        
        if ouder.bus != nil {
            object[Constanten.COLUMN_BUS] = ouder.bus
        }
        
        if ouder.telefoon != nil {
            object[Constanten.COLUMN_TELEFOON] = ouder.telefoon
        }
        
        if ouder.aansluitingsNr != nil {
            object[Constanten.COLUMN_AANSLUITINGSNUMMER] = ouder.aansluitingsNr
        }
        
        if ouder.codeGerechtigde != nil {
            object[Constanten.COLUMN_CODEGERECHTIGDE] = ouder.codeGerechtigde
        }
        
        if ouder.aansluitingsNrTweedeOuder != nil {
            object[Constanten.COLUMN_AANSLUITINGSNUMMERTWEEDEOUDER] = ouder.aansluitingsNrTweedeOuder
        }
        
        object.pin()
        object.save()
    }*/    
}