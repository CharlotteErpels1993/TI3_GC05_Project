import UIKit

class ProfielDetailsTableViewController: UITableViewController {
    @IBOutlet weak var voornaamLabel: UILabel!
    @IBOutlet weak var naamLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var telefoonLabel: UILabel!
    @IBOutlet weak var gsmLabel: UILabel!
    @IBOutlet weak var facebookLabel: UILabel!
    
    var monitor: Monitor!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideSideMenuView()
        self.navigationItem.title = (" \(monitor.voornaam!) \(monitor.naam!)")
        voornaamLabel.text = monitor.voornaam!
        naamLabel.text = monitor.naam!
        emailLabel.text = monitor.email!
        
        if monitor.telefoon == "" {
            telefoonLabel.text = "Niet beschikbaar"
        } else {
            telefoonLabel.text = monitor.telefoon!
        }
        
        gsmLabel.text = monitor.gsm!
        
        if monitor.linkFacebook == "" {
            facebookLabel.text = "Niet beschikbaar"
        } else {
            facebookLabel.text = monitor.linkFacebook!
        }
    }
}