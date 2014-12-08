import UIKit

class GeefFeedbackViewController: UITableViewController {
    
    @IBOutlet var scorePickerView: UIPickerView!
    @IBOutlet var txtFeedback: UITextView!
    
    var scores: [Int] = [1, 2, 3, 4, 5]
    var score: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return scores.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return String(scores[row])
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.score = scores[row]
    }
}