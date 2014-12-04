import UIKit

class MonitorRegistratie2ViewController: UIViewController {
    
    @IBOutlet var txtHerhaalWachtwoord: UITextField!
    @IBOutlet var txtWachtwoord: UITextField!
    @IBOutlet var txtAansluitingsNr: UITextField!
    @IBOutlet var txtCodeGerechtigde: UITextField!
    
    var monitor: Monitor = Monitor(id: "test")
    
    @IBAction func gaTerugNaarInloggen(sender: AnyObject) {
        annuleerControllerRegistratie(self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}