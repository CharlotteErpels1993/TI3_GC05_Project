class Gebruiker {
    let id: String
    let email: String
    let wachtwoord: String
    let voornaam: String
    let naam: String
    let straat: String
    let nummer: Int
    let bus: String
    let gemeente: String
    let postcode: Int
    let telefoon: String
    let gsm: String
    let aansluitingsNr: Int
    let codeGerechtigde: Int
        
    init(id: String, email: String, wachtwoord: String, voornaam: String, naam: String, straat: String, nummer: Int, bus: String, gemeente: String, postcode: Int, telefoon: String, gsm: String, aansluitingsNr: Int, codeGerechtigde: Int) {
        self.id = id
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