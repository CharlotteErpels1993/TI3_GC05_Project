//
//  JSON.swift
//  GC05_iOS
//
//  Created by Charlotte Erpels on 31/10/14.
//  Copyright (c) 2014 GC05. All rights reserved.
//

import Foundation

class JSON {
    class func omzettenPFObjectMonitorNaarDomeinKlasse(monitorPF : PFObject) -> Monitor {
        
        var id: String = monitorPF["objectId"] as String
        var email: String = monitorPF["email"] as String
        var wachtwoord: String = monitorPF["wachtwoord"] as String
        var voornaam: String = monitorPF["voornaam"] as String
        var naam: String = monitorPF["naam"] as String
        var straat: String = monitorPF["straat"] as String
        var nummer: Int = monitorPF["nummer"] as Int
        var bus: String = monitorPF["bus"] as String
        var gemeente: String = monitorPF["gemeente"] as String
        var postcode: Int = monitorPF["postcode"] as Int
        var telefoon: String = monitorPF["telefoon"] as String
        var gsm: String = monitorPF["gsm"] as String
        var aansluitingsNr: Int = monitorPF["aansluitingsNummer"] as Int
        var codeGerechtigde: Int = monitorPF["codeGerechtigde"] as Int
        var linkFacebook: String = monitorPF["linkFacebook"] as String
        var lidNr: Int = monitorPF["lidNr"] as Int
        
        
    }
}