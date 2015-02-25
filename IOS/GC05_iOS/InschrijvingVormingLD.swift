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
        
        inschrijvingVorming.monitor = LocalDatastore.getFirstObject(Constanten.TABLE_MONITOR, whereArgs: wArgsMonitor) as? Monitor
        
        /*var wArgsVakantie : [String : AnyObject] = [:]
        wArgsVakantie[Constanten.COLUMN_OBJECTID] = object[Constanten.COLUMN_VAKANTIE] as? String
        
        inschrijvingVorming.vakantie = LocalDatastore.queryFirstObject(Constanten.TABLE_VAKANTIE, whereArgs: wArgsVakantie) as? Vakantie*/
        
        return inschrijvingVorming
    }
}