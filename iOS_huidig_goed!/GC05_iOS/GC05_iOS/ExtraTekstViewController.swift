import UIKit

class ExtraTekstViewController: UIViewController {
    @IBOutlet weak var korteBeschrijving: UITextView!
    
    var tekst: String?
    var type: Int! = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        korteBeschrijving.text = tekst
        
        switch type {
        case 1:
            self.navigationItem.title = "Korte beschrijving"
            break
        case 2:
            self.navigationItem.title = "Inbegrepen prijs"
            break
        case 3:
            self.navigationItem.title = "Criteria"
            break
        case 4:
            self.navigationItem.title = "Betalingswijze"
            break
        case 5:
            self.navigationItem.title = "Periodes"
            break
        default:
            self.navigationController?.title = " "
        }
    }
}