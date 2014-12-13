import UIKit

class GeefFeedback1ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    @IBOutlet var vakantiePickerView: UIPickerView!
    
    var vakanties: [Vakantie]  = []
    var vakantie: Vakantie!
    var feedback: Feedback?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideSideMenuView()
        self.setNeedsStatusBarAppearanceUpdate()
        self.navigationController!.toolbarHidden = true
        
        var vakantiesResponse = ParseData.getAlleVakanties()
        if vakantiesResponse.1 == nil {
            self.vakanties = vakantiesResponse.0
        }
        
        vakantiePickerView.delegate = self
        vakantiePickerView.dataSource = self
        vakantiePickerView.reloadAllComponents()
    }
    
    override func viewDidAppear(animated: Bool) {
        self.setNeedsStatusBarAppearanceUpdate()
        self.navigationController!.toolbarHidden = true
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return vakanties.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return vakanties[row].titel
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.vakantie = vakanties[row]
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "geefFeedback" {
            let geefFeedback2ViewController = segue.destinationViewController as GeefFeedback2ViewController
            
            if vakantie == nil {
                vakantie = self.vakanties[0]
            }
            
            geefFeedback2ViewController.vakantie = self.vakantie
            geefFeedback2ViewController.feedback = self.feedback
        }
    }
}