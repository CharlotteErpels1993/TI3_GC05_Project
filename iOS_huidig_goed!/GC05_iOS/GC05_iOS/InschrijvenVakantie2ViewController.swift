import Foundation
import UIKit

class InschrijvenVakantie2ViewController : ResponsiveTextFieldViewController {
    var deelnemer: Deelnemer!
    var redColor: UIColor = UIColor.redColor()
    //var ouder: Ouder!
    
    @IBOutlet weak var dpGeboortedatum: UIDatePicker!
    
    @IBAction func annuleer(sender: AnyObject) {
       annuleerControllerInschrijvenVakantieVorming(self)
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "volgende" {
            let inschrijvenVakantie3ViewController = segue.destinationViewController as InschrijvenVakantie3ViewController
            deelnemer.geboortedatum = dpGeboortedatum.date
            inschrijvenVakantie3ViewController.deelnemer = deelnemer
        } else if segue.identifier == "gaTerug" {
            let vakantiesTableViewController = segue.destinationViewController as VakantiesTableViewController
        }
    }
}