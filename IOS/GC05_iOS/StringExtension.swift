import Foundation

extension String {
    func toDate(let format:String = "dd/MM/yyyy") -> NSDate? {
        var formatter:NSDateFormatter = NSDateFormatter()
        formatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        formatter.timeZone = NSTimeZone()
        formatter.dateFormat = format
        
        return formatter.dateFromString(self)
    }
}