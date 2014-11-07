import Foundation

class Vakantie: Activiteit
{
    
    var beginDatum: Date?
    var terugkeerDatum: Date?
    var aantalDagenNachten: String
    var vervoerwijze: String
    var formule: String
    
    var basisprijs: Double {
        willSet {
            assert(checkPrijsValid(newValue), "Basisprijs moet een geldige prijs zijn!")
        }
    }
    
    var bondMoysonLedenPrijs: Double {
        willSet {
            assert(checkPrijsValid(newValue), "Bond Moyson ledenprijs moet een geldige prijs zijn!")
        }
    }
    
    var sterPrijs1ouder: Double {
        willSet {
            assert(checkPrijsValid(newValue), "Sterprijs moet een geldige prijs zijn!")
        }
    }
    
    var sterPrijs2ouders: Double {
        willSet {
            assert(checkPrijsValid(newValue), "Sterprijs moet een geldige prijs zijn!")
        }
    }
    
    // sterprijs2
    
    var inbegrepenPrijs: String
    var doelgroep: String // TYPE?
    
    var maxAantalDeelnemers: Int {
        willSet {
            assert(checkMaxAantalDeelnemersValid(newValue), "Maximum aantal deelnemers moet positief zijn!")
        }
    }
    
    //var image1: UIImage
    //var image2: UIImage
    //var image3: UIImage
    
    
    init(vakantie: PFObject) {
        //super.init(activiteit: vakantie)
        //self.beginDatum = vakantie["vertrekdatum"] as Date
        //self.terugkeerDatum = vakantie["terugkeerdatum"] as Date
        self.aantalDagenNachten = vakantie["aantalDagenNachten"] as String
        self.vervoerwijze = vakantie["vervoerwijze"] as String
        self.formule = vakantie["formule"] as String
        self.basisprijs = vakantie["basisPrijs"] as Double
        self.bondMoysonLedenPrijs = vakantie["bondMoysonLedenPrijs"] as Double
        self.sterPrijs1ouder = vakantie["sterPrijs1ouder"] as Double
        self.sterPrijs2ouders = vakantie["sterPrijs2ouders"] as Double
        self.inbegrepenPrijs = vakantie["inbegrepenPrijs"] as String
        self.doelgroep = vakantie["doelgroep"] as String
        self.maxAantalDeelnemers = vakantie["maxAantalDeelnemers"] as Int
        //self.image1 = vakantie["vakAfbeelding1"] as UIImage
        //self.image2 = vakantie["vakAfbeelding2"] as UIImage
        //self.image3 = vakantie["vakAfbeelding3"] as UIImage
        
        super.init(activiteit: vakantie)
        
    }
    
    
    init(id: String, titel: String, locatie: String, korteBeschrijving: String, beginDatum: Date, terugkeerDatum: Date, aantalDagenNachten: String, vervoerwijze: String, formule: String, basisprijs: Double, bondMoysonLedenPrijs: Double, sterPrijs1: Double, sterPrijs2: Double, kortingen: String, inbegrepenPrijs: String, doelgroep: String, maxAantalDeelnemers: Int/*, image1: UIImage, image2: UIImage, image3: UIImage*/) {
        
        self.beginDatum = beginDatum
        self.terugkeerDatum = terugkeerDatum
        self.aantalDagenNachten = aantalDagenNachten
        self.vervoerwijze = vervoerwijze
        self.formule = formule
        self.basisprijs = basisprijs
        self.bondMoysonLedenPrijs = bondMoysonLedenPrijs
        self.sterPrijs1ouder = sterPrijs1
        self.sterPrijs2ouders = sterPrijs2
        self.inbegrepenPrijs = inbegrepenPrijs
        self.doelgroep = doelgroep
        self.maxAantalDeelnemers = maxAantalDeelnemers
        //self.image1 = image1
        //self.image2 = image2
        //self.image3 = image3
        
        super.init(id: id, titel: titel, locatie: locatie, korteBeschrijving: korteBeschrijving)
    }
    
    private func checkPrijsValid(p: Double) -> Bool {
        if p < 0.0 {
            return false
        }
        return true
    }
    
    private func checkMaxAantalDeelnemersValid(aantal: Int) -> Bool {
        if aantal <= 0 {
            return false
        }
        return true
    }
    
    // blablablabal
}