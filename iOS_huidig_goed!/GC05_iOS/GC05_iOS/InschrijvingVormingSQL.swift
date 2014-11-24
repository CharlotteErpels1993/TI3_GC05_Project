import Foundation

class InschrijvingVormingSQL {
    
    func createInschrijvingVormingTable() {
        if let error = SD.createTable("InschrijvingVorming", withColumnNamesAndTypes: ["objectId": .StringVal, "monitor": .StringVal, "periode": .StringVal, "vorming":
            .StringVal]) {
                
                //there was an error
                
        } else {
            //no error
        }
    }
    
    func parseInschrijvingVormingToDatabase(inschrijving: InschrijvingVorming) {
        var inschrijvingJSON = PFObject(className: "InschrijvingVorming")
        
        inschrijvingJSON.setValue(inschrijving.periode, forKey: "periode")
        inschrijvingJSON.setValue(inschrijving.monitor?.id, forKey: "monitor")
        inschrijvingJSON.setValue(inschrijvingVorming.vorming?.id, forKey: "vorming")
        
        inschrijvingVormingJSON.save()
    }

    
    
}