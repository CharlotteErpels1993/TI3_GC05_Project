import UIKit

class NieuwWachtwoordViewController: UIViewController {
    @IBOutlet weak var emailAdresTxt: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailAdresTxt.text = ""
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "nieuwWachtwoord2" {
            nieuwWachtwoord()
        }
    }
    
    func nieuwWachtwoord() {
        var email = emailAdresTxt.text
        if (email != nil && isValidEmail(email) && isValidEmailInDatabase(email)) {
            PFUser.requestPasswordResetForEmail(email)
        } else {
            var alert = UIAlertController(title: "Fout", message: "Vul een geldig email adres in!", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ga terug", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            emailAdresTxt.text = " "
            viewDidLoad()
            //email = ""
        }
    }
    
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let range = testStr.rangeOfString(emailRegEx, options:.RegularExpressionSearch)
        let result = range != nil ? true : false
        return result
    }
    
    func isValidEmailInDatabase(email: String) -> Bool {
        var monitor = ParseData.getMonitorWithEmail(email)
        var ouder = ParseData.getOuderWithEmail(email)
        if monitor.id == "nil" || monitor.id == "nil"{
            return false
        }
        
        return true
    }
    
}