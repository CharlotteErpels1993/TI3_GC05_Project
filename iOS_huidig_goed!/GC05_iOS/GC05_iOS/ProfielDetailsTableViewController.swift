import UIKit
import MessageUI

class ProfielDetailsTableViewController: UITableViewController, MFMailComposeViewControllerDelegate {
    @IBOutlet weak var voornaamLabel: UILabel!
    @IBOutlet weak var naamLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet var straatLabel: UILabel!
    @IBOutlet var nummerLabel: UILabel!
    @IBOutlet var busLabel: UILabel!
    @IBOutlet var postcodeLabel: UILabel!
    @IBOutlet var gemeenteLabel: UILabel!
    @IBOutlet weak var telefoonLabel: UILabel!
    @IBOutlet weak var gsmLabel: UILabel!
    
    var monitor: Monitor!
    var eigenProfiel: Bool = false
    
    //
    //Naam: gaTerugNaarInloggen
    //
    //Werking: - zorgt voor een unwind segue
    //
    //Parameters:
    //  - sender: AnyObject
    //
    //Return:
    //
    @IBAction func gaTerugNaarProfielDetails(segue: UIStoryboardSegue) {}
    
    //
    //Naam: viewDidLoad
    //
    //Werking: - zorgt ervoor dat de side bar menu verborgen is
    //         - stelt de titel van de navigationbar in
    //         - vult alle velden met de juiste gegevens in
    //         - right bar button is afhankelijk van de profiel die de gebruiker heeft geselecteerd
    //              * eigen profiel -> knop wordt profiel bewerken
    //              * ander profiel -> knop wordt mail icoon
    //
    //Parameters:
    //
    //Return:
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        hideSideMenuView()
        self.navigationItem.title = (" \(monitor.voornaam!) \(monitor.naam!)")
        
        
        var huidigeMonitor = LocalDatastore.getLocalObjectWithColumnConstraints(Constanten.TABLE_MONITOR, soortConstraints: [Constanten.COLUMN_EMAIL: Constanten.CONSTRAINT_EQUALTO], equalToConstraints: [Constanten.COLUMN_EMAIL: PFUser.currentUser().email]) as Monitor
        
        if monitor.id == huidigeMonitor.id {
            
            var query = PFQuery(className: Constanten.TABLE_MONITOR)
            query.whereKey(Constanten.COLUMN_OBJECTID, equalTo: self.monitor.id)
            query.fromLocalDatastore()
            
            var object = query.getFirstObject()
            
            self.monitor = LocalDatastore.getMonitor(object)
        }
        
        voornaamLabel.text = monitor.voornaam!
        naamLabel.text = monitor.naam!
        emailLabel.text = monitor.email!
        straatLabel.text = monitor.straat!
        nummerLabel.text = String(monitor.nummer!)
        
        if monitor.bus == "" {
            busLabel.text = " "
        } else {
            busLabel.text = monitor.bus
        }
        
        postcodeLabel.text = String(monitor.postcode!)
        gemeenteLabel.text = monitor.gemeente!
        
        if monitor.telefoon == "" {
            telefoonLabel.text = "Niet beschikbaar"
        } else {
            telefoonLabel.text = monitor.telefoon!
        }
        
        gsmLabel.text = monitor.gsm!
        
        if eigenProfiel == false {
            self.navigationItem.rightBarButtonItem = nil
            var rightImage: UIImage = UIImage(named: "mail")!
            var rightItem: UIBarButtonItem = UIBarButtonItem(image: rightImage, style: UIBarButtonItemStyle.Plain, target: self, action: "verstuurMail")
            self.navigationItem.rightBarButtonItem = rightItem
        }
    }
    
    //
    //Naam: verstuurMail
    //
    //Werking: - zorgt ervoor dat de mail applicatie wordt gestart
    //
    //Parameters:
    //
    //Return:
    //
    func verstuurMail() {
        let mailComposeViewController = configuredMailComposeViewController()
        if MFMailComposeViewController.canSendMail() {
            self.presentViewController(mailComposeViewController, animated: true, completion: nil)
        } else {
            self.showSendMailErrorAlert()
        }
    }
    
    //
    //Naam: configuredMailComposeViewController
    //
    //Werking: - zet het onderwerp en de tekst van de mail in
    //
    //Parameters:
    //
    //Return: MFMailComposeViewController
    //
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        mailComposerVC.setToRecipients([monitor.email!])
        mailComposerVC.setSubject("")
        mailComposerVC.setMessageBody("", isHTML: false)
        return mailComposerVC
    }
    
    //
    //Naam: showSendMailErrorAlert
    //
    //Werking: - error wordt getoond als email niet kan verzonden worden
    //
    //Parameters:
    //
    //Return:
    //
    func showSendMailErrorAlert() {
        let sendMailErrorAlert = UIAlertView(title: "Kan email niet verzenden", message: "Uw apparaat kan de email niet verzenden. Bekijk uw email instellingen en probeer nogmaals.", delegate: self, cancelButtonTitle: "OK")
        sendMailErrorAlert.show()
    }
    
    //
    //Naam: mailComposeController
    //
    //Werking: - zorgt ervoor dat de mail applicatie wordt gestart
    //
    //Parameters:
    //  - controller: MFMailComposeViewController
    //  - didFinishWithResult result: MFMailComposeResult
    //  - error: NSError
    //
    //Return:
    //
    func mailComposeController(controller: MFMailComposeViewController!, didFinishWithResult result: MFMailComposeResult, error: NSError!) {
        controller.dismissViewControllerAnimated(true, completion: nil)
    }
    
    //
    //Naam: prepareForSegue
    //
    //Werking: - maakt de volgende view met opgegeven identifier (stelt soms attributen van de volgende view op)
    //
    //Parameters:
    //  - segue: UIStoryboardSegue
    //  - sender: AnyObject?
    //
    //Return:
    //
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "bewerkProfiel" {
            let profielBewerkenViewController = segue.destinationViewController as ProfielBewerkenViewController
            profielBewerkenViewController.monitor = self.monitor
        }
    }
}