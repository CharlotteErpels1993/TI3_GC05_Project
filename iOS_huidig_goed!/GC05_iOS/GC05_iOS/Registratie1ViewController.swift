import UIKit

class Registratie1ViewController: UIViewController
{
    var ouder: Ouder!
    var gebruikerIsLid: Bool?
 
    @IBOutlet weak var isLid: UISwitch!
    
    @IBOutlet weak var lblAansluitingsNr: UILabel!
    @IBOutlet weak var txtAansluitingsNr: UITextField!
    @IBOutlet weak var lblCodeGerechtigde: UILabel!
    @IBOutlet weak var txtCodeGerechtigde: UITextField!
    @IBOutlet weak var lblRijksregisterNr: UILabel!
    @IBOutlet weak var txtRijksregisterNr: UITextField!
    @IBOutlet weak var lblAansluitingsNrTweedeOuder: UILabel!
    @IBOutlet weak var txtAansluitingsNrTweedeOuder: UITextField!
    
    @IBAction func switched(sender: UISwitch) {
        if sender.on {
            gebruikerIsLid = true
            
            lblAansluitingsNr.hidden = false
            lblCodeGerechtigde.hidden = false
            lblRijksregisterNr.hidden = false
            lblAansluitingsNrTweedeOuder.hidden = false
            
            txtAansluitingsNr.hidden = false
            txtCodeGerechtigde.hidden = false
            txtRijksregisterNr.hidden = false
            txtAansluitingsNrTweedeOuder.hidden = false
            
        } else {
            gebruikerIsLid = false
            
            lblAansluitingsNr.hidden = true
            lblCodeGerechtigde.hidden = true
            lblRijksregisterNr.hidden = true
            lblAansluitingsNrTweedeOuder.hidden = true
            
            txtAansluitingsNr.hidden = true
            txtCodeGerechtigde.hidden = true
            txtRijksregisterNr.hidden = true
            txtAansluitingsNrTweedeOuder.hidden = true
        }
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let registratie3ViewController = segue.destinationViewController as Registratie3ViewController
        
        ouder = Ouder(id: "test")
        
        if gebruikerIsLid == true {
            ouder.aansluitingsNr = txtAansluitingsNr.text.toInt()!
            ouder.codeGerechtigde = txtCodeGerechtigde.text.toInt()!
            ouder.rijksregisterNr = txtRijksregisterNr.text
            
            if !txtAansluitingsNrTweedeOuder.text.isEmpty {
                ouder.aansluitingsNrTweedeOuder = txtAansluitingsNrTweedeOuder.text.toInt()!
            }
        }
        
        registratie3ViewController.ouder = ouder
        
        /*if lidSocialistischeMutualiteitSwitch.on {
            registratie2ViewController.gebruikerIsLid = true
        } else {
            registratie2ViewController.gebruikerIsLid = false
        }*/
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