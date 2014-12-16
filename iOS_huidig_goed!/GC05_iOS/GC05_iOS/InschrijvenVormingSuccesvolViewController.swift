import UIKit

class InschrijvenVormingSuccesvolViewController: UIViewController {
    
    var inschrijvingVorming: InschrijvingVorming!
    
    //
    //Naam: gaTerugNaarInloggen
    //
    //Werking: - zorgt voor een unwind segue
    //         - verbergt de side bar menu bij het openen van de nieuwe view
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
    //Werking: - schrijft de inschrijving van de vorming weg naar de database
    //         - zorgt ervoor dat de gebruiker niet terug kan in de view door het verbergen van de terug back button
    //
    //Parameters:
    //
    //Return:
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        ParseToDatabase.parseInschrijvingVorming(inschrijvingVorming)
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
}