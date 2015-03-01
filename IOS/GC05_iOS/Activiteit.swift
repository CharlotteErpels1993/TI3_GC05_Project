import Foundation

class Activiteit {
    
    var id : String!
    var titel: String?
    var locatie: String?
    var korteBeschrijving: String?
    var periodes: [String]?
    
    init(id: String) {
        self.id = id
    }
    
    func periodesToString(periodes: [String]) -> String {
        var periodesString: String = ""
        
        var teller: Int = 0
        
        for periode in periodes {
            
            if teller != 0 {
                periodesString.extend(", \n")
            }
            
            periodesString.extend(periode)
            teller += 1
        }
        return periodesString
    }

}
