import Foundation

struct DeelnemerSQL {
    
    static func createDeelnemerTable() {
        if let error = SD.createTable("Deelnemer", withColumnNamesAndTypes:
            ["objectId": .StringVal, "voornaam": .StringVal, "naam": .StringVal,
                "geboortedatum": .StringVal ,"straat": .StringVal, "nummer": .IntVal,
                "gemeente": .StringVal, "postcode": .IntVal, "bus": .StringVal, "inschrijvingVakantie": .StringVal])
        {
            println("ERROR: error tijdens creatie van table Deelnemer")
        }
        else
        {
            //no error
        }
    }
    
    static func vulDeelnemerTableOp() {
        
        var queryString: String = ""
        
        var deelnemers: [PFObject] = []
        var query = PFQuery(className: "Deelnemer")
        deelnemers = query.findObjects() as [PFObject]
        
        var objectId: String = ""
        var voornaam: String = ""
        var naam: String = ""
        var geboortedatum: NSDate = NSDate()
        var straat: String = ""
        var nummer: Int = 0
        var bus: String = ""
        var postcode: Int = 0
        var gemeente: String = ""
        var inschrijvingVakantie: String = ""
        
        for deelnemer in deelnemers {
            
            queryString.removeAll(keepCapacity: true)
            
            objectId = deelnemer.objectId as String
            voornaam = deelnemer["voornaam"] as String
            naam = deelnemer["naam"] as String
            geboortedatum = deelnemer["geboortedatum"] as NSDate
            straat = deelnemer["straat"] as String
            nummer = deelnemer["nummer"] as Int
            bus = deelnemer["bus"] as String
            postcode = deelnemer["postcode"] as Int
            gemeente = deelnemer["gemeente"] as String
            inschrijvingVakantie = deelnemer["inschrijvingVakantie"] as String
            
            var geboortedatumString = geboortedatum.toS("dd/MM/yyyy")
            
            queryString.extend("INSERT INTO Deelnemer ")
            queryString.extend("(")
            queryString.extend("objectId, ")
            queryString.extend("voornaam, ")
            queryString.extend("naam, ")
            queryString.extend("geboortedatum, ")
            queryString.extend("straat, ")
            queryString.extend("nummer, ")
            queryString.extend("bus, ")
            queryString.extend("postcode, ")
            queryString.extend("gemeente, ")
            queryString.extend("inschrijvingVakantie")
            queryString.extend(")")
            queryString.extend(" VALUES ")
            queryString.extend("(")
            
            queryString.extend("'\(objectId)', ") //objectId - String
            queryString.extend("'\(voornaam)', ") //voornaam - String
            queryString.extend("'\(naam)', ") //naam - String
            queryString.extend("'\(geboortedatumString)', ") //geboortedatum - String
            queryString.extend("'\(straat)', ") //straat - String
            queryString.extend("\(nummer), ") //nummer - Int
            queryString.extend("'\(bus)', ") //bus - String
            queryString.extend("\(postcode), ") //postcode - Int
            queryString.extend("'\(gemeente)', ") //gemeente - String
            queryString.extend("'\(inschrijvingVakantie)'") //inschrijvingVakantie - String
            
            queryString.extend(")")
            
            if let err = SD.executeChange(queryString)
            {
                println("ERROR: error tijdens toevoegen van nieuwe deelnemer in table Deelnemer")
            }
            else
            {
                //no error, the row was inserted successfully
            }
        }
    }
    
    static func getDeelnemerMetVoornaamEnNaam(voornaam: String, naam: String) -> /*Deelnemer?*/ (Deelnemer, Int?) {
        
        var deelnemers:[Deelnemer] = []
        var deelnemer: Deelnemer = Deelnemer(id: "test")
        
        let (resultSet, err) = SD.executeQuery("SELECT * FROM Deelnemer WHERE voornaam = ? AND naam = ?", withArgs: [voornaam, naam])
        
        var response: (Deelnemer, Int?)
        var error: Int?
        
        if err != nil
        {
            println("ERROR: error tijdens ophalen van een deelnemer met voornaam en naam uit table Deelnemer")
        }
        else
        {
            if resultSet.count == 0 {
                error = 1
                //response = (deelnemer, error)
            } else {
                error = nil
                
                for row in resultSet {
                    deelnemer = getDeelnemer(row)
                    deelnemers.append(deelnemer)
                }
            }
        }
        
        //return deelnemers.first
        
        response = (deelnemer, error)
        return response
    
    }
    
    static private func getDeelnemer(row: SD.SDRow) -> Deelnemer {
        var deelnemer: Deelnemer = Deelnemer(id: "test")
        
        if let objectId = row["objectId"]?.asString() {
            deelnemer.id = objectId
        }
        if let voornaam = row["voornaam"]?.asString() {
            deelnemer.voornaam = voornaam
        }
        if let naam = row["naam"]?.asString() {
            deelnemer.naam = naam
        }
        if let geboortedatum = row["geboortedatum"]?.asString() {
            var geboortedatumString = geboortedatum
            deelnemer.geboortedatum = geboortedatumString.toDate() as NSDate!
        }
        if let straat = row["straat"]?.asString() {
            deelnemer.straat = straat
        }
        if let nummer = row["nummer"]?.asInt()! {
            deelnemer.nummer = nummer
        }
        if let bus = row["bus"]?.asString() {
            deelnemer.bus = bus
        }
        if let postcode = row["postcode"]?.asInt()! {
            deelnemer.postcode = postcode
        }
        if let gemeente = row["gemeente"]?.asString() {
            deelnemer.gemeente = gemeente
        }
        
        return deelnemer
    }
    
    static func parseDeelnemerToDatabase(deelnemer: Deelnemer) -> String {
        var deelnemerJSON = PFObject(className: "Deelnemer")
        
        deelnemerJSON.setValue(deelnemer.voornaam, forKey: "voornaam")
        deelnemerJSON.setValue(deelnemer.naam, forKey: "naam")
        deelnemerJSON.setValue(deelnemer.geboortedatum, forKey: "geboortedatum")
        deelnemerJSON.setValue(deelnemer.straat, forKey: "straat")
        deelnemerJSON.setValue(deelnemer.nummer, forKey: "nummer")
        deelnemerJSON.setValue(deelnemer.gemeente, forKey: "gemeente")
        deelnemerJSON.setValue(deelnemer.postcode, forKey: "postcode")
        //deelnemerJSON.setValue(inschrijvingId, forKey: "inschrijvingVakantie")
        
        if deelnemer.bus != nil {
            deelnemerJSON.setValue(deelnemer.bus, forKey: "bus")
        }
        
        deelnemerJSON.save()
        deelnemerJSON.fetch()
        
        return deelnemerJSON.objectId
    }
    
}