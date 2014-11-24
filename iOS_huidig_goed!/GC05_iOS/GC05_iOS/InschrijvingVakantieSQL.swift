import Foundation

struct /*class*/ InschrijvingVakantieSQL {
    
    static func createInschrijvingVakantieTable() {
        if let error = SD.createTable("InschrijvingVakantie", withColumnNamesAndTypes: ["objectId": .StringVal, "extraInformatie": .StringVal, "vakantie": .StringVal]) {
            
            //there was an error
            
        } else {
            //no error
        }
    }
    
    static func parseInschrijvingVakantieToDatabase(inschrijving: InschrijvingVakantie) -> String {
        var inschrijvingJSON = PFObject(className: "InschrijvingVakantie")
        
        inschrijvingJSON.setValue(inschrijving.vakantie?.id, forKey: "vakantie")
        
        if inschrijving.extraInfo != "" {
            inschrijvingJSON.setValue(inschrijving.extraInfo, forKey: "extraInformatie")
        }
        
        inschrijvingJSON.save()
        inschrijvingJSON.fetch()
        return inschrijvingJSON.objectId
    }
    
}