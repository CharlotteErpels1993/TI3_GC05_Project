import Foundation

class VakantieRepository {
    
    var vakanties: [Vakantie] = []
    
    init() {
        refreshVakanties()
    }
    
    func getAllVakanties() -> [Vakantie] {
        return self.vakanties
    }
    
    func getVakantieWithId(id: String) -> Vakantie {
        var vakantie: Vakantie = Vakantie(id: id)
        
        for v in vakanties {
            if v.id == id {
                vakantie = v
            }
        }
        
        return vakantie
    }
    
    private func refreshVakanties() {
        var query = PFQuery(className: "Vakantie")
        self.vakanties = query.findObjects() as [Vakantie]
    }
    
}