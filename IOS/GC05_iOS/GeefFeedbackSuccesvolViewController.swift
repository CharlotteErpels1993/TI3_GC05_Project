import UIKit

class GeefFeedbackSuccesvolViewController: UIViewController {
    var feedback: Feedback!
    
    //
    //Naam: gaTerugNaarOverzichtVakanties
    //
    //Werking: - zorgt voor een unwind segue
    //         - zorgt dat de side bar menu verborgen is bij het inladen van de view
    //
    //Parameters:
    //  - sender: AnyObject
    //
    //Return:
    //
    @IBAction func gaTerugNaarOverzichtVakanties(sender: AnyObject) {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        var destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("Feedback") as UIViewController
        sideMenuController()?.setContentViewController(destViewController)
        hideSideMenuView()
    }
    
    //
    //Naam: viewDidLoad
    //
    //Werking: - zorgt ervoor dat de tool bar verborgen is
    //         - zorgt ervoor dat de back bar button niet aanwezig is
    //         - schrijft de feedback weg naar de database
    //
    //Parameters:
    //
    //Return:
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNeedsStatusBarAppearanceUpdate()
        self.navigationController!.toolbarHidden = true
        self.navigationItem.setHidesBackButton(true, animated: true)
        //ParseToDatabase.parseFeedback(feedback)
        FeedbackLD.insert(feedback)
    }
}