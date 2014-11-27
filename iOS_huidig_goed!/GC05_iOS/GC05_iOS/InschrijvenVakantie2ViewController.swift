import Foundation
import UIKit

class InschrijvenVakantie2ViewController : ResponsiveTextFieldViewController {
    var inschrijvingVakantie: InschrijvingVakantie!
    var redColor: UIColor = UIColor.redColor()
    //var ouder: Ouder!
    
    @IBOutlet weak var dpGeboortedatum: UIDatePicker!
    
    @IBAction func annuleer(sender: AnyObject) {
       annuleerControllerInschrijvenVakantieVorming(self)
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "volgende" {
            var leeftijd = calculateAge(dpGeboortedatum.date)
            var minLeeftijd = inschrijvingVakantie.vakantie?.minLeeftijd
            var maxLeeftijd = inschrijvingVakantie?.vakantie?.maxLeeftijd
            
            if leeftijd <= minLeeftijd && leeftijd >= maxLeeftijd {
                foutBoxOproepen("Fout", "De leeftijd moet tussen \(inschrijvingVakantie.vakantie?.minLeeftijd!) en \(inschrijvingVakantie.vakantie?.maxLeeftijd!) liggen.", self)
            }
            
            /*if controleerKindAlIngeschreven() == true {
                let alertController = UIAlertController(title: "Fout", message: "Je hebt je al ingeschreven voor deze vakantie", preferredStyle: .Alert)
                let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: {
                    action in
                    let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("Vakanties") as UIViewController
                    self.sideMenuController()?.setContentViewController(destViewController)
                    self.hideSideMenuView()
                })
                alertController.addAction(okAction)
                self.presentViewController(alertController, animated: true, completion: nil)
            }*/
            
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
    
    /*func controleerKindAlIngeschreven() -> Bool {
        var inschrijvingen: [InschrijvingVakantie] = []
        
        inschrijvingen = ParseData.getInschrijvingenVakantie(inschrijvingVakantie)
        
        if inschrijvingen.count > 0 {
            return true
        }
        
        return false
    }*/
    
    
}