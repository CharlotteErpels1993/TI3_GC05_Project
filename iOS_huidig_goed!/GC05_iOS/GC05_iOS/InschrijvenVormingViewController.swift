import UIKit

class InschrijvenVormingViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    var pickerData: [String] = []
    var vorming: Vorming!
    var inschrijvingVorming: InschrijvingVorming = InschrijvingVorming(id: "test")
    var vormingenId: [String] = []
    var periodesId: [String] = []
    var periode: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getAlleVormingen()
        
        pickerView.delegate = self
        pickerView.dataSource = self
    }
    @IBAction func annuleer(sender: AnyObject) {
        annuleerControllerInschrijvenVakantieVorming(self)
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
        self.periode = pickerData[row]
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        controleerOfMonitorDezeVormingAlIngeschrevenIs()
        
        if segue.identifier == "inschrijven" {
            let inschrijvenVormingSuccesvolViewController = segue.destinationViewController as InschrijvenVormingSuccesvolViewController
            
            var monitor = ParseData.getMonitorWithEmail(PFUser.currentUser().email)
            
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
    
    func getAlleVormingen() {
        var monitor: Monitor = ParseData.getMonitorWithEmail(PFUser.currentUser().email)

        var query = PFQuery(className: "InschrijvingVorming")
        query.whereKey("monitor", equalTo: monitor.id)
        query.findObjectsInBackgroundWithBlock({(NSArray objects, NSError error) in
            if error == nil {
                for object in objects {
                    let vormingId = object["vorming"] as String
                    self.vormingenId.append(vormingId)
                    let periodeId = object["periode"] as String
                    self.periodesId.append(periodeId)
                }
            }
        })
    }
    
    func controleerOfMonitorDezeVormingAlIngeschrevenIs() {
        for vorming in self.vormingenId {
            if self.vorming.id == vorming {
                 controleerOfMonitorDezeVormingAlIngeschrevenIsPeriodes()
            }
        }
        
    }
    
    func controleerOfMonitorDezeVormingAlIngeschrevenIsPeriodes() {
        for periode in periodesId {
            if self.inschrijvingVorming.periode == periode {
                let alertController = UIAlertController(title: "Fout", message: "Je hebt je al ingeschreven voor deze vorming", preferredStyle: .Alert)
                let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: {
                    action in
                    let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("Vormingen") as UIViewController
                    self.sideMenuController()?.setContentViewController(destViewController)
                    self.hideSideMenuView()
                })
                alertController.addAction(okAction)
                self.presentViewController(alertController, animated: true, completion: nil)
            }
        }
    }
    
}