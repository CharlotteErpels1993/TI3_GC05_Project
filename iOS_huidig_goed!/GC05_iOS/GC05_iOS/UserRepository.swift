import Foundation

class UserRepository {
    
    var users: [PFUser] = []
    
    init() {
        refreshUsers()
    }
    
    func getAllUsers() -> [PFUser] {
        return self.users
    }
    
    func getUserWithId(id: String) -> PFUser {
        var user: PFUser = PFUser()
        
        for u in users {
            if u.objectId == id {
                user == u
            }
        }
        
        return user
    }
    
    func getUserWithEmailAndPassword(email: String, password: String) -> PFUser {
        var user: PFUser = PFUser()
        
        for u in users {
            if u.email == email {
                if u.password == password {
                    user = u
                }
            }
        }
        
        return user
    }
    
    func addUser(user: PFUser) {
        user.signUp()
        refreshUsers()
    }
    
    
    private func refreshUsers() {
        var query = PFUser.query()
        self.users = query.findObjects() as [PFUser]
    }
    
}