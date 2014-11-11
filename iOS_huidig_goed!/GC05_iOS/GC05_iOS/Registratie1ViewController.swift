import UIKit
import QuartzCore

class Registratie1ViewController: UIViewController
{
    var ouder: Ouder! = Ouder(id: "test")
    var gebruikerIsLid: Bool? = true
    var foutBox: FoutBox? = nil
    var redColor: UIColor = UIColor.redColor()
    
    @IBOutlet weak var isLid: UISwitch!
    
    @IBOutlet weak var lblAansluitingsNr: UILabel!
    @IBOutlet weak var txtAansluitingsNr: UITextField!
    @IBOutlet weak var lblCodeGerechtigde: UILabel!
    @IBOutlet weak var txtCodeGerechtigde: UITextField!
    @IBOutlet weak var lblRijksregisterNr: UILabel!
    @IBOutlet weak var txtRijksregisterNr: UITextField!
    @IBOutlet weak var lblAansluitingsNrTweedeOuder: UILabel!
    @IBOutlet weak var txtAansluitingsNrTweedeOuder: UITextField!
    
    var tellerAantalLegeVelden : Int = 0
    var statusTextFields: [String: String] = [:]
    var defaultBorderColor: CGColor?
    
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
            giveUITextFieldDefaultBorder(txtAansluitingsNr,defaultBorderColor!)
        }
        
        if statusTextFields["codeGerechtigde"] == "leeg" || statusTextFields["codeGerechtigde"] == "ongeldig" {
            giveUITextFieldRedBorder(txtCodeGerechtigde)
        } else {
            giveUITextFieldDefaultBorder(txtCodeGerechtigde, defaultBorderColor!)
        }
        
        if statusTextFields["rijksregisterNr"] == "leeg" || statusTextFields["rijksregisterNr"] == "ongeldig" {
            giveUITextFieldRedBorder(txtRijksregisterNr)
        } else {
            giveUITextFieldDefaultBorder(txtRijksregisterNr, defaultBorderColor!)
        }
        
        if statusTextFields["aansluitingsNrTweedeOuder"] == "ongeldig" {
            giveUITextFieldRedBorder(txtAansluitingsNrTweedeOuder)
        }  else {
            giveUITextFieldDefaultBorder(txtAansluitingsNrTweedeOuder, defaultBorderColor!)
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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let registratie3ViewController = segue.destinationViewController as Registratie3ViewController
        
        //controleren op formaat van ingevulde text! (String, int, ...)
        
        defaultBorderColor = txtAansluitingsNr.layer.borderColor

        
        if gebruikerIsLid == true {
            setStatusTextFields()
            pasLayoutVeldenAan()
        
            if controleerRodeBordersAanwezig() == true {
                foutBoxOproepen("Fout", "Gelieve de velden correct in te vullen!", self)
            } else {
                settenVerplichteGegevens()
                
                if !txtAansluitingsNrTweedeOuder.text.isEmpty {
                    ouder.aansluitingsNrTweedeOuder = txtAansluitingsNrTweedeOuder.text.toInt()!
                }
            }
        }
        registratie3ViewController.ouder = ouder
        
        
        /*if controleerRodeBordersAanwezig() == true {
            foutBoxOproepen("Fout", "Gelieve de velden correct in te vullen!", self)
        } else {
            if gebruikerIsLid == true {
                settenVerplichteGegevens()
                
                if !txtAansluitingsNrTweedeOuder.text.isEmpty {
                    ouder.aansluitingsNrTweedeOuder = txtAansluitingsNrTweedeOuder.text.toInt()!
                }
            }
            registratie3ViewController.ouder = ouder
        }*/
        
        /*if gebruikerIsLid == true {
            controleerLeegTextField(txtAansluitingsNr, id: "aansluitingsNr")
            controleerLeegTextField(txtCodeGerechtigde, id: "codeGerechtigde")
            controleerLeegTextField(txtRijksregisterNr, id: "rijksregisterNr")
            
            if controleerAlleVerplichteVeldenLeeg() == true {
                self.foutBox = FoutBox(title: "Fout", message: "Gelieve alle verplichte velden in te vullen (aansluitingsnummer, code gerechtigde en rijksregisternummer).")
            } else if controleer1ofMeerVerplichteVeldenLeeg() == true {
                var message: String = geefMessageFoutBox1ofMeerVerplichteVeldenLeeg()
                self.foutBox = FoutBox(title: "Fout", message: message)
            } else {
                controleerVerplichteGegevens()
                
                if !txtAansluitingsNrTweedeOuder.text.isEmpty {
                    controleerAansluitingsNrTweedeOuder(txtAansluitingsNrTweedeOuder.text.toInt()!)
                }
            }
        }
        
        if foutBox != nil {
            textVeldenLeegMaken()
            foutBoxOproepen(foutBox!, self)
        } else {
            if gebruikerIsLid == true {
                settenVerplichteGegevens()
                
                if !txtAansluitingsNrTweedeOuder.text.isEmpty {
                    ouder.aansluitingsNrTweedeOuder = txtAansluitingsNrTweedeOuder.text.toInt()!
                }
            }
            registratie3ViewController.ouder = ouder
        }*/
    }
    
    
    //extra functies
    /*func controleerAlleVerplichteVeldenLeeg() -> Bool {
        if statusTextFields["aansluitingsNr"] == "leeg" && statusTextFields["codeGerechtigde"] == "leeg"
            && statusTextFields["rijksregisterNr"] == "leeg" {
                return true
        } else {
            return false
        }
    }*/

    /*func controleer1ofMeerVerplichteVeldenLeeg() -> Bool {
        var teller: Int = 0
        
        if statusTextFields["aansluitingsNr"] == "leeg" {
            teller += 1
        }
        if statusTextFields["codeGerechtigde"] == "leeg" {
            teller += 1
        }
        if statusTextFields["rijksregisterNr"] == "leeg" {
            teller += 1
        }
        
        if teller >= 1 {
            return true
        } else {
            return false
        }
    }*/

    /*func geefMessageFoutBox1ofMeerVerplichteVeldenLeeg() -> String {
        var message: String = ""
        
        
        if statusTextFields["aansluitingsNr"] == "leeg" {
            message.extend("Gelieve aansluitingsnummer in te vullen.\n")
        }
        if statusTextFields["codeGerechtigde"] == "leeg" {
            message.extend("Gelieve code gerechtigde in te vullen.\n")
        }
        if statusTextFields["rijksregisterNr"] == "leeg" {
            message.extend("Gelieve rijksregisternummer in te vullen.\n")
        }
        return message
    }*/
    
    /*func controleerLeegTextField(textField: UITextField, id: String) {
        if textField.text.isEmpty {
            tellerAantalLegeVelden += 1
            statusTextFields[id] = "leeg"
        }
    }*/
    
    /*func textVeldenLeegMaken() {
        if statusTextFields["aansluitingsNr"] == "ongeldig" {
            //txtAansluitingsNr.text = ""
            
            giveUITextFieldRedBorder(txtAansluitingsNr)
        }
        if statusTextFields["codeGerechtigde"] == "ongeldig" {
            //txtCodeGerechtigde.text = ""
            
            giveUITextFieldRedBorder(txtCodeGerechtigde)
        }
        if statusTextFields["rijksregisterNr"] == "ongeldig" {
            //txtRijksregisterNr.text = ""
            
            giveUITextFieldRedBorder(txtRijksregisterNr)
        }
        if statusTextFields["aansluitingsNrTweedeOuder"] == "ongeldig" {
            //txtAansluitingsNrTweedeOuder.text = ""
            
            giveUITextFieldRedBorder(txtAansluitingsNrTweedeOuder)
        }
    }*/
    
    /*func controleerVerplichteGegevens() {
        controleerAansluitingsNr(txtAansluitingsNr.text.toInt()!)
        controleerCodeGerechtigde(txtCodeGerechtigde.text.toInt()!)
        controleerRijksregisterNr(txtRijksregisterNr.text)
    }*/

    /*func controleerAansluitingsNr(aansluitingsNr: Int) {
        if !checkPatternAansluitingsNr(aansluitingsNr) {
            if foutBox != nil {
                foutBox?.alert.message?.extend("\n Aansluitingsnummer is niet geldig.")
            } else {
                foutBox = FoutBox(title: "Ongeldige waarde(s)", message: "Aansluitingsnummer is niet geldig.")
            }
            statusTextFields["aansluitingsNr"] = "ongeldig"
        }
    }*/
    
    /*func controleerCodeGerechtigde(codeGerechtigde: Int) {
        if !checkPatternCodeGerechtigde(codeGerechtigde) {
            if foutBox != nil {
                foutBox?.alert.message?.extend("\n Code gerechtigde is niet geldig.")
            } else {
                foutBox = FoutBox(title: "Ongeldige waarde(s)", message: "Code gerechtigde is niet geldig.")
            }
            statusTextFields["codeGerechtigde"] = "ongeldig"
        }
    }*/
    
    /*func controleerRijksregisterNr(rijksregisterNr: String) {
        if !checkPatternRijksregisterNr(rijksregisterNr) {
            if foutBox != nil {
                foutBox?.alert.message?.extend("\n Rijksregisternummer is niet geldig.")
            } else {
                foutBox = FoutBox(title: "Ongeldige waarde(s)", message: "Rijksregisternummer is niet geldig.")
            }
            statusTextFields["rijksregisterNr"] = "ongeldig"
        }
    }*/
    
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
    
    /*func controleerAansluitingsNrTweedeOuder(aansluitingsNrTweedeOuder: Int) {
        if !checkPatternAansluitingsNr(aansluitingsNrTweedeOuder) {
            if foutBox != nil {
                foutBox?.alert.message?.extend("\n Aansluitingsnummer van de tweede ouder is niet geldig.")
            } else {
                foutBox = FoutBox(title: "Ongeldige waarde(s)", message: "Aansluitingsnummer van de tweede ouder is niet geldig.")
            }
            statusTextFields["aansluitingsNrTweedeOuder"] = "ongeldig"
        }
    }*/
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

func giveUITextFieldDefaultBorder(textField: UITextField, defaultColor: CGColor) {
    var defaultBorderColor: UIColor = UIColor(red: 182.0, green: 182.0, blue: 182.0, alpha: 0)
    textField.layer.borderColor = defaultBorderColor.CGColor
    textField.layer.borderWidth = 1.0
    textField.layer.cornerRadius = 5.0
}












