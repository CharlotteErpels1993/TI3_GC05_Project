import UIKit

class GeefFeedbackSuccesvolViewController: UIViewController {
    
    var feedback: Feedback!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNeedsStatusBarAppearanceUpdate()
        self.navigationController!.toolbarHidden = true
        self.navigationItem.setHidesBackButton(true, animated: true)
        ParseData.parseFeedbackToDatabase(feedback)
    }
    
    @IBAction func gaTerugNaarOverzichtVakanties(sender: AnyObject) {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        var destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("Feedback") as UIViewController
        sideMenuController()?.setContentViewController(destViewController)
        hideSideMenuView()
    }
}