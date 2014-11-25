import Foundation

struct DeelnemerSQL {
    
    static func parseDeelnemerToDatabase(deelnemer: Deelnemer, inschrijvingId: String) {
        var deelnemerJSON = PFObject(className: "Deelnemer")
        
        deelnemerJSON.setValue(deelnemer.voornaam, forKey: "voornaam")
        deelnemerJSON.setValue(deelnemer.naam, forKey: "naam")
        deelnemerJSON.setValue(deelnemer.geboortedatum, forKey: "geboortedatum")
        deelnemerJSON.setValue(deelnemer.straat, forKey: "straat")
        deelnemerJSON.setValue(deelnemer.nummer, forKey: "nummer")
        deelnemerJSON.setValue(deelnemer.gemeente, forKey: "gemeente")
        deelnemerJSON.setValue(deelnemer.postcode, forKey: "postcode")
        deelnemerJSON.setValue(inschrijvingId, forKey: "inschrijvingVakantie")
        
        if deelnemer.bus != nil {
            deelnemerJSON.setValue(deelnemer.bus, forKey: "bus")
        }
        
        deelnemerJSON.save()
    }
    
}