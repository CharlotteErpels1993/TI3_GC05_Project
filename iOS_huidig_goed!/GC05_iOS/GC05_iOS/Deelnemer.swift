import Foundation

class Deelnemer {
    var id: String
    var voornaam: String?
    var naam: String?
    var geboortedatum: NSDate? 
    var straat: String?
    var nummer: Int?
    var bus: String?
    var gemeente: String?
    var postcode: Int?
    
    init(id: String) {
        self.id = id
    }
    
    init(id: String, voornaam: String, naam: String, geboortedatum: NSDate, straat: String, nummer: Int, bus: String, gemeente: String, postcode: Int) {
        self.id = id
        self.voornaam = voornaam
        self.naam = naam
        self.straat = straat
        self.nummer = nummer
        self.bus = bus
        self.gemeente = gemeente
        self.postcode = postcode
        self.geboortedatum = geboortedatum
    }
}
