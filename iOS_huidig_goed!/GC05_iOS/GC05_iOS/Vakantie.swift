import Foundation

class Vakantie: Activiteit {
    
    var vertrekdatum: NSDate!
    var terugkeerdatum: NSDate!
    var aantalDagenNachten: String?
    var vervoerwijze: String?
    var formule: String?
    var link: String?
    var basisprijs: Double?
    var bondMoysonLedenPrijs: Double?
    var sterPrijs1ouder: Double?
    var sterPrijs2ouders: Double?
    var inbegrepenPrijs: String?
    var minLeeftijd: Int!
    var maxLeeftijd: Int?
    var maxAantalDeelnemers: Int?
    
    override init(id: String) {
        super.init(id: id)
    }
}