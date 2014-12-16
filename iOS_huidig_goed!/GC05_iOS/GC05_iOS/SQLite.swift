


/*func createTable(tableName: String) {
    var columns: [String: SwiftData.DataType] = [:]
    
    if tableName == VAKANTIE_DB {
        columns = VAKANTIE_COLUMNS_DB
    }
    
    
    if let error = SD.createTable(tableName, withColumnNamesAndTypes: columns) {
        println("ERROR: er was een error tijdens het creëeren van de table " + tableName + " in SQLite database.")
    } else {
        println("SUCCESS: table " + tableName + " is gecreëerd.")
    }
}

func isEmptyInSQLite(tableName: String) -> Bool {
    let (resultSet, error) = SD.executeQuery("SELECT * FROM i?", withArgs: [tableName])
    
    if error != nil {
        println("ERROR: er was een error tijdens het controleren of de tabel " + tableName + " leeg is.")
    } else {
        if resultSet.count == 0 {
            return true
        }
        return false
    }
    
    return true
}

func fillTableInSQLite(tableName: String) {
    var query = PFQuery(className: tableName)
    var queryString: String = ""
    var objects: [PFObject] = []
    var objectId: String = ""
    
    objects = query.findObjects() as [PFObject]
    
    var variabelenTypes: [String: SwiftData.DataType] = [:]
    var variabelenNames: [String: String] = [:]
    var variabelen: [String: AnyObject] = [:]
    
    if tableName == VAKANTIE_DB {
        variabelenTypes = VAKANTIE_COLUMNS_DB
        variabelenNames = VAKANTIE_VALUES
    }
    
    //variabelen aanmaken
    for variabeleName in variabelenNames.keys {
        if variabeleName != OBJECT_ID_DB {
            if variabelenTypes[variabeleName] == .StringVal {
                variabelen[variabeleName] = ""
            } else if variabelenTypes[variabeleName] == .IntVal {
                variabelen[variabeleName] = 0
            } else if variabelenTypes[variabeleName] == .DoubleVal {
                variabelen[variabeleName] = 0.0
            } else if variabelenTypes[variabeleName] == .BoolVal {
                variabelen[variabeleName] = false
            }
        }
    }
    
    for object in objects {
        queryString.removeAll(keepCapacity: true)
        objectId.removeAll(keepCapacity: true)
        
        for v in variabelen.keys {
            if variabelenTypes[v] == .StringVal {
                
                if v == VERTREK_DATUM_DB || v == TERUGKEER_DATUM_DB {
                    var datum = object[v] as NSDate
                    variabelen[v] = datum.toS("dd/MM/yyyy")
                } else {
                    if variabelenNames[v] == OPTIONAL && object[v] == nil {
                        variabelen[v] = ""
                    } else {
                        variabelen[v] = object[v] as String
                    }
                }
            } else if variabelenTypes[v] == .IntVal {
                if variabelenNames[v] == OPTIONAL && object[v] == nil {
                    variabelen[v] = 0
                } else {
                    variabelen[v] = object[v] as Int
                }
            } else if variabelenTypes[v] == .DoubleVal {
                if variabelenNames[v] == OPTIONAL && object[v] == nil {
                    variabelen[v] = 0.0
                } else {
                    variabelen[v] = object[v] as Double
                }
            } else if variabelenTypes[v] == .BoolVal {
                if variabelenNames[v] == OPTIONAL && object[v] == nil {
                    variabelen[v] = false
                } else {
                    variabelen[v] = object[v] as Bool
                }
            }
        }
        
        queryString.extend("INSERT INTO " + VAKANTIE_DB + " ")
        queryString.extend("(")
        queryString.extend("objectId, ")
        
        for variabele in variabelen.keys {
            queryString.extend(variabele)
            queryString.extend(", ")
        }
        
        //laatste 2 characters verwijderen (, )
        queryString.substringToIndex(queryString.endIndex.predecessor())
        queryString.substringToIndex(queryString.endIndex.predecessor())
        
        
        /*var range1: Int = countElements(queryString)
        range1 -= 1
        //queryString.removeAtIndex(range1)
        range1 -= 1
        queryString.removeAtIndex(range1)*/
        
        queryString.extend(")")
        queryString.extend(" VALUES ")
        queryString.extend("(i?, ")
        
        for variabele in variabelen.keys {
            queryString.extend("i?, ")
        }
        
        //laatste 2 characters verwijderen (, )
        queryString.substringToIndex(queryString.endIndex.predecessor())
        queryString.substringToIndex(queryString.endIndex.predecessor())
        
        queryString.extend(")")
        
        var arguments: [AnyObject] = []
        
        for value in variabelen.values {
            arguments.append(value)
        }
        
        if let error = SD.executeChange(queryString, withArgs: arguments) {
            println("ERROR: error tijdens het toevoegen van een nieuw object in de table " + tableName + " in SQLite database.")
        }
    }
}


func updateObjectsInSQLiteFromParse(tableName: String) {
    
    var variabelenTypes: [String: SwiftData.DataType] = [:]
    var variabelenNames: [String: String] = [:]
    var variabelen: [String: AnyObject] = [:]
    
    if tableName == VAKANTIE_DB {
        variabelenTypes = VAKANTIE_COLUMNS_DB
        variabelenNames = VAKANTIE_VALUES
    }
    
    let (resultSet, error) = SD.executeQuery("SELECT * FROM " + tableName)
    
    if error != nil {
        println("ERROR: error tijdens updaten van objecten uit table " + tableName + " uit SQLite database tijdens ophalen van alle objecten uit table " + tableName)
    } else {
        for row in resultSet {
            
        }
    }
    
    
    var query = PFQuery(className: tableName)
    
    query.fromLocalDatastore()
    
    var objectsLocalDatastore: [PFObject] = query.findObjects() as [PFObject]
    
    for object in objectsLocalDatastore {
        object.fetch()
    }
    
    var newObjects: [PFObject] = []
    
    var queryNewObjects = PFQuery(className: tableName)
    query.whereKey("objectId", notContainedIn: objectsLocalDatastore)
    
    newObjects = query.findObjects() as [PFObject]
    
    PFObject.pinAll(newObjects)
}

func updateObject(row: SD.SDRow, tableName: String) {
    var query = PFQuery(className: tableName)
    
    var o = PFObject(className: tableName)
    
    var variabelenTypes: [String: SwiftData.DataType] = [:]
    var variabelenNames: [String: String] = [:]
    var variabelen: [String: AnyObject] = [:]
    
    if tableName == VAKANTIE_DB {
        variabelenTypes = VAKANTIE_COLUMNS_DB
        variabelenNames = VAKANTIE_VALUES
    }
    
    
    if let objectId = row[OBJECT_ID_DB]?.asString() {
        
        var object = query.getObjectWithId(objectId)
        
        o.objectId = objectId
        o.fetch()
        
        var queryString: String = ""
        queryString.extend("UPDATE ")
        queryString.extend(tableName)
        queryString.extend(" SET ")
        
        for variabele in variabelenNames.keys {
            queryString.extend(variabele)
            queryString.extend(" = i?, ")
        }
        
        queryString.substringToIndex(queryString.endIndex.predecessor())
        queryString.substringToIndex(queryString.endIndex.predecessor())
        
        queryString.extend(" WHERE objectId = ?")
        
        var values: [AnyObject] = []
        
        for v in variabelenNames.keys {
            if variabelenTypes[v] == .StringVal {
                
                if v == VERTREK_DATUM_DB || v == TERUGKEER_DATUM_DB {
                    var datum = object[v] as NSDate
                    variabelen[v] = datum.toS("dd/MM/yyyy")
                } else {
                    if variabelenNames[v] == OPTIONAL && object[v] == nil {
                        variabelen[v] = ""
                    } else {
                        variabelen[v] = object[v] as String
                    }
                }
            } else if variabelenTypes[v] == .IntVal {
                if variabelenNames[v] == OPTIONAL && object[v] == nil {
                    variabelen[v] = 0
                } else {
                    variabelen[v] = object[v] as Int
                }
            } else if variabelenTypes[v] == .DoubleVal {
                if variabelenNames[v] == OPTIONAL && object[v] == nil {
                    variabelen[v] = 0.0
                } else {
                    variabelen[v] = object[v] as Double
                }
            } else if variabelenTypes[v] == .BoolVal {
                if variabelenNames[v] == OPTIONAL && object[v] == nil {
                    variabelen[v] = false
                } else {
                    variabelen[v] = object[v] as Bool
                }
            }
        }
        
        //enkel als vakanties
        var arguments = sortVariabelenVakantie(variabelen)
        
        if let err = SD.executeChange(queryString, withArgs: arguments) {
            println("ERROR: error tijdens het updaten van object met id " + objectId + " uit table " + tableName + " uit SQLite database.")
        }
        
    }
}

func sortVariabelenVakantie(variabelen: [String: AnyObject]) -> [AnyObject] {
    var values = [AnyObject]()
    
    values[0] = variabelen[TITEL_DB]!
    values[1] = variabelen[LOCATIE_DB]!
    values[2] = variabelen[KORTE_BESCHRIJVING_DB]!
    values[3] = variabelen[VERTREK_DATUM_DB]!
    values[4] = variabelen[TERUGKEER_DATUM_DB]!
    values[5] = variabelen[AANTAL_DAGEN_NACHTEN_DB]!
    values[6] = variabelen[VERVOERWIJZE_DB]!
    values[7] = variabelen[FORMULE_DB]!
    values[8] = variabelen[LINK_DB]!
    values[9] = variabelen[BASIS_PRIJS_DB]!
    values[10] = variabelen[BOND_MOYSON_LEDEN_PRIJS_DB]!
    values[11] = variabelen[STER_PRIJS_1_OUDER_DB]!
    values[12] = variabelen[STER_PRIJS_2_OUDERS_DB]!
    values[13] = variabelen[INBEGREPEN_PRIJS_DB]!
    values[14] = variabelen[MIN_LEEFTIJD_DB]!
    values[15] = variabelen[MAX_LEEFTIJD_DB]!
    values[16] = variabelen[MAX_AANTAL_DEELNEMERS_DB]!

    return values
}


/*func getAllObjectsFromSQLite(tableName: String) -> [AnyObject] {
    var objectsSQLite: [PFObject] = []
    
    var vakanties: [Vakantie] = []
    var vakantie: Vakantie = Vakantie(id: "test")
    
    var voorkeuren: [Voorkeur] = []
    
    
    var query = PFQuery(className: tableName)
    query.fromLocalDatastore()
    
    objectsLocalDatastore = query.findObjects() as [PFObject]
    
    for objectLocalDatastore in objectsLocalDatastore {
        if tableName == "Vakantie" {
            vakantie = getVakantie(objectLocalDatastore)
            vakanties.append(vakantie)
        }
        
        
        
        
    }
    
    if tableName == "Vakantie" {
        return vakanties
    }
    
    //random gekozen, moet nog uitgewerkt worden!
    return voorkeuren
    
}*/

func getVakantie(vakantieObject: PFObject) -> Vakantie {
    var vakantie: Vakantie = Vakantie(id: vakantieObject.objectId)
    
    vakantie.titel = vakantieObject["titel"] as? String
    vakantie.locatie = vakantieObject["locatie"] as? String
    vakantie.korteBeschrijving = vakantieObject["korteBeschrijving"] as? String
    vakantie.vertrekdatum = vakantieObject["vertrekdatum"] as NSDate
    vakantie.terugkeerdatum = vakantieObject["terugkeerdatum"] as NSDate
    vakantie.aantalDagenNachten = vakantieObject["aantalDagenNachten"] as? String
    vakantie.vervoerwijze = vakantieObject["vervoerwijze"] as? String
    vakantie.formule = vakantieObject["formule"] as? String
    vakantie.link = vakantieObject["link"] as? String
    vakantie.basisprijs = vakantieObject["basisPrijs"] as? Double
    vakantie.bondMoysonLedenPrijs = vakantieObject["bondMoysonLedenPrijs"] as? Double
    vakantie.sterPrijs1ouder = vakantieObject["sterPrijs1ouder"] as? Double
    vakantie.sterPrijs2ouders = vakantieObject["sterPrijs2ouders"] as? Double
    vakantie.inbegrepenPrijs = vakantieObject["inbegrepenPrijs"] as? String
    vakantie.minLeeftijd = vakantieObject["minLeeftijd"] as Int
    vakantie.maxLeeftijd = vakantieObject["maxLeeftijd"] as? Int
    vakantie.maxAantalDeelnemers = vakantieObject["maxAantalDeelnemers"] as? Int
    
    return vakantie
}
*/
/*func getTableInSQLiteReady(tableName: String) {
    
    var localTableIsEmpty: Bool = isEmptyInSQLite(tableName)
    
    if localTableIsEmpty == true {
        if Reachability.isConnectedToNetwork() == true {
            fillTableInSQLite(tableName)
        } 
    } else {
        if Reachability.isConnectedToNetwork() == true {
            updateObjectsInLocalDatastoreFromParse(tableName)
        }
    }
}*/








