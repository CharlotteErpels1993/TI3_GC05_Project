import Foundation

class Favoriet {
    var id: String
    var ouder: Ouder?
    var vakantie: Vakantie?
    
    init(id: String) {
        self.id = id
    }
    
    init(id: String, ouder: Ouder, vakantie: Vakantie) {
        self.id = id
        self.ouder = ouder
        self.vakantie = vakantie
    }
}