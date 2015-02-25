import Foundation

struct VoorkeurSQL {
    
    static func createVoorkeurTable() {
        if let error = SD.createTable("Voorkeur", withColumnNamesAndTypes: ["objectId": .StringVal, "monitor": .StringVal, "vakantie": .StringVal])
        {
            println("ERROR: error tijdens creatie van table Voorkeur")
        }
        else
        {
            //no error
        }
    }
    
    static func vulVoorkeurTableOp() {
        var voorkeuren: [PFObject] = []
        var query = PFQuery(className: "Voorkeur")
        voorkeuren = query.findObjects() as [PFObject]
        
        var queryString = ""
        
        var objectId: String = ""
        var monitor: String = ""
        var vakantie: String = ""
        
        for voorkeur in voorkeuren {
            
            queryString.removeAll(keepCapacity: true)
            
            objectId = voorkeur.objectId as String
            monitor = voorkeur["monitor"] as String
            vakantie = voorkeur["vakantie"] as String
            
            queryString.extend("INSERT INTO Voorkeur ")
            queryString.extend("(")
            queryString.extend("objectId, ")
            queryString.extend("monitor, ")
            queryString.extend("vakantie")
            queryString.extend(")")
            queryString.extend(" VALUES ")
            queryString.extend("(")
            
            queryString.extend("'\(objectId)', ") //objectId - String
            queryString.extend("'\(monitor)', ") //monitorId - String
            queryString.extend("'\(vakantie)'") //vakantieId - String
            
            queryString.extend(")")
            
            
            if let err = SD.executeChange(queryString)
            {
                println("ERROR: error tijdens toevoegen van nieuwe Voorkeur in table Voorkeur")
            }
            else
            {
                //no error, the row was inserted successfully
            }
            
        }
    }
    
    static func parseVoorkeurToDatabase(voorkeur: Voorkeur) {
        var voorkeurJSON = PFObject(className: "Voorkeur")
        
        //voorkeurJSON.setValue(voorkeur.data, forKey: "periodes")
        voorkeurJSON.setValue(voorkeur.monitor?.id, forKey: "monitor")
        voorkeurJSON.setValue(voorkeur.vakantie?.id, forKey: "vakantie")
        
        voorkeurJSON.save()
    }
    
    static func getVoorkeuren(monitorId: String, vakantieId: String) -> /*[Voorkeur]*/ Int?
    {
        var voorkeuren: [Voorkeur] = []
        var voorkeur: Voorkeur = Voorkeur(id: "test")
        var queryString: String = ""
        
        queryString.extend("SELECT * FROM Voorkeur ")
        queryString.extend("WHERE monitor = ? ")
        queryString.extend("AND ")
        queryString.extend("vakantie = ?")
        //queryString.extend("AND ")
        //queryString.extend("periode = ?")
        
        let (resultSet, err) = SwiftData.executeQuery(queryString, withArgs: [monitorId, vakantieId])
        
        var error: Int?
        
        if err != nil
        {
            println("ERROR: error tijdens ophalen van voorkeuren voor bepaalde monitor en vakantie uit table Voorkeur")
        }
        else
        {
            if resultSet.count == 0 {
                error = 1
            }
            else {
                error = nil
            }
            
            /*if resultSet.count > 0 {
                voorkeuren.append(voorkeur)
                voorkeuren.append(voorkeur)
            }*/
        }
        
        //return voorkeuren
        return error
    }

    
}