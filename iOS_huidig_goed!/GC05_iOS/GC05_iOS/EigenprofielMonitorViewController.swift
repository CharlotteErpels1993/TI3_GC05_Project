import UIKit

class EigenprofielMonitorViewController: UIViewController
{
    //var monitor: Monitor!
    
    //@IBOutlet weak var welkomTxt: UILabel!
    
    @IBAction func toggle(sender: AnyObject) {
        toggleSideMenuView()
    }
    
    override func viewDidLoad() {
        //navigationItem.title =
        super.viewDidLoad()
        //navigationItem.titel = "Welkom \(String(monitor.voornaam!)) \(String(monitor.naam!)),"
        var query = PFQuery(className: "Monitor")
        query.whereKey("email", containsString: PFUser.currentUser().email)
        var monitorPF = query.getFirstObject()
        var monitor = Monitor(monitor: monitorPF)
        self.navigationItem.setHidesBackButton(true, animated: true)
        //welkomTxt.text = "Welkom \(String(monitor.voornaam!)) \(String(monitor.naam!)),"
    }
    
    @IBAction func gaTerugNaarOverzichtMonitor(segue: UIStoryboardSegue) {
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "vormingen" {
            let vormingenTableViewController = segue.destinationViewController as VormingenTableViewController
            
            //vormingenTableViewController.monitor = self.monitor
        }
    }
}