import Foundation

struct /*class*/ UserSQL {
    
    static func createUserTable() {
        if let error = SD.createTable("User", withColumnNamesAndTypes:
            ["objectId": .StringVal, "username": .StringVal, "password": .StringVal,
             "email": .StringVal, "soort": .StringVal])
        {
            println("ERROR: error tijdens creatie van table User")
        }
        else
        {
            //no error
        }
    }
    
    static func vulUserTableOp() {
        
        var users: [PFUser] = []
        var query = PFUser.query()
        users = query.findObjects() as [PFUser]
        
        var objectId: String = ""
        var username: String = ""
        var password: String = ""
        var email: String = ""
        var soort: String = ""
        
        for user in users {
            objectId = user.objectId as String
            username = user.username as String
            //password = user.password as String
            email = user.email as String!
            
            
            soort = user["soort"] as String
            
            if let err = SD.executeChange("INSERT INTO User (objectId, username, password, email, soort) VALUES ('\(objectId)', '\(username)', '\(password)', '\(email)', '\(soort)')") {
                //there was an error during the insert, handle it here
            } else {
                //no error, the row was inserted successfully
            }
        }
    }
    
    static func zoekUserMetEmailEnWachtwoord(email: String, wachtwoord: String) -> PFUser {
        var users: [PFUser] = []
        var user: PFUser = PFUser()
        
        var query = "SELECT * FROM User WHERE email = \(email) AND wachtwoord = \(wachtwoord)"
        
        let (resultSet, err) = SD.executeQuery(query)
        
        if err != nil {
            //there was an error during the query, handle it here
        } else {
            for row in resultSet {
                user = getUser(row)
                users.append(user)
            }
        }
        
        return users.first!
    }
    
    static private func getUser(row: SD.SDRow) -> PFUser {
        var user: PFUser = PFUser()
        
        if let objectId = row["objectId"]?.asString() {
            user.objectId = objectId
        }
        if let username = row["username"]?.asString() {
            user.username = username
        }
        if let password = row["password"]?.asString() {
            user.password = password
        }
        if let soort = row["soort"]?.asString() {
            user["soort"] = soort
        }
        
        return user
    }
}