import UIKit

class NieuwWachtwoordViewController: ResponsiveTextFieldViewController {
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
            giveUITextFieldRedBorder(self.emailAdresTxt)
            var alert = UIAlertController(title: "Fout", message: "Vul een geldig email adres in!", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ga terug", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            emailAdresTxt.text = ""
            viewDidLoad()
        }
    }
    
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let range = testStr.rangeOfString(emailRegEx, options:.RegularExpressionSearch)
        let result = range != nil ? true : false
        return result
    }
    
    func isValidEmailInDatabase(email: String) -> Bool {
        var monitorResponse = ParseData.getMonitorWithEmail(email)
        var monitor: Monitor = Monitor(id: "id")
        
        if monitorResponse.1 == nil {
            var monitor = monitorResponse.0
        }
        
        var ouderResponse = ParseData.getOuderWithEmail(email)
        
        var ouder = ouderResponse.0
        
        if ouder.id == "test" && monitor.id == "test" {
            return false
        }
        
        return true
    }
    
}