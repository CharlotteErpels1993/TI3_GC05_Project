import UIKit

class Registratie1ViewController: UIViewController
{
    @IBOutlet weak var lidSocialistischeMutualiteitSwitch: UISwitch!
 
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "volgende" {
            
            if lidSocialistischeMutualiteitSwitch.on {
                //performSegueWithIdentifier("volgende2", sender: self)
                let registratie2ViewController = segue.destinationViewController as Registratie2ViewController
                
            } else {
                //performSegueWithIdentifier("volgende2", sender: self)
                let registratie3ViewController = segue.destinationViewController as Registratie3ViewController
               // let secondViewController =  segue
//as Registratie3ViewController

               // self.navigationController.pushViewController(secondViewController, animated: true)
            }
        }
    }
    
    @IBAction func gaTerugNaarRegistreren(segue: UIStoryboard) {
        
    }
}