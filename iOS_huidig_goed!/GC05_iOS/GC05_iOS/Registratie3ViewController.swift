import UIKit

class Registratie3ViewController: UIViewController
{
    /*var aansluitingsNr: Int?
    var codeGerechtigde: Int?
    var rijksregisterNr: String?
    var aansluitingsNrTweedeOuder: Int?*/
    
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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if segue.identifier == "volgende" {
            let registratie4ViewController = segue.destinationViewController as Registratie4ViewController
            
            //nog controleren of velden leeg zijn
            
            ouder.voornaam = txtVoornaam.text
            ouder.naam = txtNaam.text
            ouder.straat = txtStraat.text
            //ouder.nummer = txtNummer.text.toInt()
            ouder.bus = txtBus.text
            ouder.gemeente = txtGemeente.text
            // ouder.postcode = txtPostcode.text.toInt()
            ouder.telefoon = txtTelefoon.text
            ouder.gsm = txtGsm.text
            
            registratie4ViewController.ouder = self.ouder
            
            
            
            /*registratie4ViewController.aansluitingsNr = aansluitingsNr
            registratie4ViewController.codeGerechtigde = codeGerechtigde
            registratie4ViewController.rijksregisterNr = rijksregisterNr
            registratie4ViewController.aansluitingsNrTweedeOuder = aansluitingsNrTweedeOuder
            registratie4ViewController.voornaam = txtVoornaam.text
            registratie4ViewController.naam = txtNaam.text
            registratie4ViewController.straat = txtStraat.text
            registratie4ViewController.nummer = txtNummer.text.toInt()
            registratie4ViewController.bus = txtBus.text
            registratie4ViewController.gemeente = txtGemeente.text
            registratie4ViewController.postcode = txtPostcode.text.toInt()
            registratie4ViewController.telefoon = txtTelefoon.text
            registratie4ViewController.gsm = txtGsm.text*/
            
        }
    }
    
    
    
}