import UIKit

class InschrijvenVormingSuccesvolViewController: UIViewController {
    
    var monitor: Monitor!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func terugNaarOverzicht(sender: AnyObject) {
        performSegueWithIdentifier("ouderOverzicht", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "overzichtMonitor" {
            let overzichtMonitorViewController = segue.destinationViewController as OverzichtMonitorViewController
            overzichtMonitorViewController.monitor = self.monitor
        }
    }
}