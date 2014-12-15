import UIKit

class InschrijvenVormingSuccesvolViewController: UIViewController {
    
    var inschrijvingVorming: InschrijvingVorming!
    
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ParseData.parseInschrijvingVormingToDatabase(inschrijvingVorming)
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
    
    @IBAction func gaTerugNaarOverzicht(sender: AnyObject) {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        var destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("Vormingen") as UIViewController
        sideMenuController()?.setContentViewController(destViewController)
        hideSideMenuView()
    }
}