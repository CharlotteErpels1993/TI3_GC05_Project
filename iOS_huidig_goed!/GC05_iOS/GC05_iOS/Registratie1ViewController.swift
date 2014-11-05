import UIKit

class Registratie1ViewController: UIViewController
{
    @IBOutlet weak var lidSocialistischeMutualiteitSwitch: UISwitch!
 
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let registratie2ViewController = segue.destinationViewController as Registratie2ViewController
        if lidSocialistischeMutualiteitSwitch.on {
            registratie2ViewController.switchLidIsOn = true
        } else {
            registratie2ViewController.switchLidIsOn = false
        }
        /*if segue.identifier == "volgende" {
            
            if lidSocialistischeMutualiteitSwitch.on {
                let registratie2ViewController = segue.destinationViewController as Registratie2ViewController
            } else {
                let registratie3ViewController = segue.destinationViewController as Registratie3ViewController
            }
        }*/
    }
    
    @IBAction func gaTerugNaarRegistreren(segue: UIStoryboard) {
        
    }
}