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
            var leeftijd = calculateAge(dpGeboortedatum.date)
            var doelgroep = deelnemer.inschrijvingVakantie?.vakantie?.doelgroep
            
            
            let inschrijvenVakantie3ViewController = segue.destinationViewController as InschrijvenVakantie3ViewController
            deelnemer.geboortedatum = dpGeboortedatum.date
            inschrijvenVakantie3ViewController.deelnemer = deelnemer
        } else if segue.identifier == "gaTerug" {
            let vakantiesTableViewController = segue.destinationViewController as VakantiesTableViewController
        }
    }
    
    func calculateAge (birthday: NSDate) -> NSInteger {
        
        var userAge : NSInteger = 0
        var calendar : NSCalendar = NSCalendar.currentCalendar()
        var unitFlags : NSCalendarUnit = NSCalendarUnit.CalendarUnitYear | NSCalendarUnit.CalendarUnitMonth | NSCalendarUnit.CalendarUnitDay
        var dateComponentNow : NSDateComponents = calendar.components(unitFlags, fromDate: NSDate())
        var dateComponentBirth : NSDateComponents = calendar.components(unitFlags, fromDate: birthday)
        
        if ( (dateComponentNow.month < dateComponentBirth.month) ||
            ((dateComponentNow.month == dateComponentBirth.month) && (dateComponentNow.day < dateComponentBirth.day))
            )
        {
            return dateComponentNow.year - dateComponentBirth.year - 1
        }
        else {
            return dateComponentNow.year - dateComponentBirth.year
        }
    }
}