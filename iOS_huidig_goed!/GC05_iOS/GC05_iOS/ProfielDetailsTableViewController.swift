import UIKit
import MessageUI

class ProfielDetailsTableViewController: UITableViewController, MFMailComposeViewControllerDelegate {
    @IBOutlet weak var voornaamLabel: UILabel!
    @IBOutlet weak var naamLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var telefoonLabel: UILabel!
    @IBOutlet weak var gsmLabel: UILabel!
    
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
    }
    
    @IBAction func verstuurMail(sender: AnyObject) {
        let mailComposeViewController = configuredMailComposeViewController()
        if MFMailComposeViewController.canSendMail() {
            self.presentViewController(mailComposeViewController, animated: true, completion: nil)
        } else {
            self.showSendMailErrorAlert()
        }
    }
    
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        mailComposerVC.setToRecipients([monitor.email!])
        mailComposerVC.setSubject("")
        mailComposerVC.setMessageBody("", isHTML: false)
        return mailComposerVC
    }
    
    func showSendMailErrorAlert() {
        let sendMailErrorAlert = UIAlertView(title: "Kan email niet verzenden", message: "Uw apparaat kan de email niet verzenden. Bekijk uw email instellingen en probeer nogmaals.", delegate: self, cancelButtonTitle: "OK")
        sendMailErrorAlert.show()
    }
    
    func mailComposeController(controller: MFMailComposeViewController!, didFinishWithResult result: MFMailComposeResult, error: NSError!) {
        controller.dismissViewControllerAnimated(true, completion: nil)
    }
    
}