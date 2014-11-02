class Monitor: Gebruiker {
    
    let linkFacebook: String
    let lidNr: Int
    
    init(id: String, linkFacebook: String, lidNr: Int, aansluitingsNr: Int, codeGerechtigde: Int, email: String, wachtwoord: String, voornaam: String, naam: String, straat: String, nummer: Int, bus: String, gemeente: String, postcode: Int, telefoon: String, gsm: String) {
        self.linkFacebook = linkFacebook
        self.lidNr = lidNr
        
        super.init(id: id, email: email, wachtwoord: wachtwoord, voornaam: voornaam, naam: naam, straat: straat, nummer: nummer, bus: bus, gemeente: gemeente, postcode: postcode, telefoon: telefoon, gsm: gsm, aansluitingsNr: aansluitingsNr, codeGerechtigde: codeGerechtigde)
    }
}