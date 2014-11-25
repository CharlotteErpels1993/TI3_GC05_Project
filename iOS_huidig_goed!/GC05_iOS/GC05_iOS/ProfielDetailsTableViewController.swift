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
        
        voornaamLabel.text = "Voornaam: \(monitor.voornaam!)"
        naamLabel.text = "Naam: \(monitor.naam!)"
        emailLabel.text = "Email: \(monitor.email!)"
        telefoonLabel.text = "Telefoon: \(monitor.telefoon!)"
        gsmLabel.text = "Gsm: \(monitor.gsm!)"
        facebookLabel.text = "Facebook: \(monitor.linkFacebook!)"
        
    }
    
    
}