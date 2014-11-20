import Foundation

class MonitorRepository {
    
    var monitors: [Monitor] = []
    
    init() {
        refreshMonitors()
    }
    
    func getAllMonitors() -> [Monitor] {
        return self.monitors
    }
    
    func getMonitorWithEmail(email: String) -> Monitor {
        var monitor: Monitor = Monitor(id: "test")
        
        for m in monitors {
            if m.email == email {
                monitor = m
            }
        }
        
        return monitor
    }
    
    private func refreshMonitors() {
        var query = PFQuery(className: "Monitor")
        self.monitors = query.findObjects() as [Monitor]
    }
    
}