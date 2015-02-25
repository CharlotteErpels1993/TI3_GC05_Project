import UIKIt

class WatIsJoetzViewController: UIViewController {
    //
    //Naam: viewDidLoad
    //
    //Werking:
    //
    //Parameters:
    //
    //Return:
    //
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //
    //Naam: toggle
    //
    //Werking: - zorgt ervoor dat de side bar menu wordt weergegeven
    //         - zorgt er ook voor dat alle toestenborden gesloten zijn
    //
    //Parameters:
    //  - sender: AnyObject
    //
    //Return:
    //
    @IBAction func toggle(sender: AnyObject) {
        toggleSideMenuView()
    }
    
    //
    //Naam: likeOnFacebook
    //
    //Werking: - zorgt ervoor bij het klikken op de foto de browser wordt geopend met de facebook pagina van JOETZ
    //
    //Parameters:
    //
    //Return:
    //
    @IBAction func likeOnFacebook() {
        var url: NSURL = NSURL(string: "https://www.facebook.com/joetz.westvlaanderen?fref=ts")!
        UIApplication.sharedApplication().openURL(url)
    }
}