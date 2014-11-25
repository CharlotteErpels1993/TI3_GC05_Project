import UIKit

class EigenprofielMonitorViewController: UIViewController
{
    @IBOutlet weak var welkom: UILabel!
    @IBOutlet weak var voornaam: UILabel!
    @IBOutlet weak var naam: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var telefoon: UILabel!
    @IBOutlet weak var gsm: UILabel!
    @IBOutlet weak var facebook: UILabel!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    @IBAction func toggle(sender: AnyObject) {
        toggleSideMenuView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideSideMenuView()
        activityIndicatorView.startAnimating()
        //var query = PFQuery(className: "Monitor")
        //query.whereKey("email", containsString: PFUser.currentUser().email)
        //var monitorPF = query.getFirstObject()
        //var monitor = Monitor(monitor: monitorPF)
        
        var monitor = ParseData.getMonitorWithEmail(PFUser.currentUser().email)
        
        self.navigationItem.setHidesBackButton(true, animated: true)
        welkom.text = "Welkom \(String(monitor.voornaam!)) \(String(monitor.naam!)),"
        voornaam.text = monitor.voornaam
        naam.text = monitor.naam
        email.text = monitor.email
        
        if monitor.telefoon == "" {
            telefoon.text = "/"
        } else {
            telefoon.text = monitor.telefoon
        }
        
        gsm.text = monitor.gsm
        
        if monitor.linkFacebook == ""{
            facebook.text = "Nog niet ingevuld"
        } else {
            facebook.text = monitor.linkFacebook
        }

        activityIndicatorView.stopAnimating()
    }
    
    @IBAction func gaTerugNaarOverzichtMonitor(segue: UIStoryboardSegue) {
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "vormingen" {
            let vormingenTableViewController = segue.destinationViewController as VormingenTableViewController
        }
    }
}