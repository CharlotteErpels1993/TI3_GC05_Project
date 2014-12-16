import UIKit

class ExtraTekstViewController: UIViewController {
    @IBOutlet var vakantieNaamLabel: UILabel?
    @IBOutlet var korteBeschrijving: UITextView?
    
    var type: Int! = 0
    var tekst: String = ""
    var naam: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNeedsStatusBarAppearanceUpdate()

        //self.navigationController!.toolbarHidden = true
        self.korteBeschrijving?.text = tekst
        
        switch type {
        case 1:
            self.navigationItem.title = "Korte beschrijving"
            self.vakantieNaamLabel!.hidden = false
            self.vakantieNaamLabel?.text = self.naam
            break
        case 2:
            self.navigationItem.title = "Inbegrepen prijs"
            self.vakantieNaamLabel!.hidden = true
            break
        case 3:
            self.navigationItem.title = "Criteria"
            self.vakantieNaamLabel!.hidden = true
            break
        case 4:
            self.navigationItem.title = "Betalingswijze"
            self.vakantieNaamLabel!.hidden = true
            break
        case 5:
            self.navigationItem.title = "Tips"
            self.vakantieNaamLabel!.hidden = true
            break
        default:
            self.navigationController?.title = " "
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        self.setNeedsStatusBarAppearanceUpdate()
        self.navigationController!.toolbarHidden = true
    }
}