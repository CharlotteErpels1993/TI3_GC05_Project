import UIKit

class BekijkAfbeeldingViewController: UIViewController {
    
    @IBOutlet weak var afbeelding: UIImageView!
    
    var afbeeldingId: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.afbeelding.image = afbeeldingId
        self.afbeelding.sizeToFit()
    }
}