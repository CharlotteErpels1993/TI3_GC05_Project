import UIKit

class OverzichtMonitorViewController: UIViewController
{
    var monitor: Monitor?
    
    override func viewDidLoad() {
        super.viewDidLoad()
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