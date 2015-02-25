import UIKit

class SuccesvolNieuwWachtwoordViewController: UIViewController {
    //
    //Naam: viewDidLoad
    //
    //Werking: - zorgt ervoor dat de back bar button niet aanwezig is
    //
    //Parameters:
    //
    //Return:
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
}