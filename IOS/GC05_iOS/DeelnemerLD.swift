import Foundation

struct DeelnemerLD {
    
    //
    //Function: getDeelnemers
    //
    //Deze functie zet een array van PFObject om naar een array van Deelnemer.
    //
    //Parameters: - objecten: [PFObject]
    //
    //Return: een array van Deelnemer
    //
    static func getDeelnemers(objecten: [PFObject]) -> [Deelnemer] {
        var deelnemers: [Deelnemer] = []
        
        for object in objecten {
            deelnemers.append(getDeelnemer(object))
        }
        
        return deelnemers
    }
    
    //
    //Function: getDeelnemer
    //
    //Deze functie zet een  PFObject om naar een Deelnemer.
    //
    //Parameters: - object: PFObject
    //
    //Return: een Deelnemer
    //
    static func getDeelnemer(object: PFObject) -> Deelnemer {
        var deelnemer: Deelnemer = Deelnemer(id: object.objectId)
        
        deelnemer.voornaam = object[Constanten.COLUMN_VOORNAAM] as? String
        deelnemer.naam = object[Constanten.COLUMN_NAAM] as? String
        deelnemer.geboortedatum = object[Constanten.COLUMN_GEBOORTEDATUM] as? NSDate
        deelnemer.straat = object[Constanten.COLUMN_STRAAT] as? String
        deelnemer.nummer = object[Constanten.COLUMN_NUMMER] as? Int
        deelnemer.postcode = object[Constanten.COLUMN_POSTCODE] as? Int
        deelnemer.gemeente = object[Constanten.COLUMN_GEMEENTE] as? String
        
        if object[Constanten.COLUMN_BUS] != nil {
            deelnemer.bus = object[Constanten.COLUMN_BUS] as? String
        } else {
            deelnemer.bus = ""
        }
        
        return deelnemer
    }
    
    //
    //Function: insert
    //
    //Deze functie insert een Deelnemer object in de local datastore en
    //synct deze verandering dan naar de online database.
    //
    //Parameters: - deelnemer: Deelnemer
    //
    static func insert(deelnemer: Deelnemer) {
        
        let object = PFObject(className: Constanten.TABLE_DEELNEMER)
        
        object[Constanten.COLUMN_VOORNAAM] = deelnemer.voornaam
        object[Constanten.COLUMN_NAAM] = deelnemer.naam
        object[Constanten.COLUMN_GEBOORTEDATUM] = deelnemer.geboortedatum
        object[Constanten.COLUMN_STRAAT] = deelnemer.straat
        object[Constanten.COLUMN_NUMMER] = deelnemer.nummer
        object[Constanten.COLUMN_POSTCODE] = deelnemer.postcode
        object[Constanten.COLUMN_GEMEENTE] = deelnemer.gemeente
    
        if deelnemer.bus != nil {
            object[Constanten.COLUMN_BUS] = deelnemer.bus
        }

        object.pin()
        object.save()
    }

}