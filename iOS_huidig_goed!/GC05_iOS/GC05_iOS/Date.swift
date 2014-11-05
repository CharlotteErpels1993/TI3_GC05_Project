import Foundation

class Date
{
    var day : Int {
        willSet {
            assert(checkValidDay(newValue), "Dag moet een geldige dag in de maand zijn!")
        }
    }
    
    var month : Int {
        willSet {
            assert(checkValidMonth(newValue), "Maand moet tussen 1 en 12 liggen!")
        }
    }
    
    var year : Int {
        willSet {
            assert(checkValidYear(newValue), "Jaar moet geldig zijn!")
        }
    }
    
    init(day : Int, month : Int, year : Int) {
        self.day = day
        self.month = month
        self.year = year
    }
    
    //controle dagen, maanden en jaren
    private func checkValidDay(day: Int) -> Bool {
        if day < 1 {
            return false
        } else if day > 31 {
            return false
        } else {
            return true
        }
    }
    
    private func checkValidMonth(month: Int) -> Bool {
        if month < 1 {
            return false
        } else if month > 12 {
            return false
        } else {
            return true
        }
    }
    
    private func checkValidYear(year: Int) -> Bool {
        if year < 1000 {
            return false
        } else if year > 9999 {
            return false
        } else {
            return true
        }
    }
}