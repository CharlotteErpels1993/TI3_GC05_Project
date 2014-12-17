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
    
    //
    //Naam: viewDidLoad
    //
    //Werking: - zorgt ervoor dat de back bar button niet aanwezig is
    //         - bekijkt of de gebruiker internet heeft, zoniet geeft hij een gepaste melding
    //         - vult alle velden in
    //         - maakt een left bar button met de action terug (roept de methode terug() op)
    //
    //Parameters:
    //
    //Return:
    //
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

        var barBack = UIBarButtonItem(title: "Terug", style: UIBarButtonItemStyle.Plain, target: self, action: "terug")
        self.navigationItem.leftBarButtonItem = barBack
    }
    
    //
    //Naam: controleerInternet
    //
    //Werking: - bekijkt of de gebruiker internet heeft, zoniet geeft hij een gepaste melding
    //
    //Parameters:
    //
    //Return:
    //
    func controleerInternet() {
        if Reachability.isConnectedToNetwork() == false {
            var alert = UIAlertController(title: "Oeps.. U heeft geen internet", message: "U heeft internet nodig voor uw profiel te bewerken. Ga naar instellingen om dit aan te passen.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ga terug naar profielen", style: UIAlertActionStyle.Default, handler: { action in
                switch action.style {
                default:
                    self.gaVerder = true
                    self.performSegueWithIdentifier("opslaan", sender: self)
                }
            }))
            alert.addAction(UIAlertAction(title: "Ga naar instellingen", style: .Default, handler: { action in
                switch action.style{
                default:
                    UIApplication.sharedApplication().openURL(NSURL(string:UIApplicationOpenSettingsURLString)!);
                }
                
            }))
            presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    //
    //Naam: terug
    //
    //Werking: - zorgt ervoor wanneer de gebruiker op terug klik er eerst een melding wordt getoond dat er een melding wordt getoond
    //
    //Parameters:
    //
    //Return:
    //
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
    
    //
    //Naam: setStatusTextFields
    //
    //Werking: - zet de status van de text fields in
    //              * controleert of de velden leeg zijn
    //              * controleert of andere validatiemethoden geldig zijn
    //              * wanneer een text field ongeldig is krijgt deze de status "leeg" of "ongeldig"
    //
    //Parameters:
    //
    //Return:
    //
    func setStatusTextFields() {
        if voornaamTxt.text.isEmpty {
            statusTextFields["voornaam"] = "leeg"
        } else {
            statusTextFields["voornaam"] = "ingevuld"
        }
        
        if naamTxt.text.isEmpty {
            statusTextFields["naam"] = "leeg"
        } else {
            statusTextFields["naam"] = "ingevuld"
        }
        
        if straatTxt.text.isEmpty {
            statusTextFields["straat"] = "leeg"
        } else {
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
            statusTextFields["bus"] = "ingevuld"
        }
        
        if gemeenteTxt.text.isEmpty {
            statusTextFields["gemeente"] = "leeg"
        } else {
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
    
    //
    //Naam: pasLayoutVeldenAan
    //
    //Werking: - zorgt ervoor dat de text field, wanneer status "ongeldig" of "leeg" is, een rode border krijgt
    //         - als deze status niet "leeg" of "ongeldig" is wordt deze border terug op default gezet
    //
    //Parameters:
    //
    //Return:
    //
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
    
    //
    //Naam: controleerRodeBordersAanwezig
    //
    //Werking: - bekijkt of de text field borders een rode border hebben
    //
    //Parameters:
    //
    //Return: een bool true als er een rode border aanwezig is, anders false
    //
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
    
    //
    //Naam: settenVerplichteGegevens
    //
    //Werking: - afhankelijk van de status van de verplichte velden, worden de gegevens van de monitor ingesteld
    //
    //Parameters:
    //
    //Return:
    //
    func settenVerplichteGegevens() {
        monitor!.voornaam = voornaamTxt.text
        monitor!.naam = naamTxt.text
        monitor!.straat = straatTxt.text
        monitor!.nummer = nummerTxt.text.toInt()
        monitor!.gemeente = gemeenteTxt.text
        monitor!.postcode = postcodeTxt.text.toInt()
        monitor!.gsm = gsmTxt.text
    }
    
    //
    //Naam: settenOptioneleGegevens
    //
    //Werking: - afhankelijk van de status van de niet verplichte velden, worden de gegevens van de monitor ingesteld
    //
    //Parameters:
    //
    //Return:
    //
    func settenOptioneleGegevens() {
        if statusTextFields["bus"] != "leeg" {
            monitor!.bus = busTxt.text
        }
        
        if statusTextFields["telefoon"] != "leeg" {
            monitor!.telefoon = telefoonTxt.text
        }
    }
    
    //
    //Naam: prepareForSegue
    //
    //Werking: - maakt de volgende view met opgegeven identifier (stelt soms attributen van de volgende view op)
    //         - controleert ook eerste de ingevulde velden op geldigheid, zonee wordt er een foutmelding gegeven
    //
    //Parameters:
    //  - segue: UIStoryboardSegue
    //  - sender: AnyObject?
    //
    //Return:
    //
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "opslaan" {
            let profielDetailsViewController = segue.destinationViewController as ProfielDetailsTableViewController
            
            if self.gaVerder == true {
                profielDetailsViewController.monitor = self.monitor
                profielDetailsViewController.eigenProfiel = true
            } else {
                monitor = LocalDatastore.getLocalObjectWithColumnConstraints(Constanten.TABLE_MONITOR, soortConstraints: [Constanten.COLUMN_EMAIL: Constanten.CONSTRAINT_EQUALTO], equalToConstraints: [Constanten.COLUMN_EMAIL: PFUser.currentUser().email]) as Monitor
                
                setStatusTextFields()
                pasLayoutVeldenAan()
                
                if controleerRodeBordersAanwezig() == true {
                    foutBoxOproepen("Fout", "Gelieve de velden correct in te vullen!", self)
                } else {
                    settenVerplichteGegevens()
                    settenOptioneleGegevens()
                    //ParseData.updateMonitor(self.monitor!)
                    LocalDatastore.updateMonitor(self.monitor!)
                    profielDetailsViewController.monitor = self.monitor
                    profielDetailsViewController.eigenProfiel = true
                }
            }
        }
    }
}