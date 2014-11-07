import UIKit

class NieuwWachtwoordViewController: UIViewController {
    
    
    @IBOutlet weak var emailAdresTxt: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "nieuwWachtwoord2" {
            nieuwWachtwoord()
        }
    }
    
    func nieuwWachtwoord() {
        var email = emailAdresTxt.text
        if email != nil && isValidEmail(email) {
            PFUser.requestPasswordResetForEmail(email)
        } else {
            var alert = UIAlertController(title: "Fout", message: "Vul een geldig email adres in!", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ga terug", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            emailAdresTxt.text = " "
        }
    }
    
    /*func isValidEmail(testStr:String) -> Bool {
        println("validate calendar: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        
        var emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest?.evaluateWithObject(emailTest!)
        return result!
    }*/
    
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let range = testStr.rangeOfString(emailRegEx, options:.RegularExpressionSearch)
        let result = range != nil ? true : false
        return result
    }
    
    
}