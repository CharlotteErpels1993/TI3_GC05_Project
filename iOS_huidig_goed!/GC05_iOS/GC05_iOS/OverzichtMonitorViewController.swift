import UIKit

class OverzichtMonitorViewController: UIViewController
{
    var monitor: Monitor!
    
    @IBOutlet weak var welkomTxt: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true)
        welkomTxt.text = "Welkom \(String(monitor.voornaam!)) \(String(monitor.naam!)),"
    }
    
    @IBAction func gaTerugNaarOverzichtMonitor(segue: UIStoryboardSegue) {
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "vormingen" {
            let vormingenTableViewController = segue.destinationViewController as VormingenTableViewController
            
            vormingenTableViewController.monitor = self.monitor
        }
    }
}