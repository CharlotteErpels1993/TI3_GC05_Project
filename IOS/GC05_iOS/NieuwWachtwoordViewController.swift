import UIKit

class NieuwWachtwoordViewController: UIViewController {
    @IBOutlet weak var emailAdresTxt: UITextField!
    
    //
    //Naam: viewDidLoad
    //
    //Werking: - zorgt ervoor dat het text field emailadres in het begin leeg is
    //
    //Parameters:
    //
    //Return:
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        emailAdresTxt.text = ""
        LocalDatastore.getTableReady("User")
    }
    
    //
    //Naam: prepareForSegue
    //
    //Werking: - maakt de volgende view met opgegeven identifier (stelt soms attributen van de volgende view op)
    //         - controleert ook eerste de ingevulde velden op geldigheid, door middel van de methode nieuwWachtwoord()
    //
    //Parameters:
    //  - segue: UIStoryboardSegue
    //  - sender: AnyObject?
    //
    //Return:
    //
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "nieuwWachtwoord2" {
            nieuwWachtwoord()
        } else if segue.identifier == "gaTerugNaarInloggen" {
            let inloggenViewController = segue.destinationViewController as InloggenViewController
        }
    }
    
    //
    //Naam: nieuwWachtwoord
    //
    //Werking: - zorgt ervoor wanneer de gebruiker geen internet heeft, er een melding getoond wordt
    //         - controleert ook eerste email text field op geldigheid, zonee wordt er een foutmelding gegeven
    //
    //Parameters:
    //
    //Return:
    //
    func nieuwWachtwoord() {
        var email = emailAdresTxt.text
        
        if Reachability.isConnectedToNetwork() == false {
            var alert = UIAlertController(title: "Oeps.. U heeft geen internet", message: "U heeft internet nodig voor u te registeren. Ga naar instellingen om dit aan te passen.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Annuleer", style: UIAlertActionStyle.Default, handler: nil))
            alert.addAction(UIAlertAction(title: "Ga naar instellingen", style: .Default, handler: { action in
                switch action.style{
                default:
                    UIApplication.sharedApplication().openURL(NSURL(string:UIApplicationOpenSettingsURLString)!);
                }
                
            }))
            alert.addAction(UIAlertAction(title: "Ga terug naar Inloggen", style: .Default, handler: { action in
                switch action.style{
                default:
                    self.performSegueWithIdentifier("gaTerugNaarInloggen", sender: self)
            }
                
            }))
            presentViewController(alert, animated: true, completion: nil)
            emailAdresTxt.resignFirstResponder()
            
        }
        
        if (email != nil && checkPatternEmail(email) && isValidEmailInDatabase(email)) {
            PFUser.requestPasswordResetForEmail(email)
        } else {
            giveUITextFieldRedBorder(self.emailAdresTxt)
            var alert = UIAlertController(title: "Fout", message: "Vul een geldig email adres in!", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ga terug", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            emailAdresTxt.text = ""
            viewDidLoad()
        }
    }
    
    //
    //Naam: isValidEmailInDatabase
    //
    //Werking: - bekijkt in de databank of er een email is geregistreerd
    //
    //Parameters:
    //  - email: String
    //
    //Return: een bool true als het email geregistreerd is in de database, anders false
    //
    func isValidEmailInDatabase(email: String) -> Bool {
        return LocalDatastore.isEmailAlGeregistreerd(email)
    }
    
}