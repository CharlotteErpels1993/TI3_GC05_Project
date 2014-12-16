import UIKit

class InschrijvenVormingViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    var pickerData: [String] = []
    var vorming: Vorming!
    var inschrijvingVorming: InschrijvingVorming = InschrijvingVorming(id: "test")
    var vormingenId: [String] = []
    var periodesId: [String] = []
    var periode: String!
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    //
    //Naam: annuleer
    //
    //Werking: - zorgt ervoor wanneer de gebruiker op annuleer drukt, er een melding komt of de gebruiker zeker is van zijn beslissing
    //
    //Parameters:
    //  - sender: AnyObject
    //
    //Return:
    //
    @IBAction func annuleer(sender: AnyObject) {
        annuleerControllerInschrijvenVakantieVorming(self)
    }
    
    //
    //Naam: viewDidLoad
    //
    //Werking: - haalt alle vormingen op
    //         - bekijkt of de gebruiker internet heeft, zoniet geeft hij een gepaste melding
    //
    //Parameters:
    //
    //Return:
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if Reachability.isConnectedToNetwork() == false {
            var alert = UIAlertController(title: "Oeps.. U heeft geen internet", message: "U heeft internet nodig voor u in te schrijven. Ga naar instellingen om dit aan te passen.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ga terug", style: .Default, handler: { action in
                switch action.style{
                default:
                    self.performSegueWithIdentifier("gaTerug", sender: self)
                }
                
            }))
            alert.addAction(UIAlertAction(title: "Ga naar instellingen", style: .Default, handler: { action in
                switch action.style{
                default:
                    UIApplication.sharedApplication().openURL(NSURL(string:UIApplicationOpenSettingsURLString)!);
                }
                
            }))
            presentViewController(alert, animated: true, completion: nil)
        }
        
        //ParseData.getAlleVormingen()
        
        pickerView.delegate = self
        pickerView.dataSource = self
    }
    
    //
    //Naam: numberOfComponentsInPickerView
    //
    //Werking: - zorgt ervoor dat het aantal componenten is ingevuld in de pickerView
    //
    //Parameters:
    //  - pickerView: UIPickerView
    //
    //Return: het aantal componenten in de pickerView
    //
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    //
    //Naam: pickerView
    //
    //Werking: - zorgt ervoor dat het aantal rijen in een component is ingevuld in de pickerView
    //
    //Parameters:
    //  - pickerView: UIPickerView
    //  - numberOfRowsInComponent component: Int
    //
    //Return: het aantal rijen in een component in de pickerView
    //
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    //
    //Naam: pickerView
    //
    //Werking: - zorgt ervoor dat de titel van de vorming per component in de pickerView wordt ingevuld
    //
    //Parameters:
    //  - pickerView: UIPickerView
    //  - titleForRow row: Int
    //  - forComponent component: Int
    //
    //Return: de titel van de vorming per component
    //
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return pickerData[row]
    }
    
    //
    //Naam: pickerView
    //
    //Werking: - geeft aan welke vorming de gebruiker gekozen heeft
    //
    //Parameters:
    //  - pickerView: UIPickerView
    //  - didSelectRow row: Int
    //  - inComponent component: Int
    //
    //Return:
    //
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        inschrijvingVorming.periode = pickerData[row]
        self.periode = pickerData[row]
    }
    
    //
    //Naam: prepareForSegue
    //
    //Werking: - maakt de volgende view met opgegeven identifier (stelt soms attributen van de volgende view op)
    //         - controleert ook eerste de ingevulde velden op geldigheid, zonee wordt er een foutmelding gegeven
    //         - controleert ook of de gebruiker al ingeschreven is op de gekozen vorming met dezelfde periode
    //
    //Parameters:
    //  - segue: UIStoryboardSegue
    //  - sender: AnyObject?
    //
    //Return:
    //
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "inschrijven" {
            let inschrijvenVormingSuccesvolViewController = segue.destinationViewController as InschrijvenVormingSuccesvolViewController

            //ParseData.deleteInschrijvingVormingTable()
            //ParseData.vulInschrijvingVormingTableOp()
            
            /*var monitorResponse = ParseData.getMonitorWithEmail(PFUser.currentUser().email)
            if monitorResponse.1 == nil {
                inschrijvingVorming.monitor = monitorResponse.0
            }*/
            inschrijvingVorming.monitor = LocalDatastore.getMonitorWithEmail(PFUser.currentUser().email)
            
            inschrijvingVorming.vorming = vorming
            
            if inschrijvingVorming.periode == nil {
                inschrijvingVorming.periode = pickerData[0]
            }
            
            if controleerAlIngeschreven() == true {
                
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
                
            } else {
                inschrijvenVormingSuccesvolViewController.inschrijvingVorming = self.inschrijvingVorming
            }
            
        } else if segue.identifier == "gaTerug" {
            let vormingenTableViewController = segue.destinationViewController as VormingenTableViewController
        }
    }
    
    
    //
    //Naam: controleerAlIngeschreven
    //
    //Werking: - bekijkt in de databank of de monitor al ingeschreven is voor deze vorming met dezelfde periode
    //
    //Parameters:
    //
    //Return: een bool true als de monitor al ingeschreven is, anders false
    //
    func controleerAlIngeschreven() -> Bool {
        var inschrijvingen: [InschrijvingVorming] = []
        inschrijvingen = ParseData.getInschrijvingenVorming(inschrijvingVorming)
        if inschrijvingen.count > 0 {
            return true

        }
        return false
    }
}