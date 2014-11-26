import Foundation

class InschrijvingVorming
{
    var id: String
    var periode: String?
    var monitor: Monitor?
    var vorming: Vorming?
    
    init(id: String) {
        self.id = id
    }
    
    /*init(inschrijving: PFObject) {
        self.id = inschrijving.objectId
        self.periode = inschrijving["periode"] as? String
        self.monitor = inschrijving["monitor"] as? Monitor
        self.vorming = inschrijving["vorming"] as? Vorming
    }*/
    
    init(id: String, periode: String, monitor: Monitor, vorming: Vorming) {
        self.id = id
        self.periode = periode
        self.monitor = monitor
        self.vorming = vorming
    }
}