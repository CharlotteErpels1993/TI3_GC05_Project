import Foundation

class VormingRepository {
    
    var vormingen: [Vorming] = []
    
    init() {
        refreshVormingen()
    }
    
    func getAllVormingen() -> [Vorming] {
        return self.vormingen
    }
    
    func getVormingWithId(id: String) -> Vorming {
        var vorming: Vorming = Vorming(id: id)
        
        for v in vormingen {
            if v.id == id {
                vorming = v
            }
        }
        
        return vorming
    }
    
    private func refreshVormingen() {
        var query = PFQuery(className: "Vorming")
        self.vormingen = query.findObjects() as [Vorming]
    }
    
}