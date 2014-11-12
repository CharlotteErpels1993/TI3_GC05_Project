import Foundation
import UIKit
import QuartzCore

class InschrijvenVakantie5ViewController : UIViewController {
    var wilExtraInfo: Bool! = true
    var deelnemer: Deelnemer!
    var contactpersoon1: ContactpersoonNood!
    var contactpersoon2: ContactpersoonNood?
    var ouder: Ouder!
    
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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let inschrijvenVakantieSuccesvolViewController = segue.destinationViewController as InschrijvenVakantieSuccesvolViewController
    
        if wilExtraInfo == true {
            if txtViewExtraInfo.text.isEmpty {
                giveUITextViewRedBorder(txtViewExtraInfo)
                foutBoxOproepen("Fout", "Gelieve het veld in te vullen!", self)
            } else {
                deelnemer.inschrijvingVakantie?.extraInfo = txtViewExtraInfo.text
            }
        } else {
            deelnemer.inschrijvingVakantie?.extraInfo = ""
        }
        inschrijvenVakantieSuccesvolViewController.deelnemer = deelnemer
        inschrijvenVakantieSuccesvolViewController.contactpersoon1 = contactpersoon1
        inschrijvenVakantieSuccesvolViewController.ouder = ouder
        
        if contactpersoon2 != nil {
            inschrijvenVakantieSuccesvolViewController.contactpersoon2 = contactpersoon2
        }
    
    }
    
    func giveUITextViewDefaultBorder(textView: UITextView) {
        //var defaultBorderColor: UIColor = UIColor(red: 182.0, green: 182.0, blue: 182.0, alpha: 0)
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
    
}