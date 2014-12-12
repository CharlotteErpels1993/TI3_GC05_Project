import UIKit

class IndienenVoorkeurSuccesvolViewController: UIViewController {
    
    var voorkeur: Voorkeur!
    
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    @IBAction func gaTerugNaarOverzicht(sender: AnyObject) {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        var destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("Voorkeuren") as UIViewController
        sideMenuController()?.setContentViewController(destViewController)
        hideSideMenuView()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true)
        ParseData.parseVoorkeurToDatabase(voorkeur)
    }
}