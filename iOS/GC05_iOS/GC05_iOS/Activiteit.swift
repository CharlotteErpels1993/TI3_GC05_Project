import Foundation

class Activiteit
{
    var id : String
    var titel: String
    var locatie: String
    var korteBeschrijving: String
    
    init(id: String, titel: String, locatie: String, korteBeschrijving: String) {
        self.id = id
        self.titel = titel
        self.locatie = locatie
        self.korteBeschrijving = korteBeschrijving
    }
}