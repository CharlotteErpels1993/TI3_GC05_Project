import Foundation

class ContactpersoonNoodSQL {
    
    func createContactpersoonNoodTable() {
        if let error = SD.createTable("ContactpersoonNood", withColumnNamesAndTypes: ["objectId": .StringVal, "voornaam": .StringVal, "naam": .StringVal, "gsm":
            .StringVal, "telefoon": .StringVal, "inschrijvingVakantie": .StringVal]) {
                
                //there was an error
                
        } else {
            //no error
        }
    }
    
    func parseContactpersoonNoodToDatabase(contactpersoon: ContactpersoonNood, inschrijvingId: String) {
        var contactpersoonJSON = PFObject(className: "ContactpersoonNood")
        
        contactpersoonJSON.setValue(contactpersoon.voornaam, forKey: "voornaam")
        contactpersoonJSON.setValue(contactpersoon.naam, forKey: "naam")
        contactpersoonJSON.setValue(contactpersoon.gsm, forKey: "gsm")
        contactpersoonJSON.setValue(inschrijvingId, forKey: "inschrijvingVakantie")
        
        if contactpersoon.telefoon != nil {
            contactpersoonJSON.setValue(contactpersoon.telefoon, forKey: "telefoon")
        }
        
        contactpersoonJSON.save()
    }
    
}