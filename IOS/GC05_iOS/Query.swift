import Foundation

class Query {
    
    var table: String
    var q : PFQuery
    
    init() {
        self.q = PFQuery()
        self.table = ""
        q.fromLocalDatastore()
    }
    
    init(tableName: String) {
        
        self.q = PFQuery(className: tableName)
        self.table = tableName
        q.fromLocalDatastore()
    }
    
    func setTableName(tableName: String) {
        q.parseClassName = tableName
        table = tableName
    }
    
    func addWhereEqualTo(column: String, value: AnyObject!) {
        self.q.whereKey(column, equalTo: value)
    }
    
    func isEmpty() -> Bool {
        if q.countObjects() > 0 {
            return false
        } else {
            return true
        }
    }
    
    func getFirstObject() -> AnyObject {
        var first = q.getFirstObject() as PFObject
        
        if table == Constanten.TABLE_AFBEELDING {
            return AfbeeldingLD.getAfbeelding(first)
        } else if table == Constanten.TABLE_DEELNEMER {
            return DeelnemerLD.getDeelnemer(first)
        } else if table == Constanten.TABLE_FAVORIET {
            return FavorietLD.getFavoriet(first)
        } else if table == Constanten.TABLE_FEEDBACK {
            return FeedbackLD.getFeedback(first)
        } else if table == Constanten.TABLE_INSCHRIJVINGVAKANTIE {
            return InschrijvingVakantieLD.getInschrijving(first)
        } else if table == Constanten.TABLE_INSCHRIJVINGVORMING {
            return InschrijvingVormingLD.getInschrijving(first)
        } else if table == Constanten.TABLE_MONITOR {
            return MonitorLD.getMonitor(first)
        } else if table == Constanten.TABLE_OUDER {
            return OuderLD.getOuder(first)
        } else if table == Constanten.TABLE_VAKANTIE {
            return VakantieLD.getVakantie(first)
        } else {
            return VormingLD.getVorming(first)
        }
    }
    
    func getObjects() -> [AnyObject] {
        var objects = q.findObjects() as [PFObject]
        
        if table == Constanten.TABLE_AFBEELDING {
            return AfbeeldingLD.getAfbeeldingen(objects)
        } else if table == Constanten.TABLE_DEELNEMER {
            return DeelnemerLD.getDeelnemers(objects)
        } else if table == Constanten.TABLE_FAVORIET {
            return FavorietLD.getFavorieten(objects)
        } else if table == Constanten.TABLE_FEEDBACK {
            return FeedbackLD.getFeedbacks(objects)
        } else if table == Constanten.TABLE_INSCHRIJVINGVORMING {
            return InschrijvingVormingLD.getInschrijvingen(objects)
        } else if table == Constanten.TABLE_MONITOR {
            return MonitorLD.getMonitoren(objects)
        } else if table == Constanten.TABLE_OUDER {
            return OuderLD.getOuders(objects)
        } else if table == Constanten.TABLE_VAKANTIE {
            return VakantieLD.getVakanties(objects)
        } else {
            return VormingLD.getVormingen(objects)
        }
    }
    
    func deleteObjects() {
        var objects = q.findObjects()
        PFObject.deleteAll(objects)
        PFObject.unpinAll(objects)
    }
    
    func getGebruiker(soort: String) -> Gebruiker {
        
        if soort == "ouder" {
            setTableName(Constanten.TABLE_OUDER)
        } else if soort == "monitor" {
            setTableName(Constanten.TABLE_MONITOR)
        }
        
        addWhereEqualTo(Constanten.COLUMN_EMAIL, value: PFUser.currentUser().email)
        
        return getFirstObject() as Gebruiker
    }
    
    func addWhereContainedIn(column: String, objects: [AnyObject]!) {
        q.whereKey(column, containedIn: objects)
    }
    
    func addWhereNotContainedIn(column: String, objects: [AnyObject]!) {
        q.whereKey(column, notContainedIn: objects)
    }
    
    func addWhereNotEqualTo(column: String, value: AnyObject!) {
        q.whereKey(column, notEqualTo: value)
    }
    
    func updateObject(object: AnyObject, id: String) -> AnyObject? {
        var o = q.getObjectWithId(id)
        
        if table == Constanten.TABLE_MONITOR {
            var updatedObject = MonitorLD.update(o, monitor: object as Monitor) as Monitor
            return updatedObject
        }
        
        return nil
    }
}









