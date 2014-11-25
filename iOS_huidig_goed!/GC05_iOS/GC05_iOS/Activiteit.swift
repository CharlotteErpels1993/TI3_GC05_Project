import Foundation

class Activiteit
{
    var id : String
    var titel: String?
    var locatie: String?
    var korteBeschrijving: String?
    
    init(id: String) {
        self.id = id
    }
    
    init(activiteit: PFObject) {
        self.id = activiteit.objectId
        self.titel = activiteit["titel"] as? String
        self.locatie = activiteit["locatie"] as? String
        self.korteBeschrijving = activiteit["korteBeschrijving"] as? String
    }
    
    init(id: String, titel: String, locatie: String, korteBeschrijving: String) {
        self.id = id
        self.titel = titel
        self.locatie = locatie
        self.korteBeschrijving = korteBeschrijving
    }
}
