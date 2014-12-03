import UIKit

class MonitorRegistratie1ViewController: UIViewController {
    
    @IBOutlet var txtLidNummer: UITextField!
    @IBOutlet var txtRijksregisterNr: UITextField!
    @IBOutlet var txtEmail: UITextField!
    
    @IBAction func gaTerugNaarInloggen(sender: AnyObject) {
        annuleerControllerRegistratie(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}