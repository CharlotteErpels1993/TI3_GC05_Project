import Foundation
import UIKit

class FoutBox
{
    var alert: UIAlertController
    var soort: String?
    
    init(title: String, message: String) {
        self.alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        self.alert.addAction(UIAlertAction(title: "Ga terug", style: UIAlertActionStyle.Default, handler: nil))
    }
}


 func getInternetFoutBoxMetPerformSegue(titel: String, message: String, controller: UIViewController, segue: String) {
    if Reachability.isConnectedToNetwork() == false {
        var alert = UIAlertController(title: titel, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ga terug", style: .Default, handler: { action in
            switch action.style{
            default:
                controller.performSegueWithIdentifier(segue, sender: controller)
            }
            
        }))
        alert.addAction(UIAlertAction(title: "Ga naar instellingen", style: .Default, handler: { action in
            switch action.style{
            default:
                UIApplication.sharedApplication().openURL(NSURL(string:UIApplicationOpenSettingsURLString)!);
            }
            
        }))
        controller.presentViewController(alert, animated: true, completion: nil)
    }
}
