import Foundation

struct VakantieSQL {
    
    static func createVakantieTable() {
        if let error = SD.createTable("Vakantie", withColumnNamesAndTypes:
            ["objectId": .StringVal, "titel": .StringVal, "locatie": .StringVal,
             "korteBeschrijving": .StringVal, "vertrekdatum": .StringVal,
             "terugkeerdatum": .StringVal, "aantalDagenNachten": .StringVal,
             "vervoerwijze": .StringVal, "formule": .StringVal, "basisPrijs": .DoubleVal,
             "bondMoysonLedenPrijs": .DoubleVal, "inbegrepenPrijs": .StringVal,
             "minLeeftijd": .IntVal, "maxLeeftijd": .IntVal, "maxAantalDeelnemers": .IntVal,
                "sterPrijs1ouder": .DoubleVal, "sterPrijs2ouders": .DoubleVal, "link": .StringVal])
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
        //var doelgroep: String = ""
        var minLeeftijd: Int = 0
        var maxLeeftijd: Int = 0
        var maxAantalDeelnemers: Int = 0
        var sterPrijs1ouder: Double = 0.0
        var sterPrijs2ouders: Double = 0.0
        var link: String = ""
        
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
            //doelgroep = vakantie["doelgroep"] as String
            minLeeftijd = vakantie["minLeeftijd"] as Int
            maxLeeftijd = vakantie["maxLeeftijd"] as Int
            maxAantalDeelnemers = vakantie["maxAantalDeelnemers"] as Int
            sterPrijs1ouder = vakantie["sterPrijs1ouder"] as Double
            sterPrijs2ouders = vakantie["sterPrijs2ouders"] as Double
            link = vakantie["link"] as String
            
            var vertrekdatumString = vertrekdatum.toS("dd/MM/yyyy")
            var terugkeerdatumString = terugkeerdatum.toS("dd/MM/yyyy")
            
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
            //queryString.extend("doelgroep, ")
            queryString.extend("minLeeftijd, ")
            queryString.extend("maxLeeftijd, ")
            queryString.extend("maxAantalDeelnemers, ")
            queryString.extend("sterPrijs1ouder, ")
            queryString.extend("sterPrijs2ouders, ")
            queryString.extend("link")
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
            //queryString.extend("'\(doelgroep)', ") //doelgroep - String
            queryString.extend("\(minLeeftijd), ") //minLeeftijd - Int (geen '')!!
            queryString.extend("\(maxLeeftijd), ") //maxLeeftijd - Int (geen '')!!
            queryString.extend("\(maxAantalDeelnemers), ") //maxAantalDeelnemers - Int (geen '')!!
            queryString.extend("\(sterPrijs1ouder), ") //sterPrijs1ouder - Double (geen '')!!
            queryString.extend("\(sterPrijs2ouders), ") //sterPrijs2ouders - Double (geen '')!!
            queryString.extend("'\(link)'") // link - String
            
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
    
    static func getAlleVakanties() -> /*[Vakantie]*/ ([Vakantie], Int?) {
        
        var vakanties:[Vakantie] = []
        var vakantie: Vakantie = Vakantie(id: "test")
        
        let (resultSet, err) = SD.executeQuery("SELECT * FROM Vakantie")
        
        var response: ([Vakantie], Int?)
        var error: Int?
        
        if err != nil
        {
            println("ERROR: error tijdens ophalen van alle vakanties uit table Vakantie")
        }
        else
        {
            if resultSet.count == 0 {
                error = 1
            }
            else {
                error = nil
                
                for row in resultSet {
                    vakantie = getVakantie(row)
                    vakanties.append(vakantie)
                }
                
            }
            
        }
        
        response = (vakanties, error)
        return response
    }
    
    static func getVakantie(row: SD.SDRow) -> Vakantie {
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
        /*if let doelgroep = row["doelgroep"]?.asString() {
            vakantie.doelgroep = doelgroep
        }*/
        if let minLeeftijd = row["minLeeftijd"]?.asInt()! {
            vakantie.minLeeftijd = minLeeftijd
        }
        if let maxLeeftijd = row["maxLeeftijd"]?.asInt()! {
            vakantie.maxLeeftijd = maxLeeftijd
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
        if let link = row["link"]?.asString() {
            vakantie.link = link
        }
        
        return vakantie
    }
    
    static func deleteVakantiesInVerleden() {
        var vakantiesObjects: [PFObject] = []
        
        var query = PFQuery(className: "Vakantie")
        vakantiesObjects = query.findObjects() as [PFObject]
        
        
    }
}