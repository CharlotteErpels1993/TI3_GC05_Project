import Foundation

class Favoriet
{
    var id: String
    var ouder: Ouder?
    var vakantie: Vakantie?
    
    init(id: String) {
        self.id = id
    }
    
    /*init(inschrijving: PFObject) {
    self.id = inschrijving.objectId
    self.periode = inschrijving["periode"] as? String
    self.monitor = inschrijving["monitor"] as? Monitor
    self.vorming = inschrijving["vorming"] as? Vorming
    }*/
    
    init(id: String, ouder: Ouder, vakantie: Vakantie) {
        self.id = id
        self.ouder = ouder
        self.vakantie = vakantie
    }
}