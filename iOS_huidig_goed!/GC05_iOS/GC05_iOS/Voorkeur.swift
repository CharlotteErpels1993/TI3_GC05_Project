import Foundation

class Voorkeur {
    var id: String
    var data: String?
    var monitor: Monitor?
    var vakantie: Vakantie?

    init(id: String) {
        self.id = id
    }
}