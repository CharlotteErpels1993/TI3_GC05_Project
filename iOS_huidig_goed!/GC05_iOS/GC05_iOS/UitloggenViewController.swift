import UIKit

class UitloggenViewController: UIViewController {
    
    @IBAction func toggle(sender: AnyObject) {
        toggleSideMenuView()
    }
    
    @IBAction func uitloggen(sender: AnyObject) {
        PFUser.logOut()
        //performSegueWithIdentifier("overzichtVakanties", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "overzichtVakanties" {
            let overzichtVakanties = segue.destinationViewController as VakantiesTableViewController
            println("uitgelogd")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}