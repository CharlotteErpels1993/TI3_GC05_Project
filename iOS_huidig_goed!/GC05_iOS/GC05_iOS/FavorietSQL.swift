import Foundation

struct FavorietSQL {
    static func createFavorietTable() {
        if let error = SD.createTable("Favoriet", withColumnNamesAndTypes: ["objectId": .StringVal, "gebruiker": .StringVal, "vakantie": .StringVal])
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
        var gebruiker: String = ""
        var vakantie: String = ""
        
        for favoriet in favorieten {
            
            queryString.removeAll(keepCapacity: true)
            
            objectId = favoriet.objectId as String
            gebruiker = favoriet["gebruiker"] as String // TO DO --> GEBRUIKER!
            vakantie = favoriet["vakantie"] as String
            
            queryString.extend("INSERT INTO Favoriet ")
            queryString.extend("(")
            queryString.extend("objectId, ")
            queryString.extend("gebruiker, ")
            queryString.extend("vakantie")
            queryString.extend(")")
            queryString.extend(" VALUES ")
            queryString.extend("(")
            
            queryString.extend("'\(objectId)', ") //objectId - String
            queryString.extend("'\(gebruiker)', ") //ouderId - String
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
        favorietJSON.setValue(favoriet.gebruiker?.id, forKey: "gebruiker")
        favorietJSON.setValue(favoriet.vakantie?.id, forKey: "vakantie")
        
        favorietJSON.save()
    }
    
    static func isFavoriet(favoriet: Favoriet) -> Bool {
        var query = PFQuery(className: "Favoriet")
        query.whereKey("gebruiker", equalTo: favoriet.gebruiker?.id)
        query.whereKey("vakantie", equalTo: favoriet.vakantie?.id)
        
        var favorietObject = query.getFirstObject()
        
        if favorietObject == nil {
            return false
        }
        return true
    }
    
    static func deleteFavorieteVakantie(favoriet: Favoriet) {
        
        var query = PFQuery(className: "Favoriet")
        query.whereKey("gebruiker", equalTo: favoriet.gebruiker?.id)
        query.whereKey("vakantie", equalTo: favoriet.vakantie?.id)
        
        var favorietObject = query.getFirstObject()
        favorietObject.delete()
        
    }
    
    
    static func getFavorieteVakanties(gebruiker: Gebruiker) -> ([Vakantie], Int?) {
        
        var favorieteVakantiesID: [String] = []
        var favorieteVakantieID: String = ""
        var favorieteVakanties:[Vakantie] = []
        var alleVakanties: [Vakantie] = []
        var favorieteVakantie: Vakantie = Vakantie(id: "test")
        var vakantie: Vakantie = Vakantie(id: "test2")
        
        let (resultSet, err) = SD.executeQuery("SELECT * FROM Favoriet WHERE gebruiker = ?", withArgs: [gebruiker.id!])
        
        var response: ([Vakantie], Int?)
        var error: Int?
        
        if err != nil
        {
            println("ERROR: error tijdens ophalen van alle favoriete vakanties uit table Favoriet")
        }
        else
        {
            if resultSet.count == 0 {
                error = 1
            }
            else {
                error = nil
                
                let r: ([Vakantie], Int?) = VakantieSQL.getAlleVakanties()
                
                if r.1 != nil {
                    println("ERROR: geen vakanties gevonden in table Vakantie")
                }
                else {
                    alleVakanties = r.0
                    
                    for row in resultSet {
                        if let id = row["vakantie"]?.asString() {
                            favorieteVakantiesID.append(id)
                        }
                    }
                    
                    for fvId in favorieteVakantiesID {
                        for v in alleVakanties {
                            if v.id == fvId {
                                favorieteVakanties.append(v)
                            }
                        }
                    }
                }
            }
            
        }
        
        response = (favorieteVakanties, error)
        return response
    }
    
    /*static func parseFavorietToDatabase(favoriet: Favoriet) {
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
    
    
    static func getFavorieteVakanties(ouder: Ouder) -> ([Vakantie], Int?) {
        
        var favorieteVakantiesID: [String] = []
        var favorieteVakantieID: String = ""
        var favorieteVakanties:[Vakantie] = []
        var alleVakanties: [Vakantie] = []
        var favorieteVakantie: Vakantie = Vakantie(id: "test")
        var vakantie: Vakantie = Vakantie(id: "test2")
        
        let (resultSet, err) = SD.executeQuery("SELECT * FROM Favoriet WHERE ouder = ?", withArgs: [ouder.id!])
        
        var response: ([Vakantie], Int?)
        var error: Int?
        
        if err != nil
        {
            println("ERROR: error tijdens ophalen van alle favoriete vakanties uit table Favoriet")
        }
        else
        {
            if resultSet.count == 0 {
                error = 1
            }
            else {
                error = nil
                
                let r: ([Vakantie], Int?) = VakantieSQL.getAlleVakanties()
                
                if r.1 != nil {
                    println("ERROR: geen vakanties gevonden in table Vakantie")
                }
                else {
                    alleVakanties = r.0
                    
                    for row in resultSet {
                        if let id = row["vakantie"]?.asString() {
                            favorieteVakantiesID.append(id)
                        }
                    }
                    
                    for fvId in favorieteVakantiesID {
                        for v in alleVakanties {
                            if v.id == fvId {
                                favorieteVakanties.append(v)
                            }
                        }
                    }
                }
            }
            
        }
        
        response = (favorieteVakanties, error)
        return response
    }*/
    
}