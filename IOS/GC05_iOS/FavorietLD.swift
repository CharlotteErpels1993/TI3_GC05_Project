import Foundation

struct FavorietLD {
    
    //
    //Function: getFavoriet
    //
    //Deze functie zet een array van PFObject om naar een array van Favoriet.
    //
    //Parameters: - objecten: [PFObject]
    //
    //Return: een array van Favoriet
    //
    static func getFavorieten(objecten: [PFObject]) -> [Favoriet] {
        var favorieten: [Favoriet] = []
        
        for object in objecten {
            favorieten.append(getFavoriet(object))
        }
        
        return favorieten
    }
    
    //
    //Function: getFavoriet
    //
    //Deze functie zet een PFObject om naar een Favoriet.
    //
    //Parameters: - object: PFObject
    //
    //Return: een Favoriet
    //
    static func getFavoriet(object: PFObject) -> Favoriet {
        var favoriet: Favoriet = Favoriet(id: object.objectId)
        
        var wArgsGebruiker : [String : AnyObject] = [:]
        wArgsGebruiker[Constanten.COLUMN_OBJECTID] = object[Constanten.COLUMN_GEBRUIKER] as? String
        
        var wArgsVakantie : [String : AnyObject] = [:]
        wArgsVakantie[Constanten.COLUMN_OBJECTID] = object[Constanten.COLUMN_VAKANTIE] as? String
        
        var queryOuders = LocalDatastore.query(Constanten.TABLE_OUDER, whereArgs: wArgsGebruiker)
        
        if LocalDatastore.isResultSetEmpty(queryOuders) {
            
        }
        
        
        /*if LocalDatastore.isResultSetEmpty(Constanten.TABLE_OUDER, whereArgs: wArgsGebruiker) {
            favoriet.gebruiker = LocalDatastore.queryFirstObject(Constanten.TABLE_MONITOR, whereArgs: wArgsGebruiker) as? Gebruiker
        } else {
            favoriet.gebruiker = LocalDatastore.queryFirstObject(Constanten.TABLE_OUDER, whereArgs: wArgsGebruiker) as? Gebruiker
        }*/
        
        
        
        favoriet.vakantie = LocalDatastore.queryFirstObject(Constanten.TABLE_VAKANTIE, whereArgs: wArgsVakantie) as? Vakantie
        
        return favoriet
    }
}