import Foundation

struct LocalDatastore {
    static func makeQuery(tableName: String, local: Bool, queryConstraints: [String: String]) -> PFQuery {
        
        var query = PFQuery(className: tableName)
        
        for queryConstraint in queryConstraints {
            query = addQueryConstraint(query, columnName: queryConstraint.0, columnValue: queryConstraint.1)
        }
        
        if local == true {
            query.fromLocalDatastore()
        }
        
        return query
    }
    
    static func addQueryConstraint(query: PFQuery, columnName: String, columnValue: String) -> PFQuery
    {
        query.whereKey(columnName, equalTo: columnValue)
        
        return query
    }
    
    static func isEmptyInLocalDatastore(tableName: String) -> Bool {
        var query = PFQuery(className: tableName)
        
        query.fromLocalDatastore()
        
        var count = query.countObjects()
        
        if count == 0 {
            return true
        }
        
        return false
    }
    
    static func getTableReady(tableName: String) {
        
        var localTableIsEmpty: Bool = self.isEmptyInLocalDatastore(tableName)
        
        if localTableIsEmpty == true {
            if Reachability.isConnectedToNetwork() == true {
                //table is leeg & wel internet
                //table opvullen uit parse
                fillTableInLocalDatastore(tableName)
            }
        } else {
            if Reachability.isConnectedToNetwork() == true {
                //table is opgevuld & wel internet
                //table updaten uit parse
                updateObjectsInLocalDatastoreFromParse(tableName)
            }
        }
    }
    
    static func fillTableInLocalDatastore(tableName: String) {
        var query = makeQuery(tableName, local: false, queryConstraints: [:])
        
        var objects: [PFObject] = []
        
        objects = query.findObjects() as [PFObject]
        
        PFObject.pinAll(objects)
    }
    
    static func updateObjectsInLocalDatastoreFromParse(tableName: String) {
        
        var localObjects = self.fetchHuidigeObjectenInLocalDatastore(tableName)
        
        pinNewObjects(localObjects, tableName: tableName)
        
        var onlineObjects = self.getAllObjectsParse(tableName)
        
        //self.unpinOldObjects(onlineObjects, tableName: tableName)
    }
    
    static func fetchHuidigeObjectenInLocalDatastore(tableName: String) -> [PFObject] {
        
        var query = PFQuery(className: tableName)
        
        query.fromLocalDatastore()
        
        var objects: [PFObject] = query.findObjects() as [PFObject]
        
        for object in objects {
            object.fetch()
        }
        
        return objects
    }
    
    static func pinNewObjects(localObjects: [PFObject], tableName: String) {
        var query = PFQuery(className: tableName)
        
        query.whereKey("objectId", notContainedIn: localObjects)
        
        var objects = query.findObjects()
        
        PFObject.pinAll(objects)
    }
    
    static func getAllObjectsParse(tableName: String) -> [PFObject] {
        var query = PFQuery(className: tableName)
        
        var objects = query.findObjects() as [PFObject]
        
        return objects
    }
    
    static func unpinOldObjects(onlineObjects: [PFObject], tableName: String) {
        var query = PFQuery(className: tableName)
        
        query.whereKey("objectId", notContainedIn: onlineObjects)
        
        query.fromLocalDatastore()
        
        var objects = query.findObjects()
        
        PFObject.unpinAll(objects)
    }
    
    static func getVakantie(vakantieObject: PFObject) -> Vakantie {
        var vakantie: Vakantie = Vakantie(id: vakantieObject.objectId)
        
        vakantie.titel = vakantieObject["titel"] as? String
        vakantie.locatie = vakantieObject["locatie"] as? String
        vakantie.korteBeschrijving = vakantieObject["korteBeschrijving"] as? String
        vakantie.vertrekdatum = vakantieObject["vertrekdatum"] as NSDate
        vakantie.terugkeerdatum = vakantieObject["terugkeerdatum"] as NSDate
        vakantie.aantalDagenNachten = vakantieObject["aantalDagenNachten"] as? String
        vakantie.vervoerwijze = vakantieObject["vervoerwijze"] as? String
        vakantie.formule = vakantieObject["formule"] as? String
        vakantie.link = vakantieObject["link"] as? String
        vakantie.basisprijs = vakantieObject["basisPrijs"] as? Double
        vakantie.bondMoysonLedenPrijs = vakantieObject["bondMoysonLedenPrijs"] as? Double
        vakantie.sterPrijs1ouder = vakantieObject["sterPrijs1ouder"] as? Double
        vakantie.sterPrijs2ouders = vakantieObject["sterPrijs2ouders"] as? Double
        vakantie.inbegrepenPrijs = vakantieObject["inbegrepenPrijs"] as? String
        vakantie.minLeeftijd = vakantieObject["minLeeftijd"] as Int
        vakantie.maxLeeftijd = vakantieObject["maxLeeftijd"] as? Int
        vakantie.maxAantalDeelnemers = vakantieObject["maxAantalDeelnemers"] as? Int
        
        return vakantie
    }
    
    static func getFeedback(feedbackObject: PFObject) -> Feedback {
        
        var feedback: Feedback = Feedback(id: feedbackObject.objectId)
        
        var vakantieId: String = feedbackObject["vakantie"] as String
        var gebruikerId: String = feedbackObject["gebruiker"] as String
        var monitor: Gebruiker = Gebruiker(id: gebruikerId)
        
        feedback.vakantie = self.getVakantieFromFeedback(vakantieId)
        var ouder = self.getOuderFromFeedback(gebruikerId)
        
        if ouder == nil {
            monitor = self.getMonitorFromFeedback(gebruikerId)!
        }
        
        feedback.datum = feedbackObject["datum"] as? NSDate
        feedback.goedgekeurd = feedbackObject["goedgekeurd"] as? Bool
        
        if ouder != nil {
            feedback.gebruiker = ouder
        } else {
            feedback.gebruiker = monitor
        }
        
        feedback.waardering = feedbackObject["waardering"] as? String
        feedback.score = feedbackObject["score"] as? Int
        
        return feedback
    }
    
    static func getVakantieFromFeedback(vakantieId: String) -> Vakantie {
        
        var query = PFQuery(className: "Vakantie")
        
        query.fromLocalDatastore()
        
        var vakantieObject = query.getObjectWithId(vakantieId)
        
        return self.getVakantie(vakantieObject)
    }
    
    static func getOuderFromFeedback(ouderId: String) -> Gebruiker? {
        
        var query = PFQuery(className: "Ouder")
        
        query.whereKey("objectId", equalTo: ouderId)
        query.fromLocalDatastore()
        
        var count = query.countObjects()
        
        if count == 0 {
            return nil
        } else {
            var ouderObject = query.getFirstObject()
            return self.getGebruiker(ouderObject)
        }
    }
    
    static func getMonitorFromFeedback(monitorId: String) -> Gebruiker? {
        
        var query = PFQuery(className: "Monitor")
        
        query.whereKey("objectId", equalTo: monitorId)
        query.fromLocalDatastore()
        
        var count = query.countObjects()
        
        if count == 0 {
            return nil
        } else {
            var monitorObject = query.getFirstObject()
            return self.getGebruiker(monitorObject)
        }
    }
    
    static func getGebruiker(gebruikerObject: PFObject) -> Gebruiker {
        var gebruiker: Gebruiker = Gebruiker(id: gebruikerObject.objectId)
        
        gebruiker.rijksregisterNr = gebruikerObject["rijksregisterNr"] as? String
        gebruiker.email = gebruikerObject["email"] as? String
        gebruiker.voornaam = gebruikerObject["voornaam"] as? String
        gebruiker.naam = gebruikerObject["naam"] as? String
        gebruiker.straat = gebruikerObject["straat"] as? String
        gebruiker.nummer = gebruikerObject["nummer"] as? Int
        
        if gebruikerObject["bus"] != nil {
            gebruiker.bus = gebruikerObject["bus"] as? String
        } else {
            gebruiker.bus = ""
        }
        
        gebruiker.gemeente = gebruikerObject["gemeente"] as? String
        gebruiker.postcode = gebruikerObject["postcode"] as? Int
        
        if gebruikerObject["telefoon"] != nil {
            gebruiker.telefoon = gebruikerObject["telefoon"] as? String
        } else {
            gebruiker.telefoon = ""
        }
        
        gebruiker.gsm = gebruikerObject["gsm"] as? String
        
        if gebruikerObject["aansluitingsNr"] != nil {
            gebruiker.aansluitingsNr = gebruikerObject["aansluitingsNr"] as? Int
        } else {
            gebruiker.aansluitingsNr = 0
        }
        
        if gebruikerObject["codeGerechtigde"] != nil {
            gebruiker.codeGerechtigde = gebruikerObject["codeGerechtigde"] as? Int
        } else {
            gebruiker.codeGerechtigde = 0
        }
        
        return gebruiker
    }
    
    static func getAfbeelding(vakantieId: String) -> UIImage {
        var query = PFQuery(className: "Afbeelding")
        query.whereKey("vakantie", equalTo: vakantieId)
        
        query.fromLocalDatastore()
        
        var afbeeldingenObjects: [PFObject] = []
        var afbeeldingFile: PFFile
        var afbeelding: UIImage
        var afbeeldingen: [UIImage] = []
        
        afbeeldingenObjects = query.findObjects() as [PFObject]
        
        for afbeeldingO in afbeeldingenObjects {
            afbeeldingFile = afbeeldingO["afbeelding"] as PFFile
            afbeelding = UIImage(data: afbeeldingFile.getData())!
            afbeeldingen.append(afbeelding)
        }
        
        return afbeeldingen[0]
    }
    
    static func printError(methode: String, tableName: String) {
        var error: String = ""
        
        error.extend("ERROR: class: LocalDatastore.swift, methode: ")
        error.extend(methode)
        error.extend(", table: ")
        error.extend(tableName)
        
        println(error)
    }
    
    static func printError(methode: String, tableName: String, extraInfo: String) {
        var error: String = ""
        
        error.extend("ERROR: class: LocalDatastore.swift, methode: ")
        error.extend(methode)
        error.extend(", table: ")
        error.extend(tableName)
        error.extend(", extra info: ")
        error.extend(extraInfo)
        
        println(error)
    }
    
    static func getGebruikerWithEmail(email: String, tableName: String) -> Gebruiker {
        var query = PFQuery(className: tableName)
        
        query.whereKey("email", equalTo: email)
        
        query.fromLocalDatastore()
        
        var object = query.getFirstObject()
        
        return self.getGebruiker(object)
    }
    
    static func isFavorieteVakantie(favoriet: Favoriet) -> Bool {
        var query = PFQuery(className: "Favoriet")
        
        query.whereKey("vakantie", equalTo: favoriet.vakantie?.id)
        query.whereKey("gebruiker", equalTo: favoriet.gebruiker?.id)
        
        query.fromLocalDatastore()
        
        var count = query.countObjects()
        
        if count == 0 {
            return false
        }
        return true
    }
    
    static func getAfbeeldingenMetVakantie(vakantieId: String) -> [UIImage] {
        var query = PFQuery(className: "Afbeelding")
        
        query.whereKey("vakantie", equalTo: vakantieId)
        
        query.fromLocalDatastore()
        
        var objects = query.findObjects() as [PFObject]
        
        var afbeeldingen: [UIImage] = []
        var afbeeldingFile: PFFile
        var afbeelding: UIImage
        
        for object in objects {
            afbeeldingFile = object["afbeelding"] as PFFile
            afbeelding = UIImage(data: afbeeldingFile.getData())!
            afbeeldingen.append(afbeelding)
        }
        
        return afbeeldingen
    }
    
    static func getLocalObjects(tableName: String) -> [AnyObject] {
        
        var query = self.makeQuery(tableName, local: true, queryConstraints: [:])
        
        var localObjects = query.findObjects() as [PFObject]
        
        return getObjecten(localObjects, tableName: tableName)
    }
    
    static func getLocalObjectsWithColumnConstraints(tableName: String, queryConstraints: [String: String]) -> [AnyObject] {
        
        var query = self.makeQuery(tableName, local: true, queryConstraints: queryConstraints)
        
        var localObjects = query.findObjects() as [PFObject]
        
        return self.getObjecten(localObjects, tableName: tableName)
    }
    
    static func getObjecten(objects: [PFObject], tableName: String) -> [AnyObject] {
        var objecten: [AnyObject] = []
        
        for object in objects {
            if tableName == "Vakantie" {
                var vakantie = getVakantie(object)
                objecten.append(vakantie)
            } else if tableName == "Feedback" {
                var feedback = getFeedback(object)
                objecten.append(feedback)
            }
        }
        
        return objecten
    }
    
    static func parseLocalObject(object: AnyObject, tableName: String) {
        
        var pfObject: PFObject
        
        if tableName == "Favoriet" {
            pfObject = getFavorietObject(object as Favoriet)
        } else {
            //RANDOM GEKOZEN!
            pfObject = getFavorietObject(object as Favoriet)
        }
        
        if Reachability.isConnectedToNetwork() == true {
            pfObject.save()
        } else {
            pfObject.saveEventually()
        }
    }
    
    static func getFavorietObject(favoriet: Favoriet) -> PFObject {
        var object: PFObject = PFObject(className: "Favoriet")
        
        object["vakantie"] = favoriet.vakantie?.id
        object["gebruiker"] = favoriet.gebruiker?.id
        
        return object
    }
    
    static func isRijksregisternummerAlGeregistreerd(rijksregisternummer: String) -> Bool {
        var queryOuder = self.makeQuery("Ouder", local: true, queryConstraints: ["rijksregisterNr": rijksregisternummer])
        
        var aantalOuders = queryOuder.countObjects()
        
        if aantalOuders != 0 {
            return true
        } else {
            var queryMonitor = self.makeQuery("Monitor", local: true, queryConstraints: ["rijksregisterNr": rijksregisternummer])
            
            var aantalMonitors = queryMonitor.countObjects()
            
            if aantalMonitors != 0 {
                return true
            }
            return false
        }
    }
    
    static func isGsmAlGeregistreerd(gsm: String) -> Bool {
        var queryOuder = self.makeQuery("Ouder", local: true, queryConstraints: ["gsm": gsm])
        
        var aantalOuders = queryOuder.countObjects()
        
        if aantalOuders != 0 {
            return true
        } else {
            var queryMonitor = self.makeQuery("Monitor", local: true, queryConstraints: ["gsm": gsm])
            
            var aantalMonitors = queryMonitor.countObjects()
            
            if aantalMonitors != 0 {
                return true
            }
            return false
        }
    }
    
    static func isEmailAlGeregistreerd(email: String) -> Bool {
        var queryOuder = self.makeQuery("Ouder", local: true, queryConstraints: ["email": email])
        
        var aantalOuders = queryOuder.countObjects()
        
        if aantalOuders != 0 {
            return true
        } else {
            var queryMonitor = self.makeQuery("Monitor", local: true, queryConstraints: ["email": email])
            
            var aantalMonitors = queryMonitor.countObjects()
            
            if aantalMonitors != 0 {
                return true
            }
            return false
        }
    }
    
    static func pinOuder(ouder: Ouder, wachtwoord: String) {
        var object = PFObject(className: "Ouder")
        
        object.setValue(ouder.email, forKey: "email")
        object.setValue(ouder.voornaam, forKey: "voornaam")
        object.setValue(ouder.naam, forKey: "naam")
        object.setValue(ouder.straat, forKey: "straat")
        object.setValue(ouder.nummer, forKey: "nummer")
        object.setValue(ouder.postcode, forKey: "postcode")
        object.setValue(ouder.gemeente, forKey: "gemeente")
        object.setValue(ouder.gsm, forKey: "gsm")
        object.setValue(ouder.rijksregisterNr, forKey: "rijksregisterNr")
        
        if ouder.aansluitingsNr != nil {
            object.setValue(ouder.aansluitingsNr, forKey: "aansluitingsNr")
            object.setValue(ouder.codeGerechtigde, forKey: "codeGerechtigde")
            
            if ouder.aansluitingsNrTweedeOuder != nil {
                object.setValue(ouder.aansluitingsNrTweedeOuder, forKey: "aansluitingsNrTweedeOuder")
            }
        }
        
        if ouder.bus != nil {
            object.setValue(ouder.bus, forKey: "bus")
        }
        
        if ouder.telefoon != nil {
            object.setValue(ouder.telefoon, forKey: "telefoon")
        }
        
        if Reachability.isConnectedToNetwork() == true {
            object.save()
        } else {
            object.saveEventually()
        }
        
        createPFUser(ouder, wachtwoord: wachtwoord)
        logIn(ouder, wachtwoord: wachtwoord)
    }
    
    static private func createPFUser(ouder: Ouder, wachtwoord: String) {
        var user = PFUser()
        user.username = ouder.email
        user.password = wachtwoord
        user.email = ouder.email
        user["soort"] = "ouder"
        
        if Reachability.isConnectedToNetwork() == true {
            user.signUp()
        } else {
            user.saveEventually()
        }
    }
    
    static private func logIn(ouder: Ouder, wachtwoord: String) {
        PFUser.logInWithUsername(ouder.email, password: wachtwoord)
    }
    
    static func deleteFavorieteVakantie(favoriet: Favoriet) {
        var queryConstraints: [String: String] = [:]
        
        queryConstraints["vakantie"] = favoriet.vakantie?.id
        queryConstraints["gebruiker"] = favoriet.gebruiker?.id
        
        var query = self.makeQuery("Favoriet", local: true, queryConstraints: queryConstraints)
        
        var object = query.getFirstObject()
        object.unpin()
        
        if Reachability.isConnectedToNetwork() == true {
            object.delete()
        } else {
            object.deleteEventually()
        }
    }
    
    static func bestaatInschrijvingVakantieAl(inschrijving: InschrijvingVakantie) -> Bool {
        
        var bestaatDeelnemerAl = self.bestaatDeelnemerAl(inschrijving.deelnemer!)
        
        if bestaatDeelnemerAl == true {
            var deelnemerObject = getDeelnemerWithId(inschrijving.deelnemer!)
            
            if self.bestaatInschrijvingAlLocal(deelnemerObject.objectId, inschrijving: inschrijving) == true {
                return true
            }
        }
        
        return false
    }
    
    static func bestaatDeelnemerAl(deelnemer: Deelnemer) -> Bool {
        
        var queryConstraints: [String: String] = [:]
        
        queryConstraints["voornaam"] = deelnemer.voornaam
        queryConstraints["naam"] = deelnemer.naam
        
        var query = self.makeQuery("Deelnemer", local: true, queryConstraints: queryConstraints)
        
        var count = query.countObjects()
        
        if count == 0 {
            return false
        }
        return true
    }
    
    static func getDeelnemerWithId(deelnemer: Deelnemer) -> PFObject {
        
        var queryConstraints: [String: String] = [:]
        
        queryConstraints["voornaam"] = deelnemer.voornaam
        queryConstraints["naam"] = deelnemer.naam
        
        var query = self.makeQuery("Deelnemer", local: true, queryConstraints: queryConstraints)
        
        return query.getFirstObject()
    }
    
    static func bestaatInschrijvingAlLocal(deelnemerId: String, inschrijving: InschrijvingVakantie) -> Bool
    {
        var queryConstraints: [String: String] = [:]
        
        queryConstraints["deelnemer"] = deelnemerId
        queryConstraints["vakantie"] = inschrijving.vakantie?.id
        queryConstraints["ouder"] = inschrijving.ouder?.id
        
        var query = self.makeQuery("InschrijvingVakantie", local: true, queryConstraints: queryConstraints)
        
        var count = query.countObjects()
        
        if count == 0 {
            return false
        }
        return true
    }
    
    static func getOuderWithEmail(email: String) -> Ouder {
        
        var queryConstraints: [String: String] = [:]
        
        queryConstraints["email"] = email
        
        var query = self.makeQuery("Ouder", local: true, queryConstraints: queryConstraints)
        
        var object = query.getFirstObject()
        
        return getOuder(object)
    }
    
    static func getOuder(object: PFObject) -> Ouder {
        var ouder: Ouder = Ouder(id: object.objectId)
        
        ouder.rijksregisterNr = object["rijksregisterNr"] as? String
        ouder.email = object["email"] as? String
        ouder.voornaam = object["voornaam"] as? String
        ouder.naam = object["naam"] as? String
        ouder.straat = object["straat"] as? String
        ouder.nummer = object["nummer"] as? Int
        
        if object["bus"] != nil {
            ouder.bus = object["bus"] as? String
        } else {
            ouder.bus = ""
        }
        
        ouder.gemeente = object["gemeente"] as? String
        ouder.postcode = object["postcode"] as? Int
        
        if object["telefoon"] != nil {
            ouder.telefoon = object["telefoon"] as? String
        } else {
            ouder.telefoon = ""
        }
        
        ouder.gsm = object["gsm"] as? String
        
        if object["aansluitingsNr"] != nil {
            ouder.aansluitingsNr = object["aansluitingsNr"] as? Int
        } else {
            ouder.aansluitingsNr = 0
        }
        
        if object["codeGerechtigde"] != nil {
            ouder.codeGerechtigde = object["codeGerechtigde"] as? Int
        } else {
            ouder.codeGerechtigde = 0
        }
        
        if object["aansluitingsNrTweedeOuder"] != nil {
            ouder.aansluitingsNrTweedeOuder = object["aansluitingsNrTweedeOuder"] as? Int
        } else {
            ouder.aansluitingsNrTweedeOuder = 0
        }
        
        return ouder
    }
    
    static func parseDeelnemerToDatabase(deelnemer: Deelnemer) -> String {
        var object = PFObject(className: "Deelnemer")
        
        object.setValue(deelnemer.voornaam, forKey: "voornaam")
        object.setValue(deelnemer.naam, forKey: "naam")
        object.setValue(deelnemer.geboortedatum, forKey: "geboortedatum")
        object.setValue(deelnemer.straat, forKey: "straat")
        object.setValue(deelnemer.nummer, forKey: "nummer")
        object.setValue(deelnemer.gemeente, forKey: "gemeente")
        object.setValue(deelnemer.postcode, forKey: "postcode")
        
        if deelnemer.bus != nil {
            object.setValue(deelnemer.bus, forKey: "bus")
        }
        
        object.save()
        object.fetch()
        
        return object.objectId
    }

    static func parseContactpersoonNoodToDatabase(contactpersoon: ContactpersoonNood) -> String {
        var object = PFObject(className: "ContactpersoonNood")
        
        object.setValue(contactpersoon.voornaam, forKey: "voornaam")
        object.setValue(contactpersoon.naam, forKey: "naam")
        object.setValue(contactpersoon.gsm, forKey: "gsm")
        
        if contactpersoon.telefoon != nil {
            object.setValue(contactpersoon.telefoon, forKey: "telefoon")
        }
        
        object.save()
        object.fetch()
        
        return object.objectId
    }
    
    static func parseInschrijvingVakantieToDatabase(inschrijving: InschrijvingVakantie) {
        var object = PFObject(className: "InschrijvingVakantie")
        
        object.setValue(inschrijving.vakantie?.id, forKey: "vakantie")
        object.setValue(inschrijving.ouder?.id, forKey: "ouder")
        object.setValue(inschrijving.deelnemer?.id, forKey: "deelnemer")
        object.setValue(inschrijving.contactpersoon1?.id, forKey: "contactpersoon1")
        
        
        if inschrijving.extraInfo != "" {
            object.setValue(inschrijving.extraInfo, forKey: "extraInformatie")
        }
        
        if inschrijving.contactpersoon2 != nil {
            object.setValue(inschrijving.contactpersoon2?.id, forKey: "contactpersoon2")
        }
        
        object.save()
    }

}










