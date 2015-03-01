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
        
        //var wArgsGebruiker : [String : AnyObject] = [:]
        //wArgsGebruiker[Constanten.COLUMN_OBJECTID] = object[Constanten.COLUMN_GEBRUIKER] as? String
        
        //var wArgsVakantie : [String : AnyObject] = [:]
        //wArgsVakantie[Constanten.COLUMN_OBJECTID] = object[Constanten.COLUMN_VAKANTIE] as? String
        
        //var queryOuders = LocalDatastore.query(Constanten.TABLE_OUDER, whereArgs: wArgsGebruiker)
        var queryOuders = Query(tableName: Constanten.TABLE_OUDER)
        queryOuders.addWhereEqualTo(Constanten.COLUMN_OBJECTID, value: object[Constanten.COLUMN_GEBRUIKER])
        
        /*if LocalDatastore.isResultSetEmpty(queryOuders) {
            var queryMonitor = LocalDatastore.query(Constanten.TABLE_MONITOR, whereArgs: wArgsGebruiker)
            favoriet.gebruiker = LocalDatastore.getFirstObject(Constanten.TABLE_MONITOR, query: queryMonitor) as? Gebruiker
        } else {
            favoriet.gebruiker = LocalDatastore.getFirstObject(Constanten.TABLE_OUDER, query: queryOuders) as? Gebruiker
        }*/
        
        if queryOuders.isEmpty() {
            var queryMonitor = Query(tableName: Constanten.TABLE_MONITOR)
            queryMonitor.addWhereEqualTo(Constanten.COLUMN_OBJECTID, value: object[Constanten.COLUMN_GEBRUIKER])
            favoriet.gebruiker = queryMonitor.getFirstObject() as? Gebruiker
        } else {
            //favoriet.gebruiker = LocalDatastore.getFirstObject(Constanten.TABLE_OUDER, query: queryOuders) as? Gebruiker
            favoriet.gebruiker = queryOuders.getFirstObject() as? Gebruiker
        }
    
        //var queryVakantie = LocalDatastore.query(Constanten.TABLE_VAKANTIE, whereArgs: wArgsVakantie)
        
        var queryVakantie = Query(tableName: Constanten.TABLE_VAKANTIE)
        queryVakantie.addWhereEqualTo(Constanten.COLUMN_OBJECTID, value: object[Constanten.COLUMN_VAKANTIE])
        
        //favoriet.vakantie = LocalDatastore.getFirstObject(Constanten.TABLE_VAKANTIE, query: queryVakantie) as? Vakantie
        favoriet.vakantie = queryVakantie.getFirstObject() as? Vakantie
        
        return favoriet
    }
    
    //
    //Function: insert
    //
    //Deze functie insert een Favoriet object in de local datastore en
    //synct deze verandering dan naar de online database.
    //
    //Parameters: - favoriet: Favoriet
    //
    static func insert(favoriet: Favoriet) {
        
        let object = PFObject(className: Constanten.TABLE_FAVORIET)
        
        object[Constanten.COLUMN_GEBRUIKER] = favoriet.gebruiker?.id
        object[Constanten.COLUMN_VAKANTIE] = favoriet.vakantie?.id
        
        object.pin()
        object.save()
    }
}