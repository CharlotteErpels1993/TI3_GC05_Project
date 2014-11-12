import Foundation
import UIKit

class InschrijvenVakantieSuccesvolViewController : UIViewController {
    var deelnemer: Deelnemer!
    var contactpersoon1: ContactpersoonNood!
    var contactpersoon2: ContactpersoonNood?
    var ouder: Ouder!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        parseInschrijvingVakantieToDatabase(deelnemer.inschrijvingVakantie!)
        parseDeelnemerToDatabase(deelnemer)
        parseContactpersoonToDatabase(contactpersoon1)
        
        if contactpersoon2 != nil {
            parseContactpersoonToDatabase(contactpersoon2!)
        }
    }
    
    private func parseInschrijvingVakantieToDatabase(inschrijvingVakantie: InschrijvingVakantie) {
        var inschrijvingVakantieJSON = PFObject(className: "InschrijvingVakantie")
        
        inschrijvingVakantieJSON.setValue(inschrijvingVakantie.vakantie, forKey: "vakantie")
        
        if inschrijvingVakantie.extraInfo != nil {
           inschrijvingVakantieJSON.setValue(inschrijvingVakantie.extraInfo, forKey: "extraInformatie")
        }
        
        inschrijvingVakantieJSON.save()
    }

    private func parseDeelnemerToDatabase(deelnemer: Deelnemer) {
        var deelnemerJSON = PFObject(className: "Deelnemer")
        
        deelnemerJSON.setValue(deelnemer.voornaam, forKey: "voornaam")
        deelnemerJSON.setValue(deelnemer.naam, forKey: "naam")
        deelnemerJSON.setValue(deelnemer.geboortedatum, forKey: "geboortedatum")
        deelnemerJSON.setValue(deelnemer.straat, forKey: "straat")
        deelnemerJSON.setValue(deelnemer.nummer, forKey: "nummer")
        deelnemerJSON.setValue(deelnemer.gemeente, forKey: "gemeente")
        deelnemerJSON.setValue(deelnemer.postcode, forKey: "postcode")
        deelnemerJSON.setValue(deelnemer.inschrijvingVakantie, forKey: "inschrijvingVakantie")

        if deelnemer.bus != nil {
            deelnemerJSON.setValue(deelnemer.bus, forKey: "bus")
        }
        
        deelnemerJSON.save()
    }

    private func parseContactpersoonToDatabase(contactpersoon: ContactpersoonNood) {
        var contactpersoonJSON = PFObject(className: "ContactpersoonNood")

        contactpersoonJSON.setValue(contactpersoon.voornaam, forKey: "voornaam")
        contactpersoonJSON.setValue(contactpersoon.naam, forKey: "naam")
        contactpersoonJSON.setValue(contactpersoon.gsm, forKey: "gsm")
        contactpersoonJSON.setValue(contactpersoon.inschrijvingVakantie, forKey: "inschrijvingVakantie")

        if contactpersoon.telefoon != nil {
            contactpersoonJSON.setValue(contactpersoon.telefoon, forKey: "telefoon")
        }

        contactpersoonJSON.save()
    }
}