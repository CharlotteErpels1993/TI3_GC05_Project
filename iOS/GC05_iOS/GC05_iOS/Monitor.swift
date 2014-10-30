class Monitor: Gebruiker {
    
    // ID?
    let linkFacebook: String
    let lidNr: Int
    
    init(linkFacebook: String, lidNr: Int, aansluitingsNr: Int, codeGerechtigde: Int, email: String, wachtwoord: String, voornaam: String, naam: String, straat: String, nummer: Int, bus: String, gemeente: String, postcode: Int, telefoon: String, gsm: String) {
        self.linkFacebook = linkFacebook
        self.lidNr = lidNr
        
        super.init(email: email, wachtwoord: wachtwoord, voornaam: voornaam, naam: naam, straat: straat, nummer: nummer, bus: bus, gemeente: gemeente, postcode: postcode, telefoon: telefoon, gsm: gsm, aansluitingsNr: aansluitingsNr, codeGerechtigde: codeGerechtigde)
    }
}