import Foundation

struct /*class*/ VakantieSQL {
    
    static func createVakantieTable() {
        if let error = SD.createTable("Vakantie", withColumnNamesAndTypes: ["objectId":
            .StringVal, "titel": .StringVal, "locatie": .StringVal, "korteBeschrijving":
                .StringVal, "vertrekdatum": .DateVal, "terugkeerdatum": .DateVal,
            "aantalDagenNachten": .StringVal, "vervoerwijze": .StringVal, "formule":
                .StringVal, "basisPrijs": .DoubleVal, "bondMoysonLedenPrijs": .DoubleVal,
            "inbegrepenPrijs": .StringVal, "doelgroep": .StringVal, "maxAantalDeelnemers":
                .IntVal, "sterPrijs1ouder": .StringVal, "sterPrijs2ouders": .DoubleVal]) {
                    
                    //there was an error
                    
        } else {
            //no error
        }
    }
    
    static func vulVakantieTableOp() {
        
        var vakanties: [PFObject] = []
        var query = PFQuery(className: "Vakantie")
        vakanties = query.findObjects() as [PFObject]
        
        var objectId: String = ""
        var titel: String = ""
        var locatie: String = ""
        var korteBeschrijving: String = ""
        var vertrekdatum: NSDate = NSDate()
        var terugkeerdatum: NSDate = NSDate()
        var aantalDagenNachten: String = ""
        var vervoerwijze: String = ""
        var formule: String = ""
        var basisPrijs: Double = 0.0
        var bondMoysonLedenPrijs: Double = 0.0
        var inbegrepenPrijs: String = ""
        var doelgroep: String = ""
        var maxAantalDeelnemers: Int = 0
        var sterPrijs1ouder: Double = 0.0
        var sterPrijs2ouders: Double = 0.0
        
        for vakantie in vakanties {
            objectId = vakantie.objectId as String
            titel = vakantie["titel"] as String
            locatie = vakantie["locatie"] as String
            korteBeschrijving = vakantie["korteBeschrijving"] as String
            vertrekdatum = vakantie["vertrekdatum"] as NSDate
            terugkeerdatum = vakantie["terugkeerdatum"] as NSDate
            aantalDagenNachten = vakantie["aantalDagenNachten"] as String
            vervoerwijze = vakantie["vervoerwijze"] as String
            formule = vakantie["formule"] as String
            basisPrijs = vakantie["basisPrijs"] as Double
            bondMoysonLedenPrijs = vakantie["bondMoysonLedenPrijs"] as Double
            inbegrepenPrijs = vakantie["inbegrepenPrijs"] as String
            doelgroep = vakantie["doelgroep"] as String
            maxAantalDeelnemers = vakantie["maxAantalDeelnemers"] as Int
            sterPrijs1ouder = vakantie["sterPrijs1ouder"] as Double
            sterPrijs2ouders = vakantie["sterPrijs2ouders"] as Double
            
            if let err = SD.executeChange("INSERT INTO Vakantie (objectId, titel, locatie, korteBeschrijving, vertrekdatum, terugkeerdatum, aantalDagenNachten, vervoerwijze, formule, basisPrijs, bondMoysonLedenPrijs, inbegrepenPrijs, doelgroep, maxAantalDeelnemers, sterPrijs1ouder, sterPrijs2ouders) VALUES ('\(objectId)', '\(titel)', '\(locatie)', '\(korteBeschrijving)', '\(vertrekdatum)', '\(terugkeerdatum)', '\(aantalDagenNachten)', '\(vervoerwijze)', '\(formule)', '\(basisPrijs)', '\(bondMoysonLedenPrijs)', '\(inbegrepenPrijs)', '\(doelgroep)', '\(maxAantalDeelnemers)', '\(sterPrijs1ouder)', '\(sterPrijs2ouders)')") {
                //there was an error during the insert, handle it here
            } else {
                //no error, the row was inserted successfully
            }
            
        }
    }
    
    static func getAlleVakanties() -> [Vakantie] {
        
        var vakanties:[Vakantie] = []
        var vakantie: Vakantie = Vakantie(id: "test")
        
        let (resultSet, err) = SD.executeQuery("SELECT * FROM Vakantie")
        
        if err != nil {
            //there was an error during the query, handle it here
        } else {
            for row in resultSet {
                vakantie = getVakantie(row)
                vakanties.append(vakantie)
            }
        }
        
        return vakanties
    }
    
    static private func getVakantie(row: SD.SDRow) -> Vakantie {
        var vakantie: Vakantie = Vakantie(id: "test")
        
        if let objectId = row["objectId"]?.asString() {
            vakantie.id = objectId
        }
        if let titel = row["titel"]?.asString() {
            vakantie.titel = titel
        }
        if let locatie = row["locatie"]?.asString() {
            vakantie.locatie = locatie
        }
        if let korteBeschrijving = row["korteBeschrijving"]?.asString() {
            vakantie.korteBeschrijving = korteBeschrijving
        }
        if let vertrekdatum = row["vertrekdatum"]?.asDate()! {
            vakantie.beginDatum = vertrekdatum
        }
        if let terugkeerdatum = row["terugkeerdatum"]?.asDate()! {
            vakantie.terugkeerDatum = terugkeerdatum
        }
        if let aantalDagenNachten = row["aantalDagenNachten"]?.asString() {
            vakantie.aantalDagenNachten = aantalDagenNachten
        }
        if let vervoerwijze = row["vervoerwijze"]?.asString() {
            vakantie.vervoerwijze = vervoerwijze
        }
        if let formule = row["formule"]?.asString() {
            vakantie.formule = formule
        }
        if let basisPrijs = row["basisPrijs"]?.asDouble() {
            vakantie.basisprijs = basisPrijs
        }
        if let bondMoysonLedenPrijs = row["bondMoysonLedenPrijs"]?.asDouble() {
            vakantie.bondMoysonLedenPrijs = bondMoysonLedenPrijs
        }
        if let inbegrepenInPrijs = row["inbegrepenInPrijs"]?.asString() {
            vakantie.inbegrepenPrijs = inbegrepenInPrijs
        }
        if let doelgroep = row["doelgroep"]?.asString() {
            vakantie.doelgroep = doelgroep
        }
        if let maxAantalDeelnemers = row["maxAantalDeelnemers"]?.asInt()! {
            vakantie.maxAantalDeelnemers = maxAantalDeelnemers
        }
        if let sterPrijs1ouder = row["sterPrijs1ouder"]?.asDouble() {
            vakantie.sterPrijs1ouder = sterPrijs1ouder
        }
        if let sterPrijs2ouders = row["sterPrijs2ouders"]?.asDouble() {
            vakantie.sterPrijs2ouders = sterPrijs2ouders
        }
        
        return vakantie
    }
}