import Foundation

class InschrijvingVakantie
{
    var id: String
    var extraInfo: String?
    var vakantie: Vakantie?
    
    init(id: String) {
        self.id = id
    }
    
    init(id: String, extraInfo: String, vakantie: Vakantie) {
        self.id = id
        self.extraInfo = extraInfo
        self.vakantie = vakantie
    }
}