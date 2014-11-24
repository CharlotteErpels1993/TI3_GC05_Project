import Foundation
import UIKit

struct /*class*/ ParseData {
    
    /*var vakantieSQL: VakantieSQL
    var monitorSQL: MonitorSQL
    var voorkeurSQL: VoorkeurSQL
    var inschrijvingVormingSQL: InschrijvingVormingSQL
    var vormingSQL: VormingSQL
    var contactpersoonNoodSQL: ContactpersoonNoodSQL
    var deelnemerSQL: DeelnemerSQL
    var inschrijvingVakantieSQL: InschrijvingVakantieSQL
    var userSQL: UserSQL
    var ouderSQL: OuderSQL
    var afbeeldingSQL: AfbeeldingSQL*/
    
    /*init() {
        self.vakantieSQL = VakantieSQL()
        self.monitorSQL = MonitorSQL()
        self.voorkeurSQL = VoorkeurSQL()
        self.inschrijvingVormingSQL = InschrijvingVormingSQL()
        self.vormingSQL = VormingSQL()
        self.contactpersoonNoodSQL = ContactpersoonNoodSQL()
        self.deelnemerSQL = DeelnemerSQL()
        self.inschrijvingVakantieSQL = InschrijvingVakantieSQL()
        self.userSQL = UserSQL()
        self.ouderSQL = OuderSQL()
        self.afbeeldingSQL = AfbeeldingSQL()
    }*/
    
    static func createDatabase() {
        createTabellen()
        vulTabellenOp()
    }
    
    static private func createTabellen() {
        
        var response: ([String], Int?) = SD.existingTables()
        
        if response.1 == nil {
            //geen error
            
            if !contains(response.0, "User") {
                createUserTable()
            }
            if !contains(response.0, "Afbeelding") {
                createAfbeeldingTable()
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
    
    static private func vulTabellenOp() {
        vulUserTableOp()
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
        //let err = SD.deleteTable("TableName")
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
        return UserSQL.zoekUserMetEmailEnWachtwoord(email, wachtwoord: wachtwoord)
    }
    
    static func parseOuderToDatabase(ouder: Ouder) {
        OuderSQL.parseOuderToDatabase(ouder)
    }
    
    static func getAfbeeldingenMetVakantieId(vakantieId: String) -> [UIImage]{
        return AfbeeldingSQL.getAfbeeldingenMetVakantieId(vakantieId)
    }
    
    static func getAlleVakanties() -> [Vakantie] {
        return VakantieSQL.getAlleVakanties()
    }
    
    static private func vulUserTableOp() {
        UserSQL.vulUserTableOp()
    }
    
    static private func vulMonitorTableOp() {
        MonitorSQL.vulMonitorTableOp()
    }
    
    static private func vulOuderTableOp() {
        OuderSQL.vulOuderTableOp()
    }
    
    static private func vulVakantieTableOp() {
        VakantieSQL.vulVakantieTableOp()
    }
    
    static private func vulVormingTableOp() {
        VormingSQL.vulVormingTableOp()
    }
    
    static private func vulAfbeeldingTableOp() {
        AfbeeldingSQL.vulAfbeeldingTableOp()
    }
    
    static private func createUserTable() {
       UserSQL.createUserTable()
    }
    
    static private func createAfbeeldingTable() {
        AfbeeldingSQL.createAfbeeldingTable()
    }
    
    static private func createContactpersoonNoodTable() {
        ContactpersoonNoodSQL.createContactpersoonNoodTable()
    }
    
    static private func createDeelnemerTable() {
        DeelnemerSQL.createDeelnemerTable()
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