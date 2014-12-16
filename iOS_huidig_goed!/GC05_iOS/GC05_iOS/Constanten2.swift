//ALGEMEEN
let REQUIRED: String = "required"
let OPTIONAL: String = "optional"

//TABLES
let AFBEELDING_DB: String = "Afbeelding"
let CONTACTPERSOON_NOOD_DB: String = "ContactpersoonNood"
let DEELNEMER_DB: String = "Deelnemer"
let FAVORIET_DB: String = "Favoriet"
let FEEDBACK_DB: String = "Feedback"
let INSCHRIJVING_VAKANTIE_DB: String = "InschrijvingVakantie"
let INSCHRIJVING_VORMING_DB: String = "InschrijvingVorming"
let MONITOR_DB: String = "Monitor"
let OUDER_DB: String = "Ouder"
let VAKANTIE_DB: String = "Vakantie"
let VOORKEUR_DB: String = "Voorkeur"
let VORMING_DB: String = "Vorming"

//VARIABELEN VAKANTIE
let OBJECT_ID_DB: String = "objectId"
let TITEL_DB: String = "titel"
let LOCATIE_DB: String = "locatie"
let KORTE_BESCHRIJVING_DB: String = "korteBeschrijving"
let VERTREK_DATUM_DB: String = "vertrekdatum"
let TERUGKEER_DATUM_DB: String = "terugkeerdatum"
let AANTAL_DAGEN_NACHTEN_DB: String = "aantalDagenNachten"
let VERVOERWIJZE_DB: String = "vervoerwijze"
let FORMULE_DB: String = "formule"
let LINK_DB: String = "link"
let BASIS_PRIJS_DB: String = "basisPrijs"
let BOND_MOYSON_LEDEN_PRIJS_DB: String = "bondMoysonLedenPrijs"
let STER_PRIJS_1_OUDER_DB: String = "sterPrijs1ouder"
let STER_PRIJS_2_OUDERS_DB: String = "sterPrijs2ouders"
let INBEGREPEN_PRIJS_DB: String = "inbegrepenPrijs"
let MIN_LEEFTIJD_DB: String = "minLeeftijd"
let MAX_LEEFTIJD_DB: String = "maxLeeftijd"
let MAX_AANTAL_DEELNEMERS_DB: String = "maxAantalDeelnemers"

//COLUMNS VAKANTIE
let VAKANTIE_COLUMNS_DB: [String: SwiftData.DataType] =
    [OBJECT_ID_DB: .StringVal,
     TITEL_DB: .StringVal,
     LOCATIE_DB: .StringVal,
     KORTE_BESCHRIJVING_DB: .StringVal,
     VERTREK_DATUM_DB: .StringVal,
     TERUGKEER_DATUM_DB: .StringVal,
     AANTAL_DAGEN_NACHTEN_DB: .StringVal,
     VERVOERWIJZE_DB: .StringVal,
     FORMULE_DB: .StringVal,
     LINK_DB: .StringVal,
     BASIS_PRIJS_DB: .DoubleVal,
     BOND_MOYSON_LEDEN_PRIJS_DB: .DoubleVal,
     STER_PRIJS_1_OUDER_DB: .DoubleVal,
     STER_PRIJS_2_OUDERS_DB: .DoubleVal,
     INBEGREPEN_PRIJS_DB: .StringVal,
     MIN_LEEFTIJD_DB: .IntVal,
     MAX_LEEFTIJD_DB: .IntVal,
     MAX_AANTAL_DEELNEMERS_DB: .IntVal]

//REQUIRED AND OPTIONAL VELDEN
let VAKANTIE_VALUES: [String: String] =
    [OBJECT_ID_DB: REQUIRED,
     TITEL_DB: REQUIRED,
     LOCATIE_DB: REQUIRED,
     KORTE_BESCHRIJVING_DB: REQUIRED,
     VERTREK_DATUM_DB: REQUIRED,
     TERUGKEER_DATUM_DB: REQUIRED,
     AANTAL_DAGEN_NACHTEN_DB: REQUIRED,
     VERVOERWIJZE_DB: REQUIRED,
     FORMULE_DB: REQUIRED,
     LINK_DB: REQUIRED,
     BASIS_PRIJS_DB: REQUIRED,
     BOND_MOYSON_LEDEN_PRIJS_DB: OPTIONAL,
     STER_PRIJS_1_OUDER_DB: OPTIONAL,
     STER_PRIJS_2_OUDERS_DB: OPTIONAL,
     INBEGREPEN_PRIJS_DB: REQUIRED,
     MIN_LEEFTIJD_DB: REQUIRED,
     MAX_LEEFTIJD_DB: REQUIRED,
     MAX_AANTAL_DEELNEMERS_DB: REQUIRED]










