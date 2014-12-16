import Foundation

struct LocalDatastore {
    
    //
    //Function: makeQuery
    //
    //
    //
    //Parameters:
    //  - tableName: String - naam van de tabel waar de query moet op uitgevoerd worden
    //  - local: bool       - true als de query op de local datastore moet uitgevoerd worden
    //                      - false als de query op de online database van Parse.com moet uitgevoerd
    //                        worden
    //  - queryConstraints: - Dictionary[String: String]
    //                      - Eerste argument: naam van de column
    //                      - Tweede argument: variabele waarop moet vergeleken worden
    //
    //Return: een query met de opgegeven parameters
    //
    static private func makeQuery(tableName: String, local: Bool,
        soortConstraints: [String: String] = [:], equalTo: [String: String] = [:],
        notContainedIn: [String: [AnyObject]] = [:], notEqualTo: [String: String] = [:], containedIn: [String: [AnyObject]] = [:]) -> PFQuery
    {
        var query = PFQuery(className: tableName)
        
        for soortConstraint in soortConstraints {
        
            //soortConstraint.0 = column name
            //soortConstraint.1 = soort constraint (equalTo of notContainedIn)
            
            if soortConstraint.1 == Constanten.CONSTRAINT_EQUALTO {
                query = self.addQueryConstraintEqualTo(query, columnName: soortConstraint.0, columnValue: equalTo[soortConstraint.0]!)
            } else if soortConstraint.1 == Constanten.CONSTRAINT_NOTCONTAINEDIN {
                query = self.addQueryConstraintNotContainedIn(query, columnName: soortConstraint.0, columnValues: notContainedIn[soortConstraint.0]!)
            } else if soortConstraint.1 == Constanten.CONSTRAINT_NOTEQUALTO {
                query = self.addQueryConstraintNotEqualTo(query, columnName: soortConstraint.0, columnValue: notEqualTo[soortConstraint.0]!)
            } else if soortConstraint.1 == Constanten.CONSTRAINT_CONTAINEDIN {
                query = self.addQueryConstraintContainedIn(query, columnName: soortConstraint.0, columnValues: containedIn[soortConstraint.0]!)
            }
        }
        
        if local == true {
            query.fromLocalDatastore()
        }
        
        return query
    }
    
    static private func addQueryConstraintEqualTo(query: PFQuery, columnName: String,
        columnValue: String) -> PFQuery
    {
        query.whereKey(columnName, equalTo: columnValue)
        return query
    }
    
    static private func addQueryConstraintNotContainedIn(query: PFQuery, columnName: String, columnValues: [AnyObject]) -> PFQuery
    {
        query.whereKey(columnName, notContainedIn: columnValues)
        return query
    }
    
    static private func addQueryConstraintNotEqualTo(query: PFQuery, columnName: String,
        columnValue: String) -> PFQuery
    {
        query.whereKey(columnName, notEqualTo: columnValue)
        return query
    }
    
    static private func addQueryConstraintContainedIn(query: PFQuery, columnName: String, columnValues: [AnyObject]) -> PFQuery
    {
        query.whereKey(columnName, containedIn: columnValues)
        return query
    }
    
    static private func getObjecten(objects: [PFObject], tableName: String) -> [AnyObject] {
        var objecten: [AnyObject] = []
        
        for object in objects {
            if tableName == Constanten.TABLE_AFBEELDING {
                var afbeelding = self.getAfbeelding(object)
                objecten.append(afbeelding)
            } else if tableName == Constanten.TABLE_VAKANTIE {
                var vakantie = self.getVakantie(object)
                objecten.append(vakantie)
            } else if tableName == Constanten.TABLE_FEEDBACK {
                var feedback = self.getFeedback(object)
                objecten.append(feedback)
            } else if tableName == Constanten.TABLE_VORMING {
                var vorming = self.getVorming(object)
                objecten.append(vorming)
            } else if tableName == Constanten.TABLE_OUDER {
                var ouder = self.getOuder(object)
                objecten.append(ouder)
            } else if tableName == Constanten.TABLE_MONITOR {
                var monitor = self.getMonitor(object)
                objecten.append(monitor)
            } else if tableName == Constanten.TABLE_DEELNEMER {
                var deelnemer = self.getDeelnemer(object)
                objecten.append(deelnemer)
            }
        }
        
        return objecten
    }
    
    static private func getObject(object: PFObject, tableName: String) -> AnyObject {
        
        if tableName == Constanten.TABLE_AFBEELDING {
            return self.getAfbeelding(object)
        } else if tableName == Constanten.TABLE_VAKANTIE {
            return self.getVakantie(object)
        } else if tableName == Constanten.TABLE_FEEDBACK {
            return self.getFeedback(object)
        } else if tableName == Constanten.TABLE_VORMING {
            return self.getVorming(object)
        } else if tableName == Constanten.TABLE_OUDER {
            return self.getOuder(object)
        } else if tableName == Constanten.TABLE_MONITOR {
            return self.getMonitor(object)
        } else if tableName == Constanten.TABLE_DEELNEMER{
            return self.getDeelnemer(object)
        } else {
            //RANDOM GEKOZEN!!!!!
            return self.getVorming(object)
        }
    }
    
    static func getLocalObjects(tableName: String) -> [AnyObject] {
        
        var query = self.makeQuery(tableName, local: true)
        
        var localObjects = query.findObjects() as [PFObject]
        
        return self.getObjecten(localObjects, tableName: tableName)
    }
    
    static func getLocalObjectsWithColumnConstraints(tableName: String, soortConstraints: [String: String], equalToConstraints: [String: String] = [:], notContainedInConstraints: [String: [AnyObject]] = [:], notEqualToConstraints: [String: String] = [:], containedInConstraints: [String: [AnyObject]] = [:]) -> [AnyObject] {
        
        var query = self.makeQuery(tableName, local: true, soortConstraints: soortConstraints, equalTo: equalToConstraints, notContainedIn: notContainedInConstraints, notEqualTo: notEqualToConstraints, containedIn: containedInConstraints)
        
        var localObjects = query.findObjects() as [PFObject]
        
        return self.getObjecten(localObjects, tableName: tableName)
    }
    
    static func getLocalObjectWithColumnConstraints(tableName: String, soortConstraints: [String: String], equalToConstraints: [String: String] = [:], notContainedInConstraints: [String: [AnyObject]] = [:], notEqualToConstraints: [String: String] = [:], containedInConstraints: [String: [AnyObject]] = [:]) -> AnyObject {
        
        var query = self.makeQuery(tableName, local: true, soortConstraints: soortConstraints, equalTo: equalToConstraints, notContainedIn: notContainedInConstraints, notEqualTo: notEqualToConstraints, containedIn: containedInConstraints)
        
        var localObject = query.getFirstObject()
        
        return self.getObject(localObject, tableName: tableName)
    }
    
    static func bestaatLocalObjectWithConstraints(tableName: String, soortConstraints: [String: String], equalToConstraints: [String: String] = [:], notContainedInConstraints: [String: [AnyObject]] = [:], notEqualToConstraints: [String: String] = [:], containedInConstraints: [String: [AnyObject]] = [:]) -> Bool {
        
        var query = self.makeQuery(tableName, local: true, soortConstraints: soortConstraints, equalTo: equalToConstraints, notContainedIn: notContainedInConstraints)
        
        var count = query.countObjects()
        
        if count == 0 {
            return false
        }
        return true
    }
    
    static func bestaanLocalObjectsWithConstraints(tableName: String, soortConstraints: [String: String], equalToConstraints: [String: String] = [:], notContainedInConstraints: [String: [AnyObject]] = [:], notEqualToConstraints: [String: String] = [:], containedInConstraints: [String: [AnyObject]] = [:]) -> Bool {
        
        var query = self.makeQuery(tableName, local: true, soortConstraints: soortConstraints, equalTo: equalToConstraints, notContainedIn: notContainedInConstraints)
        
        var count = query.countObjects()
        
        if count == 0 {
            return false
        }
        return true
    }
    
    static func isEmpty(tableName: String) -> Bool {
        var query = PFQuery(className: tableName)
        
        query.fromLocalDatastore()
        
        var count = query.countObjects()
        
        if count == 0 {
            return true
        }
        
        return false
    }
    
    static func getTableReady(tableName: String) {
        
        if Reachability.isConnectedToNetwork() == true {
            self.unpinLocalObjects(tableName)
            self.fillTable(tableName)
        }
    }
    
    static private func unpinLocalObjects(tableName: String) {
        var query = self.makeQuery(tableName, local: true)
        
        var objects = query.findObjects() as [PFObject]
        
        PFObject.unpinAll(objects)
    }
    
    static private func fillTable(tableName: String) {
        var query = self.makeQuery(tableName, local: false)
        
        var objects: [PFObject] = []
        
        objects = query.findObjects() as [PFObject]
        
        PFObject.pinAll(objects)
    }
    
    static private func getAfbeelding(object: PFObject) -> UIImage {
        
        var imageFile = object["afbeelding"] as PFFile
        var image = UIImage(data: imageFile.getData())!
        return image
    }
    
    static private func getDeelnemer(object: PFObject) -> Deelnemer {
        var deelnemer: Deelnemer = Deelnemer(id: object.objectId)
        
        deelnemer.voornaam = object[Constanten.COLUMN_VOORNAAM] as? String
        deelnemer.naam = object[Constanten.COLUMN_NAAM] as? String
        deelnemer.straat = object[Constanten.COLUMN_STRAAT] as? String
        deelnemer.nummer = object[Constanten.COLUMN_NUMMER] as? Int
        
        if object[Constanten.COLUMN_BUS] != nil {
            deelnemer.bus = object[Constanten.COLUMN_BUS] as? String
        } else {
            deelnemer.bus = ""
        }
        
        deelnemer.gemeente = object[Constanten.COLUMN_GEMEENTE] as? String
        deelnemer.postcode = object[Constanten.COLUMN_POSTCODE] as? Int
        deelnemer.geboortedatum = object[Constanten.COLUMN_GEBOORTEDATUM] as? NSDate
        
        return deelnemer
    }
    
    static private func getFeedback(object: PFObject) -> Feedback {
        
        var feedback: Feedback = Feedback(id: object.objectId)
        
        var vakantieId: String = object[Constanten.COLUMN_VAKANTIE] as String
        var gebruikerId: String = object[Constanten.COLUMN_GEBRUIKER] as String
        var monitor: Gebruiker = Gebruiker(id: gebruikerId)
        
        feedback.vakantie = self.getLocalObjectWithColumnConstraints(Constanten.TABLE_VAKANTIE, soortConstraints: [Constanten.COLUMN_VAKANTIE: Constanten.CONSTRAINT_EQUALTO], equalToConstraints: [Constanten.COLUMN_VAKANTIE: vakantieId]) as? Vakantie
        
        var bestaatOuder = self.bestaatLocalObjectWithConstraints(Constanten.TABLE_OUDER, soortConstraints: [Constanten.COLUMN_OBJECTID: Constanten.CONSTRAINT_EQUALTO], equalToConstraints: [Constanten.COLUMN_OBJECTID: gebruikerId])
        
        if bestaatOuder == true {
            feedback.gebruiker = self.getLocalObjectWithColumnConstraints(Constanten.TABLE_OUDER, soortConstraints: [Constanten.COLUMN_OBJECTID: Constanten.CONSTRAINT_EQUALTO], equalToConstraints: [Constanten.COLUMN_OBJECTID: gebruikerId]) as Ouder
        } else {
            feedback.gebruiker = self.getLocalObjectWithColumnConstraints(Constanten.TABLE_MONITOR, soortConstraints: [Constanten.COLUMN_OBJECTID: Constanten.CONSTRAINT_EQUALTO], equalToConstraints: [Constanten.COLUMN_OBJECTID: gebruikerId]) as Monitor
        }
        
        feedback.datum = object[Constanten.COLUMN_DATUM] as? NSDate
        feedback.goedgekeurd = object[Constanten.COLUMN_GOEDGEKEURD] as? Bool
        feedback.waardering = object[Constanten.COLUMN_WAARDERING] as? String
        feedback.score = object[Constanten.COLUMN_SCORE] as? Int
        
        return feedback
    }
    
    static private func getGebruiker(object: PFObject) -> Gebruiker {
        var gebruiker: Gebruiker = Gebruiker(id: object.objectId)
        
        gebruiker.rijksregisterNr = object[Constanten.COLUMN_RIJKSREGISTERNUMMER] as? String
        gebruiker.email = object[Constanten.COLUMN_EMAIL] as? String
        gebruiker.voornaam = object[Constanten.COLUMN_VOORNAAM] as? String
        gebruiker.naam = object[Constanten.COLUMN_NAAM] as? String
        gebruiker.straat = object[Constanten.COLUMN_STRAAT] as? String
        gebruiker.nummer = object[Constanten.COLUMN_NUMMER] as? Int
        
        if object[Constanten.COLUMN_BUS] != nil {
            gebruiker.bus = object[Constanten.COLUMN_BUS] as? String
        } else {
            gebruiker.bus = ""
        }
        
        gebruiker.gemeente = object[Constanten.COLUMN_GEMEENTE] as? String
        gebruiker.postcode = object[Constanten.COLUMN_POSTCODE] as? Int
        
        if object[Constanten.COLUMN_TELEFOON] != nil {
            gebruiker.telefoon = object[Constanten.COLUMN_TELEFOON] as? String
        } else {
            gebruiker.telefoon = ""
        }
        
        gebruiker.gsm = object[Constanten.COLUMN_GSM] as? String
        
        if object[Constanten.COLUMN_AANSLUITINGSNUMMER] != nil {
            gebruiker.aansluitingsNr = object[Constanten.COLUMN_AANSLUITINGSNUMMER] as? Int
        } else {
            gebruiker.aansluitingsNr = 0
        }
        
        if object[Constanten.COLUMN_CODEGERECHTIGDE] != nil {
            gebruiker.codeGerechtigde = object[Constanten.COLUMN_CODEGERECHTIGDE] as? Int
        } else {
            gebruiker.codeGerechtigde = 0
        }
        
        return gebruiker
    }
    
    static private func getMonitor(object: PFObject) -> Monitor {
        
        var monitor = self.getGebruiker(object) as Monitor
        
        //var monitor: Monitor = Monitor(id: object.objectId)
        
        /*monitor.rijksregisterNr = object[Constanten.COLUMN_RIJKSREGISTERNUMMER] as? String
        monitor.email = object[Constanten.COLUMN_EMAIL] as? String
        monitor.voornaam = object[Constanten.COLUMN_VOORNAAM] as? String
        monitor.naam = object[Constanten.COLUMN_NAAM] as? String
        monitor.straat = object[Constanten.COLUMN_STRAAT] as? String
        monitor.nummer = object[Constanten.COLUMN_NUMMER] as? Int
        
        if object[Constanten.COLUMN_BUS] != nil {
            monitor.bus = object[Constanten.COLUMN_BUS] as? String
        } else {
            monitor.bus = ""
        }
        
        monitor.gemeente = object[Constanten.COLUMN_GEMEENTE] as? String
        monitor.postcode = object[Constanten.COLUMN_POSTCODE] as? Int
        
        if object[Constanten.COLUMN_TELEFOON] != nil {
            monitor.telefoon = object[Constanten.COLUMN_TELEFOON] as? String
        } else {
            monitor.telefoon = ""
        }
        
        monitor.gsm = object[Constanten.COLUMN_GSM] as? String
        
        if object[Constanten.COLUMN_AANSLUITINGSNUMMER] != nil {
            monitor.aansluitingsNr = object[Constanten.COLUMN_AANSLUITINGSNUMMER] as? Int
        } else {
            monitor.aansluitingsNr = 0
        }
        
        if object[Constanten.COLUMN_CODEGERECHTIGDE] != nil {
            monitor.codeGerechtigde = object[Constanten.COLUMN_CODEGERECHTIGDE] as? Int
        } else {
            monitor.codeGerechtigde = 0
        }*/
        
        if object[Constanten.COLUMN_LIDNUMMER] != nil {
            monitor.lidNr = object[Constanten.COLUMN_LIDNUMMER] as? String
        } else {
            monitor.lidNr = ""
        }
        
        return monitor
    }
    
    static private func getOuder(object: PFObject) -> Ouder {
        
        var ouder = self.getGebruiker(object) as Ouder
        
        /*var ouder: Ouder = Ouder(id: object.objectId)
        
        ouder.rijksregisterNr = object[Constanten.COLUMN_RIJKSREGISTERNUMMER] as? String
        ouder.email = object[Constanten.COLUMN_EMAIL] as? String
        ouder.voornaam = object[Constanten.COLUMN_VOORNAAM] as? String
        ouder.naam = object[Constanten.COLUMN_NAAM] as? String
        ouder.straat = object[Constanten.COLUMN_STRAAT] as? String
        ouder.nummer = object[Constanten.COLUMN_NUMMER] as? Int
        
        if object[Constanten.COLUMN_BUS] != nil {
            ouder.bus = object[Constanten.COLUMN_BUS] as? String
        } else {
            ouder.bus = ""
        }
        
        ouder.gemeente = object[Constanten.COLUMN_GEMEENTE] as? String
        ouder.postcode = object[Constanten.COLUMN_POSTCODE] as? Int
        
        if object[Constanten.COLUMN_TELEFOON] != nil {
            ouder.telefoon = object[Constanten.COLUMN_TELEFOON] as? String
        } else {
            ouder.telefoon = ""
        }
        
        ouder.gsm = object[Constanten.COLUMN_GSM] as? String
        
        if object[Constanten.COLUMN_AANSLUITINGSNUMMER] != nil {
            ouder.aansluitingsNr = object[Constanten.COLUMN_AANSLUITINGSNUMMER] as? Int
        } else {
            ouder.aansluitingsNr = 0
        }
        
        if object[Constanten.COLUMN_CODEGERECHTIGDE] != nil {
            ouder.codeGerechtigde = object[Constanten.COLUMN_CODEGERECHTIGDE] as? Int
        } else {
            ouder.codeGerechtigde = 0
        }*/
        
        if object[Constanten.COLUMN_AANSLUITINGSNUMMERTWEEDEOUDER] != nil {
            ouder.aansluitingsNrTweedeOuder = object[Constanten.COLUMN_AANSLUITINGSNUMMERTWEEDEOUDER] as? Int
        } else {
            ouder.aansluitingsNrTweedeOuder = 0
        }
        
        return ouder
    }
    
    static private func getVakantie(object: PFObject) -> Vakantie {
        var vakantie: Vakantie = Vakantie(id: object.objectId)
        
        vakantie.titel = object[Constanten.COLUMN_TITEL] as? String
        vakantie.locatie = object[Constanten.COLUMN_LOCATIE] as? String
        vakantie.korteBeschrijving = object[Constanten.COLUMN_KORTEBESCHRIJVING] as? String
        vakantie.vertrekdatum = object[Constanten.COLUMN_VERTREKDATUM] as NSDate
        vakantie.terugkeerdatum = object[Constanten.COLUMN_TERUGKEERDATUM] as NSDate
        vakantie.aantalDagenNachten = object[Constanten.COLUMN_AANTALDAGENNACHTEN] as? String
        vakantie.vervoerwijze = object[Constanten.COLUMN_VERVOERWIJZE] as? String
        vakantie.formule = object[Constanten.COLUMN_FORMULE] as? String
        vakantie.link = object[Constanten.COLUMN_LINK] as? String
        vakantie.basisprijs = object[Constanten.COLUMN_BASISPRIJS] as? Double
        vakantie.bondMoysonLedenPrijs = object[Constanten.COLUMN_LINK] as? Double
        vakantie.sterPrijs1ouder = object[Constanten.COLUMN_STERPRIJS1OUDER] as? Double
        vakantie.sterPrijs2ouders = object[Constanten.COLUMN_STERPRIJS2OUDERS] as? Double
        vakantie.inbegrepenPrijs = object[Constanten.COLUMN_INBEGREPENPRIJS] as? String
        vakantie.minLeeftijd = object[Constanten.COLUMN_MINLEEFTIJD] as Int
        vakantie.maxLeeftijd = object[Constanten.COLUMN_MAXLEEFTIJD] as? Int
        vakantie.maxAantalDeelnemers = object[Constanten.COLUMN_MAXAANTALDEELNEMERS] as? Int
        
        return vakantie
    }
    
    static func getVorming(object: PFObject) -> Vorming {
        var vorming: Vorming = Vorming(id: object.objectId)
        
        vorming.titel = object[Constanten.COLUMN_TITEL] as? String
        vorming.locatie = object[Constanten.COLUMN_LOCATIE] as? String
        vorming.korteBeschrijving = object[Constanten.COLUMN_KORTEBESCHRIJVING] as? String
        vorming.periodes = object[Constanten.COLUMN_PERIODES] as? Array
        vorming.prijs = object[Constanten.COLUMN_PRIJS] as? Double
        vorming.criteriaDeelnemers = object[Constanten.COLUMN_CRITERIADEELNEMERS] as? String
        //vorming.websiteLocatie = object[Constanten.COLUMN_WEBSITELOCATIE] as? String
        
        if object[Constanten.COLUMN_WEBSITELOCATIE] != nil {
            vorming.websiteLocatie = object[Constanten.COLUMN_WEBSITELOCATIE] as? String
        } else {
            vorming.websiteLocatie = ""
        }
        
        vorming.tips = object[Constanten.COLUMN_TIPS] as? String
        vorming.betalingWijze = object[Constanten.COLUMN_BETALINGSWIJZE] as? String
        vorming.inbegrepenPrijs = object[Constanten.COLUMN_INBEGREPENPRIJS] as? String
        
        return vorming
    }
    
    static func getHoofdAfbeelding(vakantieId: String) -> UIImage {
        
        var defaultImage: UIImage = UIImage(named: "joetzVakantie")!
        
        var query = self.makeQuery(Constanten.TABLE_AFBEELDING, local: true, soortConstraints: [Constanten.COLUMN_VAKANTIE: Constanten.CONSTRAINT_EQUALTO], equalTo: [Constanten.COLUMN_VAKANTIE: vakantieId])
        
        var count = query.countObjects()
        
        if count == 0 {
            return defaultImage
        } else {
            var imageObject = query.getFirstObject()
            return self.getAfbeelding(imageObject)
        }
        
        
        
        /*var query = PFQuery(className: "Afbeelding")
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
        
        return afbeeldingen[0]*/
    }
    
    static func isRijksregisternummerAlGeregistreerd(rijksregisternummer: String) -> Bool {
        var bestaatOuder = self.bestaatLocalObjectWithConstraints(Constanten.TABLE_OUDER, soortConstraints: [Constanten.COLUMN_RIJKSREGISTERNUMMER: Constanten.CONSTRAINT_EQUALTO], equalToConstraints: [Constanten.COLUMN_RIJKSREGISTERNUMMER: rijksregisternummer])
        
        var bestaatMonitor = self.bestaatLocalObjectWithConstraints(Constanten.TABLE_MONITOR, soortConstraints: [Constanten.COLUMN_RIJKSREGISTERNUMMER: Constanten.CONSTRAINT_EQUALTO], equalToConstraints: [Constanten.COLUMN_RIJKSREGISTERNUMMER: rijksregisternummer])
        
        if bestaatOuder == true || bestaatMonitor == true {
            return true
        }
        
        return false
        
        /*if aantalOuders != 0 {
            return true
        } else {
            var queryMonitor = self.makeQuery("Monitor", local: true, queryConstraints: ["rijksregisterNr": rijksregisternummer])
            
            var aantalMonitors = queryMonitor.countObjects()
            
            if aantalMonitors != 0 {
                return true
            }
            return false
        }*/
    }
    
    static func isGsmAlGeregistreerd(gsm: String) -> Bool {
        
        var bestaatOuder = self.bestaatLocalObjectWithConstraints(Constanten.TABLE_OUDER, soortConstraints: [Constanten.COLUMN_GSM: Constanten.CONSTRAINT_EQUALTO], equalToConstraints: [Constanten.COLUMN_GSM: gsm])
        
        var bestaatMonitor = self.bestaatLocalObjectWithConstraints(Constanten.TABLE_MONITOR, soortConstraints: [Constanten.COLUMN_GSM: Constanten.CONSTRAINT_EQUALTO], equalToConstraints: [Constanten.COLUMN_GSM: gsm])
        
        if bestaatOuder == true || bestaatMonitor == true {
            return true
        }
        
        return false
        
        
        /*var queryOuder = self.makeQuery("Ouder", local: true, queryConstraints: ["gsm": gsm])
        
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
        }*/
    }
    
    static func isEmailAlGeregistreerd(email: String) -> Bool {
        
        var bestaatOuder = self.bestaatLocalObjectWithConstraints(Constanten.TABLE_OUDER, soortConstraints: [Constanten.COLUMN_EMAIL: Constanten.CONSTRAINT_EQUALTO], equalToConstraints: [Constanten.COLUMN_EMAIL: email])
        
        var bestaatMonitor = self.bestaatLocalObjectWithConstraints(Constanten.TABLE_MONITOR, soortConstraints: [Constanten.COLUMN_EMAIL: Constanten.CONSTRAINT_EQUALTO], equalToConstraints: [Constanten.COLUMN_EMAIL: email])
        
        var bestaatAdministrator = self.bestaatLocalObjectWithConstraints(Constanten.TABLE_USER, soortConstraints: [Constanten.COLUMN_EMAIL: Constanten.CONSTRAINT_EQUALTO], equalToConstraints: [Constanten.COLUMN_EMAIL: email])
        
        if bestaatOuder == true || bestaatMonitor == true || bestaatAdministrator == true {
            return true
        }
        
        return false
        
        
        
        
        /*var queryOuder = self.makeQuery("Ouder", local: true, queryConstraints: ["email": email])
        
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
        }*/
    }
    
    static func deleteFavorieteVakantie(favoriet: Favoriet) {
        var soortConstraints: [String: String] = [:]
        soortConstraints[Constanten.COLUMN_VAKANTIE] = Constanten.CONSTRAINT_EQUALTO
        soortConstraints[Constanten.COLUMN_GEBRUIKER] = Constanten.CONSTRAINT_EQUALTO
        
        var equalToConstraints: [String: String] = [:]
        equalToConstraints[Constanten.COLUMN_VAKANTIE] = favoriet.vakantie?.id
        soortConstraints[Constanten.COLUMN_GEBRUIKER] = favoriet.gebruiker?.id
        
        var query = self.makeQuery(Constanten.TABLE_FAVORIET, local: true, soortConstraints: soortConstraints, equalTo: equalToConstraints)
        
        var object = query.getFirstObject()
        
        if Reachability.isConnectedToNetwork() == true {
            object.delete()
        } else {
            object.deleteEventually()
        }
        
        object.unpin()
    }
    
    static func bestaatInschrijvingVakantieAl(inschrijving: InschrijvingVakantie) -> Bool {
        
        var soortConstraintsDeelnemer: [String: String] = [:]
        soortConstraintsDeelnemer[Constanten.COLUMN_VOORNAAM] = Constanten.CONSTRAINT_EQUALTO
        soortConstraintsDeelnemer[Constanten.COLUMN_NAAM] = Constanten.CONSTRAINT_EQUALTO
        
        var equalToConstraintsDeelnemer: [String: String] = [:]
        equalToConstraintsDeelnemer[Constanten.COLUMN_VOORNAAM] = inschrijving.deelnemer?.voornaam
        soortConstraintsDeelnemer[Constanten.COLUMN_NAAM] = inschrijving.deelnemer?.naam
        
        var bestaatDeelnemer = self.bestaatLocalObjectWithConstraints(Constanten.TABLE_DEELNEMER, soortConstraints: soortConstraintsDeelnemer, equalToConstraints: equalToConstraintsDeelnemer)
        
        
        
        if bestaatDeelnemer == true {
            var deelnemerObject = self.getLocalObjectWithColumnConstraints(Constanten.TABLE_DEELNEMER, soortConstraints: soortConstraintsDeelnemer, equalToConstraints: equalToConstraintsDeelnemer) as Deelnemer
            
            var soortConstraintsInschrijving: [String: String] = [:]
            soortConstraintsInschrijving[Constanten.COLUMN_DEELNEMER] = Constanten.CONSTRAINT_EQUALTO
            soortConstraintsInschrijving[Constanten.COLUMN_VAKANTIE] = Constanten.CONSTRAINT_EQUALTO
            soortConstraintsInschrijving[Constanten.COLUMN_OUDER] = Constanten.CONSTRAINT_EQUALTO
            
            var equalToConstraintsInschrijving: [String: String] = [:]
            equalToConstraintsInschrijving[Constanten.COLUMN_DEELNEMER] = deelnemerObject.id
            equalToConstraintsInschrijving[Constanten.COLUMN_VAKANTIE] = inschrijving.vakantie?.id
            equalToConstraintsInschrijving[Constanten.COLUMN_OUDER] = inschrijving.ouder?.id
            
            var bestaatInschrijving = self.bestaatLocalObjectWithConstraints(Constanten.TABLE_INSCHRIJVINGVAKANTIE, soortConstraints: soortConstraintsInschrijving, equalToConstraints: equalToConstraintsInschrijving)
            
            if bestaatInschrijving == true {
                return true
            }
            return false
        }
        
        return false
    }
    
    
    
    
    
    static func getMonitorenMetDezelfdeVormingen(monitorId: String) -> [Monitor] {
        
        var monitoren: [Monitor] = []
        
        var heeftMonitorVormingen = self.bestaanLocalObjectsWithConstraints(Constanten.TABLE_INSCHRIJVINGVORMING, soortConstraints: [Constanten.COLUMN_MONITOR: Constanten.CONSTRAINT_EQUALTO], equalToConstraints: [Constanten.COLUMN_MONITOR: monitorId])
        
        if heeftMonitorVormingen == true {
            
            var vormingenMonitor = self.getLocalObjectWithColumnConstraints(Constanten.TABLE_INSCHRIJVINGVORMING, soortConstraints: [Constanten.COLUMN_MONITOR: Constanten.CONSTRAINT_EQUALTO], equalToConstraints: [Constanten.COLUMN_MONITOR: monitorId]) as [Vorming]
            
            var soortConstraintsAndereMonitoren: [String: String] = [:]
            soortConstraintsAndereMonitoren[Constanten.COLUMN_VORMING] = Constanten.CONSTRAINT_CONTAINEDIN
            soortConstraintsAndereMonitoren[Constanten.COLUMN_MONITOR] = Constanten.CONSTRAINT_NOTEQUALTO
            
            var mijnVormingenIds: [String] = []
            
            for vorming in vormingenMonitor {
                mijnVormingenIds.append(vorming.id)
            }
            
            var containedInConstraintsAndereMonitoren: [String: [AnyObject]] = [:]
            containedInConstraintsAndereMonitoren[Constanten.COLUMN_VORMING] = mijnVormingenIds
            
            var notEqualToConstraintsAndereMonitoren: [String: String] = [:]
            notEqualToConstraintsAndereMonitoren[Constanten.COLUMN_MONITOR] = monitorId
            
            var bestaanAndereMonitorenMetDezelfdeVormingen = self.bestaanLocalObjectsWithConstraints(Constanten.TABLE_INSCHRIJVINGVORMING, soortConstraints: soortConstraintsAndereMonitoren, equalToConstraints: notEqualToConstraintsAndereMonitoren, containedInConstraints: containedInConstraintsAndereMonitoren)
            
            
            if bestaanAndereMonitorenMetDezelfdeVormingen == true {
                monitoren = self.getLocalObjectsWithColumnConstraints(Constanten.TABLE_INSCHRIJVINGVORMING, soortConstraints: soortConstraintsAndereMonitoren, equalToConstraints: notEqualToConstraintsAndereMonitoren, containedInConstraints: containedInConstraintsAndereMonitoren) as [Monitor]
                
            }
        }
        
        return monitoren
    }
    
    
    static func getAndereMonitoren(monitors: [Monitor]) -> [Monitor] {
        
        var zelfdeMonitorenIds: [String] = []
    
        var andereMonitoren: [Monitor] = []
        
        var huidigeMonitor = self.getLocalObjectWithColumnConstraints(Constanten.TABLE_MONITOR, soortConstraints: [Constanten.COLUMN_EMAIL: Constanten.CONSTRAINT_EQUALTO], equalToConstraints: [Constanten.COLUMN_EMAIL: PFUser.currentUser().email]) as Monitor
        
        
        zelfdeMonitorenIds.append(huidigeMonitor.id!)
        
        for monitor in monitors {
            zelfdeMonitorenIds.append(monitor.id!)
        }
        
        
    
        var bestaanAndereMonitoren = self.bestaanLocalObjectsWithConstraints(Constanten.TABLE_INSCHRIJVINGVORMING, soortConstraints: [Constanten.COLUMN_MONITOR: Constanten.CONSTRAINT_NOTCONTAINEDIN], notContainedInConstraints: [Constanten.COLUMN_MONITOR: zelfdeMonitorenIds])
        
        
        if bestaanAndereMonitoren == true {
            andereMonitoren = self.getLocalObjectsWithColumnConstraints(Constanten.TABLE_INSCHRIJVINGVORMING, soortConstraints: [Constanten.COLUMN_MONITOR: Constanten.CONSTRAINT_NOTCONTAINEDIN], notContainedInConstraints: [Constanten.COLUMN_MONITOR: zelfdeMonitorenIds]) as [Monitor]
        }

        
        return andereMonitoren
    }

    /*static func getVakantieFromFeedback(vakantieId: String) -> Vakantie {
    
    var query = PFQuery(className: "Vakantie")
    
    query.fromLocalDatastore()
    
    var vakantieObject = query.getObjectWithId(vakantieId)
    
    return self.getVakantie(vakantieObject)
    }*/
    
    /*static func getOuderFromFeedback(ouderId: String) -> Gebruiker? {
    
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
    }*/
    
    /*static func getMonitorFromFeedback(monitorId: String) -> Gebruiker? {
    
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
    }*/
    
    /*static func getGebruikerWithEmail(email: String, tableName: String) -> Gebruiker {
    var query = PFQuery(className: tableName)
    
    query.whereKey("email", equalTo: email)
    
    query.fromLocalDatastore()
    
    var object = query.getFirstObject()
    
    return self.getGebruiker(object)
    }*/
    
    /*static func isFavorieteVakantie(favoriet: Favoriet) -> Bool {
    var query = PFQuery(className: "Favoriet")
    
    query.whereKey("vakantie", equalTo: favoriet.vakantie?.id)
    query.whereKey("gebruiker", equalTo: favoriet.gebruiker?.id)
    
    query.fromLocalDatastore()
    
    var count = query.countObjects()
    
    if count == 0 {
    return false
    }
    return true
    }*/
    
    /*static func getAfbeeldingenMetVakantie(vakantieId: String) -> [UIImage] {
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
    }*/
    
    /*static func parseLocalObject(tableName: String, object: AnyObject, wachtwoordOuder: String = "") {
    
    if tableName == Constanten.TABLE_OUDER {
    ParseToDatabase.parseOuderToDatabase(object as Ouder, wachtwoord: wachtwoordOuder)
    } else if tableName == Constanten.TABLE_DEELNEMER {
    ParseToDatabase.parseDeelnemerToDatabase(object as Deelnemer)
    }
    
    
    
    
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
    }*/
    
    /*static func getFavorietObject(favoriet: Favoriet) -> PFObject {
    var object: PFObject = PFObject(className: "Favoriet")
    
    object["vakantie"] = favoriet.vakantie?.id
    object["gebruiker"] = favoriet.gebruiker?.id
    
    return object
    }*/
    
    /*static func pinOuder(ouder: Ouder, wachtwoord: String) {
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
    }*/
    
    /*static func bestaatDeelnemerAl(deelnemer: Deelnemer) -> Bool {
    
    var queryConstraints: [String: String] = [:]
    
    queryConstraints["voornaam"] = deelnemer.voornaam
    queryConstraints["naam"] = deelnemer.naam
    
    var query = self.makeQuery("Deelnemer", local: true, queryConstraints: queryConstraints)
    
    var count = query.countObjects()
    
    if count == 0 {
    return false
    }
    return true
    }*/
    
    /*static func getDeelnemerWithId(deelnemer: Deelnemer) -> PFObject {
    
    var queryConstraints: [String: String] = [:]
    
    queryConstraints["voornaam"] = deelnemer.voornaam
    queryConstraints["naam"] = deelnemer.naam
    
    var query = self.makeQuery("Deelnemer", local: true, queryConstraints: queryConstraints)
    
    return query.getFirstObject()
    }*/
    
    /*static func bestaatInschrijvingAlLocal(deelnemerId: String, inschrijving: InschrijvingVakantie) -> Bool
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
    }*/
    
    /*static func getOuderWithEmail(email: String) -> Ouder {
    
    var queryConstraints: [String: String] = [:]
    
    queryConstraints["email"] = email
    
    var query = self.makeQuery("Ouder", local: true, queryConstraints: queryConstraints)
    
    var object = query.getFirstObject()
    
    return getOuder(object)
    }
    
    static func getMonitorWithEmail(email: String) -> Monitor {
    
    var queryConstraints: [String: String] = [:]
    
    queryConstraints["email"] = email
    
    var query = self.makeQuery("Monitor", local: true, queryConstraints: queryConstraints)
    
    var object = query.getFirstObject()
    
    return getMonitor(object)
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
    }*/
    
    /*static func getMonitorMetId(monitorId: String) -> Monitor {
    var query = PFQuery(className: "Monitor")
    
    query.fromLocalDatastore()
    
    var object = query.getObjectWithId(monitorId)
    
    return getMonitor(object)
    }
    
    static func getVormingIdMetMonitorId(monitorId: String) -> [String] {
    
    var query = self.makeQuery("InschrijvingVorming", local: true, queryConstraints: ["monitor": monitorId])
    
    var objects = query.findObjects() as [PFObject]
    
    var vormingenIds: [String] = []
    
    for object in objects {
    vormingenIds.append(object["vorming"] as String)
    }
    
    return vormingenIds
    }
    
    static func getMonitorsIdMetVormingId(vormingen: [String]) -> [String] {
    
    var monitorsId: [String] = []
    
    var query = PFQuery(className: "InschrijvingVorming")
    
    query.fromLocalDatastore()
    
    query.whereKey("vorming", containedIn: vormingen)
    
    var objects = query.findObjects() as [PFObject]
    
    for object in objects {
    monitorsId.append(object["monitor"] as String)
    }
    
    return monitorsId
    }*/
}










