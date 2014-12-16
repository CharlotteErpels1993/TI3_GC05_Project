import Foundation

class ContactpersoonNood {
    var id: String
    var voornaam: String?
    var naam: String?
    var telefoon: String?
    var gsm: String?
    
    init(id: String) {
        self.id = id
    }
}