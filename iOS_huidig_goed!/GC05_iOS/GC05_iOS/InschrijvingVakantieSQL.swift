import Foundation

struct InschrijvingVakantieSQL {
    
    static func createInschrijvingVakantieTable() {
        if let error = SD.createTable("InschrijvingVakantie", withColumnNamesAndTypes: ["objectId": .StringVal, "extraInfo": .StringVal, "vakantie": .StringVal, "ouder": .StringVal, "deelnemer": .StringVal, "contactpersoon1": .StringVal, "contactpersoon2": .StringVal])
        {
            println("ERROR: error tijdens creatie van table InschrijvingVakantie")
        }
        else
        {
            //no error
        }
    }
    
    static func vulInschrijvingVakantieTableOp() {
        var inschrijvingenVakantie: [PFObject] = []
        var query = PFQuery(className: "InschrijvingVakantie")
        inschrijvingenVakantie = query.findObjects() as [PFObject]
        
        var queryString = ""
        
        var objectId: String = ""
        var extraInfo: String = ""
        var vakantie: String = ""
        var ouder: String = ""
        var deelnemer: String = ""
        var contactpersoon1: String = ""
        var contactpersoon2: String = ""
        
        for inschrijvingVakantie in inschrijvingenVakantie {
            
            queryString.removeAll(keepCapacity: true)
            
            objectId = inschrijvingVakantie.objectId as String
            extraInfo = inschrijvingVakantie["extraInformatie"] as String
            vakantie = inschrijvingVakantie["vakantie"] as String
            ouder = inschrijvingVakantie["ouder"] as String
            deelnemer = inschrijvingVakantie["deelnemer"] as String
            contactpersoon1 = inschrijvingVakantie["contactpersoon1"] as String
            contactpersoon2 = inschrijvingVakantie["contactpersoon2"] as String
            
            queryString.extend("INSERT INTO InschrijvingVakantie ")
            queryString.extend("(")
            queryString.extend("objectId, ")
            queryString.extend("extraInformatie, ")
            queryString.extend("vakantie, ")
            queryString.extend("ouder, ")
            queryString.extend("deelnemer, ")
            queryString.extend("contactpersoon1, ")
            queryString.extend("contactpersoon2")
            queryString.extend(")")
            queryString.extend(" VALUES ")
            queryString.extend("(")
            
            queryString.extend("'\(objectId)', ") //objectId - String
            queryString.extend("'\(extraInfo)', ") //extraInfo - String
            queryString.extend("'\(vakantie)', ") //vakantieId - String
            queryString.extend("'\(ouder)', ") //ouderId - String
            queryString.extend("'\(deelnemer)', ") //deelnemerId - String
            queryString.extend("'\(contactpersoon1)', ") //contactpersoon1Id - String
            queryString.extend("'\(contactpersoon2)'") //contactpersoon2Id - String
            
            queryString.extend(")")
            
            
            if let err = SD.executeChange(queryString)
            {
                println("ERROR: error tijdens toevoegen van nieuwe InschrijvingVakantie in table InschrijvingVakantie")
            }
            else
            {
                //no error, the row was inserted successfully
            }
            
        }
    }
    
    static func getInschrijvingenVakantie(voornaamDeelnemer: String, naamDeelnemer: String, vakantieId: String, ouderId: String) -> [InschrijvingVakantie] {
        
        var inschrijvingen: [InschrijvingVakantie] = []
        var inschrijving: InschrijvingVakantie = InschrijvingVakantie(id: "test")
        var queryString: String = ""
        
        queryString.extend("SELECT * FROM InschrijvingVakantie ")
        queryString.extend("JOIN Deelnemer ON InschrijvingVakantie.deelnemer = Deelnemer.objectId ")
        queryString.extend("WHERE Deelnemer.voornaam = ? ")
        queryString.extend("AND ")
        queryString.extend("Deelnemer.naam = ? ")
        queryString.extend("AND ")
        queryString.extend("InschrijvingVakantie.vakantie = ? ")
        queryString.extend("AND ")
        queryString.extend("InschrijvingVakantie.ouder = ?")
        
        let (resultSet, err) = SwiftData.executeQuery(queryString, withArgs: [voornaamDeelnemer, naamDeelnemer, vakantieId, ouderId])
        
        if err != nil
        {
            println("ERROR: error tijdens ophalen van inschrijvingenDeelnemer uit table InschrijvingenVakantie")
        }
        else
        {
            if resultSet.count > 0 {
                inschrijvingen.append(inschrijving)
                inschrijvingen.append(inschrijving)
            }
        }
        
        return inschrijvingen
    }
    
    /*static private func getInschrijvingVakantie(row: SD.SDRow) -> InschrijvingVakantie {
        var inschrijving: InschrijvingVakantie = InschrijvingVakantie(id: "test")
        
        if let objectId = row["objectId"]?.asString() {
            inschrijving.id = objectId
        }
        if let extraInfo = row["extraInfo"]?.asString() {
            inschrijving.extraInfo = extraInfo
        }
        if let vakantie = row["vakantie"]?.asString() {
            inschrijving.vakantie = vakantie
        }
        if let ouder = row["ouder"]?.asString() {
            inschrijving.ouder = ouder
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
        
        return vakantie
    }*/
    
    /*static func getInschrijvingenMetId(inschrijvingenId: [String]) -> [InschrijvingVakantie] {
        
        var inschrijvingenVakanties:[InschrijvingVakantie] = []
        var inschrijving: InschrijvingVakantie = InschrijvingVakantie(id: "test")
        
        let (resultSet, err) = SD.executeQuery("SELECT * FROM InschrijvingVakantie")
        
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
    }*/
    
    /*static private func getVakantie(row: SD.SDRow) -> Vakantie {
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
        
        return vakantie
    }*/
    
    static func parseInschrijvingVakantieToDatabase(inschrijving: InschrijvingVakantie) {
        var inschrijvingJSON = PFObject(className: "InschrijvingVakantie")
        
        inschrijvingJSON.setValue(inschrijving.vakantie?.id, forKey: "vakantie")
        inschrijvingJSON.setValue(inschrijving.ouder?.id, forKey: "ouder")
        inschrijvingJSON.setValue(inschrijving.deelnemer?.id, forKey: "deelnemer")
        inschrijvingJSON.setValue(inschrijving.contactpersoon1?.id, forKey: "contactpersoon1")
        
        
        if inschrijving.extraInfo != "" {
            inschrijvingJSON.setValue(inschrijving.extraInfo, forKey: "extraInformatie")
        }
        
        if inschrijving.contactpersoon2 != nil {
            inschrijvingJSON.setValue(inschrijving.contactpersoon2?.id, forKey: "contactpersoon2")
        }
        
        inschrijvingJSON.save()
    }
}