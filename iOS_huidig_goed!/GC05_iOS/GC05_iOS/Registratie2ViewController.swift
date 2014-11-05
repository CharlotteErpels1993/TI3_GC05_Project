import UIKit

class Registratie2ViewController: UIViewController
{
    @IBOutlet weak var txtAansluitingsnummer: UITextField!
    @IBOutlet weak var txtCodeGerechtigde: UITextField!
    @IBOutlet weak var txtRijksregisternummer: UITextField!
    @IBOutlet weak var txtAansluitingsnummerTweedeOuder: UITextField!
    
    var gebruikerIsLid: Bool!
    var ouder: Ouder!
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if gebruikerIsLid == false {
            performSegueWithIdentifier("volgende3", sender: self)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        //if segue.identifier == "volgende2" {
            let registratie3ViewController = segue.destinationViewController as Registratie3ViewController
            
            //nog nakijken op lege velden!!! en dan view 'reloaden'?
            ouder.aansluitingsNr = txtAansluitingsnummer.text.toInt()!
            ouder.codeGerechtigde = txtCodeGerechtigde.text.toInt()!
            ouder.rijksregisterNr = txtRijksregisternummer.text
            
            if txtAansluitingsnummerTweedeOuder.text.isEmpty {
                ouder.aansluitingsNrTweedeOuder = 0
            } else {
                ouder.aansluitingsNrTweedeOuder = txtAansluitingsnummerTweedeOuder.text.toInt()!
            }
            
            //ouder-object doorgeven aan volgende viewController
            registratie3ViewController.ouder = self.ouder
            
            
            
            /*registratie3ViewController.aansluitingsNr = txtAansluitingsnummer.text.toInt()
            registratie3ViewController.codeGerechtigde = txtCodeGerechtigde.text.toInt()
            registratie3ViewController.rijksregisterNr = txtRijksregisternummer.text
            
            if txtAansluitingsnummerTweedeOuder.text.isEmpty {
                registratie3ViewController.aansluitingsNrTweedeOuder = nil
            } else {
                registratie3ViewController.aansluitingsNrTweedeOuder = txtAansluitingsnummerTweedeOuder.text.toInt()
            }*/
      //  }
    }
    
    /*func controleRijksregisternummer(rijksregisternummer: String) -> Bool {
        var length : Int = countElements(rijksregisternummer)
        var eerste9CijfersString: String = rijksregisternummer.substringWithRange(Range<String.Index>(start: rijksregisternummer.startIndex, end: advance(rijksregisternummer.endIndex, -2)))
        
        var eerste9CijfersInt: Int = eerste9CijfersString.toInt()!
        var restNaDeling97: Int = eerste9CijfersInt % 97
        var controleGetal: Int = 97 - restNaDeling97
        var laatste2CijfersString: String = rijksregisternummer.substringWithRange(Range<String.Index>(start: advance(rijksregisternummer.startIndex, 10), end: rijksregisternummer.endIndex))
        var laatste2CijfersInt: Int = laatste2CijfersString.toInt()!
        
        if length > 11 || length < 11 {
            return false
        } else if laatste2CijfersInt != controleGetal {
            return false
        } else {
            return true
        }
    }*/
}