package com.hogent.ti3g05.ti3_g05_joetzapp.SQLLite;


//Alle constante namen die gebruikt zullen worden in de locale database
public class Constants {

    public static final int DATABASE_VERSION = 2;
    public static final String DATABASE_NAAM = "joetz.db";

    //Constanten voor de vakanties
    public static final String TABLE_VAKANTIE = "vakantie";

    public static final String COLUMN_ID = "_id";
    public static final String COLUMN_VAKANTIENAAM = "titel";
    public static final String COLUMN_LOCATIE = "locatie";
    public static final String COLUMN_VERTREKDATUM = "vertrekdatum";
    public static final String COLUMN_TERUGDATUM = "terugdatum";
    public static final String COLUMN_PRIJS = "basisPrijs";
    public static final String COLUMN_AFBEELDING1 = "afbeelding1";
    public static final String COLUMN_AFBEELDING2 = "afbeelding2";
    public static final String COLUMN_AFBEELDING3 = "afbeelding3";
    public static final String COLUMN_MAXDOELGROEP = "Maxdoelgroep";
    public static final String COLUMN_MINDOELGROEP = "Mindoelgroep";
    public static final String COLUMN_BESCHRIJVING = "beschrijving";
    public static final String COLUMN_PERIODE = "periode";
    public static final String COLUMN_VERVOER = "vervoer";
    public static final String COLUMN_FORMULE = "formule";
    public static final String COLUMN_MAXDEELNEMERS = "maxAantalDeelnemers";
    public static final String COLUMN_INBEGREPENINPRIJS = "inbegrepenInPrijs";
    public static final String COLUMN_BMLEDENPRIJS = "BMLedenPrijs";
    public static final String COLUMN_STERPRIJSOUDER1 = "sterPrijsOuder1";
    public static final String COLUMN_STERPRIJS2OUDERS = "sterPrijs2Ouder";
    public static final String COLUMN_GEMIDDELDERATING = "gemiddeldeRating";

    //Constanten voor de profielen
    public static final String TABLE_PROFIELEN = "monitor";
    public static final String COLUMN_AANSLUITINGSNUMMER = "aansluitingsNr";
    public static final String COLUMN_BUS = "bus";
    public static final String COLUMN_CODEGERECHTIGDE = "codeGerechtigde";
    public static final String COLUMN_EMAIL = "email";
    public static final String COLUMN_GEMEENTE = "gemeente";
    public static final String COLUMN_GSM = "gsm";
    public static final String COLUMN_LIDNR = "lidNr";
    public static final String COLUMN_LINKFACEBOOK = "linkFacebook";
    public static final String COLUMN_NAAM = "naam";
    public static final String COLUMN_NUMMER = "nummer";
    public static final String COLUMN_POSTCODE = "postcode";
    public static final String COLUMN_RIJKSREGISTERNUMMER = "rijksregisterNr";
    public static final String COLUMN_STRAAT = "straat";
    public static final String COLUMN_TELEFOON = "telefoon";
    public static final String COLUMN_VOORNAAM = "voornaam";

    //Constanten voor de vormingen

    public static final String TABLE_VORMINGEN = "vorming";
    public static final String COLUMN_BETALINGSWIJZE = "betalingswijze";
    public static final String COLUMN_CRITERIADEELNEMER = "criteriaDeelnemer";
    public static final String COLUMN_INBEGREPENINPRIJSV = "inbegrepenInPrijs";
    public static final String COLUMN_KORTEBESCHRIJVING = "korteBeschrijving";
    public static final String COLUMN_LOCATIEV = "locatie";
    public static final String COLUMN_PERIODES = "periodes";
    public static final String COLUMN_PRIJSV = "prijs";
    public static final String COLUMN_TIPS = "tips";
    public static final String COLUMN_TITEL = "titel";
    public static final String COLUMN_WEBSITELOCATIE = "websiteLocatie";

    //Constanten voor de favorieten

    public static final String TABLE_FAVORIETEN = "favorieten";
    public static final String COLUMN_VAKANTIEID = "vakantieID";

    //Constanten voor de Feedback

    public static final String TABLE_FEEDBACK = "feedback";
    public static final String COLUMN_FEEDBACK = "feedback";
    public static final String COLUMN_SCORE = "score";
    public static final String COLUMN_VAKANTIENAAMF = "vakantienaam";
    
    public static final String COLUMN_GEBRUIKERID = "gebruikerId";
    public static final String COLUMN_GEBRUIKER = "gebruiker";
    public static final String COLUMN_GOEDGEKEURD = "goedgekeurd";



}
