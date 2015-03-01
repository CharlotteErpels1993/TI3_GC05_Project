import Foundation

struct FeedbackLD {
    
    //
    //Function: getFeedbacks
    //
    //Deze functie zet een array van PFObject om naar een array van Feedback.
    //
    //Parameters: - objecten: [PFObject]
    //
    //Return: een array van Feedback
    //
    static func getFeedbacks(objecten: [PFObject]) -> [Feedback] {
        var feedbacks: [Feedback] = []
        
        for object in objecten {
            feedbacks.append(getFeedback(object))
        }
        
        return feedbacks
    }
    
    //
    //Function: getFeedback
    //
    //Deze functie zet een PFObject om naar een Feedback.
    //
    //Parameters: - object: PFObject
    //
    //Return: een Feedback
    //
    static func getFeedback(object: PFObject) -> Feedback {
        
        var feedback: Feedback = Feedback(id: object.objectId)
        
        //var whereGebruiker : [String : AnyObject] = [:]
        //var whereVakantie : [String : AnyObject] = [:]
        
        //Constraints definiëren
        //whereGebruiker[Constanten.COLUMN_OBJECTID] = object[Constanten.COLUMN_GEBRUIKER] as? String
        //whereVakantie[Constanten.COLUMN_OBJECTID] = object[Constanten.COLUMN_VAKANTIE] as? String
        
        //Queries maken
        //var queryOuder = LocalDatastore.query(Constanten.TABLE_OUDER, whereArgs: whereGebruiker)
        var queryOuder = Query(tableName: Constanten.TABLE_OUDER)
        queryOuder.addWhereEqualTo(Constanten.COLUMN_OBJECTID, value: object[Constanten.COLUMN_GEBRUIKER])
        
        //var queryMonitor = LocalDatastore.query(Constanten.TABLE_MONITOR, whereArgs: whereGebruiker)
        var queryMonitor = Query(tableName: Constanten.TABLE_MONITOR)
        queryMonitor.addWhereEqualTo(Constanten.COLUMN_OBJECTID, value: object[Constanten.COLUMN_GEBRUIKER])
        
        //var queryVakantie = LocalDatastore.query(Constanten.TABLE_VAKANTIE, whereArgs: whereVakantie)
        var queryVakantie = Query(tableName: Constanten.TABLE_VAKANTIE)
        queryVakantie.addWhereEqualTo(Constanten.COLUMN_OBJECTID, value: object[Constanten.COLUMN_VAKANTIE])
        
        //Aftesten of gebruiker een ouder of monitor is en juiste object invullen
        /*if LocalDatastore.isResultSetEmpty(queryOuder) {
            feedback.gebruiker = LocalDatastore.getFirstObject(Constanten.TABLE_MONITOR, query: queryMonitor) as? Gebruiker
        } else {
            feedback.gebruiker = LocalDatastore.getFirstObject(Constanten.TABLE_OUDER, query: queryOuder) as? Gebruiker
        }*/
        
        if queryOuder.isEmpty() {
            feedback.gebruiker = queryMonitor.getFirstObject() as Monitor
        } else {
            feedback.gebruiker = queryOuder.getFirstObject() as Ouder
        }
        
        feedback.datum = object[Constanten.COLUMN_DATUM] as? NSDate
        feedback.goedgekeurd = object[Constanten.COLUMN_GOEDGEKEURD] as? Bool
        feedback.waardering = object[Constanten.COLUMN_WAARDERING] as? String
        feedback.score = object[Constanten.COLUMN_SCORE] as? Int

        //feedback.vakantie = LocalDatastore.getFirstObject(Constanten.TABLE_VAKANTIE, query: queryVakantie) as? Vakantie
        feedback.vakantie = queryVakantie.getFirstObject() as? Vakantie
        
        return feedback
    }
    
    //
    //Function: insert
    //
    //Deze functie insert een Feedback object in de local datastore en
    //synct deze verandering dan naar de online database.
    //
    //Parameters: - feedback: Feedback
    //
    static func insert(feedback: Feedback) {
        
        let object = PFObject(className: Constanten.TABLE_FEEDBACK)
        
        object[Constanten.COLUMN_DATUM] = feedback.datum
        object[Constanten.COLUMN_GOEDGEKEURD] = feedback.goedgekeurd
        object[Constanten.COLUMN_VAKANTIE] = feedback.vakantie?.id
        object[Constanten.COLUMN_GEBRUIKER] = feedback.gebruiker?.id
        object[Constanten.COLUMN_WAARDERING] = feedback.waardering
        object[Constanten.COLUMN_SCORE] = feedback.score
        
        object.pin()
        object.save()
    }
}