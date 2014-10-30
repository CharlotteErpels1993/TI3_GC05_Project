class Vorming: Activiteit {
    
    // ID?
    let periodes: String // TYPE?
    let prijs: Double
    let criteriaDeelnemers: String
    let websiteLocatie: String
    let tips: String
    let betalingWijze: String
    
    init(periodes: String, prijs: Double, criteriaDeelnemers: String, websiteLocatie: String, tips: String, betalingWijze: String, titel: String, locatie: String, korteBeschrijving: String) {
        
        self.periodes = periodes
        self.prijs = prijs
        self.criteriaDeelnemers = criteriaDeelnemers
        self.websiteLocatie = websiteLocatie
        self.tips = tips
        self.betalingWijze = betalingWijze
        
        super.init(titel: titel, locatie: locatie,korteBeschrijving: korteBeschrijving)
    }
    
}