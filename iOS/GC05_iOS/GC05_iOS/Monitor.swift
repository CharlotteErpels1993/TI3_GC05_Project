import Foundation

class Monitor: Gebruiker
{
    var linkFacebook: String
    var lidNr: Int
    
    init(id: String, email: String, wachtwoord: String, voornaam: String, naam: String, straat: String, nummer: Int, bus: String, gemeente: String, postcode: Int, telefoon: String, gsm: String, aansluitingsNr: Int, codeGerechtigde: Int, linkFacebook: String, lidNr: Int)
    {
        self.linkFacebook = linkFacebook
        self.lidNr = lidNr
        super.init(id: id, email: email, wachtwoord: wachtwoord, voornaam: voornaam, naam: naam, straat: straat, nummer: nummer, bus: bus, gemeente: gemeente, postcode: postcode, telefoon: telefoon, gsm: gsm, aansluitingsNr: aansluitingsNr, codeGerechtigde: codeGerechtigde)
    }
}