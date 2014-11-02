import Foundation

class Gebruiker
{
    var id: String?
    var rijksregisterNr: String
    var email: String
    var wachtwoord: String
    var voornaam: String
    var naam: String
    var straat: String
    var nummer: Int
    var bus: String
    var gemeente: String
    var postcode: Int
    var telefoon: String
    var gsm: String
    var aansluitingsNr: Int
    var codeGerechtigde: Int
    
    init(rijksregisterNr: String, email: String, wachtwoord: String, voornaam: String, naam: String, straat: String, nummer: Int, bus: String, gemeente: String, postcode: Int, telefoon: String, gsm: String, aansluitingsNr: Int, codeGerechtigde: Int) {
        self.rijksregisterNr = rijksregisterNr
        self.email = email
        self.wachtwoord = wachtwoord
        self.voornaam = voornaam
        self.naam = naam
        self.straat = straat
        self.nummer = nummer
        self.bus = bus
        self.gemeente = gemeente
        self.postcode = postcode
        self.telefoon = telefoon
        self.gsm = gsm
        self.aansluitingsNr = aansluitingsNr
        self.codeGerechtigde = codeGerechtigde
    }

    
    
    init(id: String, rijksregisterNr: String, email: String, wachtwoord: String, voornaam: String, naam: String, straat: String, nummer: Int, bus: String, gemeente: String, postcode: Int, telefoon: String, gsm: String, aansluitingsNr: Int, codeGerechtigde: Int) {
        self.id = id
        self.rijksregisterNr = rijksregisterNr
        self.email = email
        self.wachtwoord = wachtwoord
        self.voornaam = voornaam
        self.naam = naam
        self.straat = straat
        self.nummer = nummer
        self.bus = bus
        self.gemeente = gemeente
        self.postcode = postcode
        self.telefoon = telefoon
        self.gsm = gsm
        self.aansluitingsNr = aansluitingsNr
        self.codeGerechtigde = codeGerechtigde
    }
}