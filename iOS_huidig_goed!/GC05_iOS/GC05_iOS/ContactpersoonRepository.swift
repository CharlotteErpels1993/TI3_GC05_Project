import Foundation

class ContactpersoonRepository {
    
    func addContactpersoon(contactpersoon: ContactpersoonNood) {
        var contactpersoonObject = PFObject(className: "ContactpersoonNood")
        
        contactpersoonObject.setValue(contactpersoon.voornaam, forKey: "voornaam")
        contactpersoonObject.setValue(contactpersoon.naam, forKey: "naam")
        contactpersoonObject.setValue(contactpersoon.gsm, forKey: "gsm")
        contactpersoonObject.setValue(contactpersoon.inschrijvingVakantie?.id, forKey: "inschrijvingVakantie")
        
        if contactpersoon.telefoon != nil {
            contactpersoonObject.setValue(contactpersoon.telefoon, forKey: "telefoon")
        }
        
        contactpersoonObject.save()
    }
    
}