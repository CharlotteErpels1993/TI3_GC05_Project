import UIKit

class IndienenVoorkeurViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate{
    
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var periodeLabel: UILabel!
    
    var vakanties: [Vakantie] = []
    var pickerData: [String] = []
    var voorkeur: Voorkeur = Voorkeur(id: "test")
    var vertrekdatumStr: String? = ""
    var terugkeerdatumStr: String? = ""
    
    @IBAction func gaTerugNaarOverzicht(sender: AnyObject) {
        annuleerControllerVoorkeur(self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        ParseData.deleteVoorkeurTable()
        ParseData.vulVoorkeurTableOp()
        
        hideSideMenuView()
        
        var vakantiesResponse = ParseData.getAlleVakanties()
        
        if vakantiesResponse.1 == nil {
            self.vakanties = vakantiesResponse.0
        }
        
        for vakantie in vakanties {
            pickerData.append(vakantie.titel!)
        }
        
        var vakantie = self.vakanties[0]
        vertrekdatumStr = vakantie.vertrekdatum.toS("dd/MM/yyyy")
        terugkeerdatumStr = vakantie.terugkeerdatum.toS("dd/MM/yyyy")
        periodeLabel.text = ("\(vertrekdatumStr!) - \(terugkeerdatumStr!)")
        
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.reloadAllComponents()
        
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
                let destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("Profiel") as UIViewController
                self.sideMenuController()?.setContentViewController(destViewController)
                self.hideSideMenuView()
            })
            alertController.addAction(okAction)
            self.presentViewController(alertController, animated: true, completion: nil)
            
        } else {
            indienenVoorkeurSuccesvolViewController.voorkeur = self.voorkeur
        }

    }
    
    func controleerAlIngeschreven() -> Bool {
        var voorkeuren: [Voorkeur] = []
        var voorkeurenResponse = ParseData.getVoorkeurenVakantie(self.voorkeur)
        
        if voorkeurenResponse == nil {
            return true
        }
        return false
    }
}