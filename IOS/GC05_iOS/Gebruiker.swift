import Foundation

class Gebruiker {
    var id: String?
    var rijksregisterNr: String?
    var email: String?
    var voornaam: String?
    var naam: String?
    var straat: String?
    var nummer: Int?
    var bus: String?
    var gemeente: String?
    var postcode: Int?
    var telefoon: String?
    var gsm: String?
    var aansluitingsNr: Int?
    var codeGerechtigde: Int?
    
    init(id: String) {
        self.id = id
    }
}