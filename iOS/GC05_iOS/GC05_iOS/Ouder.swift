import Foundation

class Ouder: Gebruiker
{
    var aansluitingsNrTweedeOuder: Int
    
    init(id: String, email: String, wachtwoord: String, voornaam: String, naam: String, straat: String, nummer: Int, bus: String, gemeente: String, postcode: Int, telefoon: String, gsm: String, aansluitingsNr: Int, codeGerechtigde: Int, aansluitingsNrTweedeOuder: Int)
    {
        self.aansluitingsNrTweedeOuder = aansluitingsNrTweedeOuder
        super.init(id: id, email: email, wachtwoord: wachtwoord, voornaam: voornaam, naam: naam, straat: straat, nummer: nummer, bus: bus, gemeente: gemeente, postcode: postcode, telefoon: telefoon, gsm: gsm, aansluitingsNr: aansluitingsNr, codeGerechtigde: codeGerechtigde)
    }
}