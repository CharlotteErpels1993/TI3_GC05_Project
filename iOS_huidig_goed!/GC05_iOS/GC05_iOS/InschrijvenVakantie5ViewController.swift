import Foundation
import UIKit
import QuartzCore

class InschrijvenVakantie5ViewController : ResponsiveTextFieldViewController {
    var wilExtraInfo: Bool! = true
    var inschrijvingVakantie: InschrijvingVakantie!
    //var contactpersoon1: ContactpersoonNood!
    //var contactpersoon2: ContactpersoonNood?
    
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
        //inschrijvenVakantieSuccesvolViewController.contactpersoon1 = contactpersoon1
        
        /*if contactpersoon2 != nil {
            //inschrijvenVakantieSuccesvolViewController.contactpersoon2 = contactpersoon2
        }*/
        } else if segue.identifier == "gaTerug" {
            let vakantiesTableViewController = segue.destinationViewController as VakantiesTableViewController
        }
    
    }
}

func giveUITextViewDefaultBorder(textView: UITextView) {
    var grayColor: UIColor = UIColor.grayColor()
    textView.layer.borderColor = grayColor.CGColor
    textView.layer.borderWidth = 1.0
    textView.layer.cornerRadius = 5.0
}

func giveUITextViewRedBorder(textView: UITextView) {
    var redColor: UIColor = UIColor.redColor()
    textView.layer.borderColor = redColor.CGColor
    textView.layer.borderWidth = 1.0
    textView.layer.cornerRadius = 5.0
}