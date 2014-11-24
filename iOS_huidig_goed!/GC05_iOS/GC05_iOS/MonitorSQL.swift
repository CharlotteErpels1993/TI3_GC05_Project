import Foundation

struct /*class*/ MonitorSQL {
    
    static func createMonitorTable() {
        if let error = SD.createTable("Monitor", withColumnNamesAndTypes:
        ["objectId": .StringVal, "rijksregisterNr": .StringVal, "email": .StringVal,
         "wachtwoord": .StringVal ,"voornaam": .StringVal, "naam": .StringVal,
         "straat": .StringVal, "nummer": .IntVal, "bus": .StringVal, "postcode": .IntVal,
         "gemeente": .StringVal, "telefoon": .StringVal, "gsm": .StringVal,
         "aansluitingsNr": .IntVal, "codeGerechtigde": .IntVal, "lidNr": .IntVal,
         "linkFacebook": .StringVal])
        {
            println("ERROR: error tijdens creatie van table Monitor")
        }
        else
        {
            //no error
        }
    }
    
    static func zoekAlleMonitors() -> [Monitor] {
        var monitors: [Monitor] = []
        var monitor: Monitor = Monitor(id: "test")
        
        let (resultSet, err) = SD.executeQuery("SELECT * FROM Monitor")
        
        if err != nil {
            //there was an error during the query, handle it here
        } else {
            for row in resultSet {
                monitor = getMonitor(row)
                monitors.append(monitor)
            }
        }
        
        return monitors
    }
    
    static func getMonitorWithEmail(email: String) -> Monitor {
        
        var monitors: [Monitor] = []
        var monitor: Monitor = Monitor(id: "test")
        
        let (resultSet, err) = SD.executeQuery("SELECT * FROM Monitor WHERE email = \(email)")
        
        if err != nil {
            //there was an error during the query, handle it here
        } else {
            for row in resultSet {
                monitor = getMonitor(row)
                monitors.append(monitor)
            }
        }
        
        return monitors.first!
    }
    
    static func getMonitor(row: SD.SDRow) -> Monitor {
        var monitor: Monitor = Monitor(id: "test")
        
        if let objectId = row["objectId"]?.asString() {
            monitor.id = objectId
        }
        if let rijksregisterNr = row["rijksregisterNr"]?.asString() {
            monitor.rijksregisterNr = rijksregisterNr
        }
        if let email = row["email"]?.asString() {
            monitor.email = email
        }
        if let wachtwoord = row["wachtwoord"]?.asString() {
            monitor.wachtwoord = wachtwoord
        }
        if let voornaam = row["voornaam"]?.asString() {
            monitor.voornaam = voornaam
        }
        if let naam = row["naam"]?.asString() {
            monitor.naam = naam
        }
        if let straat = row["straat"]?.asString() {
            monitor.straat = straat
        }
        if let nummer = row["nummer"]?.asInt() {
            monitor.nummer = nummer
        }
        if let bus = row["bus"]?.asString() {
            monitor.bus = bus
        }
        if let postcode = row["postcode"]?.asInt() {
            monitor.postcode = postcode
        }
        if let gemeente = row["gemeente"]?.asString() {
            monitor.gemeente = gemeente
        }
        if let telefoon = row["telefoon"]?.asString() {
            monitor.telefoon = telefoon
        }
        if let gsm = row["gsm"]?.asString() {
            monitor.gsm = gsm
        }
        if let aansluitingsNr = row["aansluitingsNr"]?.asInt() {
            monitor.aansluitingsNr = aansluitingsNr
        }
        if let codeGerechtigde = row["codeGerechtigde"]?.asInt() {
            monitor.codeGerechtigde = codeGerechtigde
        }
        if let lidNr = row["lidNr"]?.asInt() {
            monitor.lidNr = lidNr
        }
        if let linkFacebook = row["linkFacebook"]?.asString() {
            monitor.linkFacebook = linkFacebook
        }
        
        return monitor
    }
    
    static func vulMonitorTableOp() {
        
        var monitors: [PFObject] = []
        var query = PFQuery(className: "Monitor")
        monitors = query.findObjects() as [PFObject]
        
        var objectId: String = ""
        var rijksregisterNr: String?
        var email: String = ""
        var wachtwoord: String?
        var voornaam: String = ""
        var naam: String = ""
        var straat: String = ""
        var nummer: Int = 0
        var bus: String?
        var postcode: Int = 0
        var gemeente: String = ""
        var telefoon: String?
        var gsm: String = ""
        var aansluitingsNr: Int?
        var codeGerechtigde: Int?
        var lidNr: Int?
        var linkFacebook: String?
        
        for monitor in monitors {
            objectId = monitor.objectId as String
            rijksregisterNr = monitor["rijksregisterNr"] as? String
            email = monitor["email"] as String
            wachtwoord = monitor["wachtwoord"] as? String
            voornaam = monitor["voornaam"] as String
            naam = monitor["naam"] as String
            straat = monitor["straat"] as String
            nummer = monitor["nummer"] as Int
            bus = monitor["bus"] as? String
            postcode = monitor["postcode"] as Int
            gemeente = monitor["gemeente"] as String
            telefoon = monitor["telefoon"] as? String
            gsm = monitor["gsm"] as String
            aansluitingsNr = monitor["aansluitingsNr"] as? Int
            codeGerechtigde = monitor["codeGerechtigde"] as? Int
            lidNr = monitor["lidNr"] as? Int
            linkFacebook = monitor["linkFacebook"] as? String
            
            if let err = SD.executeChange("INSERT INTO Monitor (objectId, rijksregisterNr, email, wachtwoord, voornaam, naam, straat, nummer, bus, postcode, gemeente, telefoon, gsm, aansluitingsNr, codeGerechtigde, lidNr, linkFacebook) VALUES ('\(objectId)', '\(rijksregisterNr)', '\(email)', '\(wachtwoord)', '\(voornaam)', '\(naam)', '\(straat)', '\(nummer)', '\(bus)', '\(postcode)', '\(gemeente)', '\(telefoon)', '\(gsm)', '\(aansluitingsNr)', '\(codeGerechtigde)', '\(lidNr)', '\(linkFacebook)')") {
                //there was an error during the insert, handle it here
            } else {
                //no error, the row was inserted successfully
            }
            
        }
    }
    
    
    static func getMonitorsMetId(monitorIds: [String]) -> [Monitor] {
        var monitors: [Monitor] = []
        var monitor: Monitor = Monitor(id: "test")
        
        for mId in monitorIds {
            var (resultSet, err) = SD.executeQuery("SELECT * FROM Monitor WHERE objectId = \(mId)")
            
            if err != nil {
                //there was an error during the query, handle it here
            } else {
                for row in resultSet {
                    monitor = getMonitor(row)
                    monitors.append(monitor)
                }
            }
            
        }
        
        return monitors
    }
    
    
    static func getAndereMonitors(monitors: [Monitor]) -> [Monitor] {
        var alleMonitors = zoekAlleMonitors()
        var andereMonitors: [Monitor] = []
        
        var bevatMonitor = false
        
        for monitor in alleMonitors {
            bevatMonitor = false
            
            for m in monitors {
                if m.id == monitor.id {
                    bevatMonitor = true
                }
            }
            
            if bevatMonitor == false {
                andereMonitors.append(monitor)
            }
        }
        
        return andereMonitors
    }
    
    static func updateMonitor(monitorNieuw: Monitor, email: String) {
        let (resultSet, err) = SD.executeQuery("UPDATE Monitor SET voornaam='\(monitorNieuw.voornaam)', naam='\(monitorNieuw.naam)', telefoon='\(monitorNieuw.telefoon)', gsm='\(monitorNieuw.gsm)', linkFacebook='\(monitorNieuw.linkFacebook)' WHERE email = \(email)")
        
        if err != nil {
            //there was an error during the query, handle it here
        } else {
            //no error
        }

    }
    
}