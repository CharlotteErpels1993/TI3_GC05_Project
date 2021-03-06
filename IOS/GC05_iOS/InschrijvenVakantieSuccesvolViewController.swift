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
        
        //var deelnemerId = ParseToDatabase.parseDeelnemer(inschrijvingVakantie.deelnemer!)
        var deelnemerId = DeelnemerLD.insert(inschrijvingVakantie.deelnemer!)
        inschrijvingVakantie.deelnemer?.id = deelnemerId
        
        //var contactpersoon1Id = ParseToDatabase.parseContactpersoonNood(inschrijvingVakantie.contactpersoon1!)
        var contactpersoon1Id = ContactpersoonNoodLD.insert(inschrijvingVakantie.contactpersoon1!)
        inschrijvingVakantie.contactpersoon1?.id = contactpersoon1Id
        
        if inschrijvingVakantie.contactpersoon2 != nil {
            var contactpersoon2Id = ContactpersoonNoodLD.insert(inschrijvingVakantie.contactpersoon2!)
            inschrijvingVakantie.contactpersoon2?.id = contactpersoon2Id
        }
        
        //ParseToDatabase.parseInschrijvingVakantie(inschrijvingVakantie)
        InschrijvingVakantieLD.insert(inschrijvingVakantie)
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
}