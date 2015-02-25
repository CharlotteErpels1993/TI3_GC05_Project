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
    static private func getDeelnemer(object: PFObject) -> Deelnemer {
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
}