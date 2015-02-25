import Foundation
import UIKit
import QuartzCore

class InschrijvenVakantie5ViewController : UIViewController {
    
    var wilExtraInfo: Bool! = true
    var inschrijvingVakantie: InschrijvingVakantie!

    @IBOutlet weak var switchExtraInfo: UISwitch!
    @IBOutlet weak var txtViewExtraInfo: UITextView!
    
    //
    //Naam: annuleer
    //
    //Werking: - zorgt ervoor wanneer de gebruiker op annuleer drukt, er een melding komt of de gebruiker zeker is van zijn beslissing
    //
    //Parameters:
    //  - sender: AnyObject
    //
    //Return:
    //
    @IBAction func annuleer(sender: AnyObject) {
        annuleerControllerInschrijvenVakantieVorming(self)
    }
    
    //
    //Naam: switched
    //
    //Werking: - kijkt of de switch aan staat:
    //              * switch aan: bool wilExtraInfo op true
    //              * switch uit: bool wilExtraInfo op false
    //
    //Parameters:
    //  - sender: UISwitch
    //
    //Return:
    //
    @IBAction func switched(sender: UISwitch) {
        if sender.on {
            wilExtraInfo = true
            giveUITextViewDefaultBorder(txtViewExtraInfo)
            txtViewExtraInfo.hidden = false
        } else {
            wilExtraInfo = false
            giveUITextViewDefaultBorder(txtViewExtraInfo)
            txtViewExtraInfo.hidden = true
        }
    }
    
    //
    //Naam: viewDidLoad
    //
    //Werking: - geeft de text field een default border
    //
    //Parameters:
    //
    //Return:
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        giveUITextViewDefaultBorder(txtViewExtraInfo)
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
            let inschrijvenVakantieSuccesvolViewController = segue.destinationViewController as InschrijvenVakantieSuccesvolViewController
    
            if wilExtraInfo == true {
                if txtViewExtraInfo.text.isEmpty {
                    giveUITextViewRedBorder(txtViewExtraInfo)
                    foutBoxOproepen("Fout", "Gelieve het veld in te vullen!", self)
                } else {
                    inschrijvingVakantie.extraInfo = txtViewExtraInfo.text
                }
            } else {
                inschrijvingVakantie.extraInfo = ""
            }
            inschrijvenVakantieSuccesvolViewController.inschrijvingVakantie = inschrijvingVakantie
        } else if segue.identifier == "gaTerug" {
            let vakantiesTableViewController = segue.destinationViewController as VakantiesTableViewController
        }
    }
}