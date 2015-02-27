import Foundation

struct InschrijvingVormingLD {
    
    //
    //Function: getInschrijvingVormingen
    //
    //Deze functie zet een array van PFObject om naar een array van InschrijvingVorming.
    //
    //Parameters: - objecten: [PFObject]
    //
    //Return: een array van InschrijvingVorming
    //
    static func getInschrijvingVormingen(objecten: [PFObject]) -> [InschrijvingVorming] {
        var inschrijvingVormingen: [InschrijvingVorming] = []
        
        for object in objecten {
            inschrijvingVormingen.append(getInschrijvingVorming(object))
        }
        
        return inschrijvingVormingen
    }
    
    //
    //Function: getInschrijvingVorming
    //
    //Deze functie zet een  PFObject om naar een InschrijvingVorming.
    //
    //Parameters: - object: PFObject
    //
    //Return: een InschrijvingVorming
    //
    static func getInschrijvingVorming(object: PFObject) -> InschrijvingVorming {
        var inschrijvingVorming: InschrijvingVorming = InschrijvingVorming(id: object.objectId)
        
        inschrijvingVorming.periode = object[Constanten.COLUMN_PERIODE] as? String
        
        var wArgsMonitor : [String : AnyObject] = [:]
        wArgsMonitor[Constanten.COLUMN_OBJECTID] = object[Constanten.COLUMN_MONITOR] as? String
        
        var queryMonitor = LocalDatastore.query(Constanten.TABLE_MONITOR, whereArgs: wArgsMonitor)
        
        inschrijvingVorming.monitor = LocalDatastore.getFirstObject(Constanten.TABLE_MONITOR, query: queryMonitor) as? Monitor
        
        var wArgsVorming : [String : AnyObject] = [:]
        wArgsVorming[Constanten.COLUMN_OBJECTID] = object[Constanten.COLUMN_VORMING] as? String
        
        var queryVorming = LocalDatastore.query(Constanten.TABLE_VORMING, whereArgs: wArgsVorming)
        
        inschrijvingVorming.vorming = LocalDatastore.getFirstObject(Constanten.TABLE_VORMING, query: queryVorming) as? Vorming
        
        return inschrijvingVorming
    }
    
    //
    //Function: insert
    //
    //Deze functie insert een InschrijvingVorming object in de local datastore en
    //synct deze verandering dan naar de online database.
    //
    //Parameters: - inschrijvingVorming: InschrijvingVorming
    //
    static func insert(inschrijvingVorming: InschrijvingVorming) {
        
        let object = PFObject(className: Constanten.TABLE_INSCHRIJVINGVORMING)
        
        object[Constanten.COLUMN_PERIODE] = inschrijvingVorming.periode
        object[Constanten.COLUMN_MONITOR] = inschrijvingVorming.monitor?.id
        object[Constanten.COLUMN_VORMING] = inschrijvingVorming.vorming?.id
        
        object.pin()
        object.save()
    }
}