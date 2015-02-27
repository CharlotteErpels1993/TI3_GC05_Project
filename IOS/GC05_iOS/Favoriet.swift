import Foundation

class Favoriet {
    var id: String
    var gebruiker: Gebruiker?
    var vakantie: Vakantie?
    
    init(id: String) {
        self.id = id
    }
}