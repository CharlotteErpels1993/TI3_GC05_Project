import UIKit

class BekijkAfbeeldingViewController: UITableViewController {
    
    @IBOutlet weak var afbeelding1: UIImageView!
    @IBOutlet weak var afbeelding2: UIImageView!
    @IBOutlet weak var afbeelding3: UIImageView!
    
    var afb1: UIImage?
    var afb2: UIImage?
    var afb3: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.afbeelding1.image = afb1
        self.afbeelding1.sizeToFit()
        
        self.afbeelding2.image = afb2
        self.afbeelding2.sizeToFit()
        
        self.afbeelding3.image = afb3
        self.afbeelding3.sizeToFit()
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Bordered, target: nil, action: nil)
    }
}