func checkPatternAansluitingsNr(aansluitingsNr: Int) -> Bool {
    var aansluitingsNrString: String = String(aansluitingsNr)
    
    if countElements(aansluitingsNrString) == 10 {
        return true
    }
    return false
}

func checkPatternCodeGerechtigde(codeGerechtigde: Int) -> Bool {
    var codeGerechtigdeString: String = String(codeGerechtigde)
    
    if countElements(codeGerechtigdeString) == 6 {
        return true
    }
    return false
}

func checkPatternNummer(nummer: Int) -> Bool {
    if nummer <= 0 {
        return false
    }
    return true
}

func checkPatternPostcode(postcode: Int) -> Bool {
    if postcode < 1000 || postcode > 9992 {
        return false
    }
    return true
}

func checkPatternGsm(gsm: String) -> Bool {
    if countElements(gsm) == 10 {
        return true
    }
    return false
}

func checkPatternTelefoon(telefoon: String) -> Bool {
    if countElements(telefoon) == 9 {
        return true
    }
    return false
}

func checkPatternRijksregisterNr(rijksregisterNr: String) -> Bool {
    var lengte: Int = countElements(rijksregisterNr)
    
    if lengte != 11 {
        return false
    }
    
    var rest: Int = 0
    var teControlerenGetal: Int = 0
    var teControlerenCijfers: String = ""
    var laatste2Str: String = rijksregisterNr.substringWithRange(Range<String.Index>(start: advance(rijksregisterNr.startIndex, 9), end: rijksregisterNr.endIndex))
    var eerste2Str: String = rijksregisterNr.substringWithRange(Range<String.Index>(start: rijksregisterNr.startIndex, end: advance(rijksregisterNr.endIndex, -9)))
    var laatste2Int: Int = laatste2Str.toInt()!
    var eerste2Int: Int = eerste2Str.toInt()!
    var rijksregisterNrArray = Array(rijksregisterNr)
    
    
    if eerste2Int < 14 {
        teControlerenCijfers = "2"
    }
    
    for (var i = 0; i <= (lengte-3); i++) {
        teControlerenCijfers.append(rijksregisterNrArray[i])
    }
    
    teControlerenGetal = teControlerenCijfers.toInt()!
    rest = teControlerenGetal % 97
    
    var controlGetal: Int = rest + laatste2Int
    
    if controlGetal < 97 {
        return false
    }
    
    return true
}

func foutBoxOproepen(title: String, message: String, controller: UIViewController) {
    var foutBox: FoutBox = FoutBox(title: title, message: message)
    var alert = foutBox.alert
    controller.presentViewController(alert, animated: true, completion: nil)
}

func foutBoxOproepen(foutBox: FoutBox, controller: UIViewController) {
    var alert = foutBox.alert
    controller.presentViewController(alert, animated: true, completion: nil)
}

func giveUITextFieldRedBorder(textField: UITextField) {
    var redColor: UIColor = UIColor.redColor()
    textField.layer.borderColor = redColor.CGColor
    textField.layer.borderWidth = 1.0
    textField.layer.cornerRadius = 5.0
}

func giveUITextFieldDefaultBorder(textField: UITextField) {
    var defaultBorderColor: UIColor = UIColor(red: 182.0, green: 182.0, blue: 182.0, alpha: 0)
    textField.layer.borderColor = defaultBorderColor.CGColor
    textField.layer.borderWidth = 1.0
    textField.layer.cornerRadius = 5.0
}

func controleerGeldigheidNummer(nummer: String) -> Bool {
    var enkelNummers: Bool = false
    
    for character in nummer {
        if character == "0" {
            enkelNummers = true
        } else if character == "1" {
            enkelNummers = true
        } else if character == "2" {
            enkelNummers = true
        } else if character == "3" {
            enkelNummers = true
        } else if character == "4" {
            enkelNummers = true
        } else if character == "5" {
            enkelNummers = true
        } else if character == "6" {
            enkelNummers = true
        } else if character == "7" {
            enkelNummers = true
        } else if character == "8" {
            enkelNummers = true
        } else if character == "9" {
            enkelNummers = true
        } else {
            return false
        }
    }
    return true
}

func wachtwoordenMatch(wachtwoord: String, herhaalWachtwoord: String) -> Bool {
    if wachtwoord == herhaalWachtwoord {
        return true
    } else {
        return false
    }
}

func checkPatternEmail(email: String) -> Bool {
    if countElements(email) == 0 {
        return false
    } else if Regex(p: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}").test(email) {
        return true
    }
    return false
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
   