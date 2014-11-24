import UIKit

class InschrijvenVormingViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    var pickerData: [String] = []
    var vorming: Vorming!
    var inschrijvingVorming: InschrijvingVorming = InschrijvingVorming(id: "test")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.delegate = self
        pickerView.dataSource = self
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return pickerData[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        inschrijvingVorming.periode = pickerData[row]
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "inschrijven" {
            let inschrijvenVormingSuccesvolViewController = segue.destinationViewController as InschrijvenVormingSuccesvolViewController
            
            var query = PFQuery(className: "Monitor")
            query.whereKey("email", containsString: PFUser.currentUser().email)
            var monitorPF = query.getFirstObject()
            var monitor = Monitor(monitor: monitorPF)
            
            if inschrijvingVorming.periode == nil {
                inschrijvingVorming.periode = pickerData[0]
            }
            
            inschrijvingVorming.monitor = monitor
            inschrijvingVorming.vorming = self.vorming
            
            inschrijvenVormingSuccesvolViewController.inschrijvingVorming = self.inschrijvingVorming
        } else if segue.identifier == "gaTerug" {
            let vormingenTableViewController = segue.destinationViewController as VormingenTableViewController
        }
    }
}