import Foundation

class Feedback {
    var id: String
    var datum: NSDate?
    var goedgekeurd: Bool?
    var vakantie: Vakantie?
    var gebruiker: Gebruiker?
    var waardering: String?
    var score: Int?
    
    init(id: String) {
        self.id = id
        self.vakantie = Vakantie(id: "test")
        self.gebruiker = Gebruiker(id: "test")
        self.datum = NSDate()
    }
}