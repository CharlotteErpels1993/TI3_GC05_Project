import Foundation

struct InschrijvingVakantieLD {
    
    //
    //Function: getInschrijvingen
    //
    //Deze functie zet een array van PFObject om naar een array van InschrijvingVakantie.
    //
    //Parameters: - objecten: [PFObject]
    //
    //Return: een array van InschrijvingVakantie
    //
    static func getInschrijvingen(objecten: [PFObject]) -> [InschrijvingVakantie] {
        var inschrijvingen: [InschrijvingVakantie] = []
        
        for object in objecten {
            inschrijvingen.append(getInschrijving(object))
        }
        
        return inschrijvingen
    }
    
    //
    //Function: getInschrijving
    //
    //Deze functie zet een  PFObject om naar een InschrijvingVakantie.
    //
    //Parameters: - object: PFObject
    //
    //Return: een InschrijvingVakantie
    //
    static func getInschrijving(object: PFObject) -> InschrijvingVakantie {
        var inschrijving: InschrijvingVakantie = InschrijvingVakantie(id: object.objectId)
        
        inschrijving.periode = object[Constanten.COLUMN_PERIODE] as? String
        inschrijving.extraInfo = object[Constanten.COLUMN_EXTRAINFORMATIE] as? String
        
        //var whereVakantie : [String : AnyObject] = [:]
        //var whereOuder : [String : AnyObject] = [:]
        var whereDeelnemer : [String : AnyObject] = [:]
        var whereCP1 : [String : AnyObject] = [:]
        var whereCP2 : [String : AnyObject] = [:]
        
        //whereVakantie[Constanten.COLUMN_OBJECTID] = object[Constanten.COLUMN_VAKANTIE] as? String
        //whereOuder[Constanten.COLUMN_OBJECTID] = object[Constanten.COLUMN_OUDER] as? String
        whereDeelnemer[Constanten.COLUMN_OBJECTID] = object[Constanten.COLUMN_DEELNEMER] as? String
        whereCP1[Constanten.COLUMN_OBJECTID] = object[Constanten.COLUMN_CONTACTPERSOON1] as? String
        whereCP2[Constanten.COLUMN_OBJECTID] = object[Constanten.COLUMN_CONTACTPERSOON2] as? String
        
        //var queryVakantie = LocalDatastore.query(Constanten.TABLE_VAKANTIE, whereArgs: whereVakantie)
        var qVakantie = Query(tableName: Constanten.TABLE_VAKANTIE)
        qVakantie.addWhereEqualTo(Constanten.COLUMN_OBJECTID, value: object[Constanten.COLUMN_VAKANTIE])
        
        //var queryOuder = LocalDatastore.query(Constanten.TABLE_OUDER, whereArgs: whereOuder)
        var qOuder = Query(tableName: Constanten.TABLE_OUDER)
        qOuder.addWhereEqualTo(Constanten.COLUMN_OBJECTID, value: object[Constanten.COLUMN_OUDER])
        
        //var queryDeelnemer = LocalDatastore.query(Constanten.TABLE_DEELNEMER, whereArgs: whereDeelnemer)
        var qDeelnemer = Query(tableName: Constanten.TABLE_DEELNEMER)
        qDeelnemer.addWhereEqualTo(Constanten.COLUMN_OBJECTID, value: object[Constanten.COLUMN_DEELNEMER])
        
        //var queryCP1 = LocalDatastore.query(Constanten.TABLE_CONTACTPERSOON, whereArgs: whereCP1)
        var qCP1 = Query(tableName: Constanten.TABLE_CONTACTPERSOON)
        qCP1.addWhereEqualTo(Constanten.COLUMN_OBJECTID, value: object[Constanten.COLUMN_CONTACTPERSOON1])
        
        //var queryCP2 = LocalDatastore.query(Constanten.TABLE_CONTACTPERSOON, whereArgs: whereCP2)
        var qCP2 = Query(tableName: Constanten.TABLE_CONTACTPERSOON)
        qCP2.addWhereEqualTo(Constanten.COLUMN_OBJECTID, value: object[Constanten.COLUMN_CONTACTPERSOON2])
        
        //inschrijving.vakantie = LocalDatastore.getFirstObject(Constanten.TABLE_VAKANTIE, query: queryVakantie) as? Vakantie
        inschrijving.vakantie = qVakantie.getFirstObject() as? Vakantie
        
        //inschrijving.ouder = LocalDatastore.getFirstObject(Constanten.TABLE_OUDER, query: queryOuder) as? Ouder
        inschrijving.ouder = qOuder.getFirstObject() as? Ouder
        
        //inschrijving.deelnemer = LocalDatastore.getFirstObject(Constanten.TABLE_DEELNEMER, query: queryDeelnemer) as? Deelnemer
        inschrijving.deelnemer = qDeelnemer.getFirstObject() as? Deelnemer
        
        //inschrijving.contactpersoon1 = LocalDatastore.getFirstObject(Constanten.TABLE_CONTACTPERSOON, query: queryCP1) as? ContactpersoonNood
        inschrijving.contactpersoon1 = qCP1.getFirstObject() as? ContactpersoonNood
        
        
        /*if !LocalDatastore.isResultSetEmpty(queryCP2) {
            inschrijving.contactpersoon2 = LocalDatastore.getFirstObject(Constanten.TABLE_CONTACTPERSOON, query: queryCP2) as? ContactpersoonNood
        }*/
        
        if !qCP2.isEmpty() {
            inschrijving.contactpersoon2 = qCP2.getFirstObject() as? ContactpersoonNood
        }
        
        inschrijving.periode = object[Constanten.COLUMN_PERIODE] as? String
        inschrijving.extraInfo = object[Constanten.COLUMN_EXTRAINFORMATIE] as? String

        return inschrijving
    }
    
    //
    //Function: insert
    //
    //Deze functie insert een InschrijvingVakantie object in de local datastore en
    //synct deze verandering dan naar de online database.
    //
    //Parameters: - inschrijving: InschrijvingVakantie
    //
    static func insert(inschrijving: InschrijvingVakantie) {
        
        let object = PFObject(className: Constanten.TABLE_INSCHRIJVINGVAKANTIE)
        
        var extraInfo: String?
        var vakantie: Vakantie?
        var periode: String?
        var ouder: Ouder?
        var deelnemer: Deelnemer?
        var contactpersoon1: ContactpersoonNood?
        var contactpersoon2: ContactpersoonNood?
        
        object[Constanten.COLUMN_EXTRAINFORMATIE] = inschrijving.extraInfo
        object[Constanten.COLUMN_VAKANTIE] = inschrijving.vakantie?.id
        object[Constanten.COLUMN_OUDER] = inschrijving.ouder?.id
        object[Constanten.COLUMN_DEELNEMER] = inschrijving.deelnemer?.id
        object[Constanten.COLUMN_CONTACTPERSOON1] = inschrijving.contactpersoon1?.id
        
        if inschrijving.contactpersoon2 != nil {
            object[Constanten.COLUMN_CONTACTPERSOON2] = inschrijving.contactpersoon2?.id
        }
        
        object.pin()
        object.save()
    }
}