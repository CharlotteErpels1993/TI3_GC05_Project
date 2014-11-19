import UIKit
import QuartzCore

class Registratie1ViewController: UIViewController
{
    var ouder: Ouder! = Ouder(id: "test")
    var gebruikerIsLid: Bool? = true
    var foutBox: FoutBox? = nil
    var redColor: UIColor = UIColor.redColor()
    var statusTextFields: [String: String] = [:]
    
    @IBOutlet weak var isLid: UISwitch!
    
    @IBOutlet weak var lblAansluitingsNr: UILabel!
    @IBOutlet weak var txtAansluitingsNr: UITextField!
    @IBOutlet weak var lblCodeGerechtigde: UILabel!
    @IBOutlet weak var txtCodeGerechtigde: UITextField!
    @IBOutlet weak var lblRijksregisterNr: UILabel!
    @IBOutlet weak var txtRijksregisterNr: UITextField!
    @IBOutlet weak var lblAansluitingsNrTweedeOuder: UILabel!
    @IBOutlet weak var txtAansluitingsNrTweedeOuder: UITextField!
    @IBOutlet weak var buttonNummers: UIButton!
    
    @IBAction func toggle(sender: AnyObject) {
        toggleSideMenuView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
    
    
    @IBAction func gaTerugNaarRegistreren(segue: UIStoryboard) {
    }
    
    @IBAction func switched(sender: UISwitch) {
        if sender.on {
            gebruikerIsLid = true
            
            lblAansluitingsNr.hidden = false
            lblCodeGerechtigde.hidden = false
            lblRijksregisterNr.hidden = false
            lblAansluitingsNrTweedeOuder.hidden = false
            
            txtAansluitingsNr.hidden = false
            txtCodeGerechtigde.hidden = false
            txtRijksregisterNr.hidden = false
            txtAansluitingsNrTweedeOuder.hidden = false
            buttonNummers.hidden = false
            
        } else {
            gebruikerIsLid = false
            
            lblAansluitingsNr.hidden = true
            lblCodeGerechtigde.hidden = true
            lblRijksregisterNr.hidden = true
            lblAansluitingsNrTweedeOuder.hidden = true
            
            txtAansluitingsNr.hidden = true
            txtCodeGerechtigde.hidden = true
            txtRijksregisterNr.hidden = true
            txtAansluitingsNrTweedeOuder.hidden = true
            buttonNummers.hidden = true
        }
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "volgende" {
        let registratie3ViewController = segue.destinationViewController as Registratie3ViewController
        
        
        
        //TO DO: controleren op formaat van ingevulde text! (String, int, ...)
        
        if gebruikerIsLid == true {
            setStatusTextFields()
            pasLayoutVeldenAan()
            
            if controleerRodeBordersAanwezig() == true {
                foutBoxOproepen("Fout", "Gelieve de velden correct in te vullen!", self)
            } else {
                settenVerplichteGegevens()
                
                if statusTextFields["aansluitingsNrTweedeouder"] != "leeg" {
                    ouder.aansluitingsNrTweedeOuder = txtAansluitingsNrTweedeOuder.text.toInt()!
                }
            }
        }
        registratie3ViewController.ouder = ouder
        } else if segue.identifier == "gaTerug" {
                let vakantiesViewController = segue.destinationViewController as VakantiesTableViewController
            }
        
    }
    
    func setStatusTextFields() {
        if txtAansluitingsNr.text.isEmpty {
            statusTextFields["aansluitingsNr"] = "leeg"
        } else {
            if !checkPatternAansluitingsNr(txtAansluitingsNr.text.toInt()!) {
                statusTextFields["aansluitingsNr"] = "ongeldig"
            } else {
                statusTextFields["aansluitingsNr"] = "geldig"
            }
        }
        
        if txtCodeGerechtigde.text.isEmpty {
            statusTextFields["codeGerechtigde"] = "leeg"
        } else {
            if !checkPatternCodeGerechtigde(txtCodeGerechtigde.text.toInt()!) {
                statusTextFields["codeGerechtigde"] = "ongeldig"
            } else {
                statusTextFields["codeGerechtigde"] = "geldig"
            }
        }
        
        if txtRijksregisterNr.text.isEmpty {
            statusTextFields["rijksregisterNr"] = "leeg"
        } else {
            if !checkPatternRijksregisterNr(txtRijksregisterNr.text) {
                statusTextFields["rijksregisterNr"] = "ongeldig"
            } else {
                statusTextFields["rijksregisterNr"] = "geldig"
            }
        }
        
        if txtAansluitingsNrTweedeOuder.text.isEmpty {
            statusTextFields["aansluitingsNrTweedeOuder"] = "leeg"
        } else {
            if !checkPatternAansluitingsNr(txtAansluitingsNrTweedeOuder.text.toInt()!) {
                statusTextFields["aansluitingsNrTweedeOuder"] = "ongeldig"
            } else {
                statusTextFields["aansluitingsNrTweedeOuder"] = "geldig"
            }
        }
    }
    
    func pasLayoutVeldenAan() {
        if statusTextFields["aansluitingsNr"] == "leeg" || statusTextFields["aansluitingsNr"] == "ongeldig" {
            giveUITextFieldRedBorder(txtAansluitingsNr)
        } else {
            giveUITextFieldDefaultBorder(txtAansluitingsNr)
        }
        
        if statusTextFields["codeGerechtigde"] == "leeg" || statusTextFields["codeGerechtigde"] == "ongeldig" {
            giveUITextFieldRedBorder(txtCodeGerechtigde)
        } else {
            giveUITextFieldDefaultBorder(txtCodeGerechtigde)
        }
        
        if statusTextFields["rijksregisterNr"] == "leeg" || statusTextFields["rijksregisterNr"] == "ongeldig" {
            giveUITextFieldRedBorder(txtRijksregisterNr)
        } else {
            giveUITextFieldDefaultBorder(txtRijksregisterNr)
        }
        
        if statusTextFields["aansluitingsNrTweedeOuder"] == "ongeldig" {
            giveUITextFieldRedBorder(txtAansluitingsNrTweedeOuder)
        }  else {
            giveUITextFieldDefaultBorder(txtAansluitingsNrTweedeOuder)
        }
    }
    
    func controleerRodeBordersAanwezig() -> Bool {
        
        if CGColorEqualToColor(txtAansluitingsNr.layer.borderColor, redColor.CGColor) {
            return true
        } else if CGColorEqualToColor(txtCodeGerechtigde.layer.borderColor, redColor.CGColor) {
            return true
        } else if CGColorEqualToColor(txtRijksregisterNr.layer.borderColor, redColor.CGColor) {
            return true
        } else if CGColorEqualToColor(txtAansluitingsNrTweedeOuder.layer.borderColor, redColor.CGColor) {
            return true
        } else {
            return false
        }
    }
    
    func checkPatternAansluitingsNr(aansluitingsNr: Int) -> Bool {
        var aansluitingsNrString: String = String(aansluitingsNr)
        
        if countElements(aansluitingsNrString) == 10 {
            return true
        }
        return false
    }
    
    func checkPatternCodeGerechtigde(codeGerechtigde: Int) -> Bool {
        var codeGerechtigdeString: String = String(codeGerechtigde)
        
        if countElements(codeGerechtigdeString) == 6 {
            return true
        }
        return false
    }
    
    func checkPatternRijksregisterNr(rijksregisterNr: String) -> Bool {
        var length : Int = countElements(rijksregisterNr)
        
        if length != 11 {
            return false
        }
        
        var eerste9CijfersString: String = rijksregisterNr.substringWithRange(Range<String.Index>(start: rijksregisterNr.startIndex, end: advance(rijksregisterNr.endIndex, -2)))
        
        var eerste9CijfersInt: Int = eerste9CijfersString.toInt()!
        var restNaDeling97: Int = eerste9CijfersInt % 97
        var controleGetal: Int = 97 - restNaDeling97
        
        var laatste2CijfersString: String = rijksregisterNr.substringWithRange(Range<String.Index>(start: advance(rijksregisterNr.startIndex, 10), end: rijksregisterNr.endIndex))
        
        
        var laatste2CijfersInt: Int = laatste2CijfersString.toInt()!
        
        if laatste2CijfersInt != controleGetal {
            return false
        } else {
            return true
        }
    }
    
    func settenVerplichteGegevens() {
        ouder.aansluitingsNr = txtAansluitingsNr.text.toInt()!
        ouder.codeGerechtigde = txtCodeGerechtigde.text.toInt()!
        ouder.rijksregisterNr = txtRijksregisterNr.text
    }
}

func checkPatternNummer(nummer: Int) -> Bool {
    if nummer <= 0 {
        return false
    }
    return true
}

func checkPatternPostcode(postcode: Int) -> Bool {
    if postcode < 1000 || postcode > 9992 {
        return false
    }
    return true
}

func checkPatternGsm(gsm: String) -> Bool {
    if countElements(gsm) == 10 {
        return true
    }
    return false
}

func checkPatternTelefoon(telefoon: String) -> Bool {
    if countElements(telefoon) == 9 {
        return true
    }
    return false
}

func foutBoxOproepen(title: String, message: String, controller: UIViewController) {
    var foutBox: FoutBox = FoutBox(title: title, message: message)
    var alert = foutBox.alert
    controller.presentViewController(alert, animated: true, completion: nil)
}

func foutBoxOproepen(foutBox: FoutBox, controller: UIViewController) {
    var alert = foutBox.alert
    controller.presentViewController(alert, animated: true, completion: nil)
}

func giveUITextFieldRedBorder(textField: UITextField) {
    var redColor: UIColor = UIColor.redColor()
    textField.layer.borderColor = redColor.CGColor
    textField.layer.borderWidth = 1.0
    textField.layer.cornerRadius = 5.0
}

func giveUITextFieldDefaultBorder(textField: UITextField) {
    var defaultBorderColor: UIColor = UIColor(red: 182.0, green: 182.0, blue: 182.0, alpha: 0)
    textField.layer.borderColor = defaultBorderColor.CGColor
    textField.layer.borderWidth = 1.0
    textField.layer.cornerRadius = 5.0
}