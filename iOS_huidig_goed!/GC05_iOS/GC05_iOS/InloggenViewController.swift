import UIKit
import QuartzCore

class InloggenViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtWachtwoord: UITextField!
    
    var statusTextFields: [String: String] = [:]
    var redColor: UIColor = UIColor.redColor()
    
    @IBAction func toggle(sender: AnyObject) {
        txtEmail.resignFirstResponder()
        txtWachtwoord.resignFirstResponder()
        toggleSideMenuView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        spinner.hidden = true
        hideSideMenuView()
        self.setNeedsStatusBarAppearanceUpdate()
        self.navigationController!.toolbarHidden = true
        txtEmail.autocorrectionType = UITextAutocorrectionType.No
        txtWachtwoord.autocorrectionType = UITextAutocorrectionType.No
        
        txtEmail.delegate = self
        txtWachtwoord.delegate = self
    }
    
    func checkPatternEmail(email: String) -> Bool {
        if countElements(email) == 0 {
            return false
        } else if Regex(p: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}").test(email) {
            return true
        }
        return false
    }
    
    func setStatusTextFields() {
        if txtEmail.text.isEmpty {
            statusTextFields["email"] = "leeg"
        } else {
            if !checkPatternEmail(txtEmail.text) {
                statusTextFields["email"] = "ongeldig"
            } else {
                statusTextFields["email"] = "geldig"
            }
        }
        
        if txtWachtwoord.text.isEmpty {
            statusTextFields["wachtwoord"] = "leeg"
        } else {
            statusTextFields["wachtwoord"] = "ingevuld"
        }
    }
    
    func pasLayoutVeldenAan() {
        if statusTextFields["email"] == "leeg" || statusTextFields["email"] == "ongeldig" {
            giveUITextFieldRedBorder(txtEmail)
        } else {
            giveUITextFieldDefaultBorder(txtEmail)
        }
        
        if statusTextFields["wachtwoord"] == "leeg" {
            giveUITextFieldRedBorder(txtWachtwoord)
        } else {
            giveUITextFieldDefaultBorder(txtWachtwoord)
        }
    }
    
    func controleerRodeBordersAanwezig() -> Bool {
        if CGColorEqualToColor(txtEmail.layer.borderColor, redColor.CGColor) {
            return true
        } else if CGColorEqualToColor(txtWachtwoord.layer.borderColor, redColor.CGColor) {
            return true
        } else {
            return false
        }
    }
    
    @IBAction func inloggen(sender: AnyObject) {
        spinner.startAnimating()
        spinner.hidden = false
        var email: String = txtEmail.text
        var wachtwoord: String = txtWachtwoord.text
        
        setStatusTextFields()
        pasLayoutVeldenAan()
        
        if controleerRodeBordersAanwezig() == true {
            spinner.stopAnimating()
            spinner.hidden = true
            foutBoxOproepen("Fout", "Gelieve de velden correct in te vullen!", self)
            self.txtEmail.text = ""
            self.txtWachtwoord.text = ""
        } else {
            var user = PFUser.logInWithUsername(txtEmail.text, password: txtWachtwoord.text)
            
            if user == nil {
                spinner.stopAnimating()
                giveUITextFieldRedBorder(self.txtEmail)
                giveUITextFieldRedBorder(self.txtWachtwoord)
                txtEmail.text = ""
                txtWachtwoord.text = ""
                foutBoxOproepen("Fout", "Foutieve combinatie e-mail & wachtwoord", self)
                spinner.hidden = true
            } else {
                var type: String = user["soort"] as String
                
                if type == "monitor" {
                    var monitor = ParseData.getMonitorWithEmail(txtEmail.text)
                    performSegueWithIdentifier("overzichtMonitor", sender: self)
                } else if type == "ouder" {
                    var ouder = ParseData.getOuderWithEmail(txtEmail.text)
                    performSegueWithIdentifier("ouderOverzicht", sender: self)
                } else if type == "administrator" {
                    performSegueWithIdentifier("administratorOverzicht", sender: self)
                } else {
                    //column "soort" is niet ingevuld bij deze user in tabel User
                    //ERROR
                }
                spinner.stopAnimating()
            }
        }
    }
    
    @IBAction func gaTerugNaarInloggen(segue: UIStoryboardSegue) {
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "nieuwWachtwoord" {
            let nieuwWachtwoordController = segue.destinationViewController as NieuwWachtwoordViewController
        } else if segue.identifier == "registreren" {
            let registrerenController = segue.destinationViewController as Registratie1ViewController
        } else if segue.identifier == "ouderOverzicht" {
            let ouderOverzichtController = segue.destinationViewController as VakantiesTableViewController
        } else if segue.identifier == "overzichtMonitor" {
            //let profielOverzichtController = segue.destinationViewController as EigenprofielMonitorTableViewController
            let vormingenTableViewController = segue.destinationViewController as VormingenTableViewController
        } else if segue.identifier == "administratorOverzicht" {
            let overzichtAdministrator = segue.destinationViewController as VakantiesTableViewController
        } else {
            var alert = UIAlertController(title: "Fout", message: "U hebt niet alle velden ingevuld!", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ga terug", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    private func veldenZijnIngevuld(email: String, wachtwoord: String) -> Bool {
        if !email.isEmpty && !wachtwoord.isEmpty {
            return true
        } else {
            return false
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == txtEmail {
            txtWachtwoord.becomeFirstResponder()
        } else if textField == txtWachtwoord {
            inloggen(self)
            txtWachtwoord.resignFirstResponder()
        }
        return true
    }
}