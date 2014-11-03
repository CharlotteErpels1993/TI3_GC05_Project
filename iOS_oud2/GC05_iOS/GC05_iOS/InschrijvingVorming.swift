import Foundation

class InschrijvingVorming
{
    var id: String
    var begindatum: Date
    var einddatum: Date
    var monitor: Monitor
    var vakantie: Vakantie
    
    init(id: String, begindatum: Date, einddatum: Date, monitor: Monitor, vakantie: Vakantie) {
        self.id = id
        self.begindatum = begindatum
        self.einddatum = einddatum
        self.monitor = monitor
        self.vakantie = vakantie
    }
}