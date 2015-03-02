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
    static func insert(contactpersoon: ContactpersoonNood) -> String {
        
        let object = PFObject(className: Constanten.TABLE_CONTACTPERSOON)
        
        object[Constanten.COLUMN_VOORNAAM] = contactpersoon.voornaam
        object[Constanten.COLUMN_NAAM] = contactpersoon.naam
        object[Constanten.COLUMN_GSM] = contactpersoon.gsm
        
        if contactpersoon.telefoon != nil {
            object[Constanten.COLUMN_TELEFOON] = contactpersoon.telefoon
        }
        
        object.pin()
        object.save()
        
        return object.objectId
    }
}