import Foundation
import UIKit
import QuartzCore

class InschrijvenVakantie2ViewController : UITableViewController {
    
    @IBOutlet weak var txtVoornaam: UITextField!
    @IBOutlet weak var txtNaam: UITextField!
    @IBOutlet weak var txtStraat: UITextField!
    @IBOutlet weak var txtNummer: UITextField!
    @IBOutlet weak var txtBus: UITextField!
    @IBOutlet weak var txtGemeente: UITextField!
    @IBOutlet weak var txtPostcode: UITextField!
    
    var vakantie: Vakantie!
    var deelnemer: Deelnemer = Deelnemer(id: "test")
    var foutBox: FoutBox? = nil
    var redColor: UIColor = UIColor.redColor()
    var statusTextFields: [String: String] = [:]
    var inschrijvingVakantie: InschrijvingVakantie! = InschrijvingVakantie(id: "test")
    
    //
    //Naam: annuleer
    //
    //Werking: - zorgt ervoor wanneer de gebruiker op annuleer drukt, er een melding komt of de gebruiker zeker is van zijn beslissing
    //
    //Parameters:
    //  - sender: AnyObject
    //
    //Return:
    //
    @IBAction func annuleer(sender: AnyObject) {
        annuleerControllerInschrijvenVakantieVorming(self)
    }
    
    //
    //Naam: viewDidLoad
    //
    //Werking: - zorgt ervoor dat de side bar menu verborgen is
    //         - bekijkt of de gebruiker internet heeft, zoniet geeft hij een gepaste melding
    //         - laadt de tables in
    //
    //Parameters:
    //
    //Return:
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNeedsStatusBarAppearanceUpdate()
        self.navigationController!.toolbarHidden = true
        controleerInternet()
        LocalDatastore.getTableReady(Constanten.TABLE_INSCHRIJVINGVAKANTIE)
        LocalDatastore.getTableReady(Constanten.TABLE_DEELNEMER)
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
            var alert = UIAlertController(title: "Oeps.. U heeft geen internet", message: "U heeft internet nodig voor u te registeren. Ga naar instellingen om dit aan te passen.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ga terug naar vakanties", style: UIAlertActionStyle.Default, handler: { action in
                switch action.style {
                default:
                    let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    var destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("Vakanties") as UIViewController
                    self.sideMenuController()?.setContentViewController(destViewController)
                    self.hideSideMenuView()
                }
            }))
            alert.addAction(UIAlertAction(title: "Ga naar instellingen", style: .Default, handler: { action in
                switch action.style{
                default:
                    UIApplication.sharedApplication().openURL(NSURL(string:UIApplicationOpenSettingsURLString)!);
                }
                
            }))
            presentViewController(alert, animated: true, completion: nil)
            txtVoornaam.resignFirstResponder()
            txtStraat.resignFirstResponder()
            txtPostcode.resignFirstResponder()
            txtNummer.resignFirstResponder()
            txtNaam.resignFirstResponder()
            txtGemeente.resignFirstResponder()
            txtBus.resignFirstResponder()
        }
    }
    
    //
    //Naam: prepareForSegue
    //
    //Werking: - maakt de volgende view met opgegeven identifier (stelt soms attributen van de volgende view op)
    //         - controleert ook eerste de ingevulde velden op geldigheid, zonee wordt er een foutmelding gegeven
    //         - controleert ook of de gebruiker al is ingeschreven (controle: ouder, deelnemer naam, deelnemer voornaam en vakantie)
    //
    //Parameters:
    //  - segue: UIStoryboardSegue
    //  - sender: AnyObject?
    //
    //Return:
    //
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "volgende" {
            let inschrijvenVakantie2ViewController = segue.destinationViewController as InschrijvenVakantie3ViewController
            
            /*ParseData.deleteDeelnemerTable()
            ParseData.vulDeelnemerTableOp()*/
            
            setStatusTextFields()
            pasLayoutVeldenAan()
            
            if controleerRodeBordersAanwezig() == true {
                foutBoxOproepen("Fout", "Gelieve de velden correct in te vullen!", self)
            } else {
                settenVerplichteGegevens()
                
                if statusTextFields["bus"] != "leeg" {
                    deelnemer.bus = txtBus.text
                }
                
                inschrijvingVakantie.vakantie = vakantie
                inschrijvingVakantie.deelnemer = deelnemer
                
                if controleerKindAlIngeschreven() == true {
                    let alertController = UIAlertController(title: "Fout", message: "Je hebt je al ingeschreven voor deze vakantie", preferredStyle: .Alert)
                    let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: {
                        action in
                        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                        let destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("Vakanties") as UIViewController
                        self.sideMenuController()?.setContentViewController(destViewController)
                        self.hideSideMenuView()
                    })
                    alertController.addAction(okAction)
                    self.presentViewController(alertController, animated: true, completion: nil)
                }
                
                
                inschrijvenVakantie2ViewController.inschrijvingVakantie = inschrijvingVakantie
            }
        } else if segue.identifier == "gaTerug" {
            let vakantiesTableViewController = segue.destinationViewController as VakantiesTableViewController
        }
        
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
        if txtVoornaam.text.isEmpty {
            statusTextFields["voornaam"] = "leeg"
        } else {
            statusTextFields["voornaam"] = "ingevuld"
        }
        
        if txtNaam.text.isEmpty {
            statusTextFields["naam"] = "leeg"
        } else {
            statusTextFields["naam"] = "ingevuld"
        }
        
        if txtStraat.text.isEmpty {
            statusTextFields["straat"] = "leeg"
        } else {
            statusTextFields["straat"] = "ingevuld"
        }
        
        if txtNummer.text.isEmpty {
            statusTextFields["nummer"] = "leeg"
        } else {
            if !controleerGeldigheidNummer(txtNummer.text) {
                statusTextFields["nummer"] = "ongeldig"
            } else if !checkPatternNummer(txtNummer.text.toInt()!) {
                statusTextFields["nummer"] = "ongeldig"
            } else {
                statusTextFields["nummer"] = "geldig"
            }
        }
        
        if txtBus.text.isEmpty {
            statusTextFields["bus"] = "leeg"
        } else {
            statusTextFields["bus"] = "ingevuld"
        }
        
        if txtGemeente.text.isEmpty {
            statusTextFields["gemeente"] = "leeg"
        } else {
            statusTextFields["gemeente"] = "ingevuld"
        }
        
        if txtPostcode.text.isEmpty {
            statusTextFields["postcode"] = "leeg"
        } else {
            if !controleerGeldigheidNummer(txtPostcode.text) {
                statusTextFields["postcode"] = "ongeldig"
            } else if !checkPatternPostcode(txtPostcode.text.toInt()!) {
                statusTextFields["postcode"] = "ongeldig"
            } else {
                statusTextFields["postcode"] = "geldig"
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
            giveUITextFieldRedBorder(txtVoornaam)
        } else {
            giveUITextFieldDefaultBorder(txtVoornaam)
        }
        
        if statusTextFields["naam"] == "leeg" {
            giveUITextFieldRedBorder(txtNaam)
        } else {
            giveUITextFieldDefaultBorder(txtNaam)
        }
        
        if statusTextFields["straat"] == "leeg" {
            giveUITextFieldRedBorder(txtStraat)
        } else {
            giveUITextFieldDefaultBorder(txtStraat)
        }
        
        if statusTextFields["nummer"] == "leeg" || statusTextFields["nummer"] == "ongeldig"{
            giveUITextFieldRedBorder(txtNummer)
        } else {
            giveUITextFieldDefaultBorder(txtNummer)
        }
        
        if statusTextFields["bus"] == "ongeldig" {
            giveUITextFieldRedBorder(txtBus)
        } else {
            giveUITextFieldDefaultBorder(txtBus)
        }
        
        if statusTextFields["postcode"] == "leeg" || statusTextFields["postcode"] == "ongeldig"{
            giveUITextFieldRedBorder(txtPostcode)
        } else {
            giveUITextFieldDefaultBorder(txtPostcode)
        }
        
        if statusTextFields["gemeente"] == "leeg" {
            giveUITextFieldRedBorder(txtGemeente)
        } else {
            giveUITextFieldDefaultBorder(txtGemeente)
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
        if CGColorEqualToColor(txtVoornaam.layer.borderColor, redColor.CGColor) {
            return true
        } else if CGColorEqualToColor(txtNaam.layer.borderColor, redColor.CGColor) {
            return true
        } else if CGColorEqualToColor(txtStraat.layer.borderColor, redColor.CGColor) {
            return true
        } else if CGColorEqualToColor(txtNummer.layer.borderColor, redColor.CGColor) {
            return true
        } else if CGColorEqualToColor(txtBus.layer.borderColor, redColor.CGColor) {
            return true
        } else if CGColorEqualToColor(txtPostcode.layer.borderColor, redColor.CGColor) {
            return true
        } else if CGColorEqualToColor(txtGemeente.layer.borderColor, redColor.CGColor) {
            return true
        } else {
            return false
        }
    }
    
    //
    //Naam: settenVerplichteGegevens
    //
    //Werking: - afhankelijk van de status van de verplichte velden, worden de gegevens van de deelnemer ingesteld
    //
    //Parameters:
    //
    //Return:
    //
    func settenVerplichteGegevens() {
        self.deelnemer.voornaam = txtVoornaam.text
        self.deelnemer.naam = txtNaam.text
        self.deelnemer.straat = txtStraat.text
        self.deelnemer.nummer = txtNummer.text.toInt()!
        self.deelnemer.postcode = txtPostcode.text.toInt()!
        self.deelnemer.gemeente = txtGemeente.text
        self.inschrijvingVakantie.vakantie = self.vakantie
        
        var ouder = LocalDatastore.getLocalObjectWithColumnConstraints(Constanten.TABLE_OUDER, soortConstraints: [Constanten.COLUMN_EMAIL: Constanten.CONSTRAINT_EQUALTO], equalToConstraints: [Constanten.COLUMN_EMAIL: PFUser.currentUser().email]) as Ouder
        
        self.inschrijvingVakantie.ouder = ouder
    }
    
    //
    //Naam: controleerKindAlIngeschreven
    //
    //Werking: - bekijkt in de databank of er al een inschrijving bestaat (controle: voornaam en naam deelnemer, ouder en vakantie)
    //
    //Parameters:
    //
    //Return: een bool true als de inschrijving al bestaat, anders false
    //
    func controleerKindAlIngeschreven() -> Bool {
        return LocalDatastore.bestaatInschrijvingVakantieAl(self.inschrijvingVakantie)
        /*var inschrijvingen: [InschrijvingVakantie] = []
        var inschrijvingenResponse = ParseData.getInschrijvingenVakantie(self.inschrijvingVakantie)
        
        if inschrijvingenResponse.1 != nil {
        return false
        }
        return true*/
    }
}