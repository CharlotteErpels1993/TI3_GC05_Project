import UIKit

class RegistratieSuccesvolViewController: UIViewController
{
    var ouder: Ouder!
    var wachtwoordOuder: String!
    
    @IBAction func gaTerugNaarInloggen(sender: AnyObject) {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        var destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("Vakanties") as UIViewController
        sideMenuController()?.setContentViewController(destViewController)
        hideSideMenuView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ParseToDatabase.parseOuderToDatabase(ouder, wachtwoord: wachtwoordOuder)
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
}