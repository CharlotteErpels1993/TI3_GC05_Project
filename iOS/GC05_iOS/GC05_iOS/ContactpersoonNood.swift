class ContactpersoonNood {
    
    // ID?
    let voornaam: String
    let naam: String
    let telefoon: String
    let gsm: String
    let inschrijvingVakantieId: InschrijvenVakantie
    
    init(voornaam: String, naam: String, telefoon: String, gsm: String, inschrijvingVakantieId: InschrijvenVakantie) {
        self.naam = naam
        self.voornaam = voornaam
        self.telefoon = telefoon
        self.gsm = gsm
        self.inschrijvingVakantieId = inschrijvingVakantieId
    }
}