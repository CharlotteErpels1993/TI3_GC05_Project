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
            if !contains(response.0, "Monitor") {
                createMonitorTable()
            }
            if !contains(response.0, "Ouder") {
                createOuderTable()
            }
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
        vulMonitorTableOp()
        vulOuderTableOp()
        vulVakantieTableOp()
    }
    
    static func getAlleMonitors() -> [Monitor] {
        return MonitorSQL.zoekAlleMonitors()
    }
    
    static func parseVoorkeurToDatabase(voorkeur: Voorkeur) {
        VoorkeurSQL.parseVoorkeurToDatabase(voorkeur)
    }
    
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
    
    static func parseInschrijvingVormingToDatabase(inschrijving: InschrijvingVorming) {
        InschrijvingVormingSQL.parseInschrijvingVormingToDatabase(inschrijving)
    }

    static func getMonitorWithEmail(email: String) -> Monitor {
        return MonitorSQL.getMonitorWithEmail(email)
    }
    
    static func getOuderWithEmail(email: String) -> Ouder {
        return OuderSQL.getOuderWithEmail(email)
    }
    
    static func getAlleVormingen() -> [Vorming] {
        return VormingSQL.getAlleVormingen()
    }
    
    static func parseContactpersoonNoodToDatabase(contactpersoon: ContactpersoonNood) -> String {
        
        return ContactpersoonNoodSQL.parseContactpersoonNoodToDatabase(contactpersoon)
    }
    
    static func parseDeelnemerToDatabase(deelnemer: Deelnemer) -> String {
        return DeelnemerSQL.parseDeelnemerToDatabase(deelnemer)
    }
    
    static func parseInschrijvingVakantieToDatabase(inschrijving: InschrijvingVakantie) {
        InschrijvingVakantieSQL.parseInschrijvingVakantieToDatabase(inschrijving)
    }
    
    static func getUserMetEmailEnWachtwoord(email: String, wachtwoord: String) -> PFUser {
        
        var query = PFUser.query()
        query.whereKey("email", equalTo: email)
        query.whereKey("password", equalTo: wachtwoord)
        
        var users: [PFUser] = query.findObjects() as [PFUser]
        return users.first!
        
        //return UserSQL.zoekUserMetEmailEnWachtwoord(email, wachtwoord: wachtwoord)
    }
    
    static func parseOuderToDatabase(ouder: Ouder) {
        OuderSQL.parseOuderToDatabase(ouder)
    }
    
    static func getAfbeeldingenMetVakantieId(vakantieId: String) -> [UIImage] {
        //return AfbeeldingSQL.getAfbeeldingenMetVakantieId(vakantieId)
        
        //onnodig extra afbeeldingen opslaan op device, beter om deze rechtstreeks van parse op te halen
        
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
        
        return afbeeldingen
    }
    
    static func getAlleVakanties() -> [Vakantie] {
        return VakantieSQL.getAlleVakanties()
    }
    
    /*static private func vulUserTableOp() {
        UserSQL.vulUserTableOp()
    }*/
    
    static private func vulMonitorTableOp() {
        MonitorSQL.vulMonitorTableOp()
    }
    
    static private func vulOuderTableOp() {
        OuderSQL.vulOuderTableOp()
    }
    
    static private func vulVakantieTableOp() {
        VakantieSQL.vulVakantieTableOp()
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
    
    static func vulInschrijvingVakantieTableOp() {
        
        var response: ([String], Int?) = SD.existingTables()
        
        if response.1 == nil {
            if !contains(response.0, "InschrijvingVakantie") {
                createInschrijvingVormingTable()
            }
        }
        
        InschrijvingVakantieSQL.vulInschrijvingVakantieTableOp()
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
    
    static func vulInschrijvingVormingTableOp() {
        
        var response: ([String], Int?) = SD.existingTables()
        
        if response.1 == nil {
            if !contains(response.0, "InschrijvingVorming") {
                createInschrijvingVormingTable()
            }
        }
        
        InschrijvingVormingSQL.vulInschrijvingVormingTableOp()
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
    
    /*static private func createUserTable() {
       UserSQL.createUserTable()
    }*/
    
    static private func createAfbeeldingTable() {
        AfbeeldingSQL.createAfbeeldingTable()
    }
    
    static private func createInschrijvingVormingTable() {
        InschrijvingVormingSQL.createInschrijvingVormingTable()
    }
    
    static private func createMonitorTable() {
        MonitorSQL.createMonitorTable()
    }
    
    static private func createVoorkeurTable() {
        VoorkeurSQL.createVoorkeurTable()
    }
    
    static private func createOuderTable() {
        OuderSQL.createOuderTable()
    }
    
    static private func createVakantieTable() {
        VakantieSQL.createVakantieTable()
    }
    
    static private func createVormingTable() {
        VormingSQL.createVormingTable()
    }
    
    static func getMonitorsMetDezelfdeVormingen(monitorId: String) -> [Monitor] {
        var vormingen = InschrijvingVormingSQL.getVormingIdMetMonitorId(monitorId)
        var monitorIds = InschrijvingVormingSQL.getMonitorsIdMetVormingId(vormingen)
        var monitors = MonitorSQL.getMonitorsMetId(monitorIds)
        
        return monitors
    }
    
    static func getMonitorsMetAndereVormingen(monitorsMetDezelfdeVorming: [Monitor]) -> [Monitor] {
        return MonitorSQL.getAndereMonitors(monitorsMetDezelfdeVorming)
    }
    
    static func updateMonitor(monitor: Monitor) {
        MonitorSQL.updateMonitor(monitor, email: PFUser.currentUser().email)
    }
    
    static func getInschrijvingenVakantie(inschrijving: InschrijvingVakantie) -> [InschrijvingVakantie] {
        
        var voornaam: String! = inschrijving.deelnemer?.voornaam
        var naam: String! = inschrijving.deelnemer?.naam
        var vakantieId: String! = inschrijving.vakantie?.id
        var ouderId: String! = inschrijving.ouder?.id
        
        return InschrijvingVakantieSQL.getInschrijvingenVakantie(voornaam, naamDeelnemer: naam, vakantieId: vakantieId, ouderId: ouderId)
        
    }
    
    static func getInschrijvingenVorming(inschrijving: InschrijvingVorming) -> [InschrijvingVorming] {
        var monitorId: String! = inschrijving.monitor?.id
        var vormingId: String! = inschrijving.vorming?.id
        var periode: String! = inschrijving.periode
        
        return InschrijvingVormingSQL.getInschrijvingenVorming(monitorId, vormingId: vormingId, periode: periode)
    }
    
    static func getVoorkeurenVakantie(voorkeur: Voorkeur) -> [Voorkeur] {
    
        //CHARLOTTE!
    
        var monitorId: String! = voorkeur.monitor?.id
        var vakantieId: String! = voorkeur.vakantie?.id
        
        return VoorkeurSQL.getVoorkeuren(monitorId, vakantieId: vakantieId)
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