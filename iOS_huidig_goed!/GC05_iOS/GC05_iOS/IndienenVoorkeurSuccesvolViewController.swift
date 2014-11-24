import UIKit

class IndienenVoorkeurSuccesvolViewController: UIViewController {
    
    var voorkeur: Voorkeur!
    
    //moet nog static klasse worden!
    //var parseData: ParseData = ParseData()
    
    
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    @IBAction func gaTerugNaarOverzicht(sender: AnyObject) {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        var destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("Profiel") as UIViewController
        sideMenuController()?.setContentViewController(destViewController)
        hideSideMenuView()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //parseVoorkeurToDatabase()
        ParseData.parseVoorkeurToDatabase(voorkeur)
        
        
    }
    
    /*func parseVoorkeurToDatabase() {
        var voorkeurJSON = PFObject(className: "Voorkeur")
        
        voorkeurJSON.setValue(voorkeur.data, forKey: "periodes")
        voorkeurJSON.setValue(voorkeur.monitor?.id, forKey: "monitor")
        voorkeurJSON.setValue(voorkeur.vakantie?.id, forKey: "vakantie")
        
        voorkeurJSON.save()
    }*/
}