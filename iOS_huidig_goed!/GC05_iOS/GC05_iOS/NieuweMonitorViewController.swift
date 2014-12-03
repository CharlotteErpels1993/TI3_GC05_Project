import UIKit

class NieuweMonitorViewController: UIViewController {
    
    @IBOutlet var txtLidnummer: UITextField!
    @IBOutlet var txtRijksregisterNr: UITextField!
    @IBOutlet var txtEmail: UITextField!
    
    @IBAction func toggle(sender: AnyObject) {
        toggleSideMenuView()
    }
    
    @IBAction func gaTerugNaarNieuweMonitor(segue: UIStoryboardSegue) {}
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "nieuweMonitor" {
            let nieuweMonitorSuccesvolViewController = segue.destinationViewController as NieuweMonitorSuccesvolViewController
        }
    }
}