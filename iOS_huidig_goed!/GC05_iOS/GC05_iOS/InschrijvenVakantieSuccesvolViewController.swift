import Foundation
import UIKit

class InschrijvenVakantieSuccesvolViewController : UIViewController {
    
    var inschrijvingVakantie: InschrijvingVakantie!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var deelnemerId = ParseToDatabase.parseDeelnemerToDatabase(inschrijvingVakantie.deelnemer!)
        //var deelnemerId = ParseData.parseDeelnemerToDatabase(inschrijvingVakantie.deelnemer!)
        //var deelnemerId = LocalDatastore.parseDeelnemerToDatabase(inschrijvingVakantie.deelnemer!)
        
        var contactpersoon1Id = ParseToDatabase.parseContactpersoonNoodToDatabase(inschrijvingVakantie.contactpersoon1!)
        //var contactpersoon1Id = ParseData.parseContactpersoonNoodToDatabase(inschrijvingVakantie.contactpersoon1!)
        //var contactpersoon1Id = LocalDatastore.parseContactpersoonNoodToDatabase(inschrijvingVakantie.contactpersoon1!)
        
        
        inschrijvingVakantie.deelnemer?.id = deelnemerId
        inschrijvingVakantie.contactpersoon1?.id = contactpersoon1Id
        
        if inschrijvingVakantie.contactpersoon2 != nil {
            //var contactpersoon2Id = ParseData.parseContactpersoonNoodToDatabase(inschrijvingVakantie.contactpersoon2!)
            var contactpersoon2Id = LocalDatastore.parseContactpersoonNoodToDatabase(inschrijvingVakantie.contactpersoon2!)
            inschrijvingVakantie.contactpersoon2?.id = contactpersoon2Id
        }
        
        //ParseData.parseInschrijvingVakantieToDatabase(inschrijvingVakantie)
        ParseToDatabase.parseInschrijvingVakantieToDatabase(inschrijvingVakantie)
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
}