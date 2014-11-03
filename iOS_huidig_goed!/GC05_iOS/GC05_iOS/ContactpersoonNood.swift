import Foundation

class ContactpersoonNood
{
    var id: String
    var voornaam: String
    var naam: String
    var telefoon: String
    var gsm: String
    var inschrijvingVakantie: InschrijvingVakantie
    
    init(id: String, voornaam: String, naam: String, telefoon: String, gsm: String, inschrijvingVakantie: InschrijvingVakantie) {
        self.id = id
        self.naam = naam
        self.voornaam = voornaam
        self.telefoon = telefoon
        self.gsm = gsm
        self.inschrijvingVakantie = inschrijvingVakantie
    }
}