import Foundation

struct LocalDatastore {
    
    //
    //Function: getTableReady
    //
    //Deze functie zorgt ervoor dat als er verbinding is met het internet, 
    //alle lokaal opgeslagen objecten in de local datastore worden verwijderd,
    //en alle objecten uit de online database lokaal worden opgeslagen in de local datastore.
    //
    //Parameters: - tableName: String - naam van de tabel
    //
    static func getTableReady(tableName: String) {
        
        if Reachability.isConnectedToNetwork() == true {
            self.unpinLocalObjects(tableName)
            self.fillTable(tableName)
        }
    }
    
    //
    //Function: unpinLocalObjects
    //
    //Deze functie zoekt eerst alle lokale objecten in de local datastore voor de opgegeven tabel,
    //en verwijderd deze lokale objecten, zodat de lokale tabel leeg is.
    //
    //Parameters: - tableName: String - naam van de tabel
    //
    static private func unpinLocalObjects(tableName: String) {
        
        //Alle lokale objecten uit de opgegeven tabel ophalen
        var query = PFQuery(className: tableName)
        query.fromLocalDatastore()
        var objects = query.findObjects() as [PFObject]
        
        //Alle gevonden objecten lokaal verwijderden
        PFObject.unpinAll(objects)
        
        /*var query = self.makeQuery(tableName, local: true)
        var objects = query.findObjects() as [PFObject]
        PFObject.unpinAll(objects)*/
    }
    
    //
    //Function: fillTable
    //
    //Deze functie haalt alle objecten uit de online database voor de opgegeven tabel op,
    //en slaat deze lokaal op in de local datastore.
    //
    static private func fillTable(tableName: String) {
        
        //Alle online objecten ophalen
        var query = PFQuery(className: tableName)
        var objects = query.findObjects() as [PFObject]
        
        //Alle gevonden objecten lokaal opslaan
        PFObject.pinAll(objects)
        
        /*var query = self.makeQuery(tableName, local: false)
        var objects: [PFObject] = []
        objects = query.findObjects() as [PFObject]
        PFObject.pinAll(objects)*/
    }
    
    //
    //Function: isResultSetEmpty
    //
    //Deze functie controleert of een opgegeven query resultaten oplevert.
    //
    //Parameters: - query: PFQuery - De query waarop gecontroleerd moet worden.
    //
    //Return: true als de query geen resultaten oplevert, false als de query wel resultaten oplevert
    //
    /*static func isResultSetEmpty(query: PFQuery) -> Bool {
        if query.countObjects() > 0 {
            return true
        } else {
            return false
        }
    }*/
    
    //
    //Function: query
    //
    //Deze functie maakt een query met de opgegeven constraints.
    //
    //Return: de gemaakte query
    //
    /*static func query(tableName: String, whereArgs: [String : AnyObject] = [:]) -> PFQuery {
            
        var query = PFQuery(className: tableName)
        query.fromLocalDatastore()
        
        if !whereArgs.isEmpty {
            for whereArg in whereArgs {
                query.whereKey(whereArg.0 , equalTo: whereArg.1)
            }
        }
        
        return query
    }*/
    
    //
    //Function: getFirstObject
    //
    //Deze functie haalt het eerste object van de query op en zet het om naar de juiste klasse.
    //
    //Parameters: - query: PFQuery - De query waaruit het eerste object gehaald moet worden.
    //
    //Return: een AnyObject
    //
    /*static func getFirstObject(tableName: String, query: PFQuery) -> AnyObject {
        
        var first = query.getFirstObject() as PFObject
        
        if tableName == Constanten.TABLE_AFBEELDING {
            return AfbeeldingLD.getAfbeelding(first)
        } else if tableName == Constanten.TABLE_DEELNEMER {
            return DeelnemerLD.getDeelnemer(first)
        } else if tableName == Constanten.TABLE_FAVORIET {
            return FavorietLD.getFavoriet(first)
        } else if tableName == Constanten.TABLE_FEEDBACK {
            return FeedbackLD.getFeedback(first)
        } else if tableName == Constanten.TABLE_INSCHRIJVINGVAKANTIE {
            return InschrijvingVakantieLD.getInschrijving(first)
        } else if tableName == Constanten.TABLE_INSCHRIJVINGVORMING {
            return InschrijvingVormingLD.getInschrijving(first)
        } else if tableName == Constanten.TABLE_MONITOR {
            return MonitorLD.getMonitor(first)
        } else if tableName == Constanten.TABLE_OUDER {
            return OuderLD.getOuder(first)
        } else if tableName == Constanten.TABLE_VAKANTIE {
            return VakantieLD.getVakantie(first)
        } else {
            return VormingLD.getVorming(first)
        }
    }*/
    
    //
    //Function: getObjecten
    //
    //Deze functie delegeert de omzetting van de objecten naar de juiste klassen,
    //en retourneert een array van omgezette objecten.
    //
    //Parameters: 
    //      - tableName: String
    //      - query: PFQuery
    //
    //Return: een array van AnyObject
    //
    /*static func getObjecten(tableName: String, query: PFQuery) -> [AnyObject] {
        
        var objecten = query.findObjects() as [PFObject]
        
        if tableName == Constanten.TABLE_AFBEELDING {
            return AfbeeldingLD.getAfbeeldingen(objecten)
        } else if tableName == Constanten.TABLE_DEELNEMER {
            return DeelnemerLD.getDeelnemers(objecten)
        } else if tableName == Constanten.TABLE_FAVORIET {
            return FavorietLD.getFavorieten(objecten)
        } else if tableName == Constanten.TABLE_FEEDBACK {
            return FeedbackLD.getFeedbacks(objecten)
        } else if tableName == Constanten.TABLE_INSCHRIJVINGVORMING {
            return InschrijvingVormingLD.getInschrijvingen(objecten)
        } else if tableName == Constanten.TABLE_MONITOR {
            return MonitorLD.getMonitoren(objecten)
        } else if tableName == Constanten.TABLE_OUDER {
            return OuderLD.getOuders(objecten)
        } else if tableName == Constanten.TABLE_VAKANTIE {
            return VakantieLD.getVakanties(objecten)
        } else {
            return VormingLD.getVormingen(objecten)
        }
    }*/
    
    /*static func insert(tableName: String, object: AnyObject) {
        if tableName == Constanten.TABLE_DEELNEMER {
            DeelnemerLD.insert(object as Deelnemer)
        } else if tableName == Constanten.TABLE_FAVORIET {
            FavorietLD.insert(object as Favoriet)
        } else if tableName == Constanten.TABLE_FEEDBACK {
            FeedbackLD.insert(object as Feedback)
        } else if tableName == Constanten.TABLE_INSCHRIJVINGVORMING {
            InschrijvingVormingLD.insert(object as InschrijvingVorming)
        } else if tableName == Constanten.TABLE_MONITOR {
            MonitorLD.insert(object as Monitor)
        } else {
            OuderLD.insert(object as Ouder)
        }
    }*/
    
    static func getCurrentUserSoort() -> String {
        var currentUser = PFUser.currentUser()
        var soort = currentUser["soort"] as? String
        return soort!
    }
    
    /*static func getAll(tableName: String) -> [AnyObject] {
        var query = self.query(tableName)
        return getObjecten(tableName, query: query)
    }*/
    
    
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
    /*static private func makeQuery(tableName: String, local: Bool,
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
            } else if tableName == Constanten.TABLE_INSCHRIJVINGVORMING {
                var inschrijvingVorming = self.getInschrijvingVorming(object)
                objecten.append(inschrijvingVorming)
            } else if tableName == Constanten.TABLE_FAVORIET {
                var favoriet = self.getFavoriet(object)
                objecten.append(favoriet)
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
        } else if tableName == Constanten.TABLE_DEELNEMER {
            return self.getDeelnemer(object)
        } else if tableName == Constanten.TABLE_INSCHRIJVINGVORMING {
            return self.getInschrijvingVorming(object)
        } else if tableName == Constanten.TABLE_FAVORIET {
            return self.getFavoriet(object)
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
        
        var query = self.makeQuery(tableName, local: true, soortConstraints: soortConstraints, equalTo: equalToConstraints, notContainedIn: notContainedInConstraints, notEqualTo: notEqualToConstraints, containedIn: containedInConstraints)
        
        var count = query.countObjects()
        
        if count == 0 {
            return false
        }
        return true
    }
    
    static func bestaanLocalObjectsWithConstraints(tableName: String, soortConstraints: [String: String], equalToConstraints: [String: String] = [:], notContainedInConstraints: [String: [AnyObject]] = [:], notEqualToConstraints: [String: String] = [:], containedInConstraints: [String: [AnyObject]] = [:]) -> Bool {
        
        var query = self.makeQuery(tableName, local: true, soortConstraints: soortConstraints, equalTo: equalToConstraints, notContainedIn: notContainedInConstraints, notEqualTo: notEqualToConstraints, containedIn: containedInConstraints)
        
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
    
    static func getFavoriet(object: PFObject) -> Favoriet {
        
        var favoriet: Favoriet = Favoriet(id: object.objectId)
        
        var vakantieId: String = object[Constanten.COLUMN_VAKANTIE] as String
        var gebruikerId: String = object[Constanten.COLUMN_GEBRUIKER] as String
        var monitor: Gebruiker = Gebruiker(id: gebruikerId)
        
        favoriet.vakantie = self.getLocalObjectWithColumnConstraints(Constanten.TABLE_VAKANTIE, soortConstraints: [Constanten.COLUMN_OBJECTID: Constanten.CONSTRAINT_EQUALTO], equalToConstraints: [Constanten.COLUMN_OBJECTID: vakantieId]) as? Vakantie
        
        var bestaatOuder = self.bestaatLocalObjectWithConstraints(Constanten.TABLE_OUDER, soortConstraints: [Constanten.COLUMN_OBJECTID: Constanten.CONSTRAINT_EQUALTO], equalToConstraints: [Constanten.COLUMN_OBJECTID: gebruikerId])
        
        if bestaatOuder == true {
            favoriet.gebruiker = self.getLocalObjectWithColumnConstraints(Constanten.TABLE_OUDER, soortConstraints: [Constanten.COLUMN_OBJECTID: Constanten.CONSTRAINT_EQUALTO], equalToConstraints: [Constanten.COLUMN_OBJECTID: gebruikerId]) as Ouder
        } else {
            favoriet.gebruiker = self.getLocalObjectWithColumnConstraints(Constanten.TABLE_MONITOR, soortConstraints: [Constanten.COLUMN_OBJECTID: Constanten.CONSTRAINT_EQUALTO], equalToConstraints: [Constanten.COLUMN_OBJECTID: gebruikerId]) as Monitor
        }
        
        return favoriet
    }
    
    static private func getFeedback(object: PFObject) -> Feedback {
        
        var feedback: Feedback = Feedback(id: object.objectId)
        
        var vakantieId: String = object[Constanten.COLUMN_VAKANTIE] as String
        var gebruikerId: String = object[Constanten.COLUMN_GEBRUIKER] as String
        var monitor: Gebruiker = Gebruiker(id: gebruikerId)
        
        feedback.vakantie = self.getLocalObjectWithColumnConstraints(Constanten.TABLE_VAKANTIE, soortConstraints: [Constanten.COLUMN_OBJECTID: Constanten.CONSTRAINT_EQUALTO], equalToConstraints: [Constanten.COLUMN_OBJECTID: vakantieId]) as? Vakantie
        
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
    
    static private func getInschrijvingVorming(object: PFObject) -> InschrijvingVorming {
        
        var inschrijving: InschrijvingVorming = InschrijvingVorming(id: object.objectId)
        
        var vormingId: String = object[Constanten.COLUMN_VORMING] as String
        var monitorId: String = object[Constanten.COLUMN_MONITOR] as String
        
        inschrijving.vorming = self.getLocalObjectWithColumnConstraints(Constanten.TABLE_VORMING, soortConstraints: [Constanten.COLUMN_OBJECTID: Constanten.CONSTRAINT_EQUALTO], equalToConstraints: [Constanten.COLUMN_OBJECTID: vormingId]) as? Vorming
        
        inschrijving.monitor = self.getLocalObjectWithColumnConstraints(Constanten.TABLE_MONITOR, soortConstraints: [Constanten.COLUMN_OBJECTID: Constanten.CONSTRAINT_EQUALTO], equalToConstraints: [Constanten.COLUMN_OBJECTID: monitorId]) as? Monitor
        
        return inschrijving
    }
    
    static func getMonitor(object: PFObject) -> Monitor {
        
        var monitor: Monitor = Monitor(id: object.objectId)
        
        monitor.rijksregisterNr = object[Constanten.COLUMN_RIJKSREGISTERNUMMER] as? String
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
        }
        
        if object[Constanten.COLUMN_LIDNUMMER] != nil {
            monitor.lidNr = object[Constanten.COLUMN_LIDNUMMER] as? String
        } else {
            monitor.lidNr = ""
        }
        
        return monitor
    }
    
    static private func getOuder(object: PFObject) -> Ouder {
        
        var ouder: Ouder = Ouder(id: object.objectId)
        
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
        }
        
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
        vakantie.bondMoysonLedenPrijs = object[Constanten.COLUMN_BONDMOYSONLEDENPRIJS] as? Double
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
        
        if object[Constanten.COLUMN_WEBSITELOCATIE] != nil {
            vorming.websiteLocatie = object[Constanten.COLUMN_WEBSITELOCATIE] as? String
        } else {
            vorming.websiteLocatie = ""
        }
        
        vorming.tips = object[Constanten.COLUMN_TIPS] as? String
        vorming.betalingWijze = object[Constanten.COLUMN_BETALINGSWIJZE] as? String
        vorming.inbegrepenPrijs = object[Constanten.COLUMN_INBEGREPENINPRIJS] as? String
        
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
        equalToConstraints[Constanten.COLUMN_GEBRUIKER] = favoriet.gebruiker?.id
        
        var query = self.makeQuery(Constanten.TABLE_FAVORIET, local: true, soortConstraints: soortConstraints, equalTo: equalToConstraints)
        
        var object = query.getFirstObject()
        
        if Reachability.isConnectedToNetwork() == true {
            object.delete()
        } else {
            //object.deleteEventually()
            object.delete()
        }
        
        object.unpin()
        LocalDatastore.getTableReady(Constanten.TABLE_FAVORIET)
    }
    
    static func bestaatInschrijvingVakantieAl(inschrijving: InschrijvingVakantie) -> Bool {
        
        var soortConstraintsDeelnemer: [String: String] = [:]
        soortConstraintsDeelnemer[Constanten.COLUMN_VOORNAAM] = Constanten.CONSTRAINT_EQUALTO
        soortConstraintsDeelnemer[Constanten.COLUMN_NAAM] = Constanten.CONSTRAINT_EQUALTO
        
        var equalToConstraintsDeelnemer: [String: String] = [:]
        equalToConstraintsDeelnemer[Constanten.COLUMN_VOORNAAM] = inschrijving.deelnemer?.voornaam
        equalToConstraintsDeelnemer[Constanten.COLUMN_NAAM] = inschrijving.deelnemer?.naam
        
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
            
            var inschrijvingenVorming = self.getLocalObjectsWithColumnConstraints(Constanten.TABLE_INSCHRIJVINGVORMING, soortConstraints: [Constanten.COLUMN_MONITOR: Constanten.CONSTRAINT_EQUALTO], equalToConstraints: [Constanten.COLUMN_MONITOR: monitorId]) as [InschrijvingVorming]

            var vormingenMonitor: [Vorming] = []
            
            for inschrijving in inschrijvingenVorming {
                vormingenMonitor.append(inschrijving.vorming!)
            }
            
            
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
            
            var bestaanAndereMonitorenMetDezelfdeVormingen = self.bestaanLocalObjectsWithConstraints(Constanten.TABLE_INSCHRIJVINGVORMING, soortConstraints: soortConstraintsAndereMonitoren, notEqualToConstraints: notEqualToConstraintsAndereMonitoren, containedInConstraints: containedInConstraintsAndereMonitoren)
            
            
            if bestaanAndereMonitorenMetDezelfdeVormingen == true {
                var inschrijvingenAndereMonitoren = self.getLocalObjectsWithColumnConstraints(Constanten.TABLE_INSCHRIJVINGVORMING, soortConstraints: soortConstraintsAndereMonitoren, notEqualToConstraints: notEqualToConstraintsAndereMonitoren, containedInConstraints: containedInConstraintsAndereMonitoren) as [InschrijvingVorming]
                
                for inschrijving in inschrijvingenAndereMonitoren {
                    monitoren.append(inschrijving.monitor!)
                }
                
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
        
        
    
        var bestaanAndereMonitoren = self.bestaanLocalObjectsWithConstraints(Constanten.TABLE_MONITOR, soortConstraints: [Constanten.COLUMN_OBJECTID: Constanten.CONSTRAINT_NOTCONTAINEDIN], notContainedInConstraints: [Constanten.COLUMN_OBJECTID: zelfdeMonitorenIds])
        
        
        if bestaanAndereMonitoren == true {
            andereMonitoren = self.getLocalObjectsWithColumnConstraints(Constanten.TABLE_MONITOR, soortConstraints: [Constanten.COLUMN_OBJECTID: Constanten.CONSTRAINT_NOTCONTAINEDIN], notContainedInConstraints: [Constanten.COLUMN_OBJECTID: zelfdeMonitorenIds]) as [Monitor]
        }

        
        return andereMonitoren
    }

    static func bestaatInschrijvingVormingAl(inschrijving: InschrijvingVorming) -> Bool {
        
        var soortConstraints: [String: String] = [:]
        soortConstraints[Constanten.COLUMN_MONITOR] = Constanten.CONSTRAINT_EQUALTO
        soortConstraints[Constanten.COLUMN_VORMING] = Constanten.CONSTRAINT_EQUALTO
        soortConstraints[Constanten.COLUMN_PERIODE] = Constanten.CONSTRAINT_EQUALTO
        
        var equalToConstraints: [String: String] = [:]
        equalToConstraints[Constanten.COLUMN_MONITOR] = inschrijving.monitor?.id
        equalToConstraints[Constanten.COLUMN_VORMING] = inschrijving.vorming?.id
        equalToConstraints[Constanten.COLUMN_PERIODE] = inschrijving.periode
        
        var bestaatInschrijving = self.bestaatLocalObjectWithConstraints(Constanten.TABLE_INSCHRIJVINGVORMING, soortConstraints: soortConstraints, equalToConstraints: equalToConstraints)
        
        if bestaatInschrijving == true {
            return true
        }
        return false
    }

    static func bestaatVoorkeurAl(voorkeur: Voorkeur) -> Bool {
        
        var soortConstraints: [String: String] = [:]
        soortConstraints[Constanten.COLUMN_MONITOR] = Constanten.CONSTRAINT_EQUALTO
        soortConstraints[Constanten.COLUMN_VAKANTIE] = Constanten.CONSTRAINT_EQUALTO
        
        var equalToConstraints: [String: String] = [:]
        equalToConstraints[Constanten.COLUMN_MONITOR] = voorkeur.monitor?.id
        equalToConstraints[Constanten.COLUMN_VAKANTIE] = voorkeur.vakantie?.id
        
        var bestaatInschrijving = self.bestaatLocalObjectWithConstraints(Constanten.TABLE_VOORKEUR, soortConstraints: soortConstraints, equalToConstraints: equalToConstraints)
        
        if bestaatInschrijving == true {
            return true
        }
        return false
    }
    
    static func updateMonitor(monitor: Monitor) {
        
        var query = PFQuery(className: Constanten.TABLE_MONITOR)
        query.whereKey(Constanten.COLUMN_OBJECTID, equalTo: monitor.id)
        query.fromLocalDatastore()
        
        var object = query.getFirstObject()
        
        var voornaam = object[Constanten.COLUMN_VOORNAAM] as? String
        var naam = object[Constanten.COLUMN_NAAM] as? String
        var straat = object[Constanten.COLUMN_STRAAT] as? String
        var nummer = object[Constanten.COLUMN_NUMMER] as? Int
        var bus = object[Constanten.COLUMN_BUS] as? String
        var gemeente = object[Constanten.COLUMN_GEMEENTE] as? String
        var postcode = object[Constanten.COLUMN_POSTCODE] as? Int
        var telefoon = object[Constanten.COLUMN_TELEFOON] as? String
        var gsm = object[Constanten.COLUMN_GSM] as? String
        
        if bus == nil {
            bus = ""
        }
        
        if telefoon == nil {
            telefoon = ""
        }
        
        
        if voornaam != monitor.voornaam {
            object.setValue(voornaam, forKey: Constanten.COLUMN_VOORNAAM)
        }
        
        if naam != monitor.naam {
            object.setValue(naam, forKey: Constanten.COLUMN_NAAM)
        }
        
        if straat != monitor.straat {
           object.setValue(straat, forKey: Constanten.COLUMN_STRAAT)
        }
        
        if nummer != monitor.nummer {
            object.setValue(nummer, forKey: Constanten.COLUMN_NUMMER)
        }
        
        if bus != monitor.bus {
            object.setValue(bus, forKey: Constanten.COLUMN_BUS)
        }
        
        if gemeente != monitor.gemeente {
            object.setValue(gemeente, forKey: Constanten.COLUMN_GEMEENTE)
        }
        
        if postcode != monitor.postcode {
            object.setValue(postcode, forKey: Constanten.COLUMN_POSTCODE)
        }
        
        if telefoon != monitor.telefoon {
            object.setValue(telefoon, forKey: Constanten.COLUMN_TELEFOON)
        }
        
        if gsm != monitor.gsm {
            object.setValue(gsm, forKey: Constanten.COLUMN_GSM)
        }
        
        object.fetchFromLocalDatastore()
        self.getTableReady(Constanten.TABLE_MONITOR)
    }*/
}