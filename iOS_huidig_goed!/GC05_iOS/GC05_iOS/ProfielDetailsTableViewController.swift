import UIKit
import MessageUI

class ProfielDetailsTableViewController: UITableViewController, MFMailComposeViewControllerDelegate {
    @IBOutlet weak var voornaamLabel: UILabel!
    @IBOutlet weak var naamLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var telefoonLabel: UILabel!
    @IBOutlet weak var gsmLabel: UILabel!
    
    var monitor: Monitor!
    var eigenProfiel: Bool = false
    
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
        
        if eigenProfiel == false {
            // BEWERKEN
            //var rightImage: UIImage = UIImage(named: "menu")!
            /*var rightItem: UIBarButtonItem = UIBarButtonItem(title: "Bewerken", style: UIBarButtonItemStyle.Plain, target: self, action: "profielBewerken")
            self.navigationItem.rightBarButtonItem = rightItem*/
        //} else {
            // MAIL
            /*var imageView = UIImageView(frame: CGRectMake(0, 0, 35, 35)) // set as you want
            var image = UIImage(named: "mail")
            imageView.image = image*/
            self.navigationItem.rightBarButtonItem = nil
            var rightImage: UIImage = UIImage(named: "mail")!
            //var buttonFrame: CGRect = rightImage.frame;
            //buttonFrame.size = CGSizeMake(150, 70);
            //rightImage.
            //var image = UIImage(named: "mail")
            //rightImage.
            var rightItem: UIBarButtonItem = UIBarButtonItem(image: rightImage, style: UIBarButtonItemStyle.Plain, target: self, action: "verstuurMail")
            self.navigationItem.rightBarButtonItem = rightItem
        }
    }
    
    func verstuurMail() {
        let mailComposeViewController = configuredMailComposeViewController()
        if MFMailComposeViewController.canSendMail() {
            self.presentViewController(mailComposeViewController, animated: true, completion: nil)
        } else {
            self.showSendMailErrorAlert()
        }
    }
    
    /*func profielBewerken() {
        performSegueWithIdentifier("bewerkProfiel", sender: self)
    }*/
    
    /*@IBAction func verstuurMail(sender: AnyObject) {
        let mailComposeViewController = configuredMailComposeViewController()
        if MFMailComposeViewController.canSendMail() {
            self.presentViewController(mailComposeViewController, animated: true, completion: nil)
        } else {
            self.showSendMailErrorAlert()
        }
    }*/
    
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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "bewerkProfiel" {
            let profielBewerkenViewController = segue.destinationViewController as ProfielBewerkenViewController
            profielBewerkenViewController.monitor = self.monitor
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        //self.tableView.reloadData()
        viewDidLoad()
    }
    
    @IBAction func gaTerugNaarProfielDetails(segue: UIStoryboardSegue) {}
    
}