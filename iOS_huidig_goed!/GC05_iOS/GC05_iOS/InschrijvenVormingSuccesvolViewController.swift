import UIKit

class InschrijvenVormingSuccesvolViewController: UIViewController {
    
    var inschrijvingVorming: InschrijvingVorming!
    
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicatorView.startAnimating()
        
        ParseData.parseInschrijvingVormingToDatabase(inschrijvingVorming)
        
        activityIndicatorView.stopAnimating()
    }
    
    /*func parseInschrijvingVormingToDatabase() {
        var inschrijvingVormingJSON = PFObject(className: "InschrijvingVorming")
        
        inschrijvingVormingJSON.setValue(inschrijvingVorming.periode, forKey: "periode")
        inschrijvingVormingJSON.setValue(inschrijvingVorming.monitor?.id, forKey: "monitor")
        inschrijvingVormingJSON.setValue(inschrijvingVorming.vorming?.id, forKey: "vorming")
        
        inschrijvingVormingJSON.save()
    }*/
    
    @IBAction func gaTerugNaarOverzicht(sender: AnyObject) {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        var destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("Profiel") as UIViewController
        sideMenuController()?.setContentViewController(destViewController)
        hideSideMenuView()
    }
    
    /*@IBAction func terugNaarOverzicht(sender: AnyObject) {
        performSegueWithIdentifier("ouderOverzicht", sender: self)
    }*/
    

}