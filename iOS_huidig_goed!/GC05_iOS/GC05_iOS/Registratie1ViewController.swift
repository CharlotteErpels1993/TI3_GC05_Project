import UIKit
import QuartzCore

class Registratie1ViewController: /*ResponsiveTextFieldViewController*/ UITableViewController, UITextFieldDelegate {
    var ouder: Ouder! = Ouder(id: "test")
    var gebruikerIsLid: Bool? = true
    var foutBox: FoutBox? = nil
    var redColor: UIColor = UIColor.redColor()
    var statusTextFields: [String: String] = [:]
    var rijksregisterNrAlGeregistreerd: Bool = false
    
    @IBOutlet weak var isLid: UISwitch!
    @IBOutlet weak var txtAansluitingsNr: UITextField!
    @IBOutlet weak var txtCodeGerechtigde: UITextField!
    @IBOutlet weak var txtRijksregisterNr: UITextField!
    @IBOutlet weak var txtAansluitingsNrTweedeOuder: UITextField!
    @IBOutlet weak var buttonNummers: UIButton!
    
    @IBAction func toggle(sender: AnyObject) {
        txtAansluitingsNr.resignFirstResponder()
        txtCodeGerechtigde.resignFirstResponder()
        txtRijksregisterNr.resignFirstResponder()
        txtAansluitingsNrTweedeOuder.resignFirstResponder()
        toggleSideMenuView()
    }
    @IBAction func gaTerugNaarInloggen(sender: AnyObject) {
        annuleerControllerRegistratie(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideSideMenuView()
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        if Reachability.isConnectedToNetwork() == false {
            var alert = UIAlertController(title: "Oeps.. U heeft geen internet", message: "U heeft internet nodig voor u te registeren. Ga naar instellingen om dit aan te passen.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Annuleer", style: UIAlertActionStyle.Default, handler: nil))
            alert.addAction(UIAlertAction(title: "Ga naar instellingen", style: .Default, handler: { action in
                switch action.style{
                default:
                    UIApplication.sharedApplication().openURL(NSURL(string:UIApplicationOpenSettingsURLString)!);
                }
                
            }))
            presentViewController(alert, animated: true, completion: nil)
            txtAansluitingsNr.resignFirstResponder()
            txtAansluitingsNrTweedeOuder.resignFirstResponder()
            txtCodeGerechtigde.resignFirstResponder()
            txtRijksregisterNr.resignFirstResponder()
        }
        
        //ParseData.deleteOuderTable()
        //ParseData.vulOuderTableOp()
        //ParseData.deleteMonitorTable()
        //ParseData.vulMonitorTableOp()
        
        txtAansluitingsNr.delegate = self
        txtCodeGerechtigde.delegate = self
        txtRijksregisterNr.delegate = self
        txtAansluitingsNrTweedeOuder.delegate = self
    }
    
    @IBAction func switched(sender: UISwitch) {
        if sender.on {
            gebruikerIsLid = true
            buttonNummers.hidden = false
            viewDidLoad()
            self.tableView.reloadData()
        } else {
            gebruikerIsLid = false
            self.tableView.deleteSections(NSIndexSet(index: 1), withRowAnimation: UITableViewRowAnimation.None)
            buttonNummers.hidden = true
        }
        
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if gebruikerIsLid == false {
            return 2
        } else {
            return 3
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if gebruikerIsLid == false {
            if section == 0 {
                return 2
            } else if section == 1 {
                return 1
            }
        } else {
            if section == 0 {
                return 2
            } else if section == 1 {
                return 3
            } else if section == 2 {
                return 1
            }
        }
        return 0
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "volgende" {
            let registratie2ViewController = segue.destinationViewController as Registratie2ViewController
            setStatusTextFields()
            pasLayoutVeldenAan()
            
            if controleerRodeBordersAanwezig() == true {
                if rijksregisterNrAlGeregistreerd == true {
                    foutBoxOproepen("Fout", "Dit rijksregisternummer (\(self.txtRijksregisterNr.text)) is al geregistreerd!", self)
                    self.txtRijksregisterNr.text = ""
                } else {
                    foutBoxOproepen("Fout", "Gelieve de velden correct in te vullen!", self)
                }
                self.viewDidLoad()
            } else {
                ouder.rijksregisterNr = txtRijksregisterNr.text
                settenOptioneleGegevens()
                registratie2ViewController.ouder = ouder
            }
        } 
    }
    
    func setStatusTextFields() {
        if txtAansluitingsNr.text.isEmpty {
            statusTextFields["aansluitingsNr"] = "leeg"
        } else {
            if !controleerGeldigheidNummer(txtAansluitingsNr.text) {
                statusTextFields["aansluitingsNr"] = "ongeldig"
                txtAansluitingsNr.text = ""
            } else if !checkPatternAansluitingsNr(txtAansluitingsNr.text.toInt()!) {
                statusTextFields["aansluitingsNr"] = "ongeldig"
                txtAansluitingsNr.text = ""
            } else {
                statusTextFields["aansluitingsNr"] = "geldig"
            }
        }
        
        if txtCodeGerechtigde.text.isEmpty {
            statusTextFields["codeGerechtigde"] = "leeg"
        } else {
            if !controleerGeldigheidNummer(txtCodeGerechtigde.text) {
                statusTextFields["codeGerechtigde"] = "ongeldig"
                txtCodeGerechtigde.text = ""
            } else if !checkPatternCodeGerechtigde(txtCodeGerechtigde.text.toInt()!) {
                statusTextFields["codeGerechtigde"] = "ongeldig"
                txtCodeGerechtigde.text = ""
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
                //txtRijksregisterNr.text = ""
            } else {
                if controleerRijksregisterNummerAlGeregisteerd() == true {
                    statusTextFields["rijksregisterNr"] = "al geregistreerd"
                    self.rijksregisterNrAlGeregistreerd = true
                    //txtRijksregisterNr.text = ""
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
                txtAansluitingsNrTweedeOuder.text = ""
            } else if !checkPatternAansluitingsNr(txtAansluitingsNrTweedeOuder.text.toInt()!) {
                statusTextFields["aansluitingsNrTweedeOuder"] = "ongeldig"
                txtAansluitingsNrTweedeOuder.text = ""
            } else {
                statusTextFields["aansluitingsNrTweedeOuder"] = "geldig"
            }
        }
    }
    
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
    
    func settenOptioneleGegevens() {
        
        if gebruikerIsLid == true {
            ouder.aansluitingsNr = txtAansluitingsNr.text.toInt()!
            ouder.codeGerechtigde = txtCodeGerechtigde.text.toInt()!
            
            if statusTextFields["aansluitingsNrTweedeOuder"] != "leeg" {
                ouder.aansluitingsNrTweedeOuder = txtAansluitingsNrTweedeOuder.text.toInt()!
            }
        }
        
    }
    
    func controleerRijksregisterNummerAlGeregisteerd() -> Bool {
        //return ParseData.getRijksregisterNummers(self.txtRijksregisterNr.text)
        return LocalDatastore.isRijksregisternummerAlGeregistreerd(self.txtRijksregisterNr.text)
    }
    
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

