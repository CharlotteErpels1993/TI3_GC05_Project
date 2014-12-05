import Foundation
import UIKit
import QuartzCore

class InschrijvenVakantie5ViewController : /*ResponsiveTextFieldViewController*/ UIViewController {
    
    var wilExtraInfo: Bool! = true
    var inschrijvingVakantie: InschrijvingVakantie!

    @IBOutlet weak var switchExtraInfo: UISwitch!
    
    
    @IBOutlet weak var txtViewExtraInfo: UITextView!
    
    @IBAction func switched(sender: UISwitch) {
        if sender.on {
            wilExtraInfo = true
            giveUITextViewDefaultBorder(txtViewExtraInfo)
            txtViewExtraInfo.hidden = false
        } else {
            wilExtraInfo = false
            giveUITextViewDefaultBorder(txtViewExtraInfo)
            txtViewExtraInfo.hidden = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        giveUITextViewDefaultBorder(txtViewExtraInfo)
    }
    @IBAction func annuleer(sender: AnyObject) {
        annuleerControllerInschrijvenVakantieVorming(self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "volgende" {
            let inschrijvenVakantieSuccesvolViewController = segue.destinationViewController as InschrijvenVakantieSuccesvolViewController
    
            if wilExtraInfo == true {
                if txtViewExtraInfo.text.isEmpty {
                    giveUITextViewRedBorder(txtViewExtraInfo)
                    foutBoxOproepen("Fout", "Gelieve het veld in te vullen!", self)
                } else {
                    inschrijvingVakantie.extraInfo = txtViewExtraInfo.text
                }
            } else {
                inschrijvingVakantie.extraInfo = ""
            }
            inschrijvenVakantieSuccesvolViewController.inschrijvingVakantie = inschrijvingVakantie
        } else if segue.identifier == "gaTerug" {
            let vakantiesTableViewController = segue.destinationViewController as VakantiesTableViewController
        }
    }
}