import Foundation

struct OuderSQL {
    
    static func createOuderTable() {
        if let error = SD.createTable("Ouder", withColumnNamesAndTypes:
            ["objectId": .StringVal, "rijksregisterNr": .StringVal, "email": .StringVal,
                /*"wachtwoord": .StringVal ,*/"voornaam": .StringVal, "naam": .StringVal,
                "straat": .StringVal, "nummer": .IntVal, "bus": .StringVal, "postcode": .IntVal,
                "gemeente": .StringVal, "telefoon": .StringVal, "gsm": .StringVal,
                "aansluitingsNr": .IntVal, "codeGerechtigde": .IntVal,
                "aansluitingsNrTweedeOuder": .IntVal])
        {
            println("ERROR: error tijdens creatie van table Ouder")
        }
        else
        {
            //no error
        }
    }
    
    static func getEmail(email: String) -> Bool {
        let (resultSet, err) = SD.executeQuery("SELECT * FROM Ouder WHERE email = ?", withArgs: [email])
        if err != nil
        {
            println("ERROR: error tijdens ophalen van alle gsms")
        }
        
        if resultSet.count == 0 {
            return false
        }
        
        return true
    }
    
    static func getGSM(gsm: String) -> Bool {
        let (resultSet, err) = SD.executeQuery("SELECT * FROM Ouder WHERE gsm = ?", withArgs: [gsm])
        if err != nil
        {
            println("ERROR: error tijdens ophalen van alle gsms")
        }
        
        if resultSet.count == 0 {
            return false
        }
        
        return true
    }
    
    static func getRijksregisterNummers(rijksregisterNummer: String) -> Bool {
        let (resultSet, err) = SD.executeQuery("SELECT * FROM Ouder WHERE rijksregisterNr = ?", withArgs: [rijksregisterNummer])
        if err != nil
        {
            println("ERROR: error tijdens ophalen van alle rijksregisternummers")
        }
        
        if resultSet.count == 0 {
            return false
        }
        
        return true
    }
    
    private static func getOuder(ouderObject: PFObject) -> Ouder {
        var id = ouderObject.objectId as String
        
        var ouder: Ouder = Ouder(id: id)
        
        ouder.email = ouderObject["email"] as? String
        ouder.rijksregisterNr = ouderObject["rijksregisterNr"] as? String
        ouder.voornaam = ouderObject["voornaam"] as? String
        ouder.naam = ouderObject["naam"] as? String
        ouder.straat = ouderObject["straat"] as? String
        ouder.nummer = ouderObject["nummer"] as? Int
        
        if ouderObject["bus"] as? String != nil {
            ouder.bus = ouderObject["bus"] as? String
        }
        
        ouder.gemeente = ouderObject["gemeente"] as? String
        ouder.postcode = ouderObject["postcode"] as? Int
        
        if ouderObject["telefoon"] as? String != nil {
            ouder.telefoon = ouderObject["telefoon"] as? String
        }
        
        ouder.gsm = ouderObject["gsm"] as? String
        
        if ouderObject["aansluitingsNr"] as? Int != nil {
            ouder.aansluitingsNr = ouderObject["aansluitingsNr"] as? Int
        }
        
        if ouderObject["codeGerechtigde"] as? Int != nil {
            ouder.codeGerechtigde = ouderObject["codeGerechtigde"] as? Int
        }
        
        if ouderObject["aansluitingsNrTweedeOuder"] as? Int != nil {
            ouder.aansluitingsNrTweedeOuder = ouderObject["aansluitingsNrTweedeOuder"] as? Int
        }
        
        return ouder
    }
    
    static func getOuderWithEmail(email: String) -> Ouder {
        
        //nieuw: Charlotte
        var query = PFQuery(className: "Ouder")
        query.whereKey("email", equalTo: email)
        
        var ouderObject = query.getFirstObject()
        
        var ouder: Ouder
        
        if ouderObject == nil {
            //ERROR, mag normaal gezien nooit gebeuren door voorgaande controles (OuderSQL.getOuderWithEmail)
            ouder = Ouder(id: "test")
        } else {
            ouder = getOuder(ouderObject)
        }
        
        return ouder
        
        /*var ouders: [Ouder] = []
        var ouder2: Ouder = Ouder(id: "test")
        var ouder: Ouder = Ouder(id: "test")
        
        let (resultSet, err) = SD.executeQuery("SELECT * FROM Ouder WHERE email = ?", withArgs: [email])
        
        if err != nil
        {
        println("ERROR: error tijdens ophalen van ouders met email uit table Ouder")
        }
        else
        {
        if resultSet.count == 0 {
        ouders.append(ouder)
        } else {
        for row in resultSet {
        ouder = getOuder(row)
        ouders.append(ouder)
        }
        }
        }
        return ouders.first!*/
    }
    
    static func getOuder(row: SD.SDRow) -> Ouder {
        var ouder: Ouder = Ouder(id: "test")
        
        if let objectId = row["objectId"]?.asString() {
            ouder.id = objectId
        }
        if let rijksregisterNr = row["rijksregisterNr"]?.asString() {
            ouder.rijksregisterNr = rijksregisterNr
        }
        if let email = row["email"]?.asString() {
            ouder.email = email
        }
        /*if let wachtwoord = row["wachtwoord"]?.asString() {
        ouder.wachtwoord = wachtwoord
        }*/
        if let voornaam = row["voornaam"]?.asString() {
            ouder.voornaam = voornaam
        }
        if let naam = row["naam"]?.asString() {
            ouder.naam = naam
        }
        if let straat = row["straat"]?.asString() {
            ouder.straat = straat
        }
        if let nummer = row["nummer"]?.asInt() {
            ouder.nummer = nummer
        }
        if let bus = row["bus"]?.asString() {
            ouder.bus = bus
        }
        if let postcode = row["postcode"]?.asInt() {
            ouder.postcode = postcode
        }
        if let gemeente = row["gemeente"]?.asString() {
            ouder.gemeente = gemeente
        }
        if let telefoon = row["telefoon"]?.asString() {
            ouder.telefoon = telefoon
        }
        if let gsm = row["gsm"]?.asString() {
            ouder.gsm = gsm
        }
        if let aansluitingsNr = row["aansluitingsNr"]?.asInt() {
            ouder.aansluitingsNr = aansluitingsNr
        }
        if let codeGerechtigde = row["codeGerechtigde"]?.asInt() {
            ouder.codeGerechtigde = codeGerechtigde
        }
        if let aansluitingsNrTweedeOuder = row["aansluitingsNrTweedeOuder"]?.asInt() {
            ouder.aansluitingsNrTweedeOuder = aansluitingsNrTweedeOuder
        }
        
        return ouder
    }
    
    static func vulOuderTableOp() {
        
        var ouders: [PFObject] = []
        var query = PFQuery(className: "Ouder")
        ouders = query.findObjects() as [PFObject]
        
        var queryString = ""
        
        var objectId: String = ""
        var rijksregisterNr: String = ""
        var email: String = ""
        //var wachtwoord: String = ""
        var voornaam: String = ""
        var naam: String = ""
        var straat: String = ""
        var nummer: Int = 0
        var bus: String?
        var postcode: Int = 0
        var gemeente: String = ""
        var telefoon: String?
        var gsm: String = ""
        var aansluitingsNr: Int?
        var codeGerechtigde: Int?
        var aansluitingsNrTweedeOuder: Int?
        
        for ouder in ouders {
            
            queryString.removeAll(keepCapacity: true)
            
            objectId = ouder.objectId as String
            rijksregisterNr = ouder["rijksregisterNr"] as String
            email = ouder["email"] as String
            //wachtwoord = ouder["wachtwoord"] as String
            voornaam = ouder["voornaam"] as String
            naam = ouder["naam"] as String
            straat = ouder["straat"] as String
            nummer = ouder["nummer"] as Int
            bus = ouder["bus"] as? String
            postcode = ouder["postcode"] as Int
            gemeente = ouder["gemeente"] as String
            telefoon = ouder["telefoon"] as? String
            gsm = ouder["gsm"] as String
            aansluitingsNr = ouder["aansluitingsNr"] as? Int
            codeGerechtigde = ouder["codeGerechtigde"] as? Int
            aansluitingsNrTweedeOuder = ouder["aansluitingsNrTweedeOuder"] as? Int
            
            if bus == nil {
                bus = ""
            }
            if telefoon == nil {
                telefoon = ""
            }
            if aansluitingsNr == nil {
                aansluitingsNr = 0
            }
            if codeGerechtigde == nil {
                codeGerechtigde = 0
            }
            if aansluitingsNrTweedeOuder == nil {
                aansluitingsNrTweedeOuder = 0
            }
            
            
            queryString.extend("INSERT INTO Ouder ")
            queryString.extend("(")
            queryString.extend("objectId, ")
            queryString.extend("rijksregisterNr, ")
            queryString.extend("email, ")
            //queryString.extend("wachtwoord, ")
            queryString.extend("voornaam, ")
            queryString.extend("naam, ")
            queryString.extend("straat, ")
            queryString.extend("nummer, ")
            queryString.extend("bus, ")
            queryString.extend("postcode, ")
            queryString.extend("gemeente, ")
            queryString.extend("telefoon, ")
            queryString.extend("gsm, ")
            queryString.extend("aansluitingsNr, ")
            queryString.extend("codeGerechtigde, ")
            queryString.extend("aansluitingsNrTweedeOuder")
            queryString.extend(")")
            queryString.extend(" VALUES ")
            queryString.extend("(")
            
            queryString.extend("'\(objectId)', ") //objectId - String
            queryString.extend("'\(rijksregisterNr)', ") //rijksregisterNr - String
            queryString.extend("'\(email)', ") //email - String
            //queryString.extend("'\(wachtwoord)', ") //wachtwoord - String
            queryString.extend("'\(voornaam)', ") //voornaam - String
            queryString.extend("'\(naam)', ") //naam - String
            queryString.extend("'\(straat)', ") //straat - String
            queryString.extend("\(nummer), ") //nummer - Int (geen '')!!
            queryString.extend("'\(bus!)', ") //bus - String
            queryString.extend("\(postcode), ") //postcode - Int (geen '')!!
            queryString.extend("'\(gemeente)', ") //gemeente - String
            queryString.extend("'\(telefoon!)', ") //telefoon - String
            queryString.extend("'\(gsm)', ") //gsm - String
            queryString.extend("\(aansluitingsNr!), ") //aansluitingsNr - Int (geen '')!!
            queryString.extend("\(codeGerechtigde!), ") //codeGerechtigde - Int (geen '')!!
            queryString.extend("\(aansluitingsNrTweedeOuder!)") //aansluitingsNrTweedeOuder - Int (geen '')!!
            
            queryString.extend(")")
            
            
            if let err = SD.executeChange(queryString) {
                //there was an error during the insert, handle it here
            } else {
                //no error, the row was inserted successfully
            }
            
        }
    }
    
    static func parseOuderToDatabase(ouder: Ouder) {
        var ouderJSON = PFObject(className: "Ouder")
        
        ouderJSON.setValue(ouder.email, forKey: "email")
        //ouderJSON.setValue(ouder.wachtwoord, forKey: "wachtwoord")
        ouderJSON.setValue(ouder.voornaam, forKey: "voornaam")
        ouderJSON.setValue(ouder.naam, forKey: "naam")
        ouderJSON.setValue(ouder.straat, forKey: "straat")
        ouderJSON.setValue(ouder.nummer, forKey: "nummer")
        ouderJSON.setValue(ouder.postcode, forKey: "postcode")
        ouderJSON.setValue(ouder.gemeente, forKey: "gemeente")
        ouderJSON.setValue(ouder.gsm, forKey: "gsm")
        ouderJSON.setValue(ouder.rijksregisterNr, forKey: "rijksregisterNr")
        
        if ouder.aansluitingsNr != nil {
            //ouderJSON.setValue(ouder.rijksregisterNr, forKey: "rijksregisterNr")
            ouderJSON.setValue(ouder.aansluitingsNr, forKey: "aansluitingsNr")
            ouderJSON.setValue(ouder.codeGerechtigde, forKey: "codeGerechtigde")
            
            if ouder.aansluitingsNrTweedeOuder != nil {
                ouderJSON.setValue(ouder.aansluitingsNrTweedeOuder, forKey: "aansluitingsNrTweedeOuder")
            }
        }
        
        if ouder.bus != nil {
            ouderJSON.setValue(ouder.bus, forKey: "bus")
        }
        
        if ouder.telefoon != nil {
            ouderJSON.setValue(ouder.telefoon, forKey: "telefoon")
        }
        
        ouderJSON.save()
        
        createPFUser(ouder)
        logIn(ouder)
    }
    
    static private func createPFUser(ouder: Ouder) {
        var user = PFUser()
        user.username = ouder.email
        user.password = ouder.wachtwoord
        user.email = ouder.email
        user["soort"] = "ouder"
        
        /*user.signUpInBackgroundWithBlock {
        (succeeded: Bool!, error: NSError!) -> Void in
        if error == nil {
        
        }
        }*/
        user.signUp()
    }
    
    static private func logIn(ouder: Ouder) {
        PFUser.logInWithUsername(ouder.email, password: ouder.wachtwoord)
    }
    
}