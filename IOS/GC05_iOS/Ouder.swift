import Foundation

class Ouder: Gebruiker {
    var aansluitingsNrTweedeOuder: Int?
    
    override init(id: String) {
        super.init(id: id)
    }
}