//
//Naam: checkPatternAansltuingsNr
//
//Werking: - bekijkt of het aansluitingsnummer voldoet aan de validatie
//
//Parameters:
//  - aansluitingsNr: Int
//
//Return: een bool die true is als het aansluitinsgnummer voldoet aan de validatie, anders false
//
func checkPatternAansluitingsNr(aansluitingsNr: Int) -> Bool {
    var aansluitingsNrString: String = String(aansluitingsNr)
    
    if countElements(aansluitingsNrString) == 10 {
        return true
    }
    return false
}

//
//Naam: checkPatternCodeGerechtigde
//
//Werking: - bekijkt of de code gerechtigde voldoet aan de validatie
//
//Parameters:
//  - codeGerechtigde: Int
//
//Return: een bool die true is als de code gerechtigde voldoet aan de validatie, anders false
//
func checkPatternCodeGerechtigde(codeGerechtigde: Int) -> Bool {
    var codeGerechtigdeString: String = String(codeGerechtigde)
    
    if countElements(codeGerechtigdeString) == 6 {
        return true
    }
    return false
}

//
//Naam: checkPatternNummer
//
//Werking: - bekijkt of de nummer voldoet aan de validatie
//
//Parameters:
//  - nummer: Int
//
//Return: een bool die true is als de nummer voldoet aan de validatie, anders false
//
func checkPatternNummer(nummer: Int) -> Bool {
    if nummer <= 0 {
        return false
    }
    return true
}

//
//Naam: checkPatternCodePostcode
//
//Werking: - bekijkt of de postcode voldoet aan de validatie
//
//Parameters:
//  - postcode: Int
//
//Return: een bool die true is als de postcode voldoet aan de validatie, anders false
//
func checkPatternPostcode(postcode: Int) -> Bool {
    if postcode < 1000 || postcode > 9992 {
        return false
    }
    return true
}

//
//Naam: checkPatternGsm
//
//Werking: - bekijkt of de gsm voldoet aan de validatie
//
//Parameters:
//  - gsm: String
//
//Return: een bool die true is als de gsm voldoet aan de validatie, anders false
//
func checkPatternGsm(gsm: String) -> Bool {
    if countElements(gsm) == 10 {
        return true
    }
    return false
}

//
//Naam: checkPatternTelefoon
//
//Werking: - bekijkt of de telefoon voldoet aan de validatie
//
//Parameters:
//  - telefoon: String
//
//Return: een bool die true is als de telefoon voldoet aan de validatie, anders false
//
func checkPatternTelefoon(telefoon: String) -> Bool {
    if countElements(telefoon) == 9 {
        return true
    }
    return false
}

//
//Naam: checkPatternRijksregisterNr
//
//Werking: - bekijkt of het rijksregisternummer voldoet aan de validatie
//
//Parameters:
//  - rijksregisterNr: String
//
//Return: een bool die true is als het rijksregisternummer voldoet aan de validatie, anders false
//
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

//
//Naam: checkPatternLidnummer
//
//Werking: - bekijkt of het lidnummer voldoet aan de validatie
//
//Parameters:
//  - lidnummer: String
//
//Return: een bool die true is als het lidnummer voldoet aan de validatie, anders false
//
func checkPatternLidnummer(lidnummer: String) -> Bool {
    if countElements(lidnummer) == 5 {
        return true
    }
    return false
}

//
//Naam: foutBoxOproepen
//
//Werking: - stelt een foutbox op met de gegevens die m'n meekrijgt
//
//Parameters:
//  - title: String
//  - message: String
//  - controller: UIViewController
//
//Return:
//
func foutBoxOproepen(title: String, message: String, controller: UIViewController) {
    var foutBox: FoutBox = FoutBox(title: title, message: message)
    var alert = foutBox.alert
    controller.presentViewController(alert, animated: true, completion: nil)
}

//
//Naam: foutboxOproepen
//
//Werking: - toont de foutbox bovenop de view
//
//Parameters:
//  - foutbox: Foutbox
//  - controller: UIViewController
//
//Return:
//
func foutBoxOproepen(foutBox: FoutBox, controller: UIViewController) {
    var alert = foutBox.alert
    controller.presentViewController(alert, animated: true, completion: nil)
}

//
//Naam: giveUITextFieldRedBorder
//
//Werking: - zorgt ervoor dat de text field een rode border krijgt
//
//Parameters:
//  - textField: UITextField
//
//Return:
//
func giveUITextFieldRedBorder(textField: UITextField) {
    var redColor: UIColor = UIColor.redColor()
    textField.layer.borderColor = redColor.CGColor
    textField.layer.borderWidth = 1.0
    textField.layer.cornerRadius = 5.0
}

//
//Naam: giveUITextFieldRedBorder
//
//Werking: - zorgt ervoor dat de text field een default border krijgt
//
//Parameters:
//  - textField: UITextField
//
//Return:
//
func giveUITextFieldDefaultBorder(textField: UITextField) {
    var defaultBorderColor: UIColor = UIColor(red: 182.0, green: 182.0, blue: 182.0, alpha: 0)
    textField.layer.borderColor = defaultBorderColor.CGColor
    textField.layer.borderWidth = 1.0
    textField.layer.cornerRadius = 5.0
}

//
//Naam: controleerGeldigheidNummer
//
//Werking: - bekijkt of de nummer effectief een nummer is (en geen letter)
//
//Parameters:
//  - nummer: String
//
//Return: een bool die true is als het voldoet aan de validatie, anders false
//
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

//
//Naam: wachtwoordMath
//
//Werking: - controleert of wachtwoord en herhaalwachtwoord gelijk is
//
//Parameters:
//  - wachtwoord: String
//  - herhaalWachtwoord: String
//
//Return:
//
func wachtwoordenMatch(wachtwoord: String, herhaalWachtwoord: String) -> Bool {
    if wachtwoord == herhaalWachtwoord {
        return true
    } else {
        return false
    }
}

//
//Naam: checkPatternEmail
//
//Werking: - bekijkt of het ingevulde emailadres voldoet aan de regex
//
//Parameters:
//  - email: String
//
//Return: een bool die true is als het email voldoet aan de regex, anders false
//
func checkPatternEmail(email: String) -> Bool {
    if countElements(email) == 0 {
        return false
    } else if Regex(p: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}").test(email) {
        return true
    }
    return false
}

//
//Naam: giveUITextViewDefaultBorder
//
//Werking: - zorgt ervoor dat de text view een default border krijgt
//
//Parameters:
//  - textField: UITextView
//
//Return:
//
func giveUITextViewDefaultBorder(textView: UITextView) {
    var grayColor: UIColor = UIColor.grayColor()
    textView.layer.borderColor = grayColor.CGColor
    textView.layer.borderWidth = 1.0
    textView.layer.cornerRadius = 5.0
}

//
//Naam: giveUITextViewRedBorder
//
//Werking: - zorgt ervoor dat de text view een rode border krijgt
//
//Parameters:
//  - textField: UITextView
//
//Return:
//
func giveUITextViewRedBorder(textView: UITextView) {
    var redColor: UIColor = UIColor.redColor()
    textView.layer.borderColor = redColor.CGColor
    textView.layer.borderWidth = 1.0
    textView.layer.cornerRadius = 5.0
}
   