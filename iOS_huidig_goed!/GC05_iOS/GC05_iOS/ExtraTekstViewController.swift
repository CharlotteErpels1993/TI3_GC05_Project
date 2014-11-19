import UIKit

class ExtraTekstViewController: UIViewController {

    @IBOutlet weak var korteBeschrijving: UITextView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    var tekst: String?
    var type: Int!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        korteBeschrijving.text = tekst
        
        switch type {
        case 1:
            self.navigationController?.title = "Korte beschrijving"
            break
        case 2:
            self.navigationController?.title = "Inbegrepen prijs"
            break
        case 3:
            self.navigationController?.title = "Criteria"
            break
        case 4:
            self.navigationController?.title = "Betalingswijze"
            break
        default:
            self.navigationController?.title = " "
        }
    }
}