import Foundation

class InschrijvingVakantie {
    var id: String
    var extraInfo: String?
    var vakantie: Vakantie?
    var periode: String? 
    var ouder: Ouder?
    var deelnemer: Deelnemer?
    var contactpersoon1: ContactpersoonNood?
    var contactpersoon2: ContactpersoonNood?
    
    init(id: String) {
        self.id = id
    }
}