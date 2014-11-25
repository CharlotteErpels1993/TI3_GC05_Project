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
    
    static func getAlleVormingen() -> [Vorming] {
        return VormingSQL.getAlleVormingen()
    }
    
    static func parseContactpersoonNoodToDatabase(contactpersoon: ContactpersoonNood, inschrijvingId: String) {
        
        ContactpersoonNoodSQL.parseContactpersoonNoodToDatabase(contactpersoon, inschrijvingId: inschrijvingId)
    }
    
    static func parseDeelnemerToDatabase(deelnemer: Deelnemer, inschrijvingId: String) {
        DeelnemerSQL.parseDeelnemerToDatabase(deelnemer, inschrijvingId: inschrijvingId)
    }
    
    static func parseInschrijvingVakantieToDatabase(inschrijving: InschrijvingVakantie) -> String {
        return InschrijvingVakantieSQL.parseInschrijvingVakantieToDatabase(inschrijving)
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
    
    static func deleteVormingTable() {
        
        var response: ([String], Int?) = SD.existingTables()
        
        if response.1 == nil {
            if contains(response.0, "Vorming") {
                let err = SD.deleteTable("Vorming")
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
}