import UIKit

class InloggenViewController: UIViewController
{
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtWachtwoord: UITextField!
    
    var queryOuder = PFQuery(className: "Ouder")
    var queryMonitor = PFQuery(className: "Monitor")
    var gebruiker: Gebruiker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func inloggen(sender: AnyObject) {
        var email: String = txtEmail.text
        var wachtwoord: String = txtWachtwoord.text
        
        if veldenZijnIngevuld(email, wachtwoord: wachtwoord) {
            //zoeken naar gebruikers
            var type: String = zoekenMatchMonitorOfOuder(email, wachtwoord: wachtwoord)
            
            if type == "monitor" {
                var monitorPF = queryMonitor.getFirstObject()
                self.gebruiker = Monitor(monitor: monitorPF)
                
                //let overzichtMonitorViewController = segue.destinationViewController as OverzichtMonitorViewController
                //overzichtMonitorViewController.monitor = self.gebruiker as Monitor
                performSegueWithIdentifier("overzichtMonitor", sender: self)
            } else if type == "ouder" {
                var ouderPF = queryOuder.getFirstObject()
                self.gebruiker = Ouder(ouder: ouderPF)
                
                //let overzichtOuderViewController = segue.destinationViewController as OverzichtOuderViewController
                //overzichtOuderViewController.ouder = ouder
                /*let overzichtVakantiesOuderViewController = segue.destinationViewController as VakantiesTableViewController*/
                performSegueWithIdentifier("ouderOverzicht", sender: self)
                //overzichtVakantiesOuderViewController.ouder = self.gebruiker as Ouder
            }
        } else {
            var alert = UIAlertController(title: "Fout", message: "De combinatie e-mail/wachtwoord is niet correct", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ga terug", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    
    
    @IBAction func gaTerugNaarInloggen(segue: UIStoryboardSegue) {
        
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        /*var email: String = txtEmail.text
        var wachtwoord: String = txtWachtwoord.text
        
        
        if veldenZijnIngevuld(email, wachtwoord: wachtwoord) {
            //zoeken naar gebruikers
            var type: String = zoekenMatchMonitorOfOuder(email, wachtwoord: wachtwoord)
            
            if type == "monitor" {
                var monitorPF = queryMonitor.getFirstObject()
                self.gebruiker = Monitor(monitor: monitorPF)
                
                let overzichtMonitorViewController = segue.destinationViewController as OverzichtMonitorViewController
                overzichtMonitorViewController.monitor = self.gebruiker as Monitor
            } else if type == "ouder" {
                var ouderPF = queryOuder.getFirstObject()
                self.gebruiker = Ouder(ouder: ouderPF)
                
                //let overzichtOuderViewController = segue.destinationViewController as OverzichtOuderViewController
                //overzichtOuderViewController.ouder = ouder
                /*let overzichtVakantiesOuderViewController = segue.destinationViewController as VakantiesTableViewController*/
                performSegueWithIdentifier("ouderOverzicht", sender: self)
                //overzichtVakantiesOuderViewController.ouder = self.gebruiker as Ouder
            } else {
                var alert = UIAlertController(title: "Fout", message: "De combinatie e-mail/wachtwoord is niet correct", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "Ga terug", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
            }
        } else*/
        if segue.identifier == "nieuwWachtwoord" {
            let nieuwWachtwoordController = segue.destinationViewController as NieuwWachtwoordViewController
        } else if segue.identifier == "registreren" {
            let registrerenController = segue.destinationViewController as Registratie1ViewController
        } else if segue.identifier == "ouderOverzicht" {
            let ouderOverzichtController = segue.destinationViewController as VakantiesTableViewController
            ouderOverzichtController.ouder = self.gebruiker as? Ouder
        } else if segue.identifier == "overzichtMonitor" {
            let monitorOverzichtController = segue.destinationViewController as OverzichtMonitorViewController
            monitorOverzichtController.monitor = self.gebruiker as? Monitor
        } else {
            //fout pop-up tonen
            var alert = UIAlertController(title: "Fout", message: "U hebt niet alle velden ingevuld!", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ga terug", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        
        }
    }
    
    private func veldenZijnIngevuld(email: String, wachtwoord: String) -> Bool {
        if !email.isEmpty && !wachtwoord.isEmpty {
            return true
        } else {
            return false
        }
    }
    
    private func zoekenMatchMonitorOfOuder(email: String, wachtwoord: String) -> String {
        if queryBevatRecords(email, wachtwoord: wachtwoord, query: queryMonitor) {
            return "monitor"
        } else if queryBevatRecords(email, wachtwoord: wachtwoord, query: queryOuder) {
            return "ouder"
        } else {
            return "geenRecords"
        }
    }
    
    private func queryBevatRecords(email: String, wachtwoord: String, query: PFQuery) -> Bool {
        query.whereKey("email", containsString: email)
        query.whereKey("wachtwoord", containsString: wachtwoord)
        if query.countObjects() > 0 {
            return true
        } else {
            return false
        }
    }
}