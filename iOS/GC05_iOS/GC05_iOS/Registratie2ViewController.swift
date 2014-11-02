import UIKit

class Registratie2ViewController: UIViewController
{
    @IBOutlet weak var txtAansluitingsnummer: UITextField!
    @IBOutlet weak var txtCodeGerechtigde: UITextField!
    @IBOutlet weak var txtRijksregisternummer: UITextField!
    @IBOutlet weak var txtAansluitingsnummerTweedeOuder: UITextField!
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if segue.identifier == "confirm" {
            let registratie3ViewController = segue.destinationViewController as Registratie3ViewController
            
            //nog nakijken op lege velden!!! en dan view 'reloaden'?
            
            registratie3ViewController.aansluitingsNr = txtAansluitingsnummer.text.toInt()
            registratie3ViewController.codeGerechtigde = txtCodeGerechtigde.text.toInt()
            registratie3ViewController.rijksregisterNr = txtRijksregisternummer.text
            
            if txtAansluitingsnummerTweedeOuder.text.isEmpty {
                registratie3ViewController.aansluitingsNrTweedeouder = nil
            } else {
                registratie3ViewController.aansluitingsNrTweedeouder = txtAansluitingsnummerTweedeOuder.text.toInt()
            }
        }
    }
    
    
    
}
