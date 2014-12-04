import UIKit

class MonitorRegistratieSuccesvolViewController: UIViewController {
    
    var monitor: Monitor!
    var ww: String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ParseData.parseMonitorToDatabase(monitor, wachtwoord: ww)
    }
}