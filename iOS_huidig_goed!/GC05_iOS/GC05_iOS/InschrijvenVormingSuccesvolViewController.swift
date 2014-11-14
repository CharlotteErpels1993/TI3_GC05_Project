import UIKit

class InschrijvenVormingSuccesvolViewController: UIViewController {
    
    var inschrijvingVorming: InschrijvingVorming!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        parseInschrijvingVormingToDatabase()
    }
    
    func parseInschrijvingVormingToDatabase() {
        var inschrijvingVormingJSON = PFObject(className: "InschrijvingVorming")
        
        inschrijvingVormingJSON.setValue(inschrijvingVorming.periode, forKey: "periode")
        inschrijvingVormingJSON.setValue(inschrijvingVorming.monitor?.id, forKey: "monitor")
        inschrijvingVormingJSON.setValue(inschrijvingVorming.vorming?.id, forKey: "vorming")
        
        inschrijvingVormingJSON.save()
    }
    
    @IBAction func terugNaarOverzicht(sender: AnyObject) {
        performSegueWithIdentifier("ouderOverzicht", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "overzichtMonitor" {
            let overzichtMonitorViewController = segue.destinationViewController as OverzichtMonitorViewController
            //overzichtMonitorViewController.monitor = self.inschrijvingVorming.monitor
        }
    }
}