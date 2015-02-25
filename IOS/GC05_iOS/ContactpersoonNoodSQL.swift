import Foundation

struct ContactpersoonNoodSQL {
    
    static func parseContactpersoonNoodToDatabase(contactpersoon: ContactpersoonNood) -> String {
        var contactpersoonJSON = PFObject(className: "ContactpersoonNood")
        
        contactpersoonJSON.setValue(contactpersoon.voornaam, forKey: "voornaam")
        contactpersoonJSON.setValue(contactpersoon.naam, forKey: "naam")
        contactpersoonJSON.setValue(contactpersoon.gsm, forKey: "gsm")
        //contactpersoonJSON.setValue(inschrijvingId, forKey: "inschrijvingVakantie")
        
        if contactpersoon.telefoon != nil {
            contactpersoonJSON.setValue(contactpersoon.telefoon, forKey: "telefoon")
        }
        
        contactpersoonJSON.save()
        contactpersoonJSON.fetch()
        
        return contactpersoonJSON.objectId
    }
}