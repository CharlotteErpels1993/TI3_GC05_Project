import Foundation
import UIKit

class ParseData {
    
    var vakantieSQL: VakantieSQL
    var monitorSQL: MonitorSQL
    var voorkeurSQL: VoorkeurSQL
    var inschrijvingVormingSQL: InschrijvingVormingSQL
    var vormingSQL: VormingSQL
    var contactpersoonNoodSQL: ContactpersoonNoodSQL
    var deelnemerSQL: DeelnemerSQL
    var inschrijvingVakantieSQL: InschrijvingVakantieSQL
    var userSQL: UserSQL
    var ouderSQL: OuderSQL
    var afbeeldingSQL: AfbeeldingSQL
    
    init() {
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
    }
    
    func createDatabase() {
        createTabellen()
        vulTabellenOp()
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
    
    func zoekAlleMonitors() -> [Monitor] {
        return self.monitorSQL.zoekAlleMonitors()
    }
    
    func parseVoorkeurToDatabase(voorkeur: Voorkeur) {
        self.voorkeurSQL.parseVoorkeurToDatabase(voorkeur)
    }
    
    func deleteAllTables() {
        //let err = SD.deleteTable("TableName")
        var response: ([String], Int?) = SD.existingTables()
        
        if response.1 == nil {
            //geen error
            
            for table in response.0 {
                let err = SD.deleteTable(table)
            }
        }
    }
    
    func parseInschrijvingVormingToDatabase(inschrijving: InschrijvingVorming) {
        self.inschrijvingVormingSQL.parseInschrijvingVormingToDatabase(inschrijving)
    }

    func getMonitorWithEmail(email: String) -> Monitor {
        return self.monitorSQL.getMonitorWithEmail(email)
    }
    
    func getAlleVormingen() -> [Vorming] {
        return self.vormingSQL.getAlleVormingen()
    }
    
    func parseContactpersoonNoodToDatabase(contactpersoon: ContactpersoonNood, inschrijvingId: String) {
        
        self.contactpersoonNoodSQL.parseContactpersoonNoodToDatabase(contactpersoon, inschrijvingId: inschrijvingId)
    }
    
    func parseDeelnemerToDatabase(deelnemer: Deelnemer, inschrijvingId: String) {
        self.deelnemerSQL.parseDeelnemerToDatabase(deelnemer, inschrijvingId: inschrijvingId)
    }
    
    func parseInschrijvingVakantieToDatabase(inschrijving: InschrijvingVakantie) -> String {
        return self.inschrijvingVakantieSQL.parseInschrijvingVakantieToDatabase(inschrijving)
    }
    
    func zoekUserMetEmailEnWachtwoord(email: String, wachtwoord: String) -> PFUser {
        return self.userSQL.zoekUserMetEmailEnWachtwoord(email, wachtwoord: wachtwoord)
    }
    
    func parseOuderToDatabase(ouder: Ouder) {
        self.ouderSQL.parseOuderToDatabase(ouder)
    }
    
    func getAfbeeldingenMetVakantieId(vakantieId: String) -> [UIImage]{
        return self.afbeeldingSQL.getAfbeeldingenMetVakantieId(vakantieId)
    }
    
    func getAlleVakanties() -> [Vakantie] {
        return self.vakantieSQL.getAlleVakanties()
    }
    
    private func vulUserTableOp() {
        self.userSQL.vulUserTableOp()
    }
    
    private func vulMonitorTableOp() {
        self.monitorSQL.vulMonitorTableOp()
    }
    
    private func vulOuderTableOp() {
        self.ouderSQL.vulOuderTableOp()
    }
    
    private func vulVakantieTableOp() {
        self.vakantieSQL.vulVakantieTableOp()
    }
    
    private func vulVormingTableOp() {
        self.vormingSQL.vulVormingTableOp()
    }
    
    private func vulAfbeeldingTableOp() {
        self.afbeeldingSQL.vulAfbeeldingTableOp()
    }
    
    private func createUserTable() {
       self.userSQL.createUserTable()
    }
    
    private func createAfbeeldingTable() {
        self.afbeeldingSQL.createAfbeeldingTable()
    }
    
    private func createContactpersoonNoodTable() {
        self.contactpersoonNoodSQL.createContactpersoonNoodTable()
    }
    
    private func createDeelnemerTable() {
        self.deelnemerSQL.createDeelnemerTable()
    }
    
    private func createInschrijvingVakantieTable() {
        self.inschrijvingVakantieSQL.createInschrijvingVakantieTable()
    }
    
    private func createInschrijvingVormingTable() {
        self.inschrijvingVormingSQL.createInschrijvingVormingTable()
    }
    
    private func createMonitorTable() {
        self.monitorSQL.createMonitorTable()
    }
    
    private func createOuderTable() {
        self.ouderSQL.createOuderTable()
    }
    
    private func createVakantieTable() {
        self.vakantieSQL.createVakantieTable()
    }
    
    private func createVoorkeurTable() {
        self.voorkeurSQL.createVoorkeurTable()
    }
    
    private func createVormingTable() {
        self.vormingSQL.createVormingTable()
    }
    
}