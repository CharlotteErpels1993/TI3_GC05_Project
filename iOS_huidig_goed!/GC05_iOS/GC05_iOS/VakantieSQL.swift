import Foundation

struct /*class*/ VakantieSQL {
    
    static func createVakantieTable() {
        if let error = SD.createTable("Vakantie", withColumnNamesAndTypes:
            ["objectId": .StringVal, "titel": .StringVal, "locatie": .StringVal,
             "korteBeschrijving": .StringVal, "vertrekdatum": .StringVal,
             "terugkeerdatum": .StringVal, "aantalDagenNachten": .StringVal,
             "vervoerwijze": .StringVal, "formule": .StringVal, "basisPrijs": .DoubleVal,
             "bondMoysonLedenPrijs": .DoubleVal, "inbegrepenPrijs": .StringVal,
             "doelgroep": .StringVal, "maxAantalDeelnemers": .IntVal,
             "sterPrijs1ouder": .DoubleVal, "sterPrijs2ouders": .DoubleVal])
        {
            println("ERROR: error tijdens creatie van table Vakantie")
        }
        else
        {
            //no error
        }
    }
    
    static func vulVakantieTableOp() {
        
        var queryString: String = ""

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
        
        var teller: Int = 0
        
        for vakantie in vakanties {
            
            //OPLOSSING fout invoegen vakanties
            //1ste vakantie ging wel
            //daarna niet meer
            //de query werd elke keer langer en langer
            //waardoor dat de queryString 3 keer de eigenlijke query bevat
            //OPLOSSING: queryString aan het begin terug leegmaken!
            queryString.removeAll(keepCapacity: true)
            
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
            
            var vertrekdatumString = vertrekdatum.toS("dd/MM/yyyy")
            var terugkeerdatumString = terugkeerdatum.toS("dd/MM/yyyy")
            
            //if let err = SD.executeChange("INSERT INTO Cities (Name, Population, IsWarm, FoundedIn) VALUES ('Toronto', 2615060, 0, '1793-08-27')")
            
            queryString.extend("INSERT INTO Vakantie ")
            queryString.extend("(")
            queryString.extend("objectId, ")
            queryString.extend("titel, ")
            queryString.extend("locatie, ")
            queryString.extend("korteBeschrijving, ")
            queryString.extend("vertrekdatum, ")
            queryString.extend("terugkeerdatum, ")
            queryString.extend("aantalDagenNachten, ")
            queryString.extend("vervoerwijze, ")
            queryString.extend("formule, ")
            queryString.extend("basisPrijs, ")
            queryString.extend("bondMoysonLedenPrijs, ")
            queryString.extend("inbegrepenPrijs, ")
            queryString.extend("doelgroep, ")
            queryString.extend("maxAantalDeelnemers, ")
            queryString.extend("sterPrijs1ouder, ")
            queryString.extend("sterPrijs2ouders")
            queryString.extend(")")
            queryString.extend(" VALUES ")
            queryString.extend("(")
            
            queryString.extend("'\(objectId)', ") //objectId - String
            queryString.extend("'\(titel)', ") //titel - String
            queryString.extend("'\(locatie)', ") //locatie - String
            queryString.extend("'\(korteBeschrijving)', ") //korteBeschrijving - String
            queryString.extend("'\(vertrekdatumString)', ") //vertrekdatumString - String
            queryString.extend("'\(terugkeerdatumString)', ") //terugkeerdatumString - String
            queryString.extend("'\(aantalDagenNachten)', ") //aantalDagenNachten - String
            queryString.extend("'\(vervoerwijze)', ") //vervoerwijze - String
            queryString.extend("'\(formule)', ") //formule - String
            queryString.extend("\(basisPrijs), ") //basisPrijs - Double (geen '')!!
            queryString.extend("\(bondMoysonLedenPrijs), ") //bondMoysonLedenPrijs - Double (geen '')!!
            queryString.extend("'\(inbegrepenPrijs)', ") //inbegrepenPrijs - String
            queryString.extend("'\(doelgroep)', ") //doelgroep - String
            queryString.extend("\(maxAantalDeelnemers), ") //maxAantalDeelnemers - Int (geen '')!!
            queryString.extend("\(sterPrijs1ouder), ") //sterPrijs1ouder - Double (geen '')!!
            queryString.extend("\(sterPrijs2ouders)") //sterPrijs2ouders - Double (geen '')!!
            
            queryString.extend(")")
            
            if let err = SD.executeChange(queryString)
            {
                println("ERROR: error tijdens toevoegen van nieuwe vakantie in table Vakantie")
            }
            else
            {
                //no error, the row was inserted successfully
            }
            
            teller += 1
            
        }
    }
    
    static func getAlleVakanties() -> [Vakantie] {
        
        var vakanties:[Vakantie] = []
        var vakantie: Vakantie = Vakantie(id: "test")
        
        let (resultSet, err) = SD.executeQuery("SELECT * FROM Vakantie")
        
        if err != nil
        {
            println("ERROR: error tijdens ophalen van alle vakanties uit table Vakantie")
        }
        else
        {
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
        if let vertrekdatum = row["vertrekdatum"]?.asString() {
            var vertrekdatumString = vertrekdatum
            vakantie.vertrekdatum = vertrekdatumString.toDate() as NSDate!
        }
        if let terugkeerdatum = row["terugkeerdatum"]?.asString() {
            var terugkeerdatumString = terugkeerdatum
            vakantie.terugkeerdatum = terugkeerdatumString.toDate() as NSDate!
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
        if let inbegrepenInPrijs = row["inbegrepenPrijs"]?.asString() {
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