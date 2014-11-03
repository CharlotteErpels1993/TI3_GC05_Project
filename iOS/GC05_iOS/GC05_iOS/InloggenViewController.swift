import UIKit

class InloggenViewController : UIViewController
{
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtWachtwoord: UITextField!
    
    var gebruikers: [Gebruiker] = []
    
    
    override func viewDidLoad() {
        test()
    }
    func test() {
        var alert = UIAlertController(title: "Fout", message: "U hebt niet alle velden ingevuld!", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    /*override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?){
    if segue.identifier == "inloggen" {
    
    
    
    /*if (txtEmail != nil && txtWachtwoord != nil) {
    for gebruiker in gebruikers {
    if(gebruiker.email == txtEmail.text && gebruiker.wachtwoord == txtWachtwoord) {
    // ga naar het overzichtpagina van de gebruiker (monitor of ouder?)
    }
    }
    } else {*/
    var alert = UIAlertController(title: "Fout", message: "U hebt niet alle velden ingevuld!", preferredStyle: UIAlertControllerStyle.Alert)
    alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.Default, handler: nil))
    self.presentViewController(alert, animated: true, completion: nil)
    
    //}
    
    }
    }*/
    
    
    
}