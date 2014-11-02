import Foundation

class Deelnemer
{
    var id: String
    var voornaam: String
    var naam: String
    var geboortedatum: Date //zelfgemaakte klasse/type, want swift heeft geen date type
    var straat: String
    var nummer: Int
    var bus: String
    var gemeente: String
    var postcode: Int
    var inschrijvingVakantie: InschrijvingVakantie
    
    init(id: String, voornaam: String, naam: String, geboortedatum: Date, straat: String, nummer: Int, bus: String, gemeente: String, postcode: Int, inschrijvingVakantie: InschrijvingVakantie) {
        self.id = id
        self.voornaam = voornaam
        self.naam = naam
        self.straat = straat
        self.nummer = nummer
        self.bus = bus
        self.gemeente = gemeente
        self.postcode = postcode
        self.inschrijvingVakantie = inschrijvingVakantie
        self.geboortedatum = geboortedatum
    }
}
