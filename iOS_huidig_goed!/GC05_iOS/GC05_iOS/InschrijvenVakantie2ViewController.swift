import Foundation
import UIKit

class InschrijvenVakantie2ViewController : UIViewController {
    var deelnemer: Deelnemer!
    var redColor: UIColor = UIColor.redColor()
    
    @IBOutlet weak var datePickerGeboorteDatum: UIDatePicker!
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let inschrijvenVakantie3ViewController = segue.destinationViewController as InschrijvenVakantie3ViewController
        
        //nog controleren!!!
        
        deelnemer.geboortedatum = datePickerGeboorteDatum.date
        
        inschrijvenVakantie3ViewController.deelnemer = deelnemer
        
    }
}