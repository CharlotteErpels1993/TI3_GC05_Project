import UIKit

class RegistratieSuccesvolViewController: UIViewController
{
    var ouder: Ouder!
    var ww: String!
    
    @IBAction func gaTerugNaarInloggen(sender: AnyObject) {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        var destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("Vakanties") as UIViewController
        sideMenuController()?.setContentViewController(destViewController)
        hideSideMenuView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ParseData.parseOuderToDatabase(ouder, wachtwoord: ww)
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
    
    private func logIn() {
        PFUser.logInWithUsername(ouder.email, password: ww)
    }
}