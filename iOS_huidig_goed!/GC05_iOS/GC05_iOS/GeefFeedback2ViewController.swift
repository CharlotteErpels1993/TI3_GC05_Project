import UIKit

class GeefFeedback2ViewController: UITableViewController {
    @IBOutlet var txtFeedback: UITextView!
    @IBOutlet weak var ster1: UIButton!
    @IBOutlet weak var ster2: UIButton!
    @IBOutlet weak var ster3: UIButton!
    @IBOutlet weak var ster4: UIButton!
    @IBOutlet weak var ster5: UIButton!
    
    var score: Int = 0
    var feedback: Feedback!
    var vakantie: Vakantie!
    var titel: String?
    var legeSter: UIImage = UIImage(named: "star2")!
    var volleSter: UIImage = UIImage(named: "star")!
    var statusTextFields: [String: String] = [:]
    var redColor: UIColor = UIColor.redColor()
    
    //
    //Naam: viewDidLoad
    //
    //Werking: - zorgt ervoor dat de side bar menu verborgen is
    //         - zorgt ervoor dat de tool bar niet aanwezig is
    //         - bekijkt of de gebruiker internet heeft, zoniet geeft hij een gepaste melding
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
        self.navigationItem.title = self.titel
        controleerInternet()
        giveUITextViewDefaultBorder(txtFeedback)
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
    //Naam: klikopSter1
    //
    //Werking: - stelt de score in op 1 (drukt op 1ste ster)
    //         - stelt de juiste images in bij veranderen
    //
    //Parameters:
    //
    //Return:
    //
    @IBAction func klikopSter1(sender: AnyObject) {
        ster1.setImage(volleSter, forState: UIControlState.Normal)
        ster2.setImage(legeSter, forState: UIControlState.Normal)
        ster3.setImage(legeSter, forState: UIControlState.Normal)
        ster4.setImage(legeSter, forState: UIControlState.Normal)
        ster5.setImage(legeSter, forState: UIControlState.Normal)
        self.score = 1
    }
    
    //
    //Naam: klikopSter2
    //
    //Werking: - stelt de score in op 2 (drukt op 2e ster)
    //         - stelt de juiste images in bij veranderen
    //
    //Parameters:
    //
    //Return:
    //
    @IBAction func klikopSter2(sender: AnyObject) {
        ster1.setImage(volleSter, forState: UIControlState.Normal)
        ster2.setImage(volleSter, forState: UIControlState.Normal)
        ster3.setImage(legeSter, forState: UIControlState.Normal)
        ster4.setImage(legeSter, forState: UIControlState.Normal)
        ster5.setImage(legeSter, forState: UIControlState.Normal)
        self.score = 2
    }
    
    //
    //Naam: klikopSter3
    //
    //Werking: - stelt de score in op 3 (drukt op 3e ster)
    //         - stelt de juiste images in bij veranderen
    //
    //Parameters:
    //
    //Return:
    //
    @IBAction func klikopSter3(sender: AnyObject) {
        ster1.setImage(volleSter, forState: UIControlState.Normal)
        ster2.setImage(volleSter, forState: UIControlState.Normal)
        ster3.setImage(volleSter, forState: UIControlState.Normal)
        ster4.setImage(legeSter, forState: UIControlState.Normal)
        ster5.setImage(legeSter, forState: UIControlState.Normal)
        self.score = 3
    }
    
    //
    //Naam: klikopSter4
    //
    //Werking: - stelt de score in op 4 (drukt op 4e ster)
    //         - stelt de juiste images in bij veranderen
    //
    //Parameters:
    //
    //Return:
    //
    @IBAction func klikopSter4(sender: AnyObject) {
        ster1.setImage(volleSter, forState: UIControlState.Normal)
        ster2.setImage(volleSter, forState: UIControlState.Normal)
        ster3.setImage(volleSter, forState: UIControlState.Normal)
        ster4.setImage(volleSter, forState: UIControlState.Normal)
        ster5.setImage(legeSter, forState: UIControlState.Normal)
        self.score = 4
    }
    
    //
    //Naam: klikopSter5
    //
    //Werking: - stelt de score in op 5 (drukt op 5e ster)
    //         - stelt de juiste images in bij veranderen
    //
    //Parameters:
    //
    //Return:
    //
    @IBAction func klikopSter5(sender: AnyObject) {
        ster1.setImage(volleSter, forState: UIControlState.Normal)
        ster2.setImage(volleSter, forState: UIControlState.Normal)
        ster3.setImage(volleSter, forState: UIControlState.Normal)
        ster4.setImage(volleSter, forState: UIControlState.Normal)
        ster5.setImage(volleSter, forState: UIControlState.Normal)
        self.score = 5
    }
    
    //
    //Naam: numbersOfSectionsInTableView
    //
    //Werking: - zorgt dat het aantal sections zich aanpast naargelang er een section wordt verwijderd
    //
    //Parameters:
    //  - tableView: UITableView
    //
    //Return: een int met de hoeveelheid sections
    //
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    //
    //Naam: tableView
    //
    //Werking: - zorgt dat het aantal rijen in een section aangepast wordt naargelang er een section wordt verwijderd
    //
    //Parameters:
    //  - tableView: UITableView
    //  - numbersOfRowsInSection section: Int
    //
    //Return: een int met de hoeveelheid rijen per section
    //
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    //
    //Naam: prepareForSegue
    //
    //Werking: - maakt de volgende view met opgegeven identifier (stelt soms attributen van de volgende view op)
    //         - controleert ook eerste de ingevulde velden op geldigheid, zonee wordt er een foutmelding gegeven
    //
    //Parameters:
    //  - segue: UIStoryboardSegue
    //  - sender: AnyObject?
    //
    //Return:
    //
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "indienen" {
            let geefFeedbackSuccesvolViewController = segue.destinationViewController as GeefFeedbackSuccesvolViewController
            feedback = Feedback(id: "test")
        
            setStatusTextFields()
            pasLayoutVeldenAan()
        
            if self.score == 0 {
                foutBoxOproepen("Fout", "Gelieve een geldige score te geven! (1 t.e.m. 5)", self)
                self.viewDidLoad()
            } else {
                if controleerRodeBordersAanwezig() == true {
                    foutBoxOproepen("Fout", "Gelieve het veld feedback in te vullen!", self)
                    self.viewDidLoad()
                } else {
                    
                    var bestaatOuder = LocalDatastore.bestaatLocalObjectWithConstraints(Constanten.TABLE_OUDER, soortConstraints: [Constanten.COLUMN_EMAIL: Constanten.CONSTRAINT_EQUALTO], equalToConstraints: [Constanten.COLUMN_EMAIL: PFUser.currentUser().email])
                    
                    if bestaatOuder == true {
                        var ouder = LocalDatastore.getLocalObjectWithColumnConstraints(Constanten.TABLE_OUDER, soortConstraints: [Constanten.COLUMN_EMAIL: Constanten.CONSTRAINT_EQUALTO], equalToConstraints: [Constanten.COLUMN_EMAIL: PFUser.currentUser().email]) as Gebruiker
                        feedback.gebruiker = ouder
                    } else {
                        var monitor = LocalDatastore.getLocalObjectWithColumnConstraints(Constanten.TABLE_MONITOR, soortConstraints: [Constanten.COLUMN_EMAIL: Constanten.CONSTRAINT_EQUALTO], equalToConstraints: [Constanten.COLUMN_EMAIL: PFUser.currentUser().email]) as Gebruiker
                        feedback.gebruiker = monitor
                    }
                    
                    feedback.datum = NSDate()
                    feedback.vakantie = self.vakantie
                        feedback.score = self.score
                feedback.waardering = self.txtFeedback.text
                    feedback.goedgekeurd = false
                    geefFeedbackSuccesvolViewController.feedback = self.feedback
                    }
            }
        } else if segue.identifier == "gaTerug" {
            let vakantiesTableViewController = segue.destinationViewController as VakantiesTableViewController
        }
    }
    
    //
    //Naam: setStatusTextFields
    //
    //Werking: - zet de status van de text fields in
    //              * controleert of de velden leeg zijn
    //              * controleert of andere validatiemethoden geldig zijn
    //              * wanneer een text field ongeldig is krijgt deze de status "leeg" of "ongeldig"
    //
    //Parameters:
    //
    //Return:
    //
    func setStatusTextFields() {
        if txtFeedback.text.isEmpty {
            statusTextFields["feedback"] = "leeg"
        } else {
            statusTextFields["feedback"] = "ingevuld"
        }
    }
    
    //
    //Naam: pasLayoutVeldenAan
    //
    //Werking: - zorgt ervoor dat de text field, wanneer status "ongeldig" of "leeg" is, een rode border krijgt
    //         - als deze status niet "leeg" of "ongeldig" is wordt deze border terug op default gezet
    //
    //Parameters:
    //
    //Return:
    //
    func pasLayoutVeldenAan() {
        if statusTextFields["feedback"] == "leeg" {
            giveUITextViewRedBorder(txtFeedback)
        } else {
            giveUITextViewDefaultBorder(txtFeedback)
        }
    }
    
    //
    //Naam: controleerRodeBordersAanwezig
    //
    //Werking: - bekijkt of de text field borders een rode border hebben
    //
    //Parameters:
    //
    //Return: een bool true als er een rode border aanwezig is, anders false
    //
    func controleerRodeBordersAanwezig() -> Bool {
        if CGColorEqualToColor(txtFeedback.layer.borderColor, redColor.CGColor) {
            return true
        } else {
            return false
        }
    }
}