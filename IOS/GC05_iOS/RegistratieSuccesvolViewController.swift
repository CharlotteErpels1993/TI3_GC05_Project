import UIKit

class RegistratieSuccesvolViewController: UIViewController
{
    var ouder: Ouder!
    var wachtwoordOuder: String!
    
    //
    //Naam: gaTerugNaarInloggen
    //
    //Werking: - zorgt voor een unwind segue (gaat naar overzicht vakanties)
    //         - zorgt er ook voor dat bij het binnenkomen bij vakanties de side bar menu verborgen is
    //
    //Parameters:
    //  - sender: AnyObject
    //
    //Return:
    //
    @IBAction func gaTerugNaarInloggen(sender: AnyObject) {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        var destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("Vakanties") as UIViewController
        sideMenuController()?.setContentViewController(destViewController)
        hideSideMenuView()
    }
    
    //
    //Naam: viewDidLoad
    //
    //Werking: - schrijft de geregistreerde ouder naar de databank
    //         - zorgt ervoor dat de gebruiker niet meer kan terugkeren, door het verbergen van de hide bar button
    //
    //Parameters:
    //
    //Return:
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        //ParseToDatabase.parseOuder(ouder, wachtwoord: wachtwoordOuder)
        OuderLD.insert(ouder, wachtwoord: wachtwoordOuder)
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
}