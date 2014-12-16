import UIKit

class ProfielBewerkenViewController: UITableViewController {
    
    @IBOutlet weak var voornaamTxt: UITextField!
    @IBOutlet weak var naamTxt: UITextField!
    @IBOutlet weak var straatTxt: UITextField!
    @IBOutlet weak var nummerTxt: UITextField!
    @IBOutlet weak var busTxt: UITextField!
    @IBOutlet weak var postcodeTxt: UITextField!
    @IBOutlet weak var gemeenteTxt: UITextField!
    @IBOutlet weak var telefoonTxt: UITextField!
    @IBOutlet weak var gsmTxt: UITextField!
    
    var monitor: Monitor!
    var statusTextFields: [String: String] = [:]
    var redColor: UIColor = UIColor.redColor()
    var gaVerder:Bool = false
    
    /*@IBAction func opslaan(sender: AnyObject) {
        ParseData.deleteMonitorTable()
        ParseData.vulMonitorTableOp()
        
        var monitorResponse = ParseData.getMonitorWithEmail(PFUser.currentUser().email)
        if monitorResponse.1 == nil {
            monitor = monitorResponse.0
        }
        
        setStatusTextFields()
        pasLayoutVeldenAan()
        
        if controleerRodeBordersAanwezig() == true {
            foutBoxOproepen("Fout", "Gelieve de velden correct in te vullen!", self)
        } else {
            vulGegevensIn()
            ParseData.updateMonitor(self.monitor!)
            
            performSegueWithIdentifier("opslaan", sender: self)
            
            /*let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            var destViewController: ProfielDetailsTableViewController = mainStoryboard.instantiateViewControllerWithIdentifier("Profiel") as ProfielDetailsTableViewController
            destViewController.monitor = self.monitor
            destViewController.eigenProfiel = true
            sideMenuController()?.setContentViewController(destViewController)
            hideSideMenuView()*/
        }
    }*/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        
        if Reachability.isConnectedToNetwork() == false {
            var alert = UIAlertController(title: "Oeps.. U heeft geen internet", message: "U heeft internet nodig om uw profiel te bewerken. Ga naar instellingen om dit aan te passen.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Annuleer", style: UIAlertActionStyle.Default, handler: nil))
            alert.addAction(UIAlertAction(title: "Ga naar instellingen", style: .Default, handler: { action in
                switch action.style{
                default:
                    UIApplication.sharedApplication().openURL(NSURL(string:UIApplicationOpenSettingsURLString)!);
                }
                
            }))
            presentViewController(alert, animated: true, completion: nil)
        }
        
        voornaamTxt.text = monitor.voornaam
        naamTxt.text = monitor.naam
        straatTxt.text = monitor.straat
        nummerTxt.text = String(monitor.nummer!)
        busTxt.text = monitor!.bus
        gemeenteTxt.text = monitor.gemeente
        postcodeTxt.text = String(monitor.postcode!)
        telefoonTxt.text = monitor.telefoon
        gsmTxt.text = monitor.gsm

        //self.navigationItem.leftItemsSupplementBackButton = true
        var barBack = UIBarButtonItem(title: "Terug", style: UIBarButtonItemStyle.Plain, target: self, action: "terug")
        self.navigationItem.leftBarButtonItem = barBack
    }
    
    func terug() {
        let alertController = UIAlertController(title: "Profiel bewerken", message: "U gaat verder zonder het opslaan van uw gegevens. Als u verder gaat, gaan uw gewijzigde gegevens verloren.", preferredStyle: .ActionSheet)
            
        let callAction = UIAlertAction(title: "Sla niet op", style: UIAlertActionStyle.Destructive, handler: {
            action in
                self.gaVerder = true
                self.performSegueWithIdentifier("opslaan", sender: self)
            }
        )
        
        alertController.addAction(callAction)
            
        let cancelAction = UIAlertAction(title: "Annuleer", style: .Default, handler: nil)
        alertController.addAction(cancelAction)
            
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    
    func setStatusTextFields() {
        if voornaamTxt.text.isEmpty {
            statusTextFields["voornaam"] = "leeg"
        } else {
            //TO DO: checken op pattern?
            statusTextFields["voornaam"] = "ingevuld"
        }
        
        if naamTxt.text.isEmpty {
            statusTextFields["naam"] = "leeg"
        } else {
            //TO DO: checken op pattern?
            statusTextFields["naam"] = "ingevuld"
        }
        
        if straatTxt.text.isEmpty {
            statusTextFields["straat"] = "leeg"
        } else {
            //TO DO: checken op pattern?
            statusTextFields["straat"] = "ingevuld"
        }
        
        if nummerTxt.text.isEmpty {
            statusTextFields["nummer"] = "leeg"
        } else {
            if !controleerGeldigheidNummer(nummerTxt.text) {
                statusTextFields["nummer"] = "ongeldig"
                nummerTxt.text = ""
            } else if !checkPatternNummer(nummerTxt.text.toInt()!) {
                statusTextFields["nummer"] = "ongeldig"
                nummerTxt.text = ""
            } else {
                statusTextFields["nummer"] = "geldig"
            }
        }
        
        if busTxt.text.isEmpty {
            statusTextFields["bus"] = "leeg"
        } else {
            //TO DO: checken op pattern?
            statusTextFields["bus"] = "ingevuld"
        }
        
        if gemeenteTxt.text.isEmpty {
            statusTextFields["gemeente"] = "leeg"
        } else {
            //TO DO: checken op pattern?
            statusTextFields["gemeente"] = "ingevuld"
        }
        
        if postcodeTxt.text.isEmpty {
            statusTextFields["postcode"] = "leeg"
        } else {
            if !controleerGeldigheidNummer(postcodeTxt.text) {
                statusTextFields["postcode"] = "ongeldig"
                postcodeTxt.text = ""
            } else if !checkPatternPostcode(postcodeTxt.text.toInt()!) {
                statusTextFields["postcode"] = "ongeldig"
                postcodeTxt.text = ""
            } else {
                statusTextFields["postcode"] = "geldig"
            }
        }
        
        if telefoonTxt.text.isEmpty {
            statusTextFields["telefoon"] = "leeg"
        } else {
            if !checkPatternTelefoon(telefoonTxt.text) {
                statusTextFields["telefoon"] = "ongeldig"
                telefoonTxt.text = ""
            } else {
                statusTextFields["telefoon"] = "geldig"
            }
        }
        
        if gsmTxt.text.isEmpty {
            statusTextFields["gsm"] = "leeg"
        } else {
            if !checkPatternGsm(gsmTxt.text) {
                statusTextFields["gsm"] = "ongeldig"
                gsmTxt.text = ""
            } else {
                statusTextFields["gsm"] = "geldig"
            }
        }
    }
    
    func pasLayoutVeldenAan() {
        if statusTextFields["voornaam"] == "leeg" {
            giveUITextFieldRedBorder(voornaamTxt)
        } else {
            giveUITextFieldDefaultBorder(voornaamTxt)
        }
        
        if statusTextFields["naam"] == "leeg" {
            giveUITextFieldRedBorder(naamTxt)
        } else {
            giveUITextFieldDefaultBorder(naamTxt)
        }
        
        if statusTextFields["straat"] == "leeg" {
            giveUITextFieldRedBorder(straatTxt)
        } else {
            giveUITextFieldDefaultBorder(straatTxt)
        }
        
        if statusTextFields["nummer"] == "leeg" || statusTextFields["nummer"] == "ongeldig"{
            giveUITextFieldRedBorder(nummerTxt)
        } else {
            giveUITextFieldDefaultBorder(nummerTxt)
        }
        
        if statusTextFields["bus"] == "ongeldig"{
            giveUITextFieldRedBorder(busTxt)
        } else {
            giveUITextFieldDefaultBorder(busTxt)
        }
        
        if statusTextFields["gemeente"] == "leeg" {
            giveUITextFieldRedBorder(gemeenteTxt)
        } else {
            giveUITextFieldDefaultBorder(gemeenteTxt)
        }
        
        if statusTextFields["postcode"] == "leeg" || statusTextFields["postcode"] == "ongeldig"{
            giveUITextFieldRedBorder(postcodeTxt)
        } else {
            giveUITextFieldDefaultBorder(postcodeTxt)
        }
        
        if statusTextFields["telefoon"] == "ongeldig"{
            giveUITextFieldRedBorder(telefoonTxt)
        } else {
            giveUITextFieldDefaultBorder(telefoonTxt)
        }
        
        if statusTextFields["gsm"] == "leeg" || statusTextFields["gsm"] == "ongeldig" || statusTextFields["gsm"] == "al geregistreerd" {
            giveUITextFieldRedBorder(gsmTxt)
        } else {
            giveUITextFieldDefaultBorder(gsmTxt)
        }
    }
    
    func controleerRodeBordersAanwezig() -> Bool {
        if CGColorEqualToColor(voornaamTxt.layer.borderColor, redColor.CGColor) {
            return true
        } else if CGColorEqualToColor(naamTxt.layer.borderColor, redColor.CGColor) {
            return true
        } else if CGColorEqualToColor(straatTxt.layer.borderColor, redColor.CGColor) {
            return true
        } else if CGColorEqualToColor(nummerTxt.layer.borderColor, redColor.CGColor) {
            return true
        } else if CGColorEqualToColor(busTxt.layer.borderColor, redColor.CGColor) {
            return true
        } else if CGColorEqualToColor(gemeenteTxt.layer.borderColor, redColor.CGColor) {
            return true
        } else if CGColorEqualToColor(postcodeTxt.layer.borderColor, redColor.CGColor) {
            return true
        } else if CGColorEqualToColor(telefoonTxt.layer.borderColor, redColor.CGColor) {
            return true
        } else if CGColorEqualToColor(gsmTxt.layer.borderColor, redColor.CGColor) {
            return true
        } else {
            return false
        }
    }
    
    func settenVerplichteGegevens() {
        monitor!.voornaam = voornaamTxt.text
        monitor!.naam = naamTxt.text
        monitor!.straat = straatTxt.text
        monitor!.nummer = nummerTxt.text.toInt()
        monitor!.gemeente = gemeenteTxt.text
        monitor!.postcode = postcodeTxt.text.toInt()
        monitor!.gsm = gsmTxt.text
    }
    
    func settenOptioneleGegevens() {
        if statusTextFields["bus"] != "leeg" {
            monitor!.bus = busTxt.text
        }
        
        if statusTextFields["telefoon"] != "leeg" {
            monitor!.telefoon = telefoonTxt.text
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "opslaan" {
            let profielDetailsViewController = segue.destinationViewController as ProfielDetailsTableViewController
            
            if self.gaVerder == true {
                profielDetailsViewController.monitor = self.monitor
                profielDetailsViewController.eigenProfiel = true
            } else {
                //ParseData.deleteMonitorTable()
                //ParseData.vulMonitorTableOp()
                
                /*var monitorResponse = ParseData.getMonitorWithEmail(PFUser.currentUser().email)
                if monitorResponse.1 == nil {
                    monitor = monitorResponse.0
                }*/
                monitor = LocalDatastore.getMonitorWithEmail(PFUser.currentUser().email)
                
                setStatusTextFields()
                pasLayoutVeldenAan()
                
                if controleerRodeBordersAanwezig() == true {
                    foutBoxOproepen("Fout", "Gelieve de velden correct in te vullen!", self)
                } else {
                    settenVerplichteGegevens()
                    settenOptioneleGegevens()
                    ParseData.updateMonitor(self.monitor!)
                    profielDetailsViewController.monitor = self.monitor
                    profielDetailsViewController.eigenProfiel = true
                }
            }
        }
    }
}