import Foundation

struct AfbeeldingLD {
    
    //
    //Function: getAfbeeldingen
    //
    //Deze functie zet een array van PFObject om naar een array van UIImage.
    //
    //Parameters: - objecten: [PFObject]
    //
    //Return: een array van UIImage
    //
    static func getAfbeeldingen(objecten: [PFObject]) -> [UIImage] {
        var afbeeldingen: [UIImage] = []
        
        for object in objecten {
            afbeeldingen.append(getAfbeelding(object))
        }
        
        return afbeeldingen
    }
    
    //
    //Function: getAfbeelding
    //
    //Deze functie zet een  PFObject om naar een UIImage.
    //
    //Parameters: - object: PFObject
    //
    //Return: een UIImage
    //
    static func getAfbeelding(object: PFObject) -> UIImage {
        var imageFile = object["afbeelding"] as PFFile
        var image = UIImage(data: imageFile.getData())!
        return image
    }
}