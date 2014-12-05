import Foundation

struct NieuweMonitorSQL {
    static func createNieuweMonitorTable() {
        if let error = SD.createTable("NieuweMonitor", withColumnNamesAndTypes: ["objectId": .StringVal, "lidnummer": .StringVal, "rijksregisternummer": .StringVal, "email": .StringVal])
        {
            println("ERROR: error tijdens creatie van table NieuweMonitor")
        }
        else
        {
            //no error
        }
    }
    
    static func vulNieuweMonitorTableOp() {
        var nieuweMonitors: [PFObject] = []
        var query = PFQuery(className: "NieuweMonitor")
        nieuweMonitors = query.findObjects() as [PFObject]
        
        var queryString = ""
        
        var objectId: String = ""
        var lidnummer: String = ""
        var rijksregisternummer: String = ""
        var email: String = ""
        
        for nieuweMonitor in nieuweMonitors {
            
            queryString.removeAll(keepCapacity: true)
            
            objectId = nieuweMonitor.objectId as String
            lidnummer = nieuweMonitor["lidnummer"] as String
            rijksregisternummer = nieuweMonitor["rijksregisternummer"] as String
            email = nieuweMonitor["email"] as String
            
            queryString.extend("INSERT INTO NieuweMonitor ")
            queryString.extend("(")
            queryString.extend("objectId, ")
            queryString.extend("lidnummer, ")
            queryString.extend("rijksregisternummer, ")
            queryString.extend("email")
            queryString.extend(")")
            queryString.extend(" VALUES ")
            queryString.extend("(")
            
            queryString.extend("'\(objectId)', ") //objectId - String
            queryString.extend("'\(lidnummer)', ") //lidnummer - String
            queryString.extend("'\(rijksregisternummer)', ") //rijksregisternummer - String
            queryString.extend("'\(email)'") //email - String
            
            queryString.extend(")")
            
            
            if let err = SD.executeChange(queryString)
            {
                println("ERROR: error tijdens toevoegen van nieuwe monitor in table NieuweMonitor")
            }
            else
            {
                //no error, the row was inserted successfully
            }
            
        }
    }
    
    static func parseNieuweMonitorToDatabase(nieuweMonitor: NieuweMonitor) {
        var nieuweMonitorJSON = PFObject(className: "NieuweMonitor")
        
        nieuweMonitorJSON.setValue(nieuweMonitor.lidnummer, forKey: "lidnummer")
        nieuweMonitorJSON.setValue(nieuweMonitor.rijksregisternummer, forKey: "rijksregisternummer")
        nieuweMonitorJSON.setValue(nieuweMonitor.email, forKey: "email")
        
        nieuweMonitorJSON.save()
    }
    
    static func getNieuweMonitors() -> ([NieuweMonitor], Int?) {
        var nieuweMonitors: [NieuweMonitor] = []
        var nieuweMonitor: NieuweMonitor = NieuweMonitor(id: "test")
        
        let (resultSet, err) = SD.executeQuery("SELECT * FROM NieuweMonitor")
        
        var response: ([NieuweMonitor], Int?)
        var error: Int?
        
        if err != nil
        {
            println("ERROR: error tijdens ophalen van alle nieuwe monitors uit table NieuweMonitor")
        }
        else
        {
            if resultSet.count == 0 {
                error = 1
            }
            else {
                error = nil
                
                for row in resultSet {
                    nieuweMonitor = getNieuweMonitor(row)
                    nieuweMonitors.append(nieuweMonitor)
                }
            }
        }
        
        response = (nieuweMonitors, error)
        return response
    }
    
    static func getNieuweMonitor(row: SD.SDRow) -> NieuweMonitor {
        var nieuweMonitor: NieuweMonitor = NieuweMonitor(id: "test")
        
        if let objectId = row["objectId"]?.asString() {
            nieuweMonitor.id = objectId
        }
        if let lidnummer = row["lidnummer"]?.asString() {
            nieuweMonitor.lidnummer = lidnummer
        }
        if let rijksregisternummer = row["rijksregisternummer"]?.asString() {
            nieuweMonitor.rijksregisternummer = rijksregisternummer
        }
        if let email = row["email"]?.asString() {
            nieuweMonitor.email = email
        }
        
        return nieuweMonitor
    }
    
    static func bestaatCombinatie(lidnummer: String, rijksregisternummer: String, email: String) -> Bool {
        
        var nieuweMonitors: [NieuweMonitor] = []
        var nieuweMonitor: NieuweMonitor = NieuweMonitor(id: "test")
        
        let (resultSet, err) = SD.executeQuery("SELECT * FROM NieuweMonitor WHERE lidnummer = ? AND rijksregisternummer = ? AND email = ?", withArgs: [lidnummer, rijksregisternummer, email])
        
        if resultSet.count == 0 {
            return false
        }
        
        return true
    }
    
    static func deleteNieuweMonitor(lidnummer: String, rijksregisternummer: String, email: String) {
        
        var query = PFQuery(className: "NieuweMonitor")
        query.whereKey("lidnummer", equalTo: lidnummer)
        query.whereKey("rijksregisternummer", equalTo: rijksregisternummer)
        query.whereKey("email", equalTo: email)
        
        var nieuweMonitorObject = query.getFirstObject()
        nieuweMonitorObject.delete()
        
    }
}



















