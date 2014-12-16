import Foundation

class Vorming: Activiteit {
    var periodes: [String]?
    var prijs: Double?
    var criteriaDeelnemers: String?
    var websiteLocatie: String?
    var tips: String?
    var betalingWijze: String?
    var inbegrepenPrijs: String?
    
    
    override init(id: String) {
        super.init(id: id)
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