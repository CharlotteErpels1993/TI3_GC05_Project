import Foundation

class Voorkeur
{
    var id: String
    var data: String // TYPE?
    var monitor: Monitor
    var vakantie: Vakantie

    init(id: String, data: String, monitor: Monitor, vakantie: Vakantie) {
        self.id = id
        self.data = data
        self.monitor = monitor
        self.vakantie = vakantie
    }
}