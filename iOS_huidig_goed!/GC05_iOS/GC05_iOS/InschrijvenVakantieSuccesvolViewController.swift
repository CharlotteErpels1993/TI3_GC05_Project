import Foundation
import UIKit

class InschrijvenVakantieSuccesvolViewController : UIViewController {
    
    var inschrijvingVakantie: InschrijvingVakantie!
    
    //
    //Naam: viewDidLoad
    //
    //Werking: - zorgt ervoor dat de inschrijving van de vakantie naar de databank wordt weggeschreven
    //
    //Parameters:
    //
    //Return:
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var deelnemerId = ParseToDatabase.parseDeelnemerToDatabase(inschrijvingVakantie.deelnemer!)
        
        var contactpersoon1Id = ParseToDatabase.parseContactpersoonNoodToDatabase(inschrijvingVakantie.contactpersoon1!)
        
        inschrijvingVakantie.contactpersoon1?.id = contactpersoon1Id
        
        if inschrijvingVakantie.contactpersoon2 != nil {
            var contactpersoon2Id = LocalDatastore.parseContactpersoonNoodToDatabase(inschrijvingVakantie.contactpersoon2!)
            inschrijvingVakantie.contactpersoon2?.id = contactpersoon2Id
        }
        
        ParseToDatabase.parseInschrijvingVakantieToDatabase(inschrijvingVakantie)
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
}