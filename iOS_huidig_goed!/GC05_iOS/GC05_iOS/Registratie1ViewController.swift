import UIKit

class Registratie1ViewController: UIViewController
{
    var ouder: Ouder! = Ouder(id: "test")
    var gebruikerIsLid: Bool? = true
    var foutBox: FoutBox? = nil
    
    
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
    var textVelden: [String: String] = [:]
    
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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let registratie3ViewController = segue.destinationViewController as Registratie3ViewController
        
        //controleren lege velden als switch op on staat
        if gebruikerIsLid == true {
            
            controleerEmptyTextfield(txtAansluitingsNr)
            controleerEmptyTextfield(txtCodeGerechtigde)
            controleerEmptyTextfield(txtRijksregisterNr)
            
            if tellerAantalLegeVelden > 0 {
                textVeldenLeegMaken()
                foutBoxOproepen("Fout", "Gelieve alle verplichte velden in te vullen!", self)
            } else {
                controleerVerplichteGegevens()
                settenVerplichteGegevens()
                
                //aansluitingsNrTweedeOuder is ingevuld
                if !txtAansluitingsNrTweedeOuder.text.isEmpty {
                    controleerAansluitingsNrTweedeOuder(txtAansluitingsNrTweedeOuder.text.toInt()!)
                    ouder.aansluitingsNrTweedeOuder = txtAansluitingsNrTweedeOuder.text.toInt()!
                }
            }
            
        }
        
        if foutBox != nil {
            textVeldenLeegMaken()
            foutBoxOproepen(foutBox!, self)
        } else {
            registratie3ViewController.ouder = ouder
        }
    }
    
    
    //extra functies
    func controleerEmptyTextfield(textField: UITextField) {
        if textField.text.isEmpty {
            tellerAantalLegeVelden += 1
        }
    }
    
    func textVeldenLeegMaken() {
        txtAansluitingsNr.text = ""
        txtCodeGerechtigde.text = ""
        txtRijksregisterNr.text = ""
        txtAansluitingsNrTweedeOuder.text = ""
    }
    
    func controleerVerplichteGegevens() {
        controleerAansluitingsNr(txtAansluitingsNr.text.toInt()!)
        controleerCodeGerechtigde(txtCodeGerechtigde.text.toInt()!)
        controleerRijksregisterNr(txtRijksregisterNr.text)
    }

    func controleerAansluitingsNr(aansluitingsNr: Int) {
        if !checkPatternAansluitingsNr(aansluitingsNr) {
            if foutBox != nil {
                foutBox?.alert.message?.extend("\n Aansluitingsnummer is niet geldig.")
            } else {
                foutBox = FoutBox(title: "Ongeldige waarde(s)", message: "Aansluitingsnummer is niet geldig.")
            }
        }
    }
    
    func controleerCodeGerechtigde(codeGerechtigde: Int) {
        if !checkPatternCodeGerechtigde(codeGerechtigde) {
            if foutBox != nil {
                foutBox?.alert.message?.extend("\n Code gerechtigde is niet geldig.")
            } else {
                foutBox = FoutBox(title: "Ongeldige waarde(s)", message: "Code gerechtigde is niet geldig.")
            }
        }
    }
    
    func controleerRijksregisterNr(rijksregisterNr: String) {
        if !checkPatternRijksregisterNr(rijksregisterNr) {
            if foutBox != nil {
                foutBox?.alert.message?.extend("\n Rijksregisternummer is niet geldig.")
            } else {
                foutBox = FoutBox(title: "Ongeldige waarde(s)", message: "Rijksregisternummer is niet geldig.")
            }
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
    
    func controleerAansluitingsNrTweedeOuder(aansluitingsNrTweedeOuder: Int) {
        if !checkPatternAansluitingsNr(aansluitingsNrTweedeOuder) {
            if foutBox != nil {
                foutBox?.alert.message?.extend("\n Aansluitingsnummer van de tweede ouder is niet geldig.")
            } else {
                foutBox = FoutBox(title: "Ongeldige waarde(s)", message: "Aansluitingsnummer van de tweede ouder is niet geldig.")
            }
        }
    }
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