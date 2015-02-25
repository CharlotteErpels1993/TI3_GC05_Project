/*import Foundation
import UIKit
import QuartzCore

class InschrijvenVakantie1ViewController : UITableViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var aantalDagenEnNachten: UILabel!
    @IBOutlet weak var pickerView: UIPickerView!
    
    var vakantie: Vakantie!
    var inschrijvingVakantie: InschrijvingVakantie! = InschrijvingVakantie(id: "test")
    var pickerData: [String] = []
    
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
        self.setNeedsStatusBarAppearanceUpdate()
        self.navigationController!.toolbarHidden = true
        controleerInternet()
        LocalDatastore.getTableReady(Constanten.TABLE_INSCHRIJVINGVAKANTIE)
        LocalDatastore.getTableReady(Constanten.TABLE_DEELNEMER)
        
        pickerView.delegate = self
        pickerView.dataSource = self
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
            var alert = UIAlertController(title: "Oeps.. U heeft geen internet", message: "U heeft internet nodig voor u te registeren. Ga naar instellingen om dit aan te passen.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ga terug naar vakanties", style: UIAlertActionStyle.Default, handler: { action in
                switch action.style {
                default:
                    let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    var destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("Vakanties") as UIViewController
                    self.sideMenuController()?.setContentViewController(destViewController)
                    self.hideSideMenuView()
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
        inschrijvingVakantie.periode = pickerData[row]
        berekenAantalDagen(pickerData[row])
        //self.periode = pickerData[row]
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "volgende" {
            let inschrijvenVakantie2ViewController = segue.destinationViewController as InschrijvenVakantie2ViewController
            
            if inschrijvingVakantie.periode == nil {
                inschrijvingVakantie.periode = pickerData[0]
            }
            
            inschrijvingVakantie.vakantie = self.vakantie
            inschrijvenVakantie2ViewController.inschrijvingVakantie = inschrijvingVakantie
        }
    }
    
    func berekenAantalDagen(datum: String) {
        var datumArray = split(datum, {$0=="-"}, allowEmptySlices: true)
        var vertrekdatum: String = datumArray[0]
        var terugkeerdatum: String = datumArray[1]
        
        
        
    }
}*/
