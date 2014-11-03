import UIKit

class Registratie3ViewController: UIViewController
{
    var aansluitingsNr: Int?
    var codeGerechtigde: Int?
    var rijksregisterNr: String?
    var aansluitingsNrTweedeOuder: Int?
    
    @IBOutlet weak var txtVoornaam: UITextField!
    @IBOutlet weak var txtNaam: UITextField!
    @IBOutlet weak var txtStraat: UITextField!
    @IBOutlet weak var txtNummer: UITextField!
    @IBOutlet weak var txtBus: UITextField!
    @IBOutlet weak var txtGemeente: UITextField!
    @IBOutlet weak var txtPostcode: UITextField!
    @IBOutlet weak var txtTelefoon: UITextField!
    @IBOutlet weak var txtGsm: UITextField!
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if segue.identifier == "volgende" {
            let registratie4ViewController = segue.destinationViewController as Registratie4ViewController
            
            registratie4ViewController.aansluitingsNr = aansluitingsNr
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
            registratie4ViewController.gsm = txtGsm.text
            
        }
    }
    
    
    
}