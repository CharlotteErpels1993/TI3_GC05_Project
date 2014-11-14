import Foundation
import UIKit

class InschrijvenVakantieSuccesvolViewController : UIViewController {
    var deelnemer: Deelnemer!
    var contactpersoon1: ContactpersoonNood!
    var contactpersoon2: ContactpersoonNood?
    var ouder: Ouder!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var iv: PFObject = parseInschrijvingVakantieToDatabase(deelnemer.inschrijvingVakantie!)
        parseDeelnemerToDatabase(deelnemer, inschrijvingVakantie: iv)
        parseContactpersoonToDatabase(contactpersoon1, inschrijvingVakantie: iv)
        
        if contactpersoon2?.naam != nil {
            parseContactpersoonToDatabase(contactpersoon2!, inschrijvingVakantie: iv)
        }
        
        performSegueWithIdentifier("overzichtVakanties", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "overzichtVakanties" {
            let vakantiesOverzichtTableViewController = segue.destinationViewController as VakantiesTableViewController
            vakantiesOverzichtTableViewController.ouder = self.ouder!
        }
    }
    
    private func parseInschrijvingVakantieToDatabase(inschrijvingVakantie: InschrijvingVakantie) -> PFObject {
        var inschrijvingVakantieJSON = PFObject(className: "InschrijvingVakantie")
        
        inschrijvingVakantieJSON.setValue(inschrijvingVakantie.vakantie?.id, forKey: "vakantie")
        
        if inschrijvingVakantie.extraInfo != "" {
           inschrijvingVakantieJSON.setValue(inschrijvingVakantie.extraInfo, forKey: "extraInformatie")
        }
        
        inschrijvingVakantieJSON.save()
        inschrijvingVakantieJSON.fetch()
        return inschrijvingVakantieJSON
    }

    private func parseDeelnemerToDatabase(deelnemer: Deelnemer, inschrijvingVakantie: PFObject) {
        var deelnemerJSON = PFObject(className: "Deelnemer")
        
        deelnemerJSON.setValue(deelnemer.voornaam, forKey: "voornaam")
        deelnemerJSON.setValue(deelnemer.naam, forKey: "naam")
        deelnemerJSON.setValue(deelnemer.geboortedatum, forKey: "geboortedatum")
        deelnemerJSON.setValue(deelnemer.straat, forKey: "straat")
        deelnemerJSON.setValue(deelnemer.nummer, forKey: "nummer")
        deelnemerJSON.setValue(deelnemer.gemeente, forKey: "gemeente")
        deelnemerJSON.setValue(deelnemer.postcode, forKey: "postcode")
        deelnemerJSON.setValue(inschrijvingVakantie.objectId, forKey: "inschrijvingVakantie")

        if deelnemer.bus != nil {
            deelnemerJSON.setValue(deelnemer.bus, forKey: "bus")
        }
        
        deelnemerJSON.save()
        deelnemerJSON.fetch()
    }

    private func parseContactpersoonToDatabase(contactpersoon: ContactpersoonNood, inschrijvingVakantie: PFObject) {
        var contactpersoonJSON = PFObject(className: "ContactpersoonNood")

        contactpersoonJSON.setValue(contactpersoon.voornaam, forKey: "voornaam")
        contactpersoonJSON.setValue(contactpersoon.naam, forKey: "naam")
        contactpersoonJSON.setValue(contactpersoon.gsm, forKey: "gsm")
        contactpersoonJSON.setValue(inschrijvingVakantie.objectId, forKey: "inschrijvingVakantie")

        if contactpersoon.telefoon != nil {
            contactpersoonJSON.setValue(contactpersoon.telefoon, forKey: "telefoon")
        }

        contactpersoonJSON.save()
    }
}