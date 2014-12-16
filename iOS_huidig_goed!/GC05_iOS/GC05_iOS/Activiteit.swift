import Foundation

class Activiteit {
    var id : String
    var titel: String?
    var locatie: String?
    var korteBeschrijving: String?
    
    init(id: String) {
        self.id = id
    }
}
