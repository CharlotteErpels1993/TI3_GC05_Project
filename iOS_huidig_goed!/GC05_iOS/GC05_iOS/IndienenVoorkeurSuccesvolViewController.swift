import UIKit

class IndienenVoorkeurSuccesvolViewController: UIViewController {
    
    var voorkeur: Voorkeur!
    
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        parseVoorkeurToDatabase()
    }
    
    func parseVoorkeurToDatabase() {
        var voorkeurJSON = PFObject(className: "Voorkeur")
        
        voorkeurJSON.setValue(voorkeur.data, forKey: "periodes")
        voorkeurJSON.setValue(voorkeur.monitor?.id, forKey: "monitor")
        voorkeurJSON.setValue(voorkeur.vakantie?.id, forKey: "vakantie")
        
        voorkeurJSON.save()
    }
}