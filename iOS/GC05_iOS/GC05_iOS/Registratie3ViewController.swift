import UIKit

class Registratie3ViewController: UIViewController
{
    var aansluitingsNr: Int?
    var codeGerechtigde: Int?
    var rijksregisterNr: String?
    var aansluitingsNrTweedeouder: Int?
    
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
        if segue.identifier == "confirm" {
            let registratie4ViewController = segue.destinationViewController as Registratie4ViewController
            
            
            
        }
    }
    
    
    
}