import UIKit

class Registratie3ViewController: UIViewController
{
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
    var tellerAantalLegeVelden: Int = 0
    var foutBox: FoutBox? = nil
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if segue.identifier == "volgende" {
            let registratie4ViewController = segue.destinationViewController as Registratie4ViewController
            
            controlerenVerplichteVeldenIngevuld()
            
            if tellerAantalLegeVelden > 0 && tellerAantalLegeVelden < 8{
                textVeldenLeegMaken()
                foutBoxOproepen("Fout", "Gelieve alle verplichte velden in te vullen!", self)
            } else {
                controlerenPatternsVerplichteVelden()
            }

            if !txtBus.text.isEmpty {
                ouder.bus = txtBus.text
            }
            
            if !txtTelefoon.text.isEmpty {
                controleerTelefoon(txtTelefoon.text)
            }
            
            
            if foutBox != nil {
                textVeldenLeegMaken()
                foutBoxOproepen(foutBox!, self)
            } else {
                settenVerplichteGegevens()
                registratie4ViewController.ouder = ouder
            }
        }
    }
    
    func controlerenVerplichteVeldenIngevuld() {
        isTextVeldEmpty(txtVoornaam)
        isTextVeldEmpty(txtNaam)
        isTextVeldEmpty(txtStraat)
        isTextVeldEmpty(txtNummer)
        isTextVeldEmpty(txtGemeente)
        isTextVeldEmpty(txtPostcode)
        isTextVeldEmpty(txtGsm)
    }
    
    func isTextVeldEmpty(textVeld: UITextField) {
        if textVeld.text.isEmpty {
            tellerAantalLegeVelden += 1
        }
    }
    
    func textVeldenLeegMaken() {
        txtVoornaam.text = ""
        txtNaam.text = ""
        txtStraat.text = ""
        txtNummer.text = ""
        txtBus.text = ""
        txtGemeente.text = ""
        txtPostcode.text = ""
        txtTelefoon.text = ""
        txtGsm.text = ""
    }
    
    func controlerenPatternsVerplichteVelden() {
        controleerNummer(txtNummer.text.toInt()!)
        controleerPostcode(txtPostcode.text.toInt()!)
        controleerGsm(txtGsm.text)
    }
    
    func controleerNummer(nummer: Int) {
        if !checkPatternNummer(nummer) {
            if foutBox != nil {
                foutBox?.alert.message?.extend("\n Nummer is niet geldig.")
            } else {
                foutBox = FoutBox(title: "Ongeldige waarde(s)", message: "Nummer is niet geldig.")
            }
        }
    }
    
    func controleerPostcode(postcode: Int) {
        if !checkPatternPostcode(postcode) {
            if foutBox != nil {
                foutBox?.alert.message?.extend("\n Postcode is niet geldig.")
            } else {
                foutBox = FoutBox(title: "Ongeldige waarde(s)", message: "Postcode is niet geldig.")
            }
        }
    }
    
    func controleerGsm(gsm: String) {
        if !checkPatternGsm(gsm) {
            if foutBox != nil {
                foutBox?.alert.message?.extend("\n Gsm is niet geldig.")
            } else {
                foutBox = FoutBox(title: "Ongeldige waarde(s)", message: "Gsm is niet geldig.")
            }
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
    
    func settenVerplichteGegevens() {
        ouder.voornaam = txtVoornaam.text
        ouder.naam = txtNaam.text
        ouder.straat = txtStraat.text
        ouder.nummer = txtNummer.text.toInt()
        ouder.bus = txtBus.text
        ouder.gemeente = txtGemeente.text
        ouder.postcode = txtPostcode.text.toInt()
        ouder.telefoon = txtTelefoon.text
        ouder.gsm = txtGsm.text
    }
    
    func controleerTelefoon(telefoon: String) {
        if !checkPatternTelefoon(telefoon) {
            if foutBox != nil {
                foutBox?.alert.message?.extend("\n Telefoon is niet geldig.")
            } else {
                foutBox = FoutBox(title: "Ongeldige waarde(s)", message: "Telefoon is niet geldig.")
            }
        }
    }
    
    func checkPatternTelefoon(telefoon: String) -> Bool {
        if countElements(telefoon) == 9 {
            return true
        }
        return false
    }
    
}