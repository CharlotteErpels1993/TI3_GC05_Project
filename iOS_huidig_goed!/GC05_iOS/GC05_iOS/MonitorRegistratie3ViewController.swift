import UIKit

class MonitorRegistratie3ViewController: UIViewController {
    
    @IBOutlet var txtVoornaam: UITextField!
    @IBOutlet var txtNaam: UITextField!
    @IBOutlet var txtStraat: UITextField!
    @IBOutlet var txtHuisnummer: UITextField!
    @IBOutlet var txtBus: UITextField!
    @IBOutlet var txtGemeente: UITextField!
    @IBOutlet var txtPostcode: UITextField!
    @IBOutlet var txtTelefoon: UITextField!
    @IBOutlet var txtGsm: UITextField!
    
    
    @IBAction func gaTerugNaarInloggen(sender: AnyObject) {
        annuleerControllerRegistratie(self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}