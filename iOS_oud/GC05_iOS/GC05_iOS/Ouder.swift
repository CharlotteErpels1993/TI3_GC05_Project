class Ouder: Gebruiker {
    
    // ID?
    let aansluitingsNrTweedeOuder: Int
    
    init(aansluitingsNrTweedeOuder: Int, aansluitingsNr: Int, codeGerechtigde: Int, email: String, wachtwoord: String, voornaam: String, naam: String, straat: String, nummer: Int, bus: String, gemeente: String, postcode: Int, telefoon: String, gsm: String) {
        self.aansluitingsNrTweedeOuder = aansluitingsNrTweedeOuder
        
        super.init(email: email, wachtwoord: wachtwoord, voornaam: voornaam, naam: naam, straat: straat, nummer: nummer, bus: bus, gemeente: gemeente, postcode: postcode, telefoon: telefoon, gsm: gsm, aansluitingsNr: aansluitingsNr, codeGerechtigde: codeGerechtigde)
    }
}