import UIKit

class InschrijvenVormingViewController: UIViewController {
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    var monitor: Monitor!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "inschrijven" {
            let inschrijvenVormingSuccesvolViewController = segue.destinationViewController as InschrijvenVormingSuccesvolViewController
            inschrijvenVormingSuccesvolViewController.monitor = self.monitor
        }
    }
}