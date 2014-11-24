import Foundation
import UIKit

class ParseData {
    
    func createDatabase() {
        createTabellen()
        vulTabellenOp()
    }
    
    func getMonitorWithEmail(email: String) -> Monitor {
        
        var monitors: [Monitor] = []
        var monitor: Monitor = Monitor(id: "test")
        
        let (resultSet, err) = SD.executeQuery("SELECT * FROM Monitor WHERE email = \(email)")
        
        if err != nil {
            //there was an error during the query, handle it here
        } else {
            for row in resultSet {
                monitor = getMonitor(row)
                monitors.append(monitor)
            }
        }
        
        return monitors.first!
    }
    
    func getMonitor(row: SD.SDRow) -> Monitor {
        var monitor: Monitor = Monitor(id: "test")
        
        if let objectId = row["objectId"]?.asString() {
            monitor.id = objectId
        }
        if let rijksregisterNr = row["rijksregisterNr"]?.asString() {
            monitor.rijksregisterNr = rijksregisterNr
        }
        if let email = row["email"]?.asString() {
            monitor.email = email
        }
        if let wachtwoord = row["wachtwoord"]?.asString() {
            monitor.wachtwoord = wachtwoord
        }
        if let voornaam = row["voornaam"]?.asString() {
            monitor.voornaam = voornaam
        }
        if let naam = row["naam"]?.asString() {
            monitor.naam = naam
        }
        if let straat = row["straat"]?.asString() {
            monitor.straat = straat
        }
        if let nummer = row["nummer"]?.asInt() {
            monitor.nummer = nummer
        }
        if let bus = row["bus"]?.asString() {
            monitor.bus = bus
        }
        if let postcode = row["postcode"]?.asInt() {
            monitor.postcode = postcode
        }
        if let gemeente = row["gemeente"]?.asString() {
            monitor.gemeente = gemeente
        }
        if let telefoon = row["telefoon"]?.asString() {
            monitor.telefoon = telefoon
        }
        if let gsm = row["gsm"]?.asString() {
            monitor.gsm = gsm
        }
        if let aansluitingsNr = row["aansluitingsNr"]?.asInt() {
            monitor.aansluitingsNr = aansluitingsNr
        }
        if let postcode = row["postcode"]?.asInt() {
            monitor.postcode = postcode
        }
        
        return monitor
    }
    
    func getAllVormingen() -> [Vorming] {
    
        var vormingen: [Vorming] = []
        var vorming: Vorming = Vorming(id: "test")
        
        let (resultSet, err) = SD.executeQuery("SELECT * FROM Vorming")
    
        if err != nil {
            //there was an error during the query, handle it here
        } else {
            for row in resultSet {
                vorming = getVorming(row)
                vormingen.append(vorming)
            }
        }
    
        return vormingen
    }
    
    private func getVorming(row: SD.SDRow) -> Vorming {
        var vorming: Vorming = Vorming(id: "test")
        
        if let objectId = row["objectId"]?.asString() {
            vorming.id = objectId
        }
        if let titel = row["titel"]?.asString() {
            vorming.titel = titel
        }
        if let locatie = row["locatie"]?.asString() {
            vorming.locatie = locatie
        }
        if let korteBeschrijving = row["korteBeschrijving"]?.asString() {
            vorming.korteBeschrijving = korteBeschrijving
        }
        /* ARRAY!!!!
        if let periodes = row["periodes"]?.asString() {
        vorming.periodes = periodes
        }
        */
        if let prijs = row["prijs"]?.asDouble()! {
            vorming.prijs = prijs
        }
        if let websiteLocatie = row["websiteLocatie"]?.asString() {
            vorming.websiteLocatie = websiteLocatie
        }
        if let criteriaDeelnemers = row["criteriaDeelnemers"]?.asString() {
            vorming.criteriaDeelnemers = criteriaDeelnemers
        }
        if let tips = row["tips"]?.asString() {
            vorming.tips = tips
        }
        if let betalingswijze = row["betalingswijze"]?.asString() {
            vorming.betalingWijze = betalingswijze
        }
        /* inbegrepenInPrijs staat niet in model klasse?
        if let inbegrepenInPrijs = row["inbegrepenInPrijs"]?.asString() {
            vorming. = basisPrijs
        }*/
        
        return vorming
    }
    
    func parseContactpersoonNoodToDatabase(contactpersoon: ContactpersoonNood, inschrijvingId: String) {
        var contactpersoonJSON = PFObject(className: "ContactpersoonNood")
        
        contactpersoonJSON.setValue(contactpersoon.voornaam, forKey: "voornaam")
        contactpersoonJSON.setValue(contactpersoon.naam, forKey: "naam")
        contactpersoonJSON.setValue(contactpersoon.gsm, forKey: "gsm")
        contactpersoonJSON.setValue(inschrijvingId, forKey: "inschrijvingVakantie")
        
        if contactpersoon.telefoon != nil {
            contactpersoonJSON.setValue(contactpersoon.telefoon, forKey: "telefoon")
        }
        
        contactpersoonJSON.save()
    }
    
    func parseDeelnemerToDatabase(deelnemer: Deelnemer, inschrijvingId: String) {
        var deelnemerJSON = PFObject(className: "Deelnemer")
        
        deelnemerJSON.setValue(deelnemer.voornaam, forKey: "voornaam")
        deelnemerJSON.setValue(deelnemer.naam, forKey: "naam")
        deelnemerJSON.setValue(deelnemer.geboortedatum, forKey: "geboortedatum")
        deelnemerJSON.setValue(deelnemer.straat, forKey: "straat")
        deelnemerJSON.setValue(deelnemer.nummer, forKey: "nummer")
        deelnemerJSON.setValue(deelnemer.gemeente, forKey: "gemeente")
        deelnemerJSON.setValue(deelnemer.postcode, forKey: "postcode")
        deelnemerJSON.setValue(inschrijvingId, forKey: "inschrijvingVakantie")
        
        if deelnemer.bus != nil {
            deelnemerJSON.setValue(deelnemer.bus, forKey: "bus")
        }
        
        deelnemerJSON.save()
        //deelnemerJSON.fetch()
    }
    
    func parseInschrijvingVakantieToDatabase(inschrijving: InschrijvingVakantie) -> String {
        var inschrijvingJSON = PFObject(className: "InschrijvingVakantie")
        
        inschrijvingJSON.setValue(inschrijving.vakantie?.id, forKey: "vakantie")
        
        if inschrijving.extraInfo != "" {
            inschrijvingJSON.setValue(inschrijving.extraInfo, forKey: "extraInformatie")
        }
        
        inschrijvingJSON.save()
        inschrijvingJSON.fetch()
        return inschrijvingJSON.objectId
    }
    
    func zoekUserMetEmailEnWachtwoord(email: String, wachtwoord: String) -> PFUser {
        var users: [PFUser] = []
        var user: PFUser = PFUser()
        
        var query = "SELECT * FROM User WHERE email = \(email) AND wachtwoord = \(wachtwoord)"
        
        let (resultSet, err) = SD.executeQuery(query)
        
        if err != nil {
            //there was an error during the query, handle it here
        } else {
            for row in resultSet {
                user = getU(row)
                users.append(user)
            }
        }
        
        return users.first!
    }
    
    private func getU(row: SD.SDRow) -> PFUser {
        var user: PFUser = PFUser()
        
        if let objectId = row["objectId"]?.asString() {
            user.objectId = objectId
        }
        if let username = row["username"]?.asString() {
            user.username = username
        }
        if let password = row["password"]?.asString() {
            user.password = password
        }
        if let soort = row["soort"]?.asString() {
            user["soort"] = soort
        }
        
        return user
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
    
    func getAfbeeldingenMetVakantieId(vakantieId: String) -> [UIImage]{
        var afbeeldingen: [UIImage] = []
        var afbeelding: UIImage = UIImage()
        
        var query = "SELECT * FROM Afbeelding WHERE vakantie = \(vakantieId)"
        
        let (resultSet, err) = SD.executeQuery(query)
        
        if err != nil {
            //there was an error during the query, handle it here
        } else {
            for row in resultSet {
                afbeelding = getA(row)
                afbeeldingen.append(afbeelding)
            }
        }
        
        return afbeeldingen
    }
    
    private func getA(row: SD.SDRow) -> UIImage {
        var afbeelding: UIImage = UIImage()
        
        if let a = row["afbeelding"]?.asImage()! {
            afbeelding = a
        }
        
        return afbeelding
    }
    
    func getAllVakanties() -> [Vakantie] {
        
        var vakanties:[Vakantie] = []
        var vakantie: Vakantie = Vakantie(id: "test")
        
        let (resultSet, err) = SD.executeQuery("SELECT * FROM Vakantie")
        
        if err != nil {
            //there was an error during the query, handle it here
        } else {
            for row in resultSet {
                vakantie = getV(row)
                vakanties.append(vakantie)
            }
        }
        
        return vakanties
    }
    
    private func getV(row: SD.SDRow) -> Vakantie {
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
    
    private func createTabellen() {
        
        var response: ([String], Int?) = SD.existingTables()
        
        if response.1 == nil {
            //geen error
            
            if !contains(response.0, "User") {
                createUserTable()
            }
            if !contains(response.0, "Afbeelding") {
                
            }
            if !contains(response.0, "ContactpersoonNood") {
                createContactpersoonNoodTable()
            }
            if !contains(response.0, "Deelnemer") {
                createDeelnemerTable()
            }
            if !contains(response.0, "InschrijvingVakantie") {
                createInschrijvingVakantieTable()
            }
            if !contains(response.0, "InschrijvingVorming") {
                createInschrijvingVormingTable()
            }
            if !contains(response.0, "Monitor") {
                createMonitorTable()
            }
            if !contains(response.0, "Ouder") {
                createOuderTable()
            }
            if !contains(response.0, "Vakantie") {
                createVakantieTable()
            }
            if !contains(response.0, "Voorkeur") {
                createVoorkeurTable()
            }
            if !contains(response.0, "Vorming") {
                createVormingTable()
            }
        }
    }
    
    private func vulTabellenOp() {
        vulUserTableOp()
        vulMonitorTableOp()
        vulOuderTableOp()
        vulVakantieTableOp()
    }
    
    private func vulUserTableOp() {
        
        var users: [PFUser] = []
        var query = PFUser.query()
        users = query.findObjects() as [PFUser]
        
        var objectId: String = ""
        var username: String = ""
        var password: String = ""
        var email: String = ""
        var soort: String = ""
        
        for user in users {
            objectId = user.objectId as String
            username = user.username as String
            //password = user.password as String
            email = user.email as String!
            
            
            soort = user["soort"] as String
        
            if let err = SD.executeChange("INSERT INTO User (objectId, username, password, email, soort) VALUES ('\(objectId)', '\(username)', '\(password)', '\(email)', '\(soort)')") {
                //there was an error during the insert, handle it here
            } else {
                //no error, the row was inserted successfully
            }
        }
    }
    
    private func vulMonitorTableOp() {
        
        var monitors: [PFObject] = []
        var query = PFQuery(className: "Monitor")
        monitors = query.findObjects() as [PFObject]
        
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
        var lidNr: Int?
        var linkFacebook: String?
        
        for monitor in monitors {
            objectId = monitor.objectId as String
            rijksregisterNr = monitor["rijksregisterNr"] as? String
            email = monitor["email"] as String
            wachtwoord = monitor["wachtwoord"] as? String
            voornaam = monitor["voornaam"] as String
            naam = monitor["naam"] as String
            straat = monitor["straat"] as String
            nummer = monitor["nummer"] as Int
            bus = monitor["bus"] as? String
            postcode = monitor["postcode"] as Int
            gemeente = monitor["gemeente"] as String
            telefoon = monitor["telefoon"] as? String
            gsm = monitor["gsm"] as String
            aansluitingsNr = monitor["aansluitingsNr"] as? Int
            codeGerechtigde = monitor["codeGerechtigde"] as? Int
            lidNr = monitor["lidNr"] as? Int
            linkFacebook = monitor["linkFacebook"] as? String
          
            if let err = SD.executeChange("INSERT INTO Monitor (objectId, rijksregisterNr, email, wachtwoord, voornaam, naam, straat, nummer, bus, postcode, gemeente, telefoon, gsm, aansluitingsNr, codeGerechtigde, lidNr, linkFacebook) VALUES ('\(objectId)', '\(rijksregisterNr)', '\(email)', '\(wachtwoord)', '\(voornaam)', '\(naam)', '\(straat)', '\(nummer)', '\(bus)', '\(postcode)', '\(gemeente)', '\(telefoon)', '\(gsm)', '\(aansluitingsNr)', '\(codeGerechtigde)', '\(lidNr)', '\(linkFacebook)')") {
                //there was an error during the insert, handle it here
            } else {
                //no error, the row was inserted successfully
            }
            
        }
    }
    
    private func vulOuderTableOp() {
        
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
    
    private func vulVakantieTableOp() {
        
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
    
    private func vulVormingTableOp() {
        
        var vormingen: [PFObject] = []
        var query = PFQuery(className: "Vorming")
        vormingen = query.findObjects() as [PFObject]
        
        var objectId: String = ""
        var titel: String = ""
        var locatie: String = ""
        var korteBeschrijving: String = ""
        var periodesArray: [String] = []
        var periodesString: String = ""
        var prijs: Double = 0.0
        var websiteLocatie: String = ""
        var criteriaDeelnemers: String = ""
        var tips: String = ""
        var betalingswijze: String = ""
        var inbegrepenInPrijs: String = ""
        
        for vorming in vormingen {
            objectId = vorming.objectId as String
            titel = vorming["titel"] as String
            locatie = vorming["locatie"] as String
            korteBeschrijving = vorming["korteBeschrijving"] as String
            periodesArray = vorming["periodes"] as [String]
            
            var teller: Int = 0
            
            for periode in periodesArray {
                if teller != 0 {
                    periodesString.extend(", ")
                }
                
                periodesString.extend(periode)
                teller += 1
            }
            
            prijs = vorming["prijs"] as Double
            websiteLocatie = vorming["websiteLocatie"] as String
            criteriaDeelnemers = vorming["criteriaDeelnemers"] as String
            tips = vorming["tips"] as String
            betalingswijze = vorming["betalingswijze"] as String
            inbegrepenInPrijs = vorming["inbegrepenInPrijs"] as String
            
            if let err = SD.executeChange("INSERT INTO Vorming (objectId, titel, locatie, korteBeschrijving, periodes, prijs, websiteLocatie, criteriaDeelnemers, tips, betalingswijze, inbegrepenInPrijs) VALUES ('\(objectId)', '\(titel)', '\(locatie)', '\(korteBeschrijving)', '\(periodesString)', '\(prijs)', '\(websiteLocatie)', '\(criteriaDeelnemers)', '\(tips)', '\(betalingswijze)', '\(inbegrepenInPrijs)')") {
                //there was an error during the insert, handle it here
            } else {
                //no error, the row was inserted successfully
            }
            
        }
    }
    
    private func vulAfbeeldingTableOp() {
        
        var afbeeldingen: [PFObject] = []
        var query = PFQuery(className: "Afbeelding")
        afbeeldingen = query.findObjects() as [PFObject]
        
        var objectId: String = ""
        var afbeelding: UIImage = UIImage()
        var vakantie: String = ""
        
        for a in afbeeldingen {
            objectId = a.objectId as String
            afbeelding = a["afbeelding"] as UIImage
            vakantie = a["vakantie"] as String
            
            if let err = SD.executeChange("INSERT INTO Afbeelding (objectId, afbeelding, vakantie) VALUES ('\(objectId)', '\(afbeelding)', '\(vakantie)')") {
                //there was an error during the insert, handle it here
            } else {
                //no error, the row was inserted successfully
            }
            
        }
    }
    
    private func createUserTable() {
        
        
        
        if let error = SD.createTable("User", withColumnNamesAndTypes: ["objectId":
            .StringVal, "username": .StringVal, "password": .StringVal, "email":
            .StringVal, "soort": .StringVal]) {
            
            //there was an error
                    
        } else {
            //no error
        }
    }
    
    private func createAfbeeldingTable() {
        if let error = SD.createTable("Afbeelding", withColumnNamesAndTypes: ["objectId":
            .StringVal, "afbeelding": .ImageVal, "vakantie": .StringVal]) {
                    
                    //there was an error
                    
        } else {
            //no error
        }
    }
    
    private func createContactpersoonNoodTable() {
        if let error = SD.createTable("ContactpersoonNood", withColumnNamesAndTypes: ["objectId": .StringVal, "voornaam": .StringVal, "naam": .StringVal, "gsm":
                .StringVal, "telefoon": .StringVal, "inschrijvingVakantie": .StringVal]) {
                    
                    //there was an error
                    
        } else {
            //no error
        }
    }
    
    private func createDeelnemerTable() {
        if let error = SD.createTable("Deelnemer", withColumnNamesAndTypes: ["objectId": .StringVal, "voornaam": .StringVal, "naam": .StringVal, "geboortedatum": .DateVal ,"straat": .StringVal, "nummer": .IntVal, "bus": .StringVal, "postcode": .IntVal, "gemeente": .StringVal, "inschrijvingVakantie": .StringVal]) {
                
                //there was an error
                
        } else {
            //no error
        }
    }
    
    private func createInschrijvingVakantieTable() {
        if let error = SD.createTable("InschrijvingVakantie", withColumnNamesAndTypes: ["objectId": .StringVal, "extraInformatie": .StringVal, "vakantie": .StringVal]) {
            
            //there was an error
            
        } else {
            //no error
        }
    }
    
    private func createInschrijvingVormingTable() {
        if let error = SD.createTable("InschrijvingVorming", withColumnNamesAndTypes: ["objectId": .StringVal, "monitor": .StringVal, "periode": .StringVal, "vorming":
            .StringVal]) {
            
            //there was an error
            
        } else {
            //no error
        }
    }
    
    private func createMonitorTable() {
        if let error = SD.createTable("Monitor", withColumnNamesAndTypes: ["objectId": .StringVal, "rijksregisterNr": .StringVal, "email": .StringVal, "wachtwoord": .StringVal ,"voornaam": .StringVal, "naam": .StringVal, "straat": .StringVal, "nummer": .IntVal, "bus": .StringVal, "postcode": .IntVal, "gemeente": .StringVal, "telefoon": .StringVal, "gsm": .StringVal, "aansluitingsNr": .IntVal, "codeGerechtigde": .IntVal, "lidNr": .IntVal, "linkFacebook": .StringVal]) {
            
            //there was an error
            
        } else {
            //no error
        }
    }
    
    private func createOuderTable() {
        if let error = SD.createTable("Ouder", withColumnNamesAndTypes: ["objectId": .StringVal, "rijksregisterNr": .StringVal, "email": .StringVal, "wachtwoord": .StringVal ,"voornaam": .StringVal, "naam": .StringVal, "straat": .StringVal, "nummer": .IntVal, "bus": .StringVal, "postcode": .IntVal, "gemeente": .StringVal, "telefoon": .StringVal, "gsm": .StringVal, "aansluitingsNr": .IntVal, "codeGerechtigde": .IntVal, "aansluitingsNrTweedeOuder": .IntVal]) {
            
            //there was an error
            
        } else {
            //no error
        }
    }
    
    private func createVakantieTable() {
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
    
    private func createVoorkeurTable() {
        if let error = SD.createTable("Voorkeur", withColumnNamesAndTypes: ["objectId":
            .StringVal, "monitor": .StringVal, "vakantie": .StringVal, "periodes":
                .StringVal]) {
                    
                    //there was an error
                    
        } else {
            //no error
        }
    }
    
    private func createVormingTable() {
        if let error = SD.createTable("Vorming", withColumnNamesAndTypes: ["objectId":
            .StringVal, "titel": .StringVal, "locatie": .StringVal, "korteBeschrijving":
        .StringVal, "periodes": .StringVal, "prijs": .DoubleVal,
            "websiteLocatie": .StringVal, "criteriaDeelnemers": .StringVal, "tips":
                .StringVal, "betalingswijze": .StringVal, "inbegrepenInPrijs": .StringVal]) {
                    
                    //there was an error
                    
        } else {
            //no error
        }
    }
    
}