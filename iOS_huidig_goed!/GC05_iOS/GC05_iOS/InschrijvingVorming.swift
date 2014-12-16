import Foundation

class InschrijvingVorming {
    var id: String
    var periode: String?
    var monitor: Monitor?
    var vorming: Vorming?
    
    init(id: String) {
        self.id = id
    }
}