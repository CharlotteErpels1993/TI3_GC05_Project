import Foundation

struct FavorietSQL {
    static func createFavorietTable() {
        if let error = SD.createTable("Favoriet", withColumnNamesAndTypes: ["objectId": .StringVal, "ouder": .StringVal, "vakantie": .StringVal])
        {
            println("ERROR: error tijdens creatie van table Favoriet")
        }
        else
        {
            //no error
        }
    }
    
    static func vulFavorietTableOp() {
        var favorieten: [PFObject] = []
        var query = PFQuery(className: "Favoriet")
        favorieten = query.findObjects() as [PFObject]
        
        var queryString = ""
        
        var objectId: String = ""
        var ouder: String = ""
        var vakantie: String = ""
        
        for favoriet in favorieten {
            
            queryString.removeAll(keepCapacity: true)
            
            objectId = favoriet.objectId as String
            ouder = favoriet["ouder"] as String
            vakantie = favoriet["vakantie"] as String
            
            queryString.extend("INSERT INTO Favoriet ")
            queryString.extend("(")
            queryString.extend("objectId, ")
            queryString.extend("ouder, ")
            queryString.extend("vakantie")
            queryString.extend(")")
            queryString.extend(" VALUES ")
            queryString.extend("(")
            
            queryString.extend("'\(objectId)', ") //objectId - String
            queryString.extend("'\(ouder)', ") //ouderId - String
            queryString.extend("'\(vakantie)'") //vakantieId - String
            
            queryString.extend(")")
            
            
            if let err = SD.executeChange(queryString)
            {
                println("ERROR: error tijdens toevoegen van nieuwe Favoriet in table Favoriet")
            }
            else
            {
                //no error, the row was inserted successfully
            }
            
        }
    }
    
    static func parseFavorietToDatabase(favoriet: Favoriet) {
        var favorietJSON = PFObject(className: "Favoriet")
        
        //inschrijvingJSON.setValue(inschrijving.periode, forKey: "periode")
        favorietJSON.setValue(favoriet.ouder?.id, forKey: "ouder")
        favorietJSON.setValue(favoriet.vakantie?.id, forKey: "vakantie")
        
        favorietJSON.save()
    }
    
    static func isFavoriet(favoriet: Favoriet) -> Bool {
        var query = PFQuery(className: "Favoriet")
        query.whereKey("ouder", equalTo: favoriet.ouder?.id)
        query.whereKey("vakantie", equalTo: favoriet.vakantie?.id)
        
        var favorietObject = query.getFirstObject()
        
        if favorietObject == nil {
            return false
        }
        return true
    }
    
    static func deleteFavorieteVakantie(favoriet: Favoriet) {
        
        var query = PFQuery(className: "Favoriet")
        query.whereKey("ouder", equalTo: favoriet.ouder?.id)
        query.whereKey("vakantie", equalTo: favoriet.vakantie?.id)
        
        var favorietObject = query.getFirstObject()
        favorietObject.delete()

    }
}