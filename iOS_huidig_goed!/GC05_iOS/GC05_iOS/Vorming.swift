import Foundation

class Vorming: Activiteit
{
    var periodes: String // TYPE?
    var prijs: Double
    var criteriaDeelnemers: String
    var websiteLocatie: String
    var tips: String
    var betalingWijze: String
    
    init(id: String, titel: String, locatie: String, korteBeschrijving: String, periodes: String, prijs: Double, criteriaDeelnemers: String, websiteLocatie: String, tips: String, betalingWijze: String) {
        
        self.periodes = periodes
        self.prijs = prijs
        self.criteriaDeelnemers = criteriaDeelnemers
        self.websiteLocatie = websiteLocatie
        self.tips = tips
        self.betalingWijze = betalingWijze
        
        super.init(id: id, titel: titel, locatie: locatie,korteBeschrijving: korteBeschrijving)
    }
    
}