import UIKit
//import MessageUI

class NieuweMonitorSuccesvolViewController: UIViewController/*,  MFMailComposeViewControllerDelegate*/ {
    
    var nieuweMonitor: NieuweMonitor!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /*let mailComposeViewController = configuredMailComposeViewController()
        if MFMailComposeViewController.canSendMail() {
            self.presentViewController(mailComposeViewController, animated: true, completion: nil)
        } else {
            self.showSendMailErrorAlert()
        }*/
        ParseData.parseNieuweMonitorToDatabase(self.nieuweMonitor)
    }
    
    /*func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        mailComposerVC.setToRecipients([nieuweMonitor.email!])
        mailComposerVC.setSubject("U bent klaar om zich te registeren!")
        mailComposerVC.setMessageBody("Beste monitor, \nU kunt u nu registeren als monitor met deze gegevens: \nLidnummer: \(nieuweMonitor.lidnummer), \nRijksregisternummer: \(nieuweMonitor.rijksregisternummer), \nEmail: \(nieuweMonitor.email) \nGa naar de Joetz-app en klik op registeren. Klik daarna op 'als monitor registeren' en kies vervolgens op ik heb een lidnummer en vul uw gegevens in. \nMet vriendelijke groet, \nHet Joetz-team", isHTML: false)
        return mailComposerVC
    }
    
    func showSendMailErrorAlert() {
        let sendMailErrorAlert = UIAlertView(title: "Kan email niet verzenden", message: "Uw apparaat kan de email niet verzenden. Bekijk uw email instellingen en probeer nogmaals.", delegate: self, cancelButtonTitle: "OK")
        sendMailErrorAlert.show()
    }*/
}