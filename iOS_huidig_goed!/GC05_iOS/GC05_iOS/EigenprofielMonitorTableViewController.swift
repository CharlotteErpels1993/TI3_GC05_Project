import UIKit

class EigenprofielMonitorTableViewController: UITableViewController
{
    
    @IBOutlet weak var voornaam: UILabel!
    @IBOutlet weak var naam: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var telefoon: UILabel!
    @IBOutlet weak var gsm: UILabel!
    @IBOutlet weak var facebook: UILabel!
    //@IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    @IBAction func toggle(sender: AnyObject) {
        toggleSideMenuView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideSideMenuView()

        
        tableView.estimatedRowHeight = 44.0
        tableView.rowHeight = UITableViewAutomaticDimension
        
        
        //activityIndicatorView.startAnimating()
        //var query = PFQuery(className: "Monitor")
        //query.whereKey("email", containsString: PFUser.currentUser().email)
        //var monitorPF = query.getFirstObject()
        
        var monitor = ParseData.getMonitorWithEmail(PFUser.currentUser().email)
        
        
        self.navigationItem.setHidesBackButton(true, animated: true)
        navigationItem.title = "Welkom \(monitor.voornaam!)"
        voornaam.text = "Voornaam: \(monitor.voornaam!)"
        naam.text = "Naam: \(monitor.naam!)"
        email.text = "Email: \(monitor.email!)"
        
        if monitor.telefoon == "" {
            telefoon.text = "Telefoon: /"
        } else {
            telefoon.text = "Telefoon: \(monitor.telefoon!)"
        }
        
        gsm.text = "Gsm: \(monitor.gsm!)"
        
        if monitor.linkFacebook == "" {
            facebook.text = "Facebook: Nog niet ingevuld"
        } else {
            facebook.text = "Facebook: \(monitor.linkFacebook!)"
        }
        
        //activityIndicatorView.stopAnimating()
    }
    
    @IBAction func gaTerugNaarOverzichtMonitor(segue: UIStoryboardSegue) {
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "vormingen" {
            let vormingenTableViewController = segue.destinationViewController as VormingenTableViewController
        }
    }
}