import Foundation

struct InschrijvingVormingLD {
    
    //
    //Function: getInschrijvingen
    //
    //Deze functie zet een array van PFObject om naar een array van InschrijvingVorming.
    //
    //Parameters: - objecten: [PFObject]
    //
    //Return: een array van InschrijvingVorming
    //
    static func getInschrijvingen(objecten: [PFObject]) -> [InschrijvingVorming] {
        var inschrijvingen: [InschrijvingVorming] = []
        
        for object in objecten {
            inschrijvingen.append(getInschrijving(object))
        }
        
        return inschrijvingen
    }
    
    //
    //Function: getInschrijving
    //
    //Deze functie zet een  PFObject om naar een InschrijvingVorming.
    //
    //Parameters: - object: PFObject
    //
    //Return: een InschrijvingVorming
    //
    static func getInschrijving(object: PFObject) -> InschrijvingVorming {
        var inschrijving: InschrijvingVorming = InschrijvingVorming(id: object.objectId)
        
        var queryMonitor = Query(tableName: Constanten.TABLE_MONITOR)
        queryMonitor.addWhereEqualTo(Constanten.COLUMN_OBJECTID, value: object[Constanten.COLUMN_MONITOR])
        inschrijving.monitor = queryMonitor.getFirstObject() as? Monitor
        
        var queryVorming = Query(tableName: Constanten.TABLE_VORMING)
        queryVorming.addWhereEqualTo(Constanten.COLUMN_OBJECTID, value: object[Constanten.COLUMN_VORMING])
        inschrijving.vorming = queryVorming.getFirstObject() as? Vorming
        
        /*var whereMonitor : [String : AnyObject] = [:]
        var whereVorming : [String : AnyObject] = [:]
        
        whereMonitor[Constanten.COLUMN_OBJECTID] = object[Constanten.COLUMN_MONITOR] as? String
        whereVorming[Constanten.COLUMN_OBJECTID] = object[Constanten.COLUMN_VORMING] as? String
        
        var queryMonitor = LocalDatastore.query(Constanten.TABLE_MONITOR, whereArgs: whereMonitor)
        var queryVorming = LocalDatastore.query(Constanten.TABLE_VORMING, whereArgs: whereVorming)
        
        inschrijving.monitor = LocalDatastore.getFirstObject(Constanten.TABLE_MONITOR, query: queryMonitor) as? Monitor
        
        inschrijving.vorming = LocalDatastore.getFirstObject(Constanten.TABLE_VORMING, query: queryVorming) as? Vorming*/
        
        inschrijving.periode = object[Constanten.COLUMN_PERIODE] as? String
        
        return inschrijving
    }
    
    //
    //Function: insert
    //
    //Deze functie insert een InschrijvingVorming object in de local datastore en
    //synct deze verandering dan naar de online database.
    //
    //Parameters: - inschrijving: InschrijvingVorming
    //
    static func insert(inschrijving: InschrijvingVorming) {
        
        let object = PFObject(className: Constanten.TABLE_INSCHRIJVINGVORMING)
        
        object[Constanten.COLUMN_PERIODE] = inschrijving.periode
        object[Constanten.COLUMN_MONITOR] = inschrijving.monitor?.id
        object[Constanten.COLUMN_VORMING] = inschrijving.vorming?.id
        
        object.pin()
        object.save()
    }
}