class InloggenViewController: UIViewController {
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtWachtwoord: UITextField!
    
    var queryOuder = PFQuery(className: "Ouder")
    var queryMonitor = PFQuery(className: "Monitor")
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        var email = txtEmail.text
        var wachtwoord = txtWachtwoord.text
        
        queryMonitor.whereKey("email", containsString: email)
        queryMonitor.whereKey("wachtwoord", containsString: wachtwoord)
        queryMonitor.whereKey("email", containsString: email)
        queryMonitor.whereKey("wachtwoord", containsString: wachtwoord)
        
        if segue.identifier == "overzicht" {
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
      }
    }

}
    
