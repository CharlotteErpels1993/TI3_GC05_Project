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
}
