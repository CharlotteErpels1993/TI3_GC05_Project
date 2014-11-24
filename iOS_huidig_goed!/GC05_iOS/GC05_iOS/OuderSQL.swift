import Foundation

class OuderSQL {
    
    func createOuderTable() {
        if let error = SD.createTable("Ouder", withColumnNamesAndTypes: ["objectId": .StringVal, "rijksregisterNr": .StringVal, "email": .StringVal, "wachtwoord": .StringVal ,"voornaam": .StringVal, "naam": .StringVal, "straat": .StringVal, "nummer": .IntVal, "bus": .StringVal, "postcode": .IntVal, "gemeente": .StringVal, "telefoon": .StringVal, "gsm": .StringVal, "aansluitingsNr": .IntVal, "codeGerechtigde": .IntVal, "aansluitingsNrTweedeOuder": .IntVal]) {
            
            //there was an error
            
        } else {
            //no error
        }
    }
    
    func vulOuderTableOp() {
        
        var ouders: [PFObject] = []
        var query = PFQuery(className: "Ouder")
        ouders = query.findObjects() as [PFObject]
        
        var objectId: String = ""
        var rijksregisterNr: String?
        var email: String = ""
        var wachtwoord: String?
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
            objectId = ouder.objectId as String
            rijksregisterNr = ouder["rijksregisterNr"] as? String
            email = ouder["email"] as String
            wachtwoord = ouder["wachtwoord"] as? String
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
            
            if let err = SD.executeChange("INSERT INTO Ouder (objectId, rijksregisterNr, email, wachtwoord, voornaam, naam, straat, nummer, bus, postcode, gemeente, telefoon, gsm, aansluitingsNr, codeGerechtigde, aansluitingsNrTweedeOuder) VALUES ('\(objectId)', '\(rijksregisterNr)', '\(email)', '\(wachtwoord)', '\(voornaam)', '\(naam)', '\(straat)', '\(nummer)', '\(bus)', '\(postcode)', '\(gemeente)', '\(telefoon)', '\(gsm)', '\(aansluitingsNr)', '\(codeGerechtigde)', '\(aansluitingsNrTweedeOuder)')") {
                //there was an error during the insert, handle it here
            } else {
                //no error, the row was inserted successfully
            }
            
        }
    }
    
    func parseOuderToDatabase(ouder: Ouder) {
        var ouderJSON = PFObject(className: "Ouder")
        
        ouderJSON.setValue(ouder.email, forKey: "email")
        ouderJSON.setValue(ouder.wachtwoord, forKey: "wachtwoord")
        ouderJSON.setValue(ouder.voornaam, forKey: "voornaam")
        ouderJSON.setValue(ouder.naam, forKey: "naam")
        ouderJSON.setValue(ouder.straat, forKey: "straat")
        ouderJSON.setValue(ouder.nummer, forKey: "nummer")
        ouderJSON.setValue(ouder.postcode, forKey: "postcode")
        ouderJSON.setValue(ouder.gemeente, forKey: "gemeente")
        ouderJSON.setValue(ouder.gsm, forKey: "gsm")
        
        if ouder.rijksregisterNr != nil {
            ouderJSON.setValue(ouder.rijksregisterNr, forKey: "rijksregisterNr")
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
    
    private func createPFUser(ouder: Ouder) {
        var user = PFUser()
        user.username = ouder.email
        user.password = ouder.wachtwoord
        user.email = ouder.email
        user["soort"] = "ouder"
        
        user.signUpInBackgroundWithBlock {
            (succeeded: Bool!, error: NSError!) -> Void in
            if error == nil {
                
            }
        }
    }
    
    private func logIn(ouder: Ouder) {
        PFUser.logInWithUsername(ouder.email, password: ouder.wachtwoord)
    }
    
}