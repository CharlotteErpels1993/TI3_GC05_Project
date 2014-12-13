import UIKIt

class WatIsJoetzViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func toggle(sender: AnyObject) {
        toggleSideMenuView()
    }
    
    @IBAction func likeOnFacebook() {
        var url: NSURL = NSURL(string: "https://www.facebook.com/joetz.westvlaanderen?fref=ts")!
        UIApplication.sharedApplication().openURL(url)
    }
}