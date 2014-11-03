import Foundation

class Vakantie: Activiteit
{
    var beginDatum: Date
    var terugkeerDatum: Date
    var aantalDagenNachten: String
    var vervoerwijze: String
    var formule: String
    var basisprijs: Double
    var bondMoysonLedenPrijs: Double
    var sterPrijs: Double
    var kortingen: String // TYPE?
    var inbegrepenPrijs: String
    var doelgroep: String // TYPE?
    var maxAantalDeelnemers: Int
    
    init(id: String, titel: String, locatie: String, korteBeschrijving: String, beginDatum: Date, terugkeerDatum: Date, aantalDagenNachten: String, vervoerwijze: String, formule: String, basisprijs: Double, bondMoysonLedenPrijs: Double, sterPrijs: Double, kortingen: String, inbegrepenPrijs: String, doelgroep: String, maxAantalDeelnemers: Int) {

        self.beginDatum = beginDatum
        self.terugkeerDatum = terugkeerDatum
        self.aantalDagenNachten = aantalDagenNachten
        self.vervoerwijze = vervoerwijze
        self.formule = formule
        self.basisprijs = basisprijs
        self.bondMoysonLedenPrijs = bondMoysonLedenPrijs
        self.sterPrijs = sterPrijs
        self.kortingen = kortingen
        self.inbegrepenPrijs = inbegrepenPrijs
        self.doelgroep = doelgroep
        self.maxAantalDeelnemers = maxAantalDeelnemers
        
        super.init(id: id, titel: titel, locatie: locatie, korteBeschrijving: korteBeschrijving)
    }
    
}