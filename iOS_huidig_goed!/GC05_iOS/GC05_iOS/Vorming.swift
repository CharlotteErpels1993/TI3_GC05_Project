import Foundation

class Vorming: Activiteit {
    //var periodes: [String]?
    var prijs: Double?
    var criteriaDeelnemers: String?
    var websiteLocatie: String?
    var tips: String?
    var betalingWijze: String?
    var inbegrepenPrijs: String?
    
    
    override init(id: String) {
        super.init(id: id)
    }
}