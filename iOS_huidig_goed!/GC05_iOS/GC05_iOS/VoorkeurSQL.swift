import Foundation

struct /*class*/ VoorkeurSQL {
    
    static func createVoorkeurTable() {
        if let error = SD.createTable("Voorkeur", withColumnNamesAndTypes:
            ["objectId": .StringVal, "monitor": .StringVal, "vakantie": .StringVal,
             "periodes": .StringVal])
        {
            println("ERROR: error tijdens creatie van table Voorkeur")
        }
        else
        {
            //no error
        }
    }
    
    static func parseVoorkeurToDatabase(voorkeur: Voorkeur) {
        var voorkeurJSON = PFObject(className: "Voorkeur")
        
        voorkeurJSON.setValue(voorkeur.data, forKey: "periodes")
        voorkeurJSON.setValue(voorkeur.monitor?.id, forKey: "monitor")
        voorkeurJSON.setValue(voorkeur.vakantie?.id, forKey: "vakantie")
        
        voorkeurJSON.save()
    }
    
}