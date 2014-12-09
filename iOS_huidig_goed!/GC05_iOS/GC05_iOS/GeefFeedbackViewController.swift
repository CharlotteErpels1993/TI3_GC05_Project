import UIKit

class GeefFeedbackViewController: UITableViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet var scorePickerView: UIPickerView!
    @IBOutlet var txtFeedback: UITextView!
    
    var scores: [Int] = [1, 2, 3, 4, 5]
    var score: Int?
    var feedback: Feedback!
    var vakantie: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideSideMenuView()
        
        scorePickerView.delegate = self
        scorePickerView.dataSource = self
        scorePickerView.reloadAllComponents()
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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let geefFeedbackSuccesvolViewController = segue.destinationViewController as GeefFeedbackSuccesvolViewController
        var gebruiker = PFUser.currentUser()
        feedback.datum = NSDate()
        //feedback.gebruiker = gebruiker as PFUser
        feedback.vakantie!.id = self.vakantie
        if self.score == nil {
            self.score = scores[0]
        }
        feedback.score = self.score
        feedback.waardering = self.txtFeedback.text
        geefFeedbackSuccesvolViewController.feedback = self.feedback
    }
}