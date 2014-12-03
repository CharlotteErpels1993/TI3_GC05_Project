import Foundation
import UIKit
import QuartzCore

class InschrijvenVakantie1ViewController : ResponsiveTextFieldViewController {
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ParseData.deleteInschrijvingVakantieTable()
        ParseData.vulInschrijvingVakantieTableOp()
    }

    @IBAction func annuleer(sender: AnyObject) {
        annuleerControllerInschrijvenVakantieVorming(self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "volgende" {
        let inschrijvenVakantie2ViewController = segue.destinationViewController as InschrijvenVakantie2ViewController
        
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
    
    func setStatusTextFields() {
        if txtVoornaam.text.isEmpty {
            statusTextFields["voornaam"] = "leeg"
        } else {
            //TO DO: checken op pattern?
            statusTextFields["voornaam"] = "ingevuld"
        }
        
        if txtNaam.text.isEmpty {
            statusTextFields["naam"] = "leeg"
        } else {
            //TO DO: checken op pattern?
            statusTextFields["naam"] = "ingevuld"
        }
        
        if txtStraat.text.isEmpty {
            statusTextFields["straat"] = "leeg"
        } else {
            //TO DO: checken op pattern?
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
            //TO DO: checken op pattern?
            statusTextFields["bus"] = "ingevuld"
        }
        
        if txtGemeente.text.isEmpty {
            statusTextFields["gemeente"] = "leeg"
        } else {
            //TO DO: checken op pattern?
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
    
    func settenVerplichteGegevens() {
        self.deelnemer.voornaam = txtVoornaam.text
        self.deelnemer.naam = txtNaam.text
        self.deelnemer.straat = txtStraat.text
        self.deelnemer.nummer = txtNummer.text.toInt()!
        self.deelnemer.postcode = txtPostcode.text.toInt()!
        self.deelnemer.gemeente = txtGemeente.text
        //self.deelnemer.inschrijvingVakantie = InschrijvingVakantie(id: "test")
        self.inschrijvingVakantie.vakantie = self.vakantie
        //self.inschrijvingVakantie.ouder = ParseData.getOuderWithEmail(PFUser.currentUser().email)
    
        var ouderResponse = ParseData.getOuderWithEmail(PFUser.currentUser().email)
        
        if ouderResponse.1 == nil {
            //er is een ouder
            self.inschrijvingVakantie.ouder = ouderResponse.0
        } else {
            println("ERROR: er is geen ouder teruggevonden in de database (Class: InschrijvenVakantie1ViewController)")
        }
    
    
    }
    
    func controleerKindAlIngeschreven() -> Bool {
        var inschrijvingen: [InschrijvingVakantie] = []
        
        //inschrijvingen = ParseData.getInschrijvingenVakantie(self.inschrijvingVakantie)
        
        var inschrijvingenResponse = ParseData.getInschrijvingenVakantie(self.inschrijvingVakantie)
        
        if inschrijvingenRespone.1 != nil {
            //er zijn geen inschrijvingen gevonden
           return false
        }
        return true
        
        /*if inschrijvingen.count > 0 {
            return true
        }*/
        
        return false
    }
}