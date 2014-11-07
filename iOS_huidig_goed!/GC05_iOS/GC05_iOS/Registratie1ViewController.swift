import UIKit

class Registratie1ViewController: UIViewController
{
    var ouder: Ouder! = Ouder(id: "test")
    var gebruikerIsLid: Bool? = true
 
    @IBOutlet weak var isLid: UISwitch!
    
    @IBOutlet weak var lblAansluitingsNr: UILabel!
    @IBOutlet weak var txtAansluitingsNr: UITextField!
    @IBOutlet weak var lblCodeGerechtigde: UILabel!
    @IBOutlet weak var txtCodeGerechtigde: UITextField!
    @IBOutlet weak var lblRijksregisterNr: UILabel!
    @IBOutlet weak var txtRijksregisterNr: UITextField!
    @IBOutlet weak var lblAansluitingsNrTweedeOuder: UILabel!
    @IBOutlet weak var txtAansluitingsNrTweedeOuder: UITextField!
    
    var tellerAantalLegeVelden : Int = 0
    var textVelden: [String: String] = [:]
    
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
        ouder.foutBox = nil
        
        //controleren lege velden als switch op on staat
        if gebruikerIsLid == true {
            
            controleerEmptyTextfield(txtAansluitingsNr)
            controleerEmptyTextfield(txtCodeGerechtigde)
            controleerEmptyTextfield(txtRijksregisterNr)
            
            if tellerAantalLegeVelden > 0 {
                textVeldenLeegMaken()
                foutBoxOproepen("Fout", message: "Gelieve alle verplichte velden in te vullen!")
            } else {
                //velden van ouder invullen
                ouder.setAansluitingsNr(txtAansluitingsNr.text.toInt()!)
                ouder.setCodeGerechtigde(txtCodeGerechtigde.text.toInt()!)
                ouder.setRijksregisterNr(txtRijksregisterNr.text)
                
                //aansluitingsNrTweedeOuder is ingevuld
                if !txtAansluitingsNrTweedeOuder.text.isEmpty {
                    ouder.setAansluitingsNrTweedeOuder(txtAansluitingsNrTweedeOuder.text.toInt()!)
                }
            }
            
        }
        
        if ouder.bestaatFoutBoxAl() {
            textVeldenLeegMaken()
            foutBoxOproepen(ouder.foutBox!)
        } else {
            registratie3ViewController.ouder = ouder
        }
    }
    
    func controleerEmptyTextfield(textField: UITextField) {
        if textField.text.isEmpty {
            tellerAantalLegeVelden += 1
        }
    }
    
    func foutBoxOproepen(title: String, message: String) {
        var foutBox: FoutBox = FoutBox(title: title, message: message)
        var alert = foutBox.alert
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func foutBoxOproepen(foutBox: FoutBox) {
        var alert = foutBox.alert
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func textVeldenLeegMaken() {
        txtAansluitingsNr.text = ""
        txtCodeGerechtigde.text = ""
        txtRijksregisterNr.text = ""
        txtAansluitingsNrTweedeOuder.text = ""
    }
    
    @IBAction func gaTerugNaarRegistreren(segue: UIStoryboard) {
        
    }
}