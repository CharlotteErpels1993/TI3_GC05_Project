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
        inschrijvingJSON.setValue(inschrijving.vorming?.id, forKey: "vorming")
        
        inschrijvingJSON.save()
    }

    func getVormingIdMetMonitorId(monitorId: String) -> [String] {
        var vormingenIds: [String] = []
        
        let (resultSet, err) = SD.executeQuery("SELECT vorming FROM InschrijvingVorming WHERE monitor = \(monitorId)")
        
        if err != nil {
            //there was an error during the query, handle it here
        } else {
            for row in resultSet {
                if let vormingId = row["vorming"]?.asString() {
                    vormingenIds.append(vormingId)
                }
            }
        }
        
        return vormingenIds
    }
    
    func getMonitorsIdMetVormingId(vormingen: [String]) -> [String] {
        var monitorsId: [String] = []
        
        for vorming in vormingen {
            var (resultSet, err) = SD.executeQuery("SELECT monitor FROM InschrijvingVorming WHERE vorming = \(vorming)")
            
            if err != nil {
                //there was an error during the query, handle it here
            } else {
                for row in resultSet {
                    if let monitorId = row["monitor"]?.asString() {
                        if !contains(monitorsId, monitorId) {
                            monitorsId.append(monitorId)
                        }
                    }
                }
            }
        }
        
        return monitorsId
    }
    
    
}