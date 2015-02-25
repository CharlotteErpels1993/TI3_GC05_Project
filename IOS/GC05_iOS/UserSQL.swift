import Foundation

struct UserSQL {
    
    /*static func createUserTable() {
        if let error = SD.createTable("User", withColumnNamesAndTypes:
            ["objectId": .StringVal, "username": .StringVal, "email": .StringVal,
             "soort": .StringVal])
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
        
        var queryString = ""
        
        var objectId: String = ""
        var username: String = ""
        //var password: String = ""
        var email: String = ""
        var soort: String = ""
        
        for user in users {
            
            queryString.removeAll(keepCapacity: true)
            
            objectId = user.objectId as String
            username = user.username as String
            //password = user.password as String
            email = user.email as String!
            soort = user["soort"] as String
            
            queryString.extend("INSERT INTO User ")
            queryString.extend("(")
            queryString.extend("objectId, ")
            queryString.extend("username, ")
            queryString.extend("email, ")
            queryString.extend("soort")
            queryString.extend(")")
            queryString.extend(" VALUES ")
            queryString.extend("(")
            
            queryString.extend("'\(objectId)', ") //objectId - String
            queryString.extend("'\(username)', ") //username - String
            queryString.extend("'\(email)', ") //email - String
            queryString.extend("'\(soort)'") //soort - String
            
            queryString.extend(")")

            
            if let err = SD.executeChange(queryString)
            {
                println("ERROR: error tijdens toevoegen van nieuwe user in table User")
            }
            else
            {
                //no error, the row was inserted successfully
            }
        }
    }*/
    
    /*static func zoekUserMetEmailEnWachtwoord(email: String, wachtwoord: String) -> PFUser {
        var users: [PFUser] = []
        var user: PFUser = PFUser()
        
        var query = "SELECT * FROM User WHERE email = \(email) AND password = \(wachtwoord)"
        
        let (resultSet, err) = SD.executeQuery(query)
        
        if err != nil
        {
            println("ERROR: error tijdens ophalen van user met email en wachtwoord uit table User")
        }
        else
        {
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
    }*/
}