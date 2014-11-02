class Vakantie: Activiteit {
    
    // ID? 
    let beginDatum: datum
    let terugkeerDatum: datum
    let aantalDagenNachten: String
    let vervoerwijze: String
    let formule: String
    let basisprijs: Double
    let bondMoysonLedenPrijs: Double
    let sterPrijs: Double
    let kortingen: String // TYPE?
    let inbegrepenPrijs: String
    let doelgroep: String // TYPE?
    let maxAantalDeelnemers: Int
    
    init(beginDatum: datum, terugkeerDatum: datum, aantalDagenNachten: String, vervoerwijze: String, formule: String, basisprijs: Double, bondMoysonLedenPrijs: Double, sterPrijs: Double, kortingen: String, inbegrepenPrijs: String, doelgroep: String, maxAantalDeelnemers: Int, titel: String, locatie: String, korteBeschrijving: String) {

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
        
        super.init(titel: titel, locatie: locatie,korteBeschrijving: korteBeschrijving)
    }
    
}