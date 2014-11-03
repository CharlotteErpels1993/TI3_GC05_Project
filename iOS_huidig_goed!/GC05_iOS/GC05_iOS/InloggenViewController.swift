import UIKit

class InloggenViewController: UIViewController
{
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtWachtwoord: UITextField!
    
    var queryOuder = PFQuery(className: "Ouder")
    var queryMonitor = PFQuery(className: "Monitor")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func gaTerugNaarInloggen(segue: UIStoryboard) {
        
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        var email: String = txtEmail.text
        var wachtwoord: String = txtWachtwoord.text
        
        
        if veldenZijnIngevuld(email, wachtwoord: wachtwoord) {
            //zoeken naar gebruikers
            var type: String = zoekenMatchMonitorOfOuder(email, wachtwoord: wachtwoord)
            
            if type == "monitor" {
                var monitorPF = queryMonitor.getFirstObject()
                var monitor = Monitor(monitor: monitorPF)
                
                let overzichtMonitorViewController = segue.destinationViewController as OverzichtMonitorViewController
                overzichtMonitorViewController.monitor = monitor
            } else if type == "ouder" {
                var ouderPF = queryOuder.getFirstObject()
                var ouder = Ouder(ouder: ouderPF)
                
                let overzichtOuderViewController = segue.destinationViewController as OverzichtOuderViewController
                overzichtOuderViewController.ouder = ouder
            } else {
                var alert = UIAlertController(title: "Fout", message: "De combinatie e-mail/wachtwoord is niet correct", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "Ga terug", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
            }
            
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
    
    
    /* if !email.isEmpty && !wachtwoord.isEmpty {
    
    // OUDER
    queryOuder.findObjectsInBackgroundWithBlock { (objects: [AnyObject]!, error: NSError!) -> Void in
    if error == nil {
    for object in objects {
    // USER LOGIN? - OUDER
    let overzichtOuderViewController = segue.destinationViewController as OverzichtOuderViewController
    
    }
    }
    }
    
    // MONITOR
    queryMonitor.findObjectsInBackgroundWithBlock { (objects: [AnyObject]!, error: NSError!) -> Void in
    if error == nil {
    for object in objects {
    // USER LOGIN ? - MONITOR
    let overzichtMonitorViewController = segue.destinationViewController as OverzichtMonitorViewController
    
    }
    }
    }
    } else {
    var alert = UIAlertController(title: "Fout", message: "U hebt niet alle velden ingevuld!", preferredStyle: UIAlertControllerStyle.Alert)
    alert.addAction(UIAlertAction(title: "Ga terug", style: UIAlertActionStyle.Default, handler: nil))
    self.presentViewController(alert, animated: true, completion: nil)
    }*/
    
    
    
    
    
    /*var monitorPF: PFObject
    var ouderPF: PFObject*/
    
    /*queryMonitor.whereKey("email", containsString: email)
    queryMonitor.whereKey("wachtwoord", containsString: wachtwoord)
    queryOuder.whereKey("email", containsString: email)
    queryOuder.whereKey("wachtwoord", containsString: wachtwoord)*/
    
    /*if queryMonitor.countObjects() > 0 {
    monitorPF = queryMonitor.getFirstObject()
    monitor = Monitor(monitor: monitorPF)
    } else if queryOuder.countObjects() > 0 {
    ouderPF = queryOuder.getFirstObject()
    ouder = Ouder(ouder: ouderPF)
    } else {
    //er zijn geen gebruikers met deze combinatie email/wachtwoord
    }*/
    
    
    /*queryOuder.findObjectsInBackgroundWithBlock {
    (objects: [AnyObject]!, error: NSError!) -> Void in
    if error == nil {
    //er zijn ouder(s) met dat email adres
    ouder = objects.first as Ouder
    }
    }
    
    queryMonitor.findObjectsInBackgroundWithBlock {
    (objects: [AnyObject]!, error: NSError!) -> Void in
    if error == nil {
    //er zijn monitor(s) met dat email adres
    monitor = objects.first as Monitor
    }
    }*/
    
    
    
    /*if segue.identifier == "overzicht" {
    if !email.isEmpty && !wachtwoord.isEmpty {
    
    // OUDER
    queryOuder.findObjectsInBackgroundWithBlock { (objects: [AnyObject]!, error: NSError!) -> Void in
    if error == nil {
    for object in objects {
    // USER LOGIN? - OUDER
    let overzichtOuderViewController = segue.destinationViewController as OverzichtOuderViewController
    
    }
    }
    }
    
    // MONITOR
    queryMonitor.findObjectsInBackgroundWithBlock { (objects: [AnyObject]!, error: NSError!) -> Void in
    if error == nil {
    for object in objects {
    // USER LOGIN ? - MONITOR
    let overzichtMonitorViewController = segue.destinationViewController as OverzichtMonitorViewController
    
    }
    }
    }
    } else {
    var alert = UIAlertController(title: "Fout", message: "U hebt niet alle velden ingevuld!", preferredStyle: UIAlertControllerStyle.Alert)
    alert.addAction(UIAlertAction(title: "Ga terug", style: UIAlertActionStyle.Default, handler: nil))
    self.presentViewController(alert, animated: true, completion: nil)
    }
    }*/

    
}