import UIKit

class GeefFeedback2ViewController: UITableViewController/*, UIPickerViewDataSource, UIPickerViewDelegate*/ {
    
   // @IBOutlet var scorePickerView: UIPickerView!
    @IBOutlet var txtFeedback: UITextView!
    @IBOutlet weak var ster1: UIButton!
    @IBOutlet weak var ster2: UIButton!
    @IBOutlet weak var ster3: UIButton!
    @IBOutlet weak var ster4: UIButton!
    @IBOutlet weak var ster5: UIButton!
    
    //var scores: [Int] = [1, 2, 3, 4, 5]
    var score: Int = 0
    var feedback: Feedback!
    var vakantie: Vakantie!
    var titel: String?
    var legeSter: UIImage = UIImage(named: "star2")!
    var volleSter: UIImage = UIImage(named: "star")!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideSideMenuView()
        self.setNeedsStatusBarAppearanceUpdate()
        self.navigationController!.toolbarHidden = true
        
        self.navigationItem.title = self.titel
        
        var grayColor: UIColor = UIColor.grayColor()
        txtFeedback.layer.borderColor = grayColor.CGColor
        txtFeedback.layer.borderWidth = 1.0
        txtFeedback.layer.cornerRadius = 5.0
        
        //scorePickerView.delegate = self
        //scorePickerView.dataSource = self
        //scorePickerView.reloadAllComponents()
    }
    
    /*func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
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
    }*/
    
    @IBAction func klikopSter1(sender: AnyObject) {
        ster1.setImage(volleSter, forState: UIControlState.Normal)
        ster2.setImage(legeSter, forState: UIControlState.Normal)
        ster3.setImage(legeSter, forState: UIControlState.Normal)
        ster4.setImage(legeSter, forState: UIControlState.Normal)
        ster5.setImage(legeSter, forState: UIControlState.Normal)
        self.score = 1
    }
    
    @IBAction func klikopSter2(sender: AnyObject) {
        ster1.setImage(volleSter, forState: UIControlState.Normal)
        ster2.setImage(volleSter, forState: UIControlState.Normal)
        ster3.setImage(legeSter, forState: UIControlState.Normal)
        ster4.setImage(legeSter, forState: UIControlState.Normal)
        ster5.setImage(legeSter, forState: UIControlState.Normal)
        self.score = 2
    }
    
    @IBAction func klikopSter3(sender: AnyObject) {
        ster1.setImage(volleSter, forState: UIControlState.Normal)
        ster2.setImage(volleSter, forState: UIControlState.Normal)
        ster3.setImage(volleSter, forState: UIControlState.Normal)
        ster4.setImage(legeSter, forState: UIControlState.Normal)
        ster5.setImage(legeSter, forState: UIControlState.Normal)
        self.score = 3
    }
    
    
    @IBAction func klikopSter4(sender: AnyObject) {
        ster1.setImage(volleSter, forState: UIControlState.Normal)
        ster2.setImage(volleSter, forState: UIControlState.Normal)
        ster3.setImage(volleSter, forState: UIControlState.Normal)
        ster4.setImage(volleSter, forState: UIControlState.Normal)
        ster5.setImage(legeSter, forState: UIControlState.Normal)
        self.score = 4
    }
    
    @IBAction func klikopSter5(sender: AnyObject) {
        ster1.setImage(volleSter, forState: UIControlState.Normal)
        ster2.setImage(volleSter, forState: UIControlState.Normal)
        ster3.setImage(volleSter, forState: UIControlState.Normal)
        ster4.setImage(volleSter, forState: UIControlState.Normal)
        ster5.setImage(volleSter, forState: UIControlState.Normal)
        self.score = 5
    }
    
    
    
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let geefFeedbackSuccesvolViewController = segue.destinationViewController as GeefFeedbackSuccesvolViewController
        var gebruiker = getGebruiker(PFUser.currentUser().email)
        feedback = Feedback(id: "test")
        
        feedback.datum = NSDate()
        feedback.gebruiker = gebruiker
        feedback.vakantie = self.vakantie
        feedback.score = self.score
        feedback.waardering = self.txtFeedback.text
        feedback.goedgekeurd = false
        geefFeedbackSuccesvolViewController.feedback = self.feedback
    }
    
    func getGebruiker(email: String) -> Gebruiker {
        ParseData.deleteOuderTable()
        ParseData.vulOuderTableOp()
        var gebruiker: Gebruiker!
        
        var responseOuder = OuderSQL.getOuderWithEmail(email)
        
        if responseOuder.1 != nil {
            ParseData.deleteMonitorTable()
            ParseData.vulMonitorTableOp()
            var responseMonitor = MonitorSQL.getMonitorWithEmail(email)
            if responseMonitor.1 == nil {
                gebruiker = MonitorSQL.getGebruiker(responseMonitor.0)
            } else {
                println("ERROR: er is geen gebruiker met dit id teruggevonden in FeedbackSQL")
            }
        }
        else {
            gebruiker = OuderSQL.getGebruiker(responseOuder.0)
        }
        return gebruiker
    }
}