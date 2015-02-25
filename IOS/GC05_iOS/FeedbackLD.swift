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
        
        var whereGebruiker : [String : AnyObject] = [:]
        var whereVakantie : [String : AnyObject] = [:]
        
        //Constraints definiëren
        whereGebruiker[Constanten.COLUMN_OBJECTID] = object[Constanten.COLUMN_GEBRUIKER] as? String
        whereVakantie[Constanten.COLUMN_OBJECTID] = object[Constanten.COLUMN_VAKANTIE] as? String
        
        //Queries maken
        var queryOuder = LocalDatastore.query(Constanten.TABLE_OUDER, whereArgs: whereGebruiker)
        var queryMonitor = LocalDatastore.query(Constanten.TABLE_MONITOR, whereArgs: whereGebruiker)
        var queryVakantie = LocalDatastore.query(Constanten.TABLE_VAKANTIE, whereArgs: whereVakantie)
        
        //Aftesten of gebruiker een ouder of monitor is en juiste object invullen
        if LocalDatastore.isResultSetEmpty(queryOuder) {
            feedback.gebruiker = LocalDatastore.getFirstObject(Constanten.TABLE_MONITOR, query: queryMonitor) as? Gebruiker
        } else {
            feedback.gebruiker = LocalDatastore.getFirstObject(Constanten.TABLE_OUDER, query: queryOuder) as? Gebruiker
        }
        
        feedback.datum = object[Constanten.COLUMN_DATUM] as? NSDate
        feedback.goedgekeurd = object[Constanten.COLUMN_GOEDGEKEURD] as? Bool
        feedback.waardering = object[Constanten.COLUMN_WAARDERING] as? String
        feedback.score = object[Constanten.COLUMN_SCORE] as? Int

        feedback.vakantie = LocalDatastore.getFirstObject(Constanten.TABLE_VAKANTIE, query: queryVakantie) as? Vakantie
        
        return feedback
    }
}