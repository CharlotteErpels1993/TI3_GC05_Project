class Deelnemer {

    // ID?
    let voornaam: String
    let naam: String
    let geboortedatum: String // TYPE?
    let straat: String
    let nummer: Int
    let bus: String
    let gemeente: String
    let postcode: Int
    let inschrijvenVakantieId: InschrijvenVakantie
    
    init(voornaam: String, naam: String, geboortedatum: String, straat: String, nummer: Int, bus: String, gemeente: String, postcode: Int, inschrijvenVakantieId: InschrijvenVakantie) {
        self.voornaam = voornaam
        self.naam = naam
        self.straat = straat
        self.nummer = nummer
        self.bus = bus
        self.gemeente = gemeente
        self.postcode = postcode
        self.inschrijvenVakantieId = inschrijvenVakantieId
        self.geboortedatum = geboortedatum
    }
}
