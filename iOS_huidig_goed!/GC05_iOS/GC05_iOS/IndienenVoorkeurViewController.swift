import UIKit

class IndienenVoorkeurViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate{
    
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var periodeLabel: UILabel!
    
    var vakanties: [Vakantie] = []
    var pickerData: [String] = []
    var voorkeur: Voorkeur = Voorkeur(id: "test")
    var vertrekdatumStr: String? = ""
    var terugkeerdatumStr: String? = ""
    
    //
    //Naam: gaTerugNaarOverzicht
    //
    //Werking: - zorgt voor een unwind segue
    //         - geeft ook een melding bij het verlaten van het scherm (of de gebruiker dit effectief wilt)
    //
    //Parameters:
    //  - sender: AnyObject
    //
    //Return:
    //
    @IBAction func gaTerugNaarOverzicht(sender: AnyObject) {
        annuleerControllerVoorkeur(self)
    }

    //
    //Naam: viewDidLoad
    //
    //Werking: - zorgt ervoor dat de side bar menu verborgen is
    //         - laadt de voorkeur tabel in
    //         - bekijkt of de gebruiker internet heeft, zoniet geeft hij een gepaste melding
    //         - maak de pickerView al klaar
    //
    //Parameters:
    //
    //Return:
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        controleerInternet()
        
        LocalDatastore.getTableReady(Constanten.TABLE_VOORKEUR)
        
        hideSideMenuView()
        
        //var vakantiesResponse = ParseData.getAlleVakanties()
        var vakanties = LocalDatastore.getLocalObjects(Constanten.TABLE_VAKANTIE) as [Vakantie]
        
        for v in vakanties {
            pickerData.append(v.titel!)
        }
        
        //var vakantie = self.vakanties.first!
        var vakantie = vakanties[0]
        vertrekdatumStr = vakantie.vertrekdatum.toS("dd/MM/yyyy")
        terugkeerdatumStr = vakantie.terugkeerdatum.toS("dd/MM/yyyy")
        periodeLabel.text = ("\(vertrekdatumStr!) - \(terugkeerdatumStr!)")
        
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.reloadAllComponents()
        
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
            var alert = UIAlertController(title: "Oeps.. U heeft geen internet", message: "U heeft internet nodig om uw voorkeur in te dienen. Ga naar instellingen om dit aan te passen.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ga terug naar vormingen", style: UIAlertActionStyle.Default, handler: { action in
                switch action.style {
                default:
                    let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    var destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("Vormingen") as UIViewController
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
    //Werking: - zorgt ervoor dat de titel van de vakantie per component in de pickerView wordt ingevuld
    //
    //Parameters:
    //  - pickerView: UIPickerView
    //  - titleForRow row: Int
    //  - forComponent component: Int
    //
    //Return: de titel van de vakantie per component
    //
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return pickerData[row]
    }
    
    //
    //Naam: pickerView
    //
    //Werking: - geeft aan welke vakantie de gebruiker gekozen heeft
    //
    //Parameters:
    //  - pickerView: UIPickerView
    //  - didSelectRow row: Int
    //  - inComponent component: Int
    //
    //Return:
    //
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        var vakantieNaam = pickerData[row]
        
        var vakantie: Vakantie = Vakantie(id: "test")
        
        for v in vakanties {
            if v.titel == vakantieNaam {
                vakantie = v
            }
        }
        
        voorkeur.vakantie = vakantie
        
        self.vertrekdatumStr = voorkeur.vakantie!.vertrekdatum.toS("dd/MM/yyyy")
        self.terugkeerdatumStr = voorkeur.vakantie!.terugkeerdatum.toS("dd/MM/yyyy")
        
        if voorkeur.vakantie == nil {
            var vakantie = vakanties[0]
            vertrekdatumStr = vakantie.vertrekdatum.toS("dd/MM/yyyy")
            terugkeerdatumStr = vakantie.terugkeerdatum.toS("dd/MM/yyyy")
        }
        
        periodeLabel.text = ("\(vertrekdatumStr!) - \(terugkeerdatumStr!)")
    }
    
    //
    //Naam: prepareForSegue
    //
    //Werking: - maakt de volgende view met opgegeven identifier (stelt soms attributen van de volgende view op)
    //         - controleert ook eerste de ingevulde velden op geldigheid, zonee wordt er een foutmelding gegeven
    //         - controleert of de gebruiker al een voorkeur heeft ingediend voor dezelfde vakantie
    //
    //Parameters:
    //  - segue: UIStoryboardSegue
    //  - sender: AnyObject?
    //
    //Return:
    //
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let indienenVoorkeurSuccesvolViewController = segue.destinationViewController as IndienenVoorkeurSuccesvolViewController
            var monitorResponse = ParseData.getMonitorWithEmail(PFUser.currentUser().email)
            var monitor: Monitor = Monitor(id: "test")
            if monitorResponse.1 == nil {
                monitor = monitorResponse.0
            }
        
            self.voorkeur.monitor = monitor
            
            if self.voorkeur.vakantie == nil {
                self.voorkeur.vakantie = vakanties[0]
            }
        
        if controleerAlIngeschreven() == true {
            
            let alertController = UIAlertController(title: "Fout", message: "Je hebt je voorkeur al opgegeven voor deze vakantie", preferredStyle: .Alert)
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
            indienenVoorkeurSuccesvolViewController.voorkeur = self.voorkeur
        }

    }
    
    //
    //Naam: controleerAlIngeschreven
    //
    //Werking: - bekijkt in de databank of er al een monitor een voorkeur heeft ingediend voor een bepaalde vakantie
    //
    //Parameters:
    //
    //Return: een bool true als de monitor al een voorkeur heeft ingediend voor een bepaalde vakantie
    //
    func controleerAlIngeschreven() -> Bool {
        
        return LocalDatastore.bestaatVoorkeurAl(voorkeur)
        
        /*var voorkeuren: [Voorkeur] = []
        var voorkeurenResponse = ParseData.getVoorkeurenVakantie(self.voorkeur)
        
        if voorkeurenResponse == nil {
            return true
        }
        return false*/
    }
}