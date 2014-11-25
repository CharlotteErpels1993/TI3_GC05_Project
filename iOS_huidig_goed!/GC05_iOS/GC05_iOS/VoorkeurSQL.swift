import Foundation

struct VoorkeurSQL {
    
    static func parseVoorkeurToDatabase(voorkeur: Voorkeur) {
        var voorkeurJSON = PFObject(className: "Voorkeur")
        
        voorkeurJSON.setValue(voorkeur.data, forKey: "periodes")
        voorkeurJSON.setValue(voorkeur.monitor?.id, forKey: "monitor")
        voorkeurJSON.setValue(voorkeur.vakantie?.id, forKey: "vakantie")
        
        voorkeurJSON.save()
    }
    
}