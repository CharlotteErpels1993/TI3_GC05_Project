import UIKit

class NieuweMonitorSuccesvolViewController: UIViewController {
    
    var nieuweMonitor: NieuweMonitor!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ParseData.parseNieuweMonitorToDatabase(self.nieuweMonitor)
    }
}