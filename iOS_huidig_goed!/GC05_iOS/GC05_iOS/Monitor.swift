import Foundation

class Monitor: Gebruiker
{
    var linkFacebook: String?
    var lidNr: Int?
    
    init(monitor: PFObject) {
        super.init(gebruiker: monitor)
    }
    
    override init(rijksregisterNr: String, email: String, wachtwoord: String, voornaam: String, naam: String, straat: String, nummer: Int, bus: String, gemeente: String, postcode: Int, telefoon: String, gsm: String, aansluitingsNr: Int, codeGerechtigde: Int)
    {
        super.init(rijksregisterNr: rijksregisterNr, email: email, wachtwoord: wachtwoord, voornaam: voornaam, naam: naam, straat: straat, nummer: nummer, bus: bus, gemeente: gemeente, postcode: postcode, telefoon: telefoon, gsm: gsm, aansluitingsNr: aansluitingsNr, codeGerechtigde: codeGerechtigde)
    }
    
    init(rijksregisterNr: String, email: String, wachtwoord: String, voornaam: String, naam: String, straat: String, nummer: Int, bus: String, gemeente: String, postcode: Int, telefoon: String, gsm: String, aansluitingsNr: Int, codeGerechtigde: Int, linkFacebook: String, lidNr: Int)
    {
        self.linkFacebook = linkFacebook
        self.lidNr = lidNr
        super.init(rijksregisterNr: rijksregisterNr, email: email, wachtwoord: wachtwoord, voornaam: voornaam, naam: naam, straat: straat, nummer: nummer, bus: bus, gemeente: gemeente, postcode: postcode, telefoon: telefoon, gsm: gsm, aansluitingsNr: aansluitingsNr, codeGerechtigde: codeGerechtigde)
    }
    
    init(id: String, rijksregisterNr: String, email: String, wachtwoord: String, voornaam: String, naam: String, straat: String, nummer: Int, bus: String, gemeente: String, postcode: Int, telefoon: String, gsm: String, aansluitingsNr: Int, codeGerechtigde: Int, linkFacebook: String, lidNr: Int)
    {
        self.linkFacebook = linkFacebook
        self.lidNr = lidNr
        super.init(id: id, rijksregisterNr: rijksregisterNr, email: email, wachtwoord: wachtwoord, voornaam: voornaam, naam: naam, straat: straat, nummer: nummer, bus: bus, gemeente: gemeente, postcode: postcode, telefoon: telefoon, gsm: gsm, aansluitingsNr: aansluitingsNr, codeGerechtigde: codeGerechtigde)
    }
}