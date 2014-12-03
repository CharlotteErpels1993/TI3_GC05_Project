import UIKit

class MonitorRegistratie2ViewController: UIViewController {
    
    @IBOutlet var txtHerhaalWachtwoord: UITextField!
    @IBOutlet var txtWachtwoord: UITextField!
    @IBOutlet var txtAansluitingsNr: UITextField!
    @IBOutlet var txtCodeGerechtigde: UITextField!
    
    @IBAction func gaTerugNaarInloggen(sender: AnyObject) {
        annuleerControllerRegistratie(self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}