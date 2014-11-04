import Foundation

class Gebruiker
{
    var id: String?

    var rijksregisterNr: String {
        willSet {
            assert(checkValidRijksregisterNummer(newValue), "Rijksregisternummer moet geldig zijn!")
        }
    }
    
    var email: String {
        willSet {
            assert(checkValidEmail(newValue), "E-mail moet een geldig e-mailadres zijn!")
        }
    }

    var wachtwoord: String
    var voornaam: String
    var naam: String
    var straat: String
    
    var nummer: Int {
        willSet {
            assert(checkValidNummer(newValue), "Huisnummer moet een geldig nummer zijn!")
        }
    }
    
    var bus: String
    var gemeente: String
    
    var postcode: Int {
        willSet {
            assert(checkValidPostcode(newValue), "Postcode moet geldig zijn!")
        }
    }
    
    var telefoon: String {
        willSet {
            assert(checkValidTelefoon(newValue), "Telefoon moet een geldig telefoonnummer zijn!")
        }
    }

    var gsm: String {
        willSet {
            assert(checkValidGsm(newValue), "Gsm moet een geldig gsmnummer zijn!")
        }
    }
    
    var aansluitingsNr: Int {
        willSet {
            assert(checkValidAansluitingsNr(newValue), "Aansluitingsnummer moet geldig zijn!")
        }
    }
    
    var codeGerechtigde: Int {
        willSet {
            assert(checkValidCodeGerechtigde(newValue), "Code gerechtigde moet geldig zijn!")
        }
    }
    
    init(gebruiker: PFObject) {
        self.id = gebruiker.objectId
        self.rijksregisterNr = gebruiker["rijksregisterNr"] as String
        self.email = gebruiker["email"] as String
        self.wachtwoord = gebruiker["wachtwoord"] as String
        self.voornaam = gebruiker["voornaam"] as String
        self.naam = gebruiker["naam"] as String
        self.straat = gebruiker["straat"] as String
        self.nummer = gebruiker["nummer"] as Int
        self.bus = gebruiker["bus"] as String
        self.gemeente = gebruiker["gemeente"] as String
        self.postcode = gebruiker["postcode"] as Int
        self.telefoon = gebruiker["telefoon"] as String
        self.gsm = gebruiker["gsm"] as String
        self.aansluitingsNr = gebruiker["aansluitingsNr"] as Int
        self.codeGerechtigde = gebruiker["codeGerechtigde"] as Int
    }
    
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
        /*initializeVariables(rijksregisterNr, email: email, wachtwoord: wachtwoord, voornaam: voornaam, naam: naam, straat: straat, nummer: nummer, bus: bus, gemeente: gemeente, postcode: postcode, telefoon: telefoon, gsm: gsm, aansluitingsNr: aansluitingsNr, codeGerechtigde: codeGerechtigde)*/
    }
    
    func initializeVariables(rijksregisterNr: String, email: String, wachtwoord: String, voornaam: String, naam: String, straat: String, nummer: Int, bus: String, gemeente: String, postcode: Int, telefoon: String, gsm: String, aansluitingsNr: Int, codeGerechtigde: Int)
    {
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
    
    
    private func checkValidRijksregisterNummer(rrn: String) -> Bool {
        var length : Int = countElements(rrn)
        var eerste9CijfersString: String = rrn.substringWithRange(Range<String.Index>(start: rrn.startIndex, end: advance(rrn.endIndex, -2)))
        
        var eerste9CijfersInt: Int = eerste9CijfersString.toInt()!
        var restNaDeling97: Int = eerste9CijfersInt % 97
        var controleGetal: Int = 97 - restNaDeling97
        var laatste2CijfersString: String = rrn.substringWithRange(Range<String.Index>(start: advance(rrn, 10), end: rrn))
        var laatste2CijfersInt: Int = laatste2CijfersString.toInt()!
        
        if length > 11 || length < 11 {
            return false
        } else if laatste2CijfersInt != controleGetal {
            return false
        } else {
            return true
        }
    }
    
    private func checkValidEmail(email: String) -> Bool {
        if countElements(email) == 0 {
            return false
        } else if Regex("[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}").test(email) {
            return true
        }
    }
    
    private func checkValidNummer(nr: Int) -> Bool {
        if nr <= 0 {
            return false
        }
        return true
    }
    
    private func checkValidPostcode(pc: Int) -> Bool {
        if pc < 1000 || pc > 9992 {
            return false
        }
        return true
    }
    
    private func checkValidTelefoon(tel: String) -> Bool {
        if countElements(tel) == 9 {
            return true
        }
        return false
    }
    
    private func checkValidGsm(gsm: String) -> Bool {
        if countElements(gsm) == 10 {
            return true
        }
        return false
    }
    
    func checkValidAansluitingsNr(aansluitingsNr: Int) -> Bool {
        if countElements(aansluitingsNr) == 10 {
            return true
        }
        return false
    }
    
    private func checkValidCodeGerechtigde(codeGerechtigde: Int) -> Bool {
        if countElements(codeGerechtigde) == 6 {
            return true
        }
        return false
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}