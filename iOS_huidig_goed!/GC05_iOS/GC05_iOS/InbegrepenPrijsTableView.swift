import UIKit

class InbegrepenPrijsTableView: UIViewController {
    @IBOutlet weak var inbegrepenPrijs: UITextView!
    
    var tekst: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        inbegrepenPrijs.text = tekst
    }
}