import UIKit
import QuartzCore

class Registratie1ViewController: UITableViewController {
    @IBOutlet weak var isLid: UISwitch!
    @IBOutlet weak var txtAansluitingsNr: UITextField!
    @IBOutlet weak var txtCodeGerechtigde: UITextField!
    @IBOutlet weak var txtRijksregisterNr: UITextField!
    @IBOutlet weak var txtAansluitingsNrTweedeOuder: UITextField!
    @IBOutlet weak var buttonNummers: UIButton!
    
    var ouder: Ouder! = Ouder(id: "test")
    var gebruikerIsLid: Bool? = true
    var redColor: UIColor = UIColor.redColor()
    var statusTextFields: [String: String] = [:]
    var rijksregisterNrAlGeregistreerd: Bool = false
    
    //
    //Naam: toggle
    //
    //Werking: - zorgt ervoor dat de side bar menu wordt weergegeven
    //         - zorgt er ook voor dat alle toestenborden gesloten zijn
    //
    //Parameters:
    //  - sender: AnyObject
    //
    //Return:
    //
    @IBAction func toggle(sender: AnyObject) {
        txtAansluitingsNr.resignFirstResponder()
        txtCodeGerechtigde.resignFirstResponder()
        txtRijksregisterNr.resignFirstResponder()
        txtAansluitingsNrTweedeOuder.resignFirstResponder()
        toggleSideMenuView()
    }
    
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
    //Werking: - zorgt ervoor dat de side bar menu verborgen is
    //         - zorgt ervoor dat de back bar button niet aanwezig is
    //         - bekijkt of de gebruiker internet heeft, zoniet geeft hij een gepaste melding (methode controleerInternet)
    //
    //Parameters:
    //
    //Return:
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        hideSideMenuView()
        self.navigationItem.setHidesBackButton(true, animated: true)
        controleerInternet()
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
            txtAansluitingsNr.resignFirstResponder()
            txtAansluitingsNrTweedeOuder.resignFirstResponder()
            txtCodeGerechtigde.resignFirstResponder()
            txtRijksregisterNr.resignFirstResponder()
        }
    }
    
    //
    //Naam: switched
    //
    //Werking: - bekijkt of de switch aan staat:
    //              * zoja, velden worden getoond en buttons worden getoond
    //              * zonee, wordt de gehele section verwijderd en buttons worden verborgen
    //
    //Parameters:
    //  - sender: UISwitch
    //
    //Return:
    //
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
    
    //
    //Naam: numbersOfSectionsInTableView
    //
    //Werking: - zorgt dat het aantal sections zich aanpast naargelang er een section wordt verwijderd
    //
    //Parameters:
    //  - tableView: UITableView
    //
    //Return: een int met de hoeveelheid sections
    //
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if gebruikerIsLid == false {
            return 2
        } else {
            return 3
        }
    }
    
    //
    //Naam: tableView
    //
    //Werking: - zorgt dat het aantal rijen in een section aangepast wordt naargelang er een section wordt verwijderd
    //
    //Parameters:
    //  - tableView: UITableView
    //  - numbersOfRowsInSection section: Int
    //
    //Return: een int met de hoeveelheid rijen per section
    //
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
            let registratie2ViewController = segue.destinationViewController as Registratie2ViewController
            setStatusTextFields()
            pasLayoutVeldenAan()
            
            if controleerRodeBordersAanwezig() == true {
                if rijksregisterNrAlGeregistreerd == true {
                    foutBoxOproepen("Fout", "Dit rijksregisternummer (\(self.txtRijksregisterNr.text!)) is al geregistreerd!", self)
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
                txtAansluitingsNrTweedeOuder.text = ""
            } else if !checkPatternAansluitingsNr(txtAansluitingsNrTweedeOuder.text.toInt()!) {
                statusTextFields["aansluitingsNrTweedeOuder"] = "ongeldig"
                txtAansluitingsNrTweedeOuder.text = ""
            } else {
                statusTextFields["aansluitingsNrTweedeOuder"] = "geldig"
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
        if gebruikerIsLid == true {
            ouder.aansluitingsNr = txtAansluitingsNr.text.toInt()!
            ouder.codeGerechtigde = txtCodeGerechtigde.text.toInt()!
            
            if statusTextFields["aansluitingsNrTweedeOuder"] != "leeg" {
                ouder.aansluitingsNrTweedeOuder = txtAansluitingsNrTweedeOuder.text.toInt()!
            }
        }
    }
    
    //
    //Naam: controleerRijksregisterNummerAlGeregistreerd
    //
    //Werking: - bekijkt in de databank of er al een ouder zich ingeschreven heeft met dat rijksregisternummer
    //
    //Parameters:
    //
    //Return: een bool true als het rijksregisternummer al geregistreerd is, anders false
    //
    func controleerRijksregisterNummerAlGeregisteerd() -> Bool {
        
        var query = Query(tableName: Constanten.TABLE_OUDER)
        query.addWhereEqualTo(Constanten.COLUMN_RIJKSREGISTERNUMMER, value: txtRijksregisterNr.text)
        
        if query.isEmpty() {
            return false
        } else {
            return true
        }
        
        /*var arguments : [String : AnyObject] = [:]
        arguments[Constanten.COLUMN_RIJKSREGISTERNUMMER] = self.txtRijksregisterNr.text
        
        var query = LocalDatastore.query(Constanten.TABLE_OUDER, whereArgs: arguments)
        
        if LocalDatastore.isResultSetEmpty(query) {
            return false
        } else {
            return true
        }*/
        
        //return LocalDatastore.isRijksregisternummerAlGeregistreerd(self.txtRijksregisterNr.text)
    }
}