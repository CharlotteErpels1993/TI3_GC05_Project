import Foundation

struct FeedbackSQL {
    static func createFeedbackTable() {
        if let error = SD.createTable("Feedback", withColumnNamesAndTypes: ["objectId": .StringVal, "datum": .StringVal, "gebruiker": .StringVal, "vakantie": .StringVal, "goedgekeurd": .BoolVal, "waardering": .StringVal, "score": .IntVal])
        {
            println("ERROR: error tijdens creatie van table Feedback")
        }
        else
        {
            //no error
        }
    }
    
    static func vulFeedbackTableOp() {
        var feedbacken: [PFObject] = []
        var query = PFQuery(className: "Feedback")
        feedbacken = query.findObjects() as [PFObject]
        
        var queryString = ""
        
        var objectId: String = ""
        var datum: NSDate = NSDate()
        var gebruiker: String = ""
        var vakantie: String = ""
        var goedgekeurd: Bool = false
        var waardering: String = ""
        var score: Int = 0
        
        for feedback in feedbacken {
            
            queryString.removeAll(keepCapacity: true)
            
            objectId = feedback.objectId as String
            datum = feedback["datum"] as NSDate
            gebruiker = feedback["gebruiker"] as String
            vakantie = feedback["vakantie"] as String
            goedgekeurd = feedback["goedgekeurd"] as Bool
            waardering = feedback["waardering"] as String
            score = feedback["score"] as Int
            
            queryString.extend("INSERT INTO Feedback ")
            queryString.extend("(")
            queryString.extend("objectId, ")
            queryString.extend("datum, ")
            queryString.extend("gebruiker, ")
            queryString.extend("vakantie, ")
            queryString.extend("goedgekeurd, ")
            queryString.extend("waardering, ")
            queryString.extend("score")
            queryString.extend(")")
            queryString.extend(" VALUES ")
            queryString.extend("(")
            
            queryString.extend("'\(objectId)', ") //objectId - String
            queryString.extend("'\(datum)', ") //datum - String
            queryString.extend("'\(gebruiker)', ") //gebruiker - String
            queryString.extend("'\(vakantie)', ") //vakantie - String
            queryString.extend("'\(goedgekeurd)', ") //goedgekeurd - Bool
            queryString.extend("'\(waardering)', ") //waardering - String
            queryString.extend("\(score)") // score - Int (geen '')!!
            
            queryString.extend(")")
            
            
            if let err = SD.executeChange(queryString)
            {
                println("ERROR: error tijdens toevoegen van nieuwe Feedback in table Feedback")
            }
            else
            {
                //no error, the row was inserted successfully
            }
            
        }
    }
    
    static func getAlleFeedback() -> ([Feedback], Int?) {
        var feedbacken:[Feedback] = []
        var feedback: Feedback = Feedback(id: "test")
        
        let (resultSet, err) = SD.executeQuery("SELECT * FROM Feedback")
        
        var response: ([Feedback], Int?)
        var error: Int?
        
        if err != nil
        {
            println("ERROR: error tijdens ophalen van alle feedback uit table Feedback")
        }
        else
        {
            if resultSet.count == 0 {
                error = 1
            }
            else {
                error = nil
                
                for row in resultSet {
                    feedback = getFeedback(row)
                    feedbacken.append(feedback)
                }
                
            }
            
        }
        
        response = (feedbacken, error)
        return response
    }
    
    static func getFeedback(row: SD.SDRow) -> Feedback {
        var feedback: Feedback = Feedback(id: "test")
        
        if let objectId = row["objectId"]?.asString() {
            feedback.id = objectId
        }
        if let datum = row["datum"]?.asString() {
            var datumString = datum
            feedback.datum = datumString.toDate() as NSDate!
        }
        if let gebruiker = row["gebruiker"]?.asString() {
            feedback.gebruiker?.id = gebruiker
        }
        if let vakantie = row["vakantie"]?.asString() {
            feedback.vakantie?.id = vakantie
        }
        if let goedgekeurd = row["goedgekeurd"]?.asBool() {
            feedback.goedgekeurd = goedgekeurd
        }
        if let waadering = row["waardering"]?.asString() {
            feedback.waardering = waadering
        }
        if let score = row["score"]?.asInt() {
            feedback.score = score
        }
        
        return feedback
    }
    
    static func parseFeedbackToDatabase(feedback: Feedback) {
        var feedbackJSON = PFObject(className: "Feedback")
        
        //inschrijvingJSON.setValue(inschrijving.periode, forKey: "periode")
        //feedbackJSON.setValue(favoriet.ouder?.id, forKey: "ouder")
        //favorietJSON.setValue(favoriet.vakantie?.id, forKey: "vakantie")
        feedbackJSON.setValue(feedback.datum, forKey: "datum")
        feedbackJSON.setValue(feedback.goedgekeurd, forKey: "goedgekeurd")
        feedbackJSON.setValue(feedback.gebruiker!.id, forKey: "gebruiker")
        feedbackJSON.setValue(feedback.vakantie!.id, forKey: "vakantie")
        feedbackJSON.setValue(feedback.waardering, forKey: "waardering")
        feedbackJSON.setValue(feedback.score, forKey: "score")
        
        
        feedbackJSON.save()
    }
    
    static func getAlleFeedbackMetVakantieId(vakantieId: String) -> ([Feedback], Int?){
        var feedbacken: [Feedback] = []
        var feedback: Feedback = Feedback(id: "test")
        
        var query = "SELECT * FROM Feedback WHERE vakantie = \(vakantieId)"
        
        let (resultSet, err) = SD.executeQuery(query)
        
        var response: ([Feedback], Int?)
        var error: Int?
        
        if err != nil {
            //there was an error during the query, handle it here
        } else {
            if resultSet.count == 0 {
                error = 1
            }
            else {
                error = nil
                
                for row in resultSet {
                    feedback = getFeedback(row)
                    feedbacken.append(feedback)
                }
            }
        }
        
        //return afbeeldingen
        response = (feedbacken, error)
        return response
    }
}