import UIKit

class ProfielBewerkenViewController: ResponsiveTextFieldViewController {
    
    @IBOutlet weak var voornaamTxt: UITextField!
    @IBOutlet weak var naamTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var telefoonTxt: UITextField!
    @IBOutlet weak var gsmTxt: UITextField!
    @IBOutlet weak var facebookTxt: UITextField!
    
    @IBAction func opslaan(sender: AnyObject) {
        schrijfGegevensNaarDatabank()
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        var destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("Profiel") as UIViewController
        sideMenuController()?.setContentViewController(destViewController)
        hideSideMenuView()
    }
    
    var monitor: Monitor!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideSideMenuView()
        //getCurrentUser()
        //vulGegevensDatabankIn()
    }
    
    /*func getCurrentUser() {
        var query = PFQuery(className: "Monitor")
        query.whereKey("email", containsString: PFUser.currentUser().email)
        var monitorPF = query.getFirstObject()
        monitor = Monitor(monitor: monitorPF)
    }*/
    
    func vulGegevensDatabankIn() {
        voornaamTxt.text = monitor.voornaam
        naamTxt.text = monitor.naam
        emailTxt.text = monitor.email
        telefoonTxt.text = monitor.telefoon
        gsmTxt.text = monitor.gsm
        facebookTxt.text = monitor.linkFacebook
    }
    
    /*func schrijfGegevensNaarDatabank() {
        monitor.voornaam = voornaamTxt.text
        monitor.naam = naamTxt.text
        monitor.email = emailTxt.text
        monitor.telefoon = telefoonTxt.text
        monitor.gsm = gsmTxt.text
        monitor.linkFacebook = facebookTxt.text
        
        var monitorJSON = PFObject(className: "Monitor")
        monitorJSON.objectId = monitor.id
        
        //query.whereKey("email", containsString: PFUser.currentUser().email)
        
        monitorJSON.setValue(monitor.voornaam, forKey: "voornaam")
        monitorJSON.setValue(monitor.naam, forKey: "naam")
        monitorJSON.setValue(monitor.email, forKey: "email")
        monitorJSON.setValue(monitor.telefoon, forKey: "telefoon")
        monitorJSON.setValue(monitor.gsm, forKey: "gsm")
        monitorJSON.setValue(monitor.linkFacebook, forKey: "linkFacebook")
        
        monitorJSON.save()
        monitorJSON.fetch()
        
    }*/
}