import Foundation
import UIKit

struct /*class*/ ParseData {
    
    static func createDatabase() {
        createTabellen()
        vulTabellenOp()
    }
    
    static private func createTabellen() {
        
        var response: ([String], Int?) = SD.existingTables()
        
        if response.1 == nil {
            //geen error
            
            /*if !contains(response.0, "User") {
            createUserTable()
            }*/
            /*if !contains(response.0, "Monitor") {
            createMonitorTable()
            }
            if !contains(response.0, "Ouder") {
            createOuderTable()
            }*/
            if !contains(response.0, "Vakantie") {
                createVakantieTable()
            }
            /*if !contains(response.0, "Vorming") {
            createVormingTable()
            }*/
        }
    }
    
    static private func vulTabellenOp() {
        //vulUserTableOp()
        //vulMonitorTableOp()
        //vulOuderTableOp()
        vulVakantieTableOp()
    }
    
    //creatie tabellen
    static private func createDeelnemerTable() {
        DeelnemerSQL.createDeelnemerTable()
    }
    
    static private func createFavorietTable() {
        FavorietSQL.createFavorietTable()
    }
    
    static private func createAfbeeldingTable() {
        AfbeeldingSQL.createAfbeeldingTable()
    }
    
    static private func createInschrijvingVakantieTable() {
        InschrijvingVakantieSQL.createInschrijvingVakantieTable()
    }
    
    static private func createInschrijvingVormingTable() {
        InschrijvingVormingSQL.createInschrijvingVormingTable()
    }
    
    static private func createMonitorTable() {
        MonitorSQL.createMonitorTable()
    }
    
    static private func createOuderTable() {
        OuderSQL.createOuderTable()
    }
    
    static private func createVakantieTable() {
        VakantieSQL.createVakantieTable()
    }
    
    static private func createVoorkeurTable() {
        VoorkeurSQL.createVoorkeurTable()
    }
    
    static private func createVormingTable() {
        VormingSQL.createVormingTable()
    }
    
    //opvullen tables
    static func vulDeelnemerTableOp() {
        
        var response: ([String], Int?) = SD.existingTables()
        
        if response.1 == nil {
            if !contains(response.0, "Deelnemer") {
                createDeelnemerTable()
            }
        }
        
        DeelnemerSQL.vulDeelnemerTableOp()
    }
    
    static func vulFavorietTableOp() {
        
        var response: ([String], Int?) = SD.existingTables()
        
        if response.1 == nil {
            if !contains(response.0, "Favoriet") {
                createFavorietTable()
            }
        }
        
        FavorietSQL.vulFavorietTableOp()
    }
    
    static func vulInschrijvingVakantieTableOp() {
        
        var response: ([String], Int?) = SD.existingTables()
        
        if response.1 == nil {
            if !contains(response.0, "InschrijvingVakantie") {
                createInschrijvingVakantieTable()
            }
        }
        
        InschrijvingVakantieSQL.vulInschrijvingVakantieTableOp()
    }
    
    static func vulInschrijvingVormingTableOp() {
        
        var response: ([String], Int?) = SD.existingTables()
        
        if response.1 == nil {
            if !contains(response.0, "InschrijvingVorming") {
                createInschrijvingVormingTable()
            }
        }
        
        InschrijvingVormingSQL.vulInschrijvingVormingTableOp()
    }
    
    static func vulMonitorTableOp() {
        
        var response: ([String], Int?) = SD.existingTables()
        
        if response.1 == nil {
            if !contains(response.0, "Monitor") {
                createMonitorTable()
            }
        }
        
        MonitorSQL.vulMonitorTableOp()
    }
    
    
    static func vulOuderTableOp() {
        var response: ([String], Int?) = SD.existingTables()
        
        if response.1 == nil {
            if !contains(response.0, "Ouder") {
                createOuderTable()
            }
        }
        
        OuderSQL.vulOuderTableOp()
    }
    
    static private func vulVakantieTableOp() {
        VakantieSQL.vulVakantieTableOp()
    }
    
    static func vulVoorkeurTableOp() {
        
        var response: ([String], Int?) = SD.existingTables()
        
        if response.1 == nil {
            if !contains(response.0, "Voorkeur") {
                createVoorkeurTable()
            }
        }

        
        VoorkeurSQL.vulVoorkeurTableOp()
    }
    
    static func vulVormingTableOp() {
        
        var response: ([String], Int?) = SD.existingTables()
        
        if response.1 == nil {
            if !contains(response.0, "Vorming") {
                createVormingTable()
            }
        }
        
        VormingSQL.vulVormingTableOp()
    }
    
    //delete tables
    static func deleteAllTables() {
        var response: ([String], Int?) = SD.existingTables()
        
        if response.1 == nil {
            //geen error
            for table in response.0 {
                if table != "sqlite_sequence" {
                    let err = SD.deleteTable(table)
                }
            }
        }
    }
    
    static func deleteDeelnemerTable() {
        
        var response: ([String], Int?) = SD.existingTables()
        
        if response.1 == nil {
            if contains(response.0, "Deelnemer") {
                let err = SD.deleteTable("Deelnemer")
            }
        }
    }
    
    static func deleteFavorietTable() {
        
        var response: ([String], Int?) = SD.existingTables()
        
        if response.1 == nil {
            if contains(response.0, "Favoriet") {
                let err = SD.deleteTable("Favoriet")
            }
        }
    }
    
    static func deleteFavorieteVakantie(favoriet: Favoriet) {
        FavorietSQL.deleteFavorieteVakantie(favoriet)
    }
    
    static func deleteInschrijvingVakantieTable() {
        
        var response: ([String], Int?) = SD.existingTables()
        
        if response.1 == nil {
            if contains(response.0, "InschrijvingVakantie") {
                let err = SD.deleteTable("InschrijvingVakantie")
            }
        }
        
    }
    
    static func deleteInschrijvingVormingTable() {
        
        var response: ([String], Int?) = SD.existingTables()
        
        if response.1 == nil {
            if contains(response.0, "InschrijvingVorming") {
                let err = SD.deleteTable("InschrijvingVorming")
            }
        }
        
    }
    
    static func deleteMonitorTable() {
        
        var response: ([String], Int?) = SD.existingTables()
        
        if response.1 == nil {
            if contains(response.0, "Monitor") {
                let err = SD.deleteTable("Monitor")
            }
        }
        
    }

    static func deleteOuderTable() {
        
        var response: ([String], Int?) = SD.existingTables()
        
        if response.1 == nil {
            if contains(response.0, "Ouder") {
                let err = SD.deleteTable("Ouder")
            }
        }
        
    }
    
    static func deleteVoorkeurTable() {
        
        var response: ([String], Int?) = SD.existingTables()
        
        if response.1 == nil {
            if contains(response.0, "Voorkeur") {
                let err = SD.deleteTable("Voorkeur")
            }
        }
        
    }
    
    static func deleteVormingTable() {
        
        var response: ([String], Int?) = SD.existingTables()
        
        if response.1 == nil {
            if contains(response.0, "Vorming") {
                let err = SD.deleteTable("Vorming")
            }
        }
        
    }
    
    static func deleteVakantiesInVerleden() {
        //VakantieSQL.deleteVakantiesInVerleden()
    }
    
    //parse to database
    static func parseContactpersoonNoodToDatabase(contactpersoon: ContactpersoonNood) -> String {
        
        return ContactpersoonNoodSQL.parseContactpersoonNoodToDatabase(contactpersoon)
    }
    
    static func parseDeelnemerToDatabase(deelnemer: Deelnemer) -> String {
        return DeelnemerSQL.parseDeelnemerToDatabase(deelnemer)
    }
    
    static func parseFavorietToDatabase(favoriet: Favoriet) {
        return FavorietSQL.parseFavorietToDatabase(favoriet)
    }
    
    static func parseInschrijvingVakantieToDatabase(inschrijving: InschrijvingVakantie) {
        InschrijvingVakantieSQL.parseInschrijvingVakantieToDatabase(inschrijving)
    }
    
    static func parseInschrijvingVormingToDatabase(inschrijving: InschrijvingVorming) {
        InschrijvingVormingSQL.parseInschrijvingVormingToDatabase(inschrijving)
    }
    
    static func parseMonitorToDatabase(monitor: Monitor, wachtwoord: String) {
        MonitorSQL.parseMonitorToDatabase(monitor, wachtwoord: wachtwoord)
    }
    
    static func parseOuderToDatabase(ouder: Ouder, wachtwoord: String) {
        OuderSQL.parseOuderToDatabase(ouder, wachtwoord: wachtwoord)
    }
    
    static func parseVoorkeurToDatabase(voorkeur: Voorkeur) {
        VoorkeurSQL.parseVoorkeurToDatabase(voorkeur)
    }
    
    //AfbeeldingenTable
    static func getAfbeeldingenMetVakantieId(vakantieId: String) -> /*[UIImage]*/ ([UIImage], Int?) {
        //return AfbeeldingSQL.getAfbeeldingenMetVakantieId(vakantieId)
        
        //onnodig extra afbeeldingen opslaan op device, beter om deze rechtstreeks van parse op te halen
        
        var response: ([UIImage], Int?)
        var error: Int?
        
        var query = PFQuery(className: "Afbeelding")
        query.whereKey("vakantie", equalTo: vakantieId)
        
        var afbeeldingenObjects: [PFObject] = []
        var afbeeldingFile: PFFile
        var afbeelding: UIImage
        var afbeeldingen: [UIImage] = []
        
        afbeeldingenObjects = query.findObjects() as [PFObject]
        
        if afbeeldingenObjects.count == 0 {
            error = 1
        }
        else {
            error = nil
            
            for afbeeldingO in afbeeldingenObjects {
                afbeeldingFile = afbeeldingO["afbeelding"] as PFFile
                afbeelding = UIImage(data: afbeeldingFile.getData())!
                afbeeldingen.append(afbeelding)
            }
        }
        
        //return afbeeldingen
        response = (afbeeldingen, error)
        return response
    }
    
    static func getAfbeeldingMetVakantieId(vakantieId: String) -> UIImage {
        var query = PFQuery(className: "Afbeelding")
        query.whereKey("vakantie", equalTo: vakantieId)
        
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
    
    static func getFavorieteVakanties(ouder: Ouder) -> ([Vakantie], Int?) {
        return FavorietSQL.getFavorieteVakanties(ouder)
    }
    
    //InschrijvingenVakantieTable
    static func getInschrijvingenVakantie(inschrijving: InschrijvingVakantie) -> /*[InschrijvingVakantie] */ ([InschrijvingVakantie], Int?){
        
        var voornaam: String! = inschrijving.deelnemer?.voornaam
        var naam: String! = inschrijving.deelnemer?.naam
        var vakantieId: String! = inschrijving.vakantie?.id
        var ouderId: String! = inschrijving.ouder?.id
        
        return InschrijvingVakantieSQL.getInschrijvingenVakantie(voornaam, naamDeelnemer: naam, vakantieId: vakantieId, ouderId: ouderId)
        
    }
    
    //InschrijvingVormingTable
    static func getInschrijvingenVorming(inschrijving: InschrijvingVorming) -> [InschrijvingVorming] {
        var monitorId: String! = inschrijving.monitor?.id
        var vormingId: String! = inschrijving.vorming?.id
        //var periode: String! = inschrijving.periode
        
        return InschrijvingVormingSQL.getInschrijvingenVorming(monitorId, vormingId: vormingId/*, periode: periode*/)
    }
    
    //MonitorTable
    static func getAlleMonitors() -> /*[Monitor]*/([Monitor], Int?) {
        return MonitorSQL.zoekAlleMonitors()
    }
    
    static func getMonitorsMetAndereVormingen(monitorsMetDezelfdeVorming: [Monitor]) -> /*[Monitor]*/([Monitor], Int?) {
        return MonitorSQL.getAndereMonitors(monitorsMetDezelfdeVorming)
    }
    
    static func getMonitorsMetDezelfdeVormingen(monitorId: String) -> /*[Monitor]*/ ([Monitor], Int?) {
        
        var monitors: [Monitor] = []
        var response: ([Monitor], Int?)
        var error: Int?
        
        var vormingenResponse = InschrijvingVormingSQL.getVormingIdMetMonitorId(monitorId)
        
        if vormingenResponse.1 == nil {
            //geen error, er zijn vormingen gevonden
            var monitorIdsResponse = InschrijvingVormingSQL.getMonitorsIdMetVormingId(vormingenResponse.0)
            
            if monitorIdsResponse.1 == nil {
                //geen error, er zijn monitors met dezelfde vormingen gevonden
                var monitors = MonitorSQL.getMonitorsMetId(monitorIdsResponse.0)
                error = nil
                response = (monitors, error)
                
            } else {
                error = 1
                response = (monitors, error)
            }
        } else {
            error = 1
            response = (monitors, error)
        }
        
        return response
    }
    
    static func getMonitorWithEmail(email: String) -> Monitor {
        return MonitorSQL.getMonitorWithEmail(email)
    }
    
    static func updateMonitor(monitor: Monitor) {
        MonitorSQL.updateMonitor(monitor/*, email: PFUser.currentUser().email*/)
    }
    
    //OuderTable
    static func getOuderWithEmail(email: String) -> /*Ouder*/ (Ouder, Int?) {
        return OuderSQL.getOuderWithEmail(email)
    }
    
    //VakantieTable
    static func getAlleVakanties() -> /*[Vakantie]*/ ([Vakantie], Int?) {
        return VakantieSQL.getAlleVakanties()
    }
    
    //VormingTable
    static func getAlleVormingen() -> /*[Vorming]*/ ([Vorming], Int?) {
        return VormingSQL.getAlleVormingen()
    }
    
    //PFUser
    static func getUserMetEmailEnWachtwoord(email: String, wachtwoord: String) -> PFUser {
        
        var query = PFUser.query()
        query.whereKey("email", equalTo: email)
        query.whereKey("password", equalTo: wachtwoord)
        
        var users: [PFUser] = query.findObjects() as [PFUser]
        return users.first!
        
        //return UserSQL.zoekUserMetEmailEnWachtwoord(email, wachtwoord: wachtwoord)
    }
    
    
    /*static private func vulUserTableOp() {
    UserSQL.vulUserTableOp()
    }*/
    
    /*static private func vulMonitorTableOp() {
    MonitorSQL.vulMonitorTableOp()
    }*/
    
    
    /*static private func createUserTable() {
    UserSQL.createUserTable()
    }*/
    
    
    
    static func getRijksregisterNummers(rijksregisterNummer: String) -> Bool {
        if OuderSQL.getRijksregisterNummers(rijksregisterNummer) == true ||
            MonitorSQL.getRijksregisterNummers(rijksregisterNummer) == true {
            return true
        }
        return false
    }
    
    static func getGSM(gsm: String) -> Bool {
        if OuderSQL.getGSM(gsm) == true || MonitorSQL.getGSM(gsm) == true {
            return true
        }
        return false
    }
    
    static func getEmail(email: String) -> Bool {
        var boolOuder = OuderSQL.getEmail(email)
        var boolMonitor = MonitorSQL.getEmail(email)
        
        if boolOuder == true || boolMonitor == true {
            return true
        }
        
        return false
    }
    
    static func isFavorieteVakantie(favoriet: Favoriet) -> Bool {
        return FavorietSQL.isFavoriet(favoriet)
    }
    
    static func getVoorkeurenVakantie(voorkeur: Voorkeur) -> /*[Voorkeur]*/ Int? {
        
        var monitorId: String! = voorkeur.monitor?.id
        var vakantieId: String! = voorkeur.vakantie?.id
        
        return VoorkeurSQL.getVoorkeuren(monitorId, vakantieId: vakantieId)
    }
    
    static func lidNummerMonitorAlToegevoegd(lidNummer: Int) -> Bool {
        return MonitorSQL.lidNummerAlToegevoegd(lidNummer)
    }
    
    static func rijksregisterNrMonitorAlToegevoegd(rijksregisterNr: String) -> Bool {
        return MonitorSQL.getRijksregisterNummers(rijksregisterNr)
    }
    
    static func emailMonitorAlToegevoegd(email: String) -> Bool {
        return MonitorSQL.getEmail(email)
    }
    
    /*static func getInschrijvingenVakantieDeelnemer(voornaam: String, naam: String, vakantie: String, ouder: String) -> [InschrijvingVakantie] {
    //var inschrijvingen: [String] = []
    
    var inschrijvingenVakantie: [InschrijvingVakantie] = []
    
    /*var d = DeelnemerSQL.getDeelnemerMetVoornaamEnNaam(deelnemer.voornaam!, naam: deelnemer.naam!)
    
    if d == nil {
    return inschrijvingenVakantie
    } else {
    //inschrijvingen = getInschrijvingen(d)
    //if inschrijvingen.count() == 0
    }
    */
    
    var queryString = ""
    
    queryString.extend("SELECT * FROM Deelnemer ")
    queryString.extend("JOIN ")
    queryString.extend("InschrijvingVakantie ON Deelnemer.inschrijvingVakantie = InschrijvingVakantie.objectId ")//join table
    queryString.extend("JOIN ")
    queryString.extend("Vakantie ON InschrijvingVakantie.vakantie = Vakantie.objectId ")//join table
    queryString.extend("JOIN  ")
    queryString.extend("Ouder ON InschrijvingVakantie.ouder = Ouder.objectId ")//join table
    queryString.extend("WHERE ")
    queryString.extend("Deelnemer.voornaam = ? ")
    queryString.extend("AND ")
    queryString.extend("Deelnemer.naam = ? ")
    queryString.extend("AND ")
    queryString.extend("InschrijvingVakantie.vakantie = ? ")
    queryString.extend("AND ")
    queryString.extend("InschrijvingVakantie.ouder = ?")
    //queryString.extend(")")
    
    /*voornaam: String! = deelnemer.voornaam!
    var naam: String! = deelnemer.naam!
    var vakantieId: String! = deelnemer.inschrijvingVakantie?.vakantie?.id
    var ouderId: String! = deelnemer.inschrijvingVakantie?.ouder?.id*/
    
    /*if let err = SD.executeQuery(queryString, withArgs: [voornaam, naam, vakantieId, ouderId])
    {
    println("ERROR: error tijdens toevoegen van nieuwe vakantie in table Vakantie")
    }
    else
    {
    //no error, the row was inserted successfully
    }*/
    
    
    return inschrijvingenVakantie
    }
    
    static func getInschrijvingen(inschrijvingenId: [String]) /*-> [InschrijvingVakantie]*/ {
    var inschrijvingen: [InschrijvingVakantie] = []
    
    //var iv = InschrijvingVakantie.getInschrijvingenMetId(inschrijvingen)
    
    
    
    }*/
    
}