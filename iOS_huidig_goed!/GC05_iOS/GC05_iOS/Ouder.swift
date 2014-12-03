import Foundation

class Ouder: Gebruiker
{
    var aansluitingsNrTweedeOuder: Int?
    
    override init(id: String) {
        super.init(id: id)
    }
    
    /*init(ouder: PFObject) {
        self.aansluitingsNrTweedeOuder = ouder["aansluitingsNrTweedeOuder"] as? Int
        super.init(gebruiker: ouder)
    }*/
    
    init(rijksregisterNr: String, email: String, wachtwoord: String, voornaam: String, naam: String, straat: String, nummer: Int, bus: String, gemeente: String, postcode: Int, telefoon: String, gsm: String, aansluitingsNr: Int, codeGerechtigde: Int, aansluitingsNrTweedeOuder: Int)
    {
        self.aansluitingsNrTweedeOuder = aansluitingsNrTweedeOuder
        super.init(rijksregisterNr: rijksregisterNr, email: email, wachtwoord: wachtwoord, voornaam: voornaam, naam: naam, straat: straat, nummer: nummer, bus: bus, gemeente: gemeente, postcode: postcode, telefoon: telefoon, gsm: gsm, aansluitingsNr: aansluitingsNr, codeGerechtigde: codeGerechtigde)
    }

    init(id: String, rijksregisterNr: String, email: String, wachtwoord: String, voornaam: String, naam: String, straat: String, nummer: Int, bus: String, gemeente: String, postcode: Int, telefoon: String, gsm: String, aansluitingsNr: Int, codeGerechtigde: Int, aansluitingsNrTweedeOuder: Int)
    {
        self.aansluitingsNrTweedeOuder = aansluitingsNrTweedeOuder
        super.init(id: id, rijksregisterNr: rijksregisterNr, email: email, wachtwoord: wachtwoord, voornaam: voornaam, naam: naam, straat: straat, nummer: nummer, bus: bus, gemeente: gemeente, postcode: postcode, telefoon: telefoon, gsm: gsm, aansluitingsNr: aansluitingsNr, codeGerechtigde: codeGerechtigde)
    }
}