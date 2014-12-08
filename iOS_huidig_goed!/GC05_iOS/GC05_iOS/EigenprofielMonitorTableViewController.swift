import UIKit

class EigenprofielMonitorTableViewController: UITableViewController {
    
    @IBOutlet weak var voornaam: UILabel!
    @IBOutlet weak var naam: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var telefoon: UILabel!
    @IBOutlet weak var gsm: UILabel!
    
    var activityIndicator: UIActivityIndicatorView!
    
    @IBAction func toggle(sender: AnyObject) {
        toggleSideMenuView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideSideMenuView()

        tableView.estimatedRowHeight = 44.0
        tableView.rowHeight = UITableViewAutomaticDimension
        
        var monitor = ParseData.getMonitorWithEmail(PFUser.currentUser().email)
        
        self.navigationItem.setHidesBackButton(true, animated: true)
        navigationItem.title = "Welkom \(monitor.voornaam!)"
        voornaam.text = monitor.voornaam!
        naam.text = monitor.naam!
        email.text = monitor.email!
        
        if monitor.telefoon == "" {
            telefoon.text = "Nog niet ingegvuld"
        } else {
            telefoon.text = monitor.telefoon!
        }
        
        gsm.text = monitor.gsm!
    }
    
    @IBAction func gaTerugNaarOverzichtMonitor(segue: UIStoryboardSegue) { }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "vormingen" {
            let vormingenTableViewController = segue.destinationViewController as VormingenTableViewController
        }
    }
}