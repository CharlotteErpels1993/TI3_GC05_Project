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
    
    init(id: String, titel: String, locatie: String, korteBeschrijving: String, beginDatum: NSDate, terugkeerDatum: NSDate, aantalDagenNachten: String, vervoerwijze: String, formule: String, basisprijs: Double, bondMoysonLedenPrijs: Double, sterPrijs1: Double, sterPrijs2: Double, kortingen: String, inbegrepenPrijs: String, minLeeftijd: Int, maxLeeftijd: Int, maxAantalDeelnemers: Int, link: String) {
        
        self.vertrekdatum = beginDatum
        self.terugkeerdatum = terugkeerDatum
        self.aantalDagenNachten = aantalDagenNachten
        self.vervoerwijze = vervoerwijze
        self.formule = formule
        self.basisprijs = basisprijs
        self.bondMoysonLedenPrijs = bondMoysonLedenPrijs
        self.sterPrijs1ouder = sterPrijs1
        self.sterPrijs2ouders = sterPrijs2
        self.inbegrepenPrijs = inbegrepenPrijs
        self.minLeeftijd = minLeeftijd
        self.maxLeeftijd = maxLeeftijd
        self.maxAantalDeelnemers = maxAantalDeelnemers
        self.link = link
        
        super.init(id: id, titel: titel, locatie: locatie, korteBeschrijving: korteBeschrijving)
    }
    
    private func checkPrijsValid(p: Double) -> Bool {
        if p < 0.0 {
            return false
        }
        return true
    }
    
    private func checkMaxAantalDeelnemersValid(aantal: Int) -> Bool {
        if aantal <= 0 {
            return false
        }
        return true
    }
}