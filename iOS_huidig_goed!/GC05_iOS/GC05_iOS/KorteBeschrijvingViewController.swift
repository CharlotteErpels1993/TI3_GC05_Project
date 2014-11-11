import UIKit

class KorteBeschrijvingViewController: UIViewController {
    @IBOutlet weak var korteBeschrijvingLabel: UILabel!
    
    var tekst: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        korteBeschrijvingLabel.text = tekst
    }
}