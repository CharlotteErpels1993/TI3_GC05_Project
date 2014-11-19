import UIKit

class RegistratieSuccesvolViewController: UIViewController
{
    var ouder: Ouder!
    
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        //Activity indicator (start animating)
        activityIndicatorView.startAnimating()
        
        parseOuderToDatabase()
        createPFUser()
        logIn()
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        //Activity indicator (stop animating)
        activityIndicatorView.stopAnimating()
    }
    
    private func parseOuderToDatabase() {
        
        var ouderJSON = PFObject(className: "Ouder")
        
        ouderJSON.setValue(ouder.email, forKey: "email")
        ouderJSON.setValue(ouder.wachtwoord, forKey: "wachtwoord")
        ouderJSON.setValue(ouder.voornaam, forKey: "voornaam")
        ouderJSON.setValue(ouder.naam, forKey: "naam")
        ouderJSON.setValue(ouder.straat, forKey: "straat")
        ouderJSON.setValue(ouder.nummer, forKey: "nummer")
        ouderJSON.setValue(ouder.postcode, forKey: "postcode")
        ouderJSON.setValue(ouder.gemeente, forKey: "gemeente")
        ouderJSON.setValue(ouder.gsm, forKey: "gsm")
        
        if ouder.rijksregisterNr != nil {
            ouderJSON.setValue(ouder.rijksregisterNr, forKey: "rijksregisterNr")
            ouderJSON.setValue(ouder.aansluitingsNr, forKey: "aansluitingsNr")
            ouderJSON.setValue(ouder.codeGerechtigde, forKey: "codeGerechtigde")
            
            if ouder.aansluitingsNrTweedeOuder != nil {
                ouderJSON.setValue(ouder.aansluitingsNrTweedeOuder, forKey: "aansluitingsNrTweedeOuder")
            }
        }
        
        if ouder.bus != nil {
            ouderJSON.setValue(ouder.bus, forKey: "bus")
        }
        
        if ouder.telefoon != nil {
            ouderJSON.setValue(ouder.telefoon, forKey: "telefoon")
        }
        
        ouderJSON.save()
    }
    
    private func createPFUser() {
        var user = PFUser()
        user.username = ouder.email
        user.password = ouder.wachtwoord
        user.email = ouder.email
        
        user.signUpInBackgroundWithBlock {
            (succeeded: Bool!, error: NSError!) -> Void in
            if error == nil {
                
            }
        }
    }
    
    private func logIn() {
        PFUser.logInWithUsername(ouder.email, password: ouder.wachtwoord)
    }
}