import UIKit

class GeefFeedback1ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    @IBOutlet var vakantiePickerView: UIPickerView!
    
    var vakanties: [Vakantie]  = []
    var vakantie: Vakantie!
    var feedback: Feedback?
    
    //
    //Naam: viewDidLoad
    //
    //Werking: - zorgt ervoor dat de side bar menu verborgen is
    //         - zorgt ervoor dat de tool bar niet aanwezig is
    //         - bekijkt of de gebruiker internet heeft, zoniet geeft hij een gepaste melding
    //         - haalt alle vakanties op
    //
    //Parameters:
    //
    //Return:
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        hideSideMenuView()
        self.setNeedsStatusBarAppearanceUpdate()
        self.navigationController!.toolbarHidden = true
        
        controleerInternet()
        var queryVakanties = Query(tableName: Constanten.TABLE_VAKANTIE)
        self.vakanties = queryVakanties.getObjects() as [Vakantie]
        //self.vakanties = LocalDatastore.getLocalObjects(Constanten.TABLE_VAKANTIE) as [Vakantie]
        
        vakantiePickerView.delegate = self
        vakantiePickerView.dataSource = self
        vakantiePickerView.reloadAllComponents()
    }
    
    //
    //Naam: viewDidAppear
    //
    //Werking: - zorgt ervoor dat bij het opnieuw laden van de view de tool bar verborgen is
    //
    //Parameters:
    //  - animated: Bool
    //
    //Return:
    //
    override func viewDidAppear(animated: Bool) {
        self.setNeedsStatusBarAppearanceUpdate()
        self.navigationController!.toolbarHidden = true
    }
    
    //
    //Naam: controleerInternet
    //
    //Werking: - bekijkt of de gebruiker internet heeft, zoniet geeft hij een gepaste melding
    //
    //Parameters:
    //
    //Return:
    //
    func controleerInternet() {
        if Reachability.isConnectedToNetwork() == false {
            var alert = UIAlertController(title: "Oeps.. U heeft geen internet", message: "U heeft internet nodig voor feedback toe te voegen. Ga naar instellingen om dit aan te passen.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ga terug naar Feedback", style: UIAlertActionStyle.Default, handler: { action in
                switch action.style {
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
        return vakanties.count
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
        return vakanties[row].titel
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
        self.vakantie = vakanties[row]
    }
    
    //
    //Naam: prepareForSegue
    //
    //Werking: - maakt de volgende view met opgegeven identifier (stelt soms attributen van de volgende view op)
    //
    //Parameters:
    //  - segue: UIStoryboardSegue
    //  - sender: AnyObject?
    //
    //Return:
    //
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "geefFeedback" {
            let geefFeedback2ViewController = segue.destinationViewController as GeefFeedback2ViewController
            
            if vakantie == nil {
                vakantie = self.vakanties[0]
            }
            
            geefFeedback2ViewController.vakantie = self.vakantie
            geefFeedback2ViewController.feedback = self.feedback
        } else if segue.identifier == "gaTerug" {
            let feedbackTableViewController = segue.destinationViewController as FeedbackTableViewController
        }
    }
}