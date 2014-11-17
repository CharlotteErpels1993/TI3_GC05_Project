import Foundation
import UIKit

class InschrijvenVakantie2ViewController : UIViewController {
    var deelnemer: Deelnemer!
    var redColor: UIColor = UIColor.redColor()
    //var ouder: Ouder!
    
    @IBOutlet weak var dpGeboortedatum: UIDatePicker!
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "volegnde" {
        let inschrijvenVakantie3ViewController = segue.destinationViewController as InschrijvenVakantie3ViewController
        
        //nog controleren!!!
        
        deelnemer.geboortedatum = dpGeboortedatum.date
        
        inschrijvenVakantie3ViewController.deelnemer = deelnemer
        //inschrijvenVakantie3ViewController.ouder = ouder
        } else if segue.identifier == "gaTerug" {
            let vakantiesTableViewController = segue.destinationViewController as VakantiesTableViewController
        }
    }
}