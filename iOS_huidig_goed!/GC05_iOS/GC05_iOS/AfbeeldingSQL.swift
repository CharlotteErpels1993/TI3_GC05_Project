import Foundation

struct /*class*/ AfbeeldingSQL {
    
    static func createAfbeeldingTable() {
        if let error = SD.createTable("Afbeelding", withColumnNamesAndTypes:
            ["objectId": .StringVal, "afbeelding": .ImageVal, "vakantie": .StringVal])
        {
            println("ERROR: error tijdens creatie van table Afbeelding")
        }
        else
        {
            //no error
        }
    }
    
    /*static func vulAfbeeldingTableOp(vakantieId: String) {
        var afbeeldingen: [PFObject] = []
        var query = PFQuery(className: "Afbeelding")
        query.whereKey("vakantie", equalTo: vakantieId)
        afbeeldingen = query.findObjects() as [PFObject]
        
        var objectId: String = ""
        var afbeelding: UIImage = UIImage()
        var vakantie: String = ""
        
        for a in afbeeldingen {
            objectId = a.objectId as String
            afbeelding = a["afbeelding"] as UIImage
            vakantie = a["vakantie"] as String
            
            if let err = SD.executeChange("INSERT INTO Afbeelding (objectId, afbeelding, vakantie) VALUES ('\(objectId)', '\(afbeelding)', '\(vakantie)')") {
                //there was an error during the insert, handle it here
            } else {
                //no error, the row was inserted successfully
            }
            
        }
    }*/
    
    
    static func getAfbeeldingenMetVakantieId(vakantieId: String) -> [UIImage]{
        var afbeeldingen: [UIImage] = []
        var afbeelding: UIImage = UIImage()
        
        var query = "SELECT * FROM Afbeelding WHERE vakantie = \(vakantieId)"
        
        let (resultSet, err) = SD.executeQuery(query)
        
        if err != nil {
            //there was an error during the query, handle it here
        } else {
            for row in resultSet {
                afbeelding = getAfbeelding(row)
                afbeeldingen.append(afbeelding)
            }
        }
        
        return afbeeldingen
    }
    
    static private func getAfbeelding(row: SD.SDRow) -> UIImage {
        var afbeelding: UIImage = UIImage()
        
        if let a = row["afbeelding"]?.asImage()! {
            afbeelding = a
        }
        
        return afbeelding
    }
    
}