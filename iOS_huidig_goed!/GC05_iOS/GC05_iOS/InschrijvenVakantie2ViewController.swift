import Foundation
import UIKit

class InschrijvenVakantie2ViewController : UIViewController {
    
    var inschrijvingVakantie: InschrijvingVakantie!
    var redColor: UIColor = UIColor.redColor()
    var grayColor: UIColor = UIColor.grayColor()
    var leeftijd: Int = 0
    
    @IBOutlet weak var dpGeboortedatum: UIDatePicker!
    
    //
    //Naam: controleerRijksregisterNummerAlGeregistreerd
    //
    //Werking: - bekijkt in de databank of er al een ouder zich ingeschreven heeft met dat rijksregisternummer
    //
    //Parameters:
    //
    //Return: een bool true als het rijksregisternummer al geregistreerd is, anders false
    //
    @IBAction func annuleer(sender: AnyObject) {
       annuleerControllerInschrijvenVakantieVorming(self)
    }
    
    //
    //Naam: viewDidLoad
    //
    //Werking:
    //
    //Parameters:
    //
    //Return:
    //
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //
    //Naam: prepareForSegue
    //
    //Werking: - maakt de volgende view met opgegeven identifier (stelt soms attributen van de volgende view op)
    //         - controleert ook eerste de ingevulde velden op geldigheid, zonee wordt er een foutmelding gegeven
    //
    //Parameters:
    //  - segue: UIStoryboardSegue
    //  - sender: AnyObject?
    //
    //Return:
    //
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
    
    //
    //Naam: calculateAge
    //
    //Werking: - berekent de leeftijd aan de hand van de geboortedatum
    //
    //Parameters:
    //  - birthday: NSDate
    //
    //Return:
    //
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