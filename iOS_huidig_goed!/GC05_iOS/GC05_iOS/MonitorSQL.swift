import Foundation

struct MonitorSQL {
    
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
        
        if err != nil
        {
            println("ERROR: error tijdens ophalen van alle monitors uit table Monitor")
        }
        else
        {
            for row in resultSet {
                monitor = getMonitor(row)
                monitors.append(monitor)
            }
        }
        
        return monitors
    }
    
    static func getMonitorWithEmail(email: String) -> Monitor {
        
        var monitors: [Monitor] = []
        var monitor2: Monitor = Monitor(id: "test")
        var monitor: Monitor = Monitor(id: "test")
        
        let (resultSet, err) = SD.executeQuery("SELECT * FROM Monitor WHERE email = ?", withArgs: [email])
        
        if err != nil
        {
            println("ERROR: error tijdens ophalen van monitors met email uit table Monitor")
        }
        else
        {
            if resultSet.count == 0 {
                monitors.append(monitor)
            } else {
                for row in resultSet {
                    monitor = getMonitor(row)
                    monitors.append(monitor)
                }
            }
        }
        return monitors.first!
    }
    
    static func getEmail(email: String) -> Bool {
        let (resultSet, err) = SD.executeQuery("SELECT * FROM Monitor WHERE email = ?", withArgs: [email])
        if err != nil
        {
            println("ERROR: error tijdens ophalen van alle gsms")
        }
        
        if resultSet.count == 0 {
            return false
        }
        
        return true
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
        
        var queryString = ""
        
        var objectId: String = ""
        var rijksregisterNr: String?
        var email: String = ""
        var wachtwoord: String = ""
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
            
            queryString.removeAll(keepCapacity: true)
            
            objectId = monitor.objectId as String
            rijksregisterNr = monitor["rijksregisterNr"] as? String
            email = monitor["email"] as String
            wachtwoord = monitor["wachtwoord"] as String
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
            
            if rijksregisterNr == nil {
                rijksregisterNr = ""
            }
            if bus == nil {
                bus = ""
            }
            if telefoon == nil {
                telefoon = ""
            }
            if aansluitingsNr == nil {
                aansluitingsNr = 0
            }
            if codeGerechtigde == nil {
                codeGerechtigde = 0
            }
            if lidNr == nil {
                lidNr = 0
            }
            if linkFacebook == nil {
                linkFacebook = ""
            }
            
            
            queryString.extend("INSERT INTO Monitor ")
            queryString.extend("(")
            queryString.extend("objectId, ")
            queryString.extend("rijksregisterNr, ")
            queryString.extend("email, ")
            queryString.extend("wachtwoord, ")
            queryString.extend("voornaam, ")
            queryString.extend("naam, ")
            queryString.extend("straat, ")
            queryString.extend("nummer, ")
            queryString.extend("bus, ")
            queryString.extend("postcode, ")
            queryString.extend("gemeente, ")
            queryString.extend("telefoon, ")
            queryString.extend("gsm, ")
            queryString.extend("aansluitingsNr, ")
            queryString.extend("codeGerechtigde, ")
            queryString.extend("lidNr, ")
            queryString.extend("linkFacebook")
            queryString.extend(")")
            queryString.extend(" VALUES ")
            queryString.extend("(")
            
            queryString.extend("'\(objectId)', ") //objectId - String
            queryString.extend("'\(rijksregisterNr!)', ") //rijksregisterNr - String
            queryString.extend("'\(email)', ") //email - String
            queryString.extend("'\(wachtwoord)', ") //wachtwoord - String
            queryString.extend("'\(voornaam)', ") //voornaam - String
            queryString.extend("'\(naam)', ") //naam - String
            queryString.extend("'\(straat)', ") //straat - String
            queryString.extend("\(nummer), ") //nummer - Int (geen '')!!
            queryString.extend("'\(bus!)', ") //bus - String
            queryString.extend("\(postcode), ") //postcode - Int (geen '')!!
            queryString.extend("'\(gemeente)', ") //gemeente - String
            queryString.extend("'\(telefoon!)', ") //telefoon - String
            queryString.extend("'\(gsm)', ") //gsm - String
            queryString.extend("\(aansluitingsNr!), ") //aansluitingsNr - Int (geen '')!!
            queryString.extend("\(codeGerechtigde!), ") //codeGerechtigde - Int (geen '')!!
            queryString.extend("\(lidNr!), ") //lidNr - Int (geen '')!!
            queryString.extend("'\(linkFacebook!)'") //linkFacebook - String
            
            queryString.extend(")")
            
            
            if let err = SD.executeChange(queryString)
            {
                println("ERROR: error tijdens toevoegen van nieuwe monitor in table Monitor")
            }
            else
            {
                //no error, the row was inserted successfully
            }
            
        }
    }
    
    
    static func getMonitorsMetId(monitorIds: [String]) -> [Monitor] {
        var monitors: [Monitor] = []
        var monitor: Monitor = Monitor(id: "test")
        
        var aangemeldeMonitor = MonitorSQL.getMonitorWithEmail(PFUser.currentUser().email)
        
        for mId in monitorIds {
            var (resultSet, err) = SD.executeQuery("SELECT * FROM Monitor WHERE objectId = ?", withArgs: [mId])
            
            if err != nil
            {
                println("ERROR: error tijdens ophalen van Monitors met id uit table Monitor")
            }
            else
            {
                for row in resultSet {
                    monitor = getMonitor(row)
                    
                    if monitor.id != aangemeldeMonitor.id {
                        monitors.append(monitor)
                    }
                    
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
        
        var queryString: String = ""
        
        queryString.extend("UPDATE Monitor SET ")
        queryString.extend("voornaam=?, ")
        queryString.extend("naam=?, ")
        queryString.extend("telefoon=?, ")
        queryString.extend("gsm=?, ")
        queryString.extend("linkFacebook=? ")
        queryString.extend("WHERE email = ?")
        
        /*let (resultSet, err) = SD.executeQuery("UPDATE Monitor SET voornaam='\(monitorNieuw.voornaam)', naam='\(monitorNieuw.naam)', telefoon='\(monitorNieuw.telefoon)', gsm='\(monitorNieuw.gsm)', linkFacebook='\(monitorNieuw.linkFacebook)' WHERE email = \(email)")*/
        
        let err = SD.executeChange(queryString, withArgs: [monitorNieuw.voornaam!, monitorNieuw.naam!, monitorNieuw.telefoon!, monitorNieuw.gsm!, monitorNieuw.linkFacebook!, email])
        
        
        
        if err != nil
        {
            println("ERROR: error tijdens updaten van monitor in table Monitor")
        }
        else
        {
            //no error
        }

    }
    
}