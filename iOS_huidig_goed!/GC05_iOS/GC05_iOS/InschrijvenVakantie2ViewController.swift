import Foundation
import UIKit

class InschrijvenVakantie2ViewController : ResponsiveTextFieldViewController {
    var inschrijvingVakantie: InschrijvingVakantie!
    var redColor: UIColor = UIColor.redColor()
    var grayColor: UIColor = UIColor.grayColor()
    //var ouder: Ouder!
    var leeftijd: Int = 0
    
    @IBOutlet weak var dpGeboortedatum: UIDatePicker!
    
    @IBAction func annuleer(sender: AnyObject) {
       annuleerControllerInschrijvenVakantieVorming(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "volgende" {
            self.leeftijd = calculateAge(dpGeboortedatum.date) as Int
            var minLeeftijd = inschrijvingVakantie.vakantie!.minLeeftijd
            var maxLeeftijd = inschrijvingVakantie.vakantie!.maxLeeftijd
            
            if leeftijd < minLeeftijd || leeftijd > maxLeeftijd || leeftijd == 0 {
                dpGeboortedatum.layer.borderColor = redColor.CGColor
                dpGeboortedatum.layer.borderWidth = 2.0
                dpGeboortedatum.layer.cornerRadius = 5.0
                foutBoxOproepen("Fout", "De leeftijd moet tussen \(inschrijvingVakantie.vakantie!.minLeeftijd!) en \(inschrijvingVakantie.vakantie!.maxLeeftijd!) liggen.", self)
                 viewDidLoad()
            }
            
            let inschrijvenVakantie3ViewController = segue.destinationViewController as InschrijvenVakantie3ViewController
            inschrijvingVakantie.deelnemer?.geboortedatum = dpGeboortedatum.date
            inschrijvenVakantie3ViewController.inschrijvingVakantie = inschrijvingVakantie
            
            
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