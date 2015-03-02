import Foundation

struct VormingLD {
    
    //
    //Function: getVormingen
    //
    //Deze functie zet een array van PFObject om naar een array van Vorming.
    //
    //Parameters: - objecten: [PFObject]
    //
    //Return: een array van Vorming
    //
    static func getVormingen(objecten: [PFObject]) -> [Vorming] {
        var vormingen: [Vorming] = []
        
        for object in objecten {
            vormingen.append(getVorming(object))
        }
        
        return vormingen
    }
    
    //
    //Function: getVorming
    //
    //Deze functie zet een  PFObject om naar een Vorming.
    //
    //Parameters: - object: PFObject
    //
    //Return: een Vorming
    //
    static func getVorming(object: PFObject) -> Vorming {
        var vorming: Vorming = Vorming(id: object.objectId)
        
        vorming.titel = object[Constanten.COLUMN_TITEL] as? String
        vorming.locatie = object[Constanten.COLUMN_LOCATIE] as? String
        vorming.korteBeschrijving = object[Constanten.COLUMN_KORTEBESCHRIJVING] as? String
        vorming.periodes = object[Constanten.COLUMN_PERIODES] as? [String]
        vorming.prijs = object[Constanten.COLUMN_PRIJS] as? Double
        vorming.criteriaDeelnemers = object[Constanten.COLUMN_CRITERIADEELNEMERS] as? String
        vorming.websiteLocatie = object[Constanten.COLUMN_WEBSITELOCATIE] as? String
        vorming.tips = object[Constanten.COLUMN_TIPS] as? String
        vorming.betalingWijze = object[Constanten.COLUMN_BETALINGSWIJZE] as? String
        vorming.inbegrepenPrijs = object[Constanten.COLUMN_INBEGREPENINPRIJS] as? String
        
        return vorming
    }
}