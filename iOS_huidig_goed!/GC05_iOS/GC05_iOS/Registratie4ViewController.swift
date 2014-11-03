import UIKit

class Registratie4ViewController: UIViewController
{
    var aansluitingsNr: Int?
    var codeGerechtigde: Int?
    var rijksregisterNr: String!
    var aansluitingsNrTweedeOuder: Int?
    var voornaam: String!
    var naam: String!
    var straat: String!
    var nummer: Int?
    var bus: String?
    var gemeente: String!
    var postcode: Int?
    var telefoon: String!
    var gsm: String!
    
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtWachtwoord: UITextField!
    @IBOutlet weak var txtBevestigWachtwoord: UITextField!
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        //hoe weten we, als de gebruiker geen lid is van de socialistische mutualiteit
        //of de gebruiker een ouder of een monitor is?
        
        
        //nog controleren op wachtwoord en bevestig wachtwoord, dan view reloaden?
        
        if segue.identifier == "voltooiRegistratie" {
            let registratieSuccesvolViewController = segue.destinationViewController as RegistratieSuccesvolViewController
            
            registratieSuccesvolViewController.gebruiker = Gebruiker(rijksregisterNr: rijksregisterNr!, email: txtEmail.text, wachtwoord: txtWachtwoord.text, voornaam: voornaam!, naam: naam!, straat: straat!, nummer: nummer!, bus: bus!, gemeente: gemeente!, postcode: postcode!, telefoon: telefoon!, gsm: gsm!, aansluitingsNr: aansluitingsNr!, codeGerechtigde: codeGerechtigde!, aansluitingsNrTweedeOuder: aansluitingsNrTweedeOuder!)
            
            //registratieSuccesvolViewController.aansluitingsNrTweedeOuder = aansluitingsNrTweedeOuder
            
        }
    }
    
    //alternatief verloop nog toevoegen in lastenboek!!!! (UC Registreren)
    func controleerGekendeEmail(email: String) -> Bool {
        //var monitors: [PFObject] = []
        var ouders: [PFObject] = []
        
        //var queryMonitor = PFQuery(className: "Monitor")
        var queryOuder = PFQuery(className: "Ouder")
        
        //queryMonitor.whereKey("email", containsString: email)
        queryOuder.whereKey("email", containsString: email)
        
        //var aantalMonitorsMetEmail: Int = queryMonitor.countObjects()
        var aantalOudersMetEmail: Int = queryOuder.countObjects()
    
        if /*aantalMonitorsMetEmail > 0 ||*/ aantalOudersMetEmail > 0 {
            return true
        } else {
            return false
        }
    }
}