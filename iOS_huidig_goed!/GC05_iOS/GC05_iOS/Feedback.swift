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
    }
    
    init(id: String, datum: NSDate, goedgekeurd: Bool, vakantie: Vakantie, gebruiker: Gebruiker, waardering: String, score: Int) {
        self.id = id
        self.datum = datum
        self.goedgekeurd = goedgekeurd
        self.vakantie = vakantie
        self.gebruiker = gebruiker
        self.waardering = waardering
        self.score = score
    }
}