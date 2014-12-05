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
    
    init(id: String, titel: String, locatie: String, korteBeschrijving: String, periodes: [String], prijs: Double, criteriaDeelnemers: String, websiteLocatie: String, tips: String, betalingWijze: String) {
        
        self.periodes = periodes
        self.prijs = prijs
        self.criteriaDeelnemers = criteriaDeelnemers
        self.websiteLocatie = websiteLocatie
        self.tips = tips
        self.betalingWijze = betalingWijze
        
        super.init(id: id, titel: titel, locatie: locatie,korteBeschrijving: korteBeschrijving)
    }
    
    private func checkPrijsValid(p: Double) -> Bool {
        if p <= 0.0 {
            return false
        }
        return false
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