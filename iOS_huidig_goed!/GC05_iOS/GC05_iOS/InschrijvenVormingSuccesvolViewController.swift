import UIKit

class InschrijvenVormingSuccesvolViewController: UIViewController {
    
    var inschrijvingVorming: InschrijvingVorming!
    
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicatorView.startAnimating()
        parseInschrijvingVormingToDatabase()
        activityIndicatorView.stopAnimating()
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
            let profielMonitorViewController = segue.destinationViewController as EigenprofielMonitorViewController
            //overzichtMonitorViewController.monitor = self.inschrijvingVorming.monitor
        }
    }
}