import UIKit

class IndienenVoorkeurSuccesvolViewController: UIViewController {
    
    var voorkeur: Voorkeur!
    
    //
    //Naam: gaTerugNaarInloggen
    //
    //Werking: - zorgt voor een unwind segue
    //         - verbergt de side bar menu bij het laden van de view
    //
    //Parameters:
    //  - sender: AnyObject
    //
    //Return:
    //
    @IBAction func gaTerugNaarOverzicht(sender: AnyObject) {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        var destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("Vormingen") as UIViewController
        sideMenuController()?.setContentViewController(destViewController)
        hideSideMenuView()
    }
    
    //
    //Naam: viewDidLoad
    //
    //Werking: - zorgt ervoor dat de back bar button niet aanwezig is
    //         - schrijft de voorkeur van de vakantie weg naar de database
    //
    //Parameters:
    //
    //Return:
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true)
        ParseToDatabase.parseVoorkeur(voorkeur)
    }
}