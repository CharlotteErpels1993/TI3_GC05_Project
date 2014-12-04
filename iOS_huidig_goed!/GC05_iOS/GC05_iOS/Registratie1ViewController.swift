import UIKit
import QuartzCore

class Registratie1ViewController: ResponsiveTextFieldViewController
{
    var ouder: Ouder! = Ouder(id: "test")
    var gebruikerIsLid: Bool? = true
    var foutBox: FoutBox? = nil
    var redColor: UIColor = UIColor.redColor()
    var statusTextFields: [String: String] = [:]
    var rijksregisterNrAlGeregistreerd: Bool = false
    
    
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
    @IBOutlet weak var buttonRegisterenMonitor: UIButton!
    @IBOutlet weak var labelVerplichtInTevullen: UILabel!
    
    @IBAction func toggle(sender: AnyObject) {
        toggleSideMenuView()
    }
    @IBAction func gaTerugNaarInloggen(sender: AnyObject) {
        annuleerControllerRegistratie(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideSideMenuView()
        self.txtRijksregisterNr.text = ""
        self.txtCodeGerechtigde.text = ""
        self.txtAansluitingsNr.text = ""
        self.txtAansluitingsNrTweedeOuder.text = ""
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        ParseData.deleteOuderTable()
        ParseData.vulOuderTableOp()
        ParseData.deleteMonitorTable()
        ParseData.vulMonitorTableOp()
        
    }
    
    
    @IBAction func gaTerugNaarRegistreren(segue: UIStoryboard) {
    }
    
    @IBAction func switched(sender: UISwitch) {
        if sender.on {
            gebruikerIsLid = true
            
            lblAansluitingsNr.hidden = false
            lblCodeGerechtigde.hidden = false
            lblAansluitingsNrTweedeOuder.hidden = false
            
            txtAansluitingsNr.hidden = false
            txtCodeGerechtigde.hidden = false
            txtAansluitingsNrTweedeOuder.hidden = false
            buttonNummers.hidden = false
            buttonRegisterenMonitor.hidden = false
            labelVerplichtInTevullen.hidden = false
            
        } else {
            gebruikerIsLid = false
            
            lblAansluitingsNr.hidden = true
            lblCodeGerechtigde.hidden = true
            lblAansluitingsNrTweedeOuder.hidden = true
            
            txtAansluitingsNr.hidden = true
            txtCodeGerechtigde.hidden = true
            txtAansluitingsNrTweedeOuder.hidden = true
            buttonNummers.hidden = true
            buttonRegisterenMonitor.hidden = true
            labelVerplichtInTevullen.hidden = true
        }
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "volgende" {
        let registratie2ViewController = segue.destinationViewController as Registratie2ViewController
            
            //nieuw: Charlotte
            setStatusTextFields()
            pasLayoutVeldenAan()
            
            if controleerRodeBordersAanwezig() == true {
                
                if rijksregisterNrAlGeregistreerd == true {
                    foutBoxOproepen("Fout", "Dit rijksregisternummer (\(self.txtRijksregisterNr.text)) is al geregistreerd!", self)
                } else {
                    foutBoxOproepen("Fout", "Gelieve de velden correct in te vullen!", self)
                }
                self.viewDidLoad()
            } else {
                ouder.rijksregisterNr = txtRijksregisterNr.text
                settenOptioneleGegevens()
                registratie2ViewController.ouder = ouder
            }
            
            
            /*if gebruikerIsLid == true {
                setStatusTextFields()
                pasLayoutVeldenAan()
            
                if controleerRodeBordersAanwezig() == true {
                    foutBoxOproepen("Fout", "Gelieve de velden correct in te vullen!", self)
                    self.viewDidLoad()
                } else {
                    settenVerplichteGegevens()
                
                    if statusTextFields["aansluitingsNrTweedeouder"] != "leeg" {
                        ouder.aansluitingsNrTweedeOuder = txtAansluitingsNrTweedeOuder.text.toInt()!
                    }
                }
            } else {
                setStatusTextFieldsRijksregisterNummer()
                pasLayoutVeldenAanRijksregisterNummer()
                
                if controleerRodeBordersAanwezig() == true {
                    foutBoxOproepen("Fout", "Gelieve het veld correct in te vullen", self)
                    self.viewDidLoad()
                } else {
                    self.ouder.rijksregisterNr = self.txtRijksregisterNr.text
                }
            }
            
            if controleerRijksregisterNummerAlGeregisteerd() == true {
                giveUITextFieldRedBorder(self.txtRijksregisterNr)
                let alertController = UIAlertController(title: "Fout", message: "Deze rijksregisternummer bestaat al", preferredStyle: .Alert)
                let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: {
                    action in
                    self.viewDidLoad()
                })
                alertController.addAction(okAction)
                self.presentViewController(alertController, animated: true, completion: nil)
            } else {
                registratie2ViewController.ouder = ouder
            }*/
        } else if segue.identifier == "gaTerug" {
                let vakantiesViewController = segue.destinationViewController as VakantiesTableViewController
            }
        
    }
    
    /*func setStatusTextFieldsRijksregisterNummer() {
        if txtRijksregisterNr.text.isEmpty {
            statusTextFields["rijksregisterNr"] = "leeg"
        } else {
            /*if !checkPatternRijksregisterNr(txtRijksregisterNr.text) {
                statusTextFields["rijksregisterNr"] = "ongeldig"
            } else  {
                statusTextFields["rijksregisterNr"] = "geldig"
            }*/
            statusTextFields["rijksregisterNr"] = "geldig"
        }
    }*/
    
    func setStatusTextFields() {
        if txtAansluitingsNr.text.isEmpty {
            statusTextFields["aansluitingsNr"] = "leeg"
        } else {
            if !controleerGeldigheidNummer(txtAansluitingsNr.text) {
                statusTextFields["aansluitingsNr"] = "ongeldig"
            } else if !checkPatternAansluitingsNr(txtAansluitingsNr.text.toInt()!) {
                statusTextFields["aansluitingsNr"] = "ongeldig"
            } else {
                statusTextFields["aansluitingsNr"] = "geldig"
            }
        }
        
        if txtCodeGerechtigde.text.isEmpty {
            statusTextFields["codeGerechtigde"] = "leeg"
        } else {
            if !controleerGeldigheidNummer(txtCodeGerechtigde.text) {
                statusTextFields["codeGerechtigde"] = "ongeldig"
            } else if !checkPatternCodeGerechtigde(txtCodeGerechtigde.text.toInt()!) {
                statusTextFields["codeGerechtigde"] = "ongeldig"
            } else {
                statusTextFields["codeGerechtigde"] = "geldig"
            }
        }
        
        if txtRijksregisterNr.text.isEmpty {
            statusTextFields["rijksregisterNr"] = "leeg"
            self.rijksregisterNrAlGeregistreerd = false
        } else {
            if !checkPatternRijksregisterNr(txtRijksregisterNr.text) {
                statusTextFields["rijksregisterNr"] = "ongeldig"
                self.rijksregisterNrAlGeregistreerd = false
            } else {
                if controleerRijksregisterNummerAlGeregisteerd() == true {
                    statusTextFields["rijksregisterNr"] = "al geregistreerd"
                    self.rijksregisterNrAlGeregistreerd = true
                } else {
                    statusTextFields["rijksregisterNr"] = "geldig"
                    self.rijksregisterNrAlGeregistreerd = false
                }
            }
        }
        
        if txtAansluitingsNrTweedeOuder.text.isEmpty {
            statusTextFields["aansluitingsNrTweedeOuder"] = "leeg"
        } else {
            if !controleerGeldigheidNummer(txtAansluitingsNrTweedeOuder.text) {
                statusTextFields["aansluitingsNrTweedeOuder"] = "ongeldig"
            } else if !checkPatternAansluitingsNr(txtAansluitingsNrTweedeOuder.text.toInt()!) {
                statusTextFields["aansluitingsNrTweedeOuder"] = "ongeldig"
            } else {
                statusTextFields["aansluitingsNrTweedeOuder"] = "geldig"
            }
        }
    }
    
    /*func pasLayoutVeldenAanRijksregisterNummer() {
        if statusTextFields["rijksregisterNr"] == "leeg" || statusTextFields["rijksregisterNr"] == "ongeldig" {
            giveUITextFieldRedBorder(txtRijksregisterNr)
        } else {
            giveUITextFieldDefaultBorder(txtRijksregisterNr)
        }
    }*/
    
    func pasLayoutVeldenAan() {
        
        if statusTextFields["rijksregisterNr"] == "leeg" || statusTextFields["rijksregisterNr"] == "ongeldig" || statusTextFields["rijksregisterNr"] == "al geregistreerd" {
            giveUITextFieldRedBorder(txtRijksregisterNr)
        } else {
            giveUITextFieldDefaultBorder(txtRijksregisterNr)
        }
        
        if gebruikerIsLid == true {
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
            
            if statusTextFields["aansluitingsNrTweedeOuder"] == "ongeldig" {
                giveUITextFieldRedBorder(txtAansluitingsNrTweedeOuder)
            }  else {
                giveUITextFieldDefaultBorder(txtAansluitingsNrTweedeOuder)
            }
        } else {
            giveUITextFieldDefaultBorder(txtAansluitingsNr)
            giveUITextFieldDefaultBorder(txtCodeGerechtigde)
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
    
    func settenOptioneleGegevens() {
        
        if gebruikerIsLid == true {
            ouder.aansluitingsNr = txtAansluitingsNr.text.toInt()!
            ouder.codeGerechtigde = txtCodeGerechtigde.text.toInt()!
            
            if statusTextFields["aansluitingsNrTweedeouder"] != "leeg" {
                ouder.aansluitingsNrTweedeOuder = txtAansluitingsNrTweedeOuder.text.toInt()!
            }
        }
        
    }
    
    func controleerRijksregisterNummerAlGeregisteerd() -> Bool {
        return ParseData.getRijksregisterNummers(self.txtRijksregisterNr.text)
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

func checkPatternRijksregisterNr(rijksregisterNr: String) -> Bool {
    var lengte: Int = countElements(rijksregisterNr)
    
    if lengte != 11 {
        return false
    }
    
    var rest: Int = 0
    var teControlerenGetal: Int = 0
    var teControlerenCijfers: String = ""
    var laatste2Str: String = rijksregisterNr.substringWithRange(Range<String.Index>(start: advance(rijksregisterNr.startIndex, 9), end: rijksregisterNr.endIndex))
    var eerste2Str: String = rijksregisterNr.substringWithRange(Range<String.Index>(start: rijksregisterNr.startIndex, end: advance(rijksregisterNr.endIndex, -9)))
    var laatste2Int: Int = laatste2Str.toInt()!
    var eerste2Int: Int = eerste2Str.toInt()!
    var rijksregisterNrArray = Array(rijksregisterNr)
    
    
    if eerste2Int < 14 {
        teControlerenCijfers = "2"
    }
    
    for (var i = 0; i <= (lengte-3); i++) {
        teControlerenCijfers.append(rijksregisterNrArray[i])
        //teControlerenCijfers.insert(rijksregisterNrArray[i], atIndex: rijksregisterNr.endIndex)
        /*let y = advance(rijksregisterNr.startIndex, i)
        teControlerenCijfers.insert(rijksregisterNr[y], atIndex: rijksregisterNr.endIndex)*/
    }
    
    teControlerenGetal = teControlerenCijfers.toInt()!
    rest = teControlerenGetal % 97
    
    var controlGetal: Int = rest + laatste2Int
    
    if controlGetal < 97 {
        return false
    }
    
    return true
    
    
    /*var rest: Int = 0
    var teControlerenGetal: Int = 0
    var teControlerenCijfers: String = ""
    var controleGetal: String
    controleGetal = rijksregisterNr.substringWithRange(Range<String.Index>(start: advance(rijksregisterNr.startIndex, 9), end: rijksregisterNr.endIndex))*/
    
    /*var length : Int = countElements(rijksregisterNr)
    
    if length != 11 {
    return false
    }
    
    var eerste9CijfersString: String = rijksregisterNr.substringWithRange(Range<String.Index>(start: rijksregisterNr.startIndex, end: advance(rijksregisterNr.endIndex, -2)))
    
    var eerste9CijfersInt: Int = eerste9CijfersString.toInt()!
    var restNaDeling97: Int = eerste9CijfersInt % 97
    var controleGetal: Int = 97 - restNaDeling97
    
    var laatste2CijfersString: String = rijksregisterNr.substringWithRange(Range<String.Index>(start: advance(rijksregisterNr.startIndex, 9), end: rijksregisterNr.endIndex))
    
    
    var laatste2CijfersInt: Int = laatste2CijfersString.toInt()!
    
    if laatste2CijfersInt != controleGetal {
    return false
    } else {
    return true
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

func giveUITextFieldDefaultBorder(textField: UITextField) {
    var defaultBorderColor: UIColor = UIColor(red: 182.0, green: 182.0, blue: 182.0, alpha: 0)
    textField.layer.borderColor = defaultBorderColor.CGColor
    textField.layer.borderWidth = 1.0
    textField.layer.cornerRadius = 5.0
}

func controleerGeldigheidNummer(nummer: String) -> Bool {
    var enkelNummers: Bool = false
    
    for character in nummer {
        if character == "0" {
            enkelNummers = true
        } else if character == "1" {
            enkelNummers = true
        } else if character == "2" {
            enkelNummers = true
        } else if character == "3" {
            enkelNummers = true
        } else if character == "4" {
            enkelNummers = true
        } else if character == "5" {
            enkelNummers = true
        } else if character == "6" {
            enkelNummers = true
        } else if character == "7" {
            enkelNummers = true
        } else if character == "8" {
            enkelNummers = true
        } else if character == "9" {
            enkelNummers = true
        } else {
            return false
        }
    }
    
    return true
}

