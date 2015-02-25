import UIKit

class ExtraTekstViewController: UIViewController {
    @IBOutlet var naamLabel: UILabel?
    @IBOutlet var tekstView: UITextView?
    
    var type: Int! = 0
    var tekst: String = ""
    var naam: String = ""
    
    //
    //Naam: viewDidLoad
    //
    //Werking: - zorgt ervoor dat de tekst view opgevuld wordt met de juiste tekst
    //         - zorgt ervoor dat elke titel wordt veranderd naargelang de segue
    //
    //Parameters:
    //
    //Return:
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tekstView?.text = tekst
        
        switch type {
        case 1:
            self.navigationItem.title = "Korte beschrijving"
            self.naamLabel!.hidden = false
            self.naamLabel?.text = self.naam
            break
        case 2:
            self.navigationItem.title = "Inbegrepen prijs"
            self.naamLabel!.hidden = true
            break
        case 3:
            self.navigationItem.title = "Criteria"
            self.naamLabel!.hidden = true
            break
        case 4:
            self.navigationItem.title = "Betalingswijze"
            self.naamLabel!.hidden = true
            break
        case 5:
            self.navigationItem.title = "Tips"
            self.naamLabel!.hidden = true
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