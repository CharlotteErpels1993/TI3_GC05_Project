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
        
        feedback.datum = object[Constanten.COLUMN_DATUM] as? NSDate
        feedback.goedgekeurd = object[Constanten.COLUMN_GOEDGEKEURD] as? Bool
        feedback.waardering = object[Constanten.COLUMN_WAARDERING] as? String
        feedback.score = object[Constanten.COLUMN_SCORE] as? Int
        
        var wArgsGebruiker : [String : AnyObject] = [:]
        wArgsGebruiker[Constanten.COLUMN_OBJECTID] = object[Constanten.COLUMN_GEBRUIKER] as? String
        
        if LocalDatastore.isResultSetEmpty(Constanten.TABLE_OUDER, whereArgs: wArgsGebruiker) {
            feedback.gebruiker = LocalDatastore.queryFirstObject(Constanten.TABLE_MONITOR, whereArgs: wArgsGebruiker) as? Gebruiker
        } else {
            feedback.gebruiker = LocalDatastore.queryFirstObject(Constanten.TABLE_OUDER, whereArgs: wArgsGebruiker) as? Gebruiker
        }
        
        var wArgsVakantie : [String : AnyObject] = [:]
        wArgsVakantie[Constanten.COLUMN_OBJECTID] = object[Constanten.COLUMN_VAKANTIE] as? String
        
        feedback.vakantie = LocalDatastore.queryFirstObject(Constanten.TABLE_VAKANTIE, whereArgs: wArgsVakantie) as? Vakantie
        
        return feedback
    }
}