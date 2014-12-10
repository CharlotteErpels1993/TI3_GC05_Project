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
            
            queryString.extend("?, ") //objectId - String
            queryString.extend("?, ") //datum - String
            queryString.extend("?, ") //gebruiker - String
            queryString.extend("?, ") //vakantie - String
            queryString.extend("?, ") //goedgekeurd - Bool
            queryString.extend("?, ") //waardering - String
            queryString.extend("?") // score - Int (geen '')!!
            
            queryString.extend(")")
            
            if let err = SD.executeChange(queryString, withArgs: [objectId, datum, gebruiker, vakantie, goedgekeurd, waardering, score])
            {
                println("ERROR: error tijdens toevoegen van nieuwe feedback in table Feedback")
            }
            
            
            /*if let err = SD.executeChange(queryString)
            {
                println("ERROR: error tijdens toevoegen van nieuwe Feedback in table Feedback")
            }
            else
            {
                //no error, the row was inserted successfully
            }*/
            
        }
    }
    
    static func getAlleFeedback() -> ([Feedback], Int?) {
        var feedbacken:[Feedback] = []
        var feedback: Feedback = Feedback(id: "test")
        var trueBool: Bool = true
        
        let (resultSet, err) = SD.executeQuery("SELECT * FROM Feedback WHERE goedgekeurd = ?", withArgs: [trueBool])
        
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
        var vakantie: Vakantie = Vakantie(id: "test")
        var gebruiker: Gebruiker = Gebruiker(id: "test")
        
        if let objectId = row["objectId"]?.asString() {
            feedback.id = objectId
        }
        if let datum = row["datum"]?.asString() {
            var datumString = datum
            feedback.datum = datumString.toDate() as NSDate!
        }
        if let gebruikerId = row["gebruiker"]?.asString() {
            feedback.gebruiker?.id = gebruikerId
            
            ParseData.deleteOuderTable()
            ParseData.vulOuderTableOp()
            
            var responseOuder = OuderSQL.getOuder(gebruikerId)
            
            if responseOuder.1 != nil {
                //het is geen ouder
                
                ParseData.deleteMonitorTable()
                ParseData.vulMonitorTableOp()
                
                var responseMonitor = MonitorSQL.getMonitor(gebruikerId)
                
                if responseMonitor.1 == nil {
                    //het is een monitor
                    feedback.gebruiker = MonitorSQL.getGebruiker(responseMonitor.0)
                } else {
                    //er is geen gebruiker met dit id teruggevonden
                    println("ERROR: er is geen gebruiker met dit id teruggevonden in FeedbackSQL")
                }
            }
            else {
                //het is een ouder
                feedback.gebruiker = OuderSQL.getGebruiker(responseOuder.0)
            }
        }
        if let vakantieId = row["vakantie"]?.asString() {
            feedback.vakantie?.id = vakantieId
            
            var responseVakantie = VakantieSQL.getVakantie(vakantieId)
            
            if responseVakantie.1 == nil {
                feedback.vakantie = responseVakantie.0
            }
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
}