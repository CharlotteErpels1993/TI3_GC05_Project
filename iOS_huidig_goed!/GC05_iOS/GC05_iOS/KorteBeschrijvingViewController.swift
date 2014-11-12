import UIKit

class KorteBeschrijvingViewController: UIViewController {

    @IBOutlet weak var korteBeschrijving: UITextView!
    
    var tekst: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        korteBeschrijving.text = tekst
        //navigationItem.backBarButtonItem?.title = "Vakantie"

    }
}