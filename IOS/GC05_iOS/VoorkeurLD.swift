import Foundation

struct VoorkeurLD {
    
    //
    //Function: getVoorkeur
    //
    //Deze functie zet een array van PFObject om naar een array van Voorkeur.
    //
    //Parameters: - objecten: [PFObject]
    //
    //Return: een array van Voorkeur
    //
    static func getVoorkeuren(objecten: [PFObject]) -> [Voorkeur] {
        var voorkeuren: [Voorkeur] = []
        
        for object in objecten {
            voorkeuren.append(getVoorkeur(object))
        }
        
        return voorkeuren
    }
    
    //
    //Function: getVoorkeur
    //
    //Deze functie zet een  PFObject om naar een Voorkeur.
    //
    //Parameters: - object: PFObject
    //
    //Return: een Voorkeur
    //
    static func getVoorkeur(object: PFObject) -> Voorkeur {
        var voorkeur: Voorkeur = Voorkeur(id: object.objectId)
        
        var monitor: Monitor?
        var vakantie: Vakantie?
        
        var qMonitor = Query(tableName: Constanten.TABLE_MONITOR)
        qMonitor.addWhereEqualTo(Constanten.COLUMN_OBJECTID, value: object[Constanten.COLUMN_MONITOR])
        
        var qVakantie = Query(tableName: Constanten.TABLE_VAKANTIE)
        qVakantie.addWhereEqualTo(Constanten.COLUMN_OBJECTID, value: object[Constanten.COLUMN_VAKANTIE])
        
        voorkeur.monitor = qMonitor.getFirstObject() as? Monitor
        voorkeur.vakantie = qVakantie.getFirstObject() as? Vakantie
        
        return voorkeur
    }
    
    static func insert(voorkeur: Voorkeur) {
        
        let object = PFObject(className: Constanten.TABLE_VOORKEUR)
        
        object[Constanten.COLUMN_VAKANTIE] = voorkeur.vakantie?.id
        object[Constanten.COLUMN_MONITOR] = voorkeur.monitor?.id
        
        object.pin()
        object.save()
    }
}