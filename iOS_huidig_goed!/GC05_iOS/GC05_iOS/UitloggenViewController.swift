import UIKit

class UitloggenViewController: UIViewController {
    
    @IBAction func toggle(sender: AnyObject) {
        toggleSideMenuView()
    }
    
    /*@IBAction func uitloggen(sender: AnyObject) {
        PFUser.logOut()
    }*/
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "overzichtVakanties" {
            let overzichtVakanties = segue.destinationViewController as VakantiesTableViewController
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let alertController = UIAlertController(title: "Uitloggen", message: "Wilt u zeker uitloggen?", preferredStyle: .ActionSheet)
        
        let callAction = UIAlertAction(title: "Uitloggen", style: .Default, handler: {
            action in
                PFUser.logOut()
                let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                var destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("Inloggen") as UIViewController
                self.sideMenuController()?.setContentViewController(destViewController)
                self.hideSideMenuView()
            }
        )
        alertController.addAction(callAction)
        
        /*let defaultAction = UIAlertAction(title: "Cancel", style: .Default, handler: nil)
        alertController.addAction(defaultAction)*/
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Default, handler: {
            action in
            
            if PFUser.currentUser() != nil {
                var gebruikerPF = PFUser.currentUser()
                var soort: String = gebruikerPF["soort"] as String
                
                if soort == "ouder" {
                    let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    var destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("Vakanties") as UIViewController
                    self.sideMenuController()?.setContentViewController(destViewController)
                    self.hideSideMenuView()
                } else if soort == "monitor" {
                    let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    var destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("Profiel") as UIViewController
                    self.sideMenuController()?.setContentViewController(destViewController)
                    self.hideSideMenuView()
                }
            }

            }
        )
        alertController.addAction(callAction)
        
        presentViewController(alertController, animated: true, completion: nil)
    }
}