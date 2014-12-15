import Foundation

class Favoriet {
    var id: String
    //var ouder: Ouder?
    var gebruiker: Gebruiker?
    var vakantie: Vakantie?
    
    init(id: String) {
        self.id = id
    }
    
    init(id: String, /*ouder: Ouder,*/ gebruiker: Gebruiker, vakantie: Vakantie) {
        self.id = id
        self.gebruiker = gebruiker
        self.vakantie = vakantie
    }
}