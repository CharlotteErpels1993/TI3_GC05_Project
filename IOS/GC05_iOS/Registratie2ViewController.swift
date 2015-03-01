import UIKit
import QuartzCore

class Registratie2ViewController: UITableViewController {
    @IBOutlet weak var txtVoornaam: UITextField!
    @IBOutlet weak var txtNaam: UITextField!
    @IBOutlet weak var txtStraat: UITextField!
    @IBOutlet weak var txtNummer: UITextField!
    @IBOutlet weak var txtBus: UITextField!
    @IBOutlet weak var txtGemeente: UITextField!
    @IBOutlet weak var txtPostcode: UITextField!
    @IBOutlet weak var txtTelefoon: UITextField!
    @IBOutlet weak var txtGsm: UITextField!
    
    var ouder: Ouder!
    var foutBox: FoutBox? = nil
    var statusTextFields: [String: String] = [:]
    var redColor: UIColor = UIColor.redColor()
    var gsmAlGeregistreerd: Bool = false
    
    //
    //Naam: gaTerugNaarInloggen
    //
    //Werking: - zorgt voor een unwind segue
    //         - geeft ook een melding bij het verlaten van het scherm (of de gebruiker dit effectief wilt)
    //
    //Parameters:
    //  - sender: AnyObject
    //
    //Return:
    //
    @IBAction func gaTerugNaarInloggen(sender: AnyObject) {
        annuleerControllerRegistratie(self)
    }
    
    //
    //Naam: viewDidLoad
    //
    //Werking:
    //
    //Parameters:
    //
    //Return:
    //
    override func viewDidLoad() {
        super.viewDidLoad()
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
        if segue.identifier == "volgende" {
            let registratie3ViewController = segue.destinationViewController as Registratie3ViewController
        
            setStatusTextFields()
            pasLayoutVeldenAan()
            
            if controleerRodeBordersAanwezig() == true {
                if gsmAlGeregistreerd == true {
                    foutBoxOproepen("Fout", "Dit GSM-nummer (\(self.txtGsm.text!)) is al geregistreerd bij ons!", self)
                    self.txtGsm.text = ""
                } else {
                    foutBoxOproepen("Fout", "Gelieve de velden correct in te vullen!", self)
                }
                self.viewDidLoad()
            } else {
                settenVerplichteGegevens()
                settenOptioneleGegevens()
                registratie3ViewController.ouder = ouder
            }
        } else if segue.identifier == "gaTerug" {
            let vakantiesViewController = segue.destinationViewController as VakantiesTableViewController
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
                txtNummer.text = ""
            } else if !checkPatternNummer(txtNummer.text.toInt()!) {
                statusTextFields["nummer"] = "ongeldig"
                txtNummer.text = ""
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
                txtPostcode.text = ""
            } else if !checkPatternPostcode(txtPostcode.text.toInt()!) {
                statusTextFields["postcode"] = "ongeldig"
                txtPostcode.text = ""
            } else {
                statusTextFields["postcode"] = "geldig"
            }
        }
        
        if txtTelefoon.text.isEmpty {
            statusTextFields["telefoon"] = "leeg"
        } else {
            if !checkPatternTelefoon(txtTelefoon.text) {
                statusTextFields["telefoon"] = "ongeldig"
                txtTelefoon.text = ""
            } else {
                statusTextFields["telefoon"] = "geldig"
            }
        }
        
        if txtGsm.text.isEmpty {
            statusTextFields["gsm"] = "leeg"
            gsmAlGeregistreerd = false
        } else {
            if !checkPatternGsm(txtGsm.text) {
                statusTextFields["gsm"] = "ongeldig"
                gsmAlGeregistreerd = false
            } else if controleerGSMAlGeregisteerd() == true {
                statusTextFields["gsm"] = "al geregistreerd"
                gsmAlGeregistreerd = true
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
        
        if statusTextFields["bus"] == "ongeldig"{
            giveUITextFieldRedBorder(txtBus)
        } else {
            giveUITextFieldDefaultBorder(txtBus)
        }
        
        if statusTextFields["gemeente"] == "leeg" {
            giveUITextFieldRedBorder(txtGemeente)
        } else {
            giveUITextFieldDefaultBorder(txtGemeente)
        }
        
        if statusTextFields["postcode"] == "leeg" || statusTextFields["postcode"] == "ongeldig"{
            giveUITextFieldRedBorder(txtPostcode)
        } else {
            giveUITextFieldDefaultBorder(txtPostcode)
        }
        
        if statusTextFields["telefoon"] == "ongeldig"{
            giveUITextFieldRedBorder(txtTelefoon)
        } else {
            giveUITextFieldDefaultBorder(txtTelefoon)
        }
        
        if statusTextFields["gsm"] == "leeg" || statusTextFields["gsm"] == "ongeldig" || statusTextFields["gsm"] == "al geregistreerd" {
            giveUITextFieldRedBorder(txtGsm)
        } else {
            giveUITextFieldDefaultBorder(txtGsm)
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
        } else if CGColorEqualToColor(txtGemeente.layer.borderColor, redColor.CGColor) {
            return true
        } else if CGColorEqualToColor(txtPostcode.layer.borderColor, redColor.CGColor) {
            return true
        } else if CGColorEqualToColor(txtTelefoon.layer.borderColor, redColor.CGColor) {
            return true
        } else if CGColorEqualToColor(txtGsm.layer.borderColor, redColor.CGColor) {
            return true
        } else {
            return false
        }
    }
    
    //
    //Naam: settenVerplichteGegevens
    //
    //Werking: - afhankelijk van de status van de verplichte velden, worden de gegevens van de ouder ingesteld
    //
    //Parameters:
    //
    //Return:
    //
    func settenVerplichteGegevens() {
        ouder.voornaam = txtVoornaam.text
        ouder.naam = txtNaam.text
        ouder.straat = txtStraat.text
        ouder.nummer = txtNummer.text.toInt()
        ouder.gemeente = txtGemeente.text
        ouder.postcode = txtPostcode.text.toInt()
        ouder.gsm = txtGsm.text
    }
    
    //
    //Naam: settenOptioneleGegevens
    //
    //Werking: - afhankelijk van de status van de niet verplichte velden, worden de gegevens van de ouder ingesteld
    //
    //Parameters:
    //
    //Return:
    //
    func settenOptioneleGegevens() {
        if statusTextFields["bus"] != "leeg" {
            ouder.bus = txtBus.text
        }
        
        if statusTextFields["telefoon"] != "leeg" {
            ouder.telefoon = txtTelefoon.text
        }
    }
    
    //
    //Naam: controleerGSMAlGeregistreerd
    //
    //Werking: - bekijkt in de databank of er al een ouder zich ingeschreven heeft met die gsm-nummer
    //
    //Parameters:
    //
    //Return: een bool true als het gsm-nummer al geregistreerd is, anders false
    //
    func controleerGSMAlGeregisteerd() -> Bool {
        
        /*var arguments : [String : AnyObject] = [:]
        arguments[Constanten.COLUMN_GSM] = self.txtGsm.text
        
        var query = LocalDatastore.query(Constanten.TABLE_OUDER, whereArgs: arguments)

        if LocalDatastore.isResultSetEmpty(query) {
            return false
        } else {
            return true
        }*/
        
        var query = Query(tableName: Constanten.TABLE_OUDER)
        query.addWhereEqualTo(Constanten.COLUMN_GSM, value: txtGsm.text)
        
        if query.isEmpty() {
            return false
        } else {
            return true
        }
        
        
        //return LocalDatastore.isGsmAlGeregistreerd(self.txtGsm.text)
    }
}