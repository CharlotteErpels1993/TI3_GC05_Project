import Foundation

struct VakantieLD {
    
    //
    //Function: getVakanties
    //
    //Deze functie zet een array van PFObject om naar een array van Vakantie.
    //
    //Parameters: - objecten: [PFObject]
    //
    //Return: een array van Vakantie
    //
    static func getVakanties(objecten: [PFObject]) -> [Vakantie] {
        var vakanties: [Vakantie] = []
        
        for object in objecten {
            vakanties.append(getVakantie(object))
        }
        
        return vakanties
    }
    
    //
    //Function: getVakantie
    //
    //Deze functie zet een  PFObject om naar een Vakantie.
    //
    //Parameters: - object: PFObject
    //
    //Return: een Vakantie
    //
    static private func getVakantie(object: PFObject) -> Vakantie {
        var vakantie: Vakantie = Vakantie(id: object.objectId)
        
        vakantie.titel = object[Constanten.COLUMN_TITEL] as? String
        vakantie.locatie = object[Constanten.COLUMN_LOCATIE] as? String
        vakantie.korteBeschrijving = object[Constanten.COLUMN_KORTEBESCHRIJVING] as? String
        vakantie.vertrekdatum = object[Constanten.COLUMN_VERTREKDATUM] as? NSDate
        vakantie.terugkeerdatum = object[Constanten.COLUMN_TERUGKEERDATUM] as? NSDate
        vakantie.aantalDagenNachten = object[Constanten.COLUMN_AANTALDAGENNACHTEN] as? String
        vakantie.vervoerwijze = object[Constanten.COLUMN_VERVOERWIJZE] as? String
        vakantie.formule = object[Constanten.COLUMN_FORMULE] as? String
        vakantie.link = object[Constanten.COLUMN_LINK] as? String
        vakantie.basisprijs = object[Constanten.COLUMN_BASISPRIJS] as? Double
        vakantie.bondMoysonLedenPrijs = object[Constanten.COLUMN_BONDMOYSONLEDENPRIJS] as? Double
        vakantie.sterPrijs1ouder = object[Constanten.COLUMN_STERPRIJS1OUDER] as? Double
        vakantie.sterPrijs2ouders = object[Constanten.COLUMN_STERPRIJS2OUDERS] as? Double
        vakantie.inbegrepenPrijs = object[Constanten.COLUMN_INBEGREPENPRIJS] as? String
        vakantie.minLeeftijd = object[Constanten.COLUMN_MINLEEFTIJD] as? Int
        vakantie.maxLeeftijd = object[Constanten.COLUMN_MAXLEEFTIJD] as? Int
        vakantie.maxAantalDeelnemers = object[Constanten.COLUMN_MAXAANTALDEELNEMERS] as? Int
        vakantie.periodes = object[Constanten.COLUMN_PERIODES] as? [String]
        
        return vakantie
    }
}