import Foundation

struct InschrijvingVakantieSQL {
    
    static func parseInschrijvingVakantieToDatabase(inschrijving: InschrijvingVakantie) -> String {
        var inschrijvingJSON = PFObject(className: "InschrijvingVakantie")
        
        inschrijvingJSON.setValue(inschrijving.vakantie?.id, forKey: "vakantie")
        
        if inschrijving.extraInfo != "" {
            inschrijvingJSON.setValue(inschrijving.extraInfo, forKey: "extraInformatie")
        }
        
        inschrijvingJSON.save()
        inschrijvingJSON.fetch()
        return inschrijvingJSON.objectId
    }
}