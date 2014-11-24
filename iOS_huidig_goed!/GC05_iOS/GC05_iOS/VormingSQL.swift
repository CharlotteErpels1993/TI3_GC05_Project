import Foundation

class VormingSQL {
    
    func createVormingTable() {
        if let error = SD.createTable("Vorming", withColumnNamesAndTypes: ["objectId":
            .StringVal, "titel": .StringVal, "locatie": .StringVal, "korteBeschrijving":
                .StringVal, "periodes": .StringVal, "prijs": .DoubleVal,
            "websiteLocatie": .StringVal, "criteriaDeelnemers": .StringVal, "tips":
                .StringVal, "betalingswijze": .StringVal, "inbegrepenInPrijs": .StringVal]) {
                    
                    //there was an error
                    
        } else {
            //no error
        }
    }
    
    func vulVormingTableOp() {
        
        var vormingen: [PFObject] = []
        var query = PFQuery(className: "Vorming")
        vormingen = query.findObjects() as [PFObject]
        
        var objectId: String = ""
        var titel: String = ""
        var locatie: String = ""
        var korteBeschrijving: String = ""
        var periodesArray: [String] = []
        var periodesString: String = ""
        var prijs: Double = 0.0
        var websiteLocatie: String = ""
        var criteriaDeelnemers: String = ""
        var tips: String = ""
        var betalingswijze: String = ""
        var inbegrepenInPrijs: String = ""
        
        for vorming in vormingen {
            objectId = vorming.objectId as String
            titel = vorming["titel"] as String
            locatie = vorming["locatie"] as String
            korteBeschrijving = vorming["korteBeschrijving"] as String
            periodesArray = vorming["periodes"] as [String]
            
            var teller: Int = 0
            
            for periode in periodesArray {
                if teller != 0 {
                    periodesString.extend(", ")
                }
                
                periodesString.extend(periode)
                teller += 1
            }
            
            prijs = vorming["prijs"] as Double
            websiteLocatie = vorming["websiteLocatie"] as String
            criteriaDeelnemers = vorming["criteriaDeelnemers"] as String
            tips = vorming["tips"] as String
            betalingswijze = vorming["betalingswijze"] as String
            inbegrepenInPrijs = vorming["inbegrepenInPrijs"] as String
            
            if let err = SD.executeChange("INSERT INTO Vorming (objectId, titel, locatie, korteBeschrijving, periodes, prijs, websiteLocatie, criteriaDeelnemers, tips, betalingswijze, inbegrepenInPrijs) VALUES ('\(objectId)', '\(titel)', '\(locatie)', '\(korteBeschrijving)', '\(periodesString)', '\(prijs)', '\(websiteLocatie)', '\(criteriaDeelnemers)', '\(tips)', '\(betalingswijze)', '\(inbegrepenInPrijs)')") {
                //there was an error during the insert, handle it here
            } else {
                //no error, the row was inserted successfully
            }
            
        }
    }
    
    func getAlleVormingen() -> [Vorming] {
        
        var vormingen: [Vorming] = []
        var vorming: Vorming = Vorming(id: "test")
        
        let (resultSet, err) = SD.executeQuery("SELECT * FROM Vorming")
        
        if err != nil {
            //there was an error during the query, handle it here
            } else {
                for row in resultSet {
                    vorming = getVorming(row)
                    vormingen.append(vorming)
            }
        }
        
        return vormingen
    }
    
    private func getVorming(row: SD.SDRow) -> Vorming {
        var vorming: Vorming = Vorming(id: "test")
        
        if let objectId = row["objectId"]?.asString() {
            vorming.id = objectId
        }
        if let titel = row["titel"]?.asString() {
            vorming.titel = titel
        }
        if let locatie = row["locatie"]?.asString() {
            vorming.locatie = locatie
        }
        if let korteBeschrijving = row["korteBeschrijving"]?.asString() {
            vorming.korteBeschrijving = korteBeschrijving
        }
        /* ARRAY!!!!
        if let periodes = row["periodes"]?.asString() {
        vorming.periodes = periodes
        }
        */
        if let prijs = row["prijs"]?.asDouble()! {
            vorming.prijs = prijs
        }
        if let websiteLocatie = row["websiteLocatie"]?.asString() {
            vorming.websiteLocatie = websiteLocatie
        }
        if let criteriaDeelnemers = row["criteriaDeelnemers"]?.asString() {
            vorming.criteriaDeelnemers = criteriaDeelnemers
        }
        if let tips = row["tips"]?.asString() {
            vorming.tips = tips
        }
        if let betalingswijze = row["betalingswijze"]?.asString() {
            vorming.betalingWijze = betalingswijze
        }
        /* inbegrepenInPrijs staat niet in model klasse?
        if let inbegrepenInPrijs = row["inbegrepenInPrijs"]?.asString() {
        vorming. = basisPrijs
        }*/
        
        return vorming
    }
    
}