package com.hogent.ti3g05.ti3_g05_joetzapp.SQLLite;

import android.content.ContentValues;
import android.content.Context;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;

import com.hogent.ti3g05.ti3_g05_joetzapp.domein.Monitor;
import com.hogent.ti3g05.ti3_g05_joetzapp.domein.Vakantie;

import java.awt.font.NumericShaper;
import java.util.ArrayList;
import java.util.List;

import static com.hogent.ti3g05.ti3_g05_joetzapp.SQLLite.Constants.TABLE_PROFIELEN;
import static com.hogent.ti3g05.ti3_g05_joetzapp.SQLLite.Constants.TABLE_VAKANTIE;

public class DBHandler extends SQLiteOpenHelper {



    public DBHandler(Context context)
    {
        super(context,Constants.DATABASE_NAAM, null, Constants.DATABASE_VERSION);

    }


    @Override
    public void onCreate(SQLiteDatabase sqLiteDatabase) {
        String CREATE_VAKANTIE_TABLE = "CREATE TABLE " + TABLE_VAKANTIE + "(" +Constants.COLUMN_ID + " INTEGER PRIMARY KEY AUTOINCREMENT," +Constants.COLUMN_VAKANTIENAAM + " TEXT," + Constants.COLUMN_LOCATIE + " TEXT," + Constants.COLUMN_VERTREKDATUM + " TEXT," +
                Constants.COLUMN_TERUGDATUM + " TEXT," + Constants.COLUMN_PRIJS + " NUMERIC," + Constants.COLUMN_AFBEELDING1 + " TEXT," +Constants.COLUMN_AFBEELDING2 + " TEXT," +Constants.COLUMN_AFBEELDING3 + " TEXT," +
                Constants.COLUMN_DOELGROEP + " TEXT," + Constants.COLUMN_BESCHRIJVING + " TEXT," + Constants.COLUMN_PERIODE + " TEXT," + Constants.COLUMN_VERVOER + " TEXT," +
                Constants.COLUMN_FORMULE + " TEXT," + Constants.COLUMN_MAXDEELNEMERS + " NUMERIC," + Constants.COLUMN_INBEGREPENINPRIJS + " TEXT," + Constants.COLUMN_BMLEDENPRIJS + " NUMERIC," +
                Constants.COLUMN_STERPRIJSOUDER1 + " NUMERIC," + Constants.COLUMN_STERPRIJS2OUDERS + " NUMERIC" + ")";


      /*  String CREATE_PROFIELEN_TABLE = "CREATE TABLE " + TABLE_PROFIELEN + "(" +Constants.COLUMN_ID + " INTEGER PRIMARY KEY AUTOINCREMENT," +Constants.COLUMN_AANSLUITINGSNUMMER + " NUMERIC," + Constants.COLUMN_BUS + " TEXT," + Constants.COLUMN_CODEGERECHTIGDE + " NUMERIC," +
                Constants.COLUMN_EMAIL + " TEXT," + Constants.COLUMN_GEMEENTE + " TEXT," + Constants.COLUMN_GSM + " TEXT," +Constants.COLUMN_LIDNR + " NUMERIC," +Constants.COLUMN_LINKFACEBOOK + " TEXT," +
                Constants.COLUMN_NAAM + " TEXT," + Constants.COLUMN_NUMMER + " NUMERIC," + Constants.COLUMN_POSTCODE + " NUMERIC," + Constants.COLUMN_RIJKSREGISTERNUMMER + " TEXT," +
                Constants.COLUMN_STRAAT + " TEXT," + Constants.COLUMN_TELEFOON + " TEXT," + Constants.COLUMN_VOORNAAM + " TEXT" + ")";*/
        sqLiteDatabase.execSQL(CREATE_VAKANTIE_TABLE);
        //sqLiteDatabase.execSQL(CREATE_PROFIELEN_TABLE);
    }

    @Override
    public void onUpgrade(SQLiteDatabase sqLiteDatabase, int i, int i2) {
        sqLiteDatabase.execSQL("DROP TABLE IF EXISTS " + TABLE_VAKANTIE);
        sqLiteDatabase.execSQL("DROP TABLE IF EXISTS " + TABLE_PROFIELEN);
        onCreate(sqLiteDatabase);

    }

    public void drop(SQLiteDatabase db)
    {
        db.execSQL("DROP TABLE IF EXISTS " + TABLE_VAKANTIE);
        db.execSQL("DROP TABLE IF EXISTS " + TABLE_PROFIELEN);
        onCreate(db);
    }

    public Long toevoegenGegevensVakantie(Vakantie vakantie)
    {
        ContentValues values = new ContentValues();
        values.put(Constants.COLUMN_VAKANTIENAAM, vakantie.getNaamVakantie());
        values.put(Constants.COLUMN_LOCATIE, vakantie.getLocatie());
        values.put(Constants.COLUMN_VERTREKDATUM, vakantie.getVertrekDatum().toString());
        values.put(Constants.COLUMN_TERUGDATUM, vakantie.getTerugkeerDatum().toString());

        values.put(Constants.COLUMN_PRIJS,(Integer) vakantie.getBasisprijs());
        values.put(Constants.COLUMN_AFBEELDING1, vakantie.getFoto1());
        values.put(Constants.COLUMN_AFBEELDING2, vakantie.getFoto2());
        values.put(Constants.COLUMN_AFBEELDING3, vakantie.getFoto3());
        values.put(Constants.COLUMN_DOELGROEP, vakantie.getDoelGroep());

        values.put(Constants.COLUMN_BESCHRIJVING, vakantie.getKorteBeschrijving());
        values.put(Constants.COLUMN_PERIODE, vakantie.getPeriode());
        values.put(Constants.COLUMN_VERVOER, vakantie.getVervoerswijze());

        values.put(Constants.COLUMN_FORMULE, vakantie.getFormule());
        values.put(Constants.COLUMN_MAXDEELNEMERS, (Integer) vakantie.getMaxAantalDeelnemers());
        values.put(Constants.COLUMN_INBEGREPENINPRIJS, vakantie.getInbegrepenInPrijs());
        values.put(Constants.COLUMN_BMLEDENPRIJS,(Integer) vakantie.getBondMoysonLedenPrijs());

        if((Integer)vakantie.getSterPrijs1Ouder()<0)
            vakantie.setSterPrijs1Ouder(0);
        if((Integer)vakantie.getSterPrijs2Ouder()<0)
            vakantie.setSterPrijs2Ouder(0);

        values.put(Constants.COLUMN_STERPRIJSOUDER1,(Integer) vakantie.getSterPrijs1Ouder());
        values.put(Constants.COLUMN_STERPRIJS2OUDERS,(Integer) vakantie.getSterPrijs2Ouder());
        SQLiteDatabase db = this.getWritableDatabase();

        Long id = db.insert(TABLE_VAKANTIE, null, values);
        db.close();

        return id;

    }

    public List<Vakantie> krijgAlleVakanties()
    {
        List<Vakantie> vakanties = new ArrayList<Vakantie>();
        SQLiteDatabase db = this.getWritableDatabase();
        String query = "SELECT * FROM " + TABLE_VAKANTIE;
        Cursor c = db.rawQuery(query,null);
        c.moveToFirst();
        while(!c.isAfterLast())
        {
            Vakantie v = krijgVakanties(c.getString(1));
            vakanties.add(v);
            c.moveToNext();
        }
        c.close();
        return vakanties;
    }

    public Vakantie krijgVakanties(String vakantienaam)
    {
        String query = "Select * FROM " + TABLE_VAKANTIE + " WHERE " + Constants.COLUMN_VAKANTIENAAM + " = \"" + vakantienaam + "\"";
        SQLiteDatabase db = this.getWritableDatabase();

        Cursor cursor = db.rawQuery(query, null);

        Vakantie vakantie = new Vakantie();

        if(cursor.moveToFirst())
        {
            cursor.moveToFirst();
            vakantie.setNaamVakantie(cursor.getString(1));
            vakantie.setLocatie(cursor.getString(2));
            vakantie.setVertrekDatumString(cursor.getString(3));
            vakantie.setTerugDatumString(cursor.getString(4));
            vakantie.setBasisprijs(Double.parseDouble(cursor.getString(5)));
            vakantie.setFoto1(cursor.getString(6));
            vakantie.setFoto2(cursor.getString(7));
            vakantie.setFoto3(cursor.getString(8));
            vakantie.setDoelGroep(cursor.getString(9));
            vakantie.setKorteBeschrijving(cursor.getString(10));
            vakantie.setPeriode(cursor.getString(11));
            vakantie.setVervoerswijze(cursor.getString(12));
            vakantie.setFormule(cursor.getString(13));
            vakantie.setMaxAantalDeelnemers(Integer.parseInt(cursor.getString(14)));
            vakantie.setInbegrepenInPrijs(cursor.getString(15));
            vakantie.setBondMoysonLedenPrijs(Integer.parseInt(cursor.getString(16)));
            vakantie.setSterPrijs1Ouder(Integer.parseInt(cursor.getString(17)));
            vakantie.setSterPrijs2Ouder(Integer.parseInt(cursor.getString(18)));
        } else
        {
            vakantie = null;
        }
        cursor.close();
        db.close();
        return vakantie;
    }

   /* public long toevoegenGegevensVakantie(ContentValues nieuweVakantie) {
        return 0;
    }*/

    public Long toevoegenGegevensMonitor(Monitor monitor)
    {
        ContentValues values = new ContentValues();
        values.put(Constants.COLUMN_AANSLUITINGSNUMMER,(Integer) monitor.getAansluitingsNr());
        values.put(Constants.COLUMN_BUS, monitor.getBus());
        values.put(Constants.COLUMN_CODEGERECHTIGDE,(Integer) monitor.getCodeGerechtigde());
        values.put(Constants.COLUMN_EMAIL, monitor.getEmail());

        values.put(Constants.COLUMN_GEMEENTE, monitor.getGemeente());
        values.put(Constants.COLUMN_GSM, monitor.getGsm());
        values.put(Constants.COLUMN_LIDNR, monitor.getLidNummer());
        values.put(Constants.COLUMN_LINKFACEBOOK, monitor.getLinkFacebook());
        values.put(Constants.COLUMN_NAAM, monitor.getNaam());

        values.put(Constants.COLUMN_NUMMER,(Integer) monitor.getHuisnr());
        values.put(Constants.COLUMN_POSTCODE, monitor.getPostcode());
        values.put(Constants.COLUMN_RIJKSREGISTERNUMMER, monitor.getRijksregNr());

        values.put(Constants.COLUMN_STRAAT, monitor.getStraat());
        values.put(Constants.COLUMN_TELEFOON, monitor.getTelefoon());
        values.put(Constants.COLUMN_VOORNAAM, monitor.getVoornaam());

        SQLiteDatabase db = this.getWritableDatabase();

        Long id = db.insert(TABLE_PROFIELEN, null, values);
        db.close();

        return id;

    }

    public List<Monitor> krijgProfielen()
    {
        List<Monitor> profielen = new ArrayList<Monitor>();
        SQLiteDatabase db = this.getWritableDatabase();
        String query = "SELECT * FROM " + TABLE_PROFIELEN;
        Cursor c = db.rawQuery(query,null);
        c.moveToFirst();
        while(!c.isAfterLast())
        {
            Monitor v = krijgProfielen(c.getString(15));
            profielen.add(v);
            c.moveToNext();
        }
        c.close();
        return profielen;
    }

    public Monitor krijgProfielen(String profielnaam)
    {
        String query = "Select * FROM " + TABLE_PROFIELEN + " WHERE " + Constants.COLUMN_NAAM + " = \"" + profielnaam + "\"";
        SQLiteDatabase db = this.getWritableDatabase();

        Cursor cursor = db.rawQuery(query, null);

        Monitor monitor = new Monitor();

        if(cursor.moveToFirst())
        {
            cursor.moveToFirst();
            monitor.setAansluitingsNr(Integer.parseInt(cursor.getString(1)));
            monitor.setBus(cursor.getString(2));
            monitor.setCodeGerechtigde(Integer.parseInt(cursor.getString(3)));
            monitor.setEmail(cursor.getString(4));
            monitor.setGemeente(cursor.getString(5));
            monitor.setGsm(cursor.getString(6));
            monitor.setLidNummer(Integer.parseInt(cursor.getString(7)));
            monitor.setLinkFacebook(cursor.getString(8));
            monitor.setNaam(cursor.getString(9));
            monitor.setHuisnr(Integer.parseInt(cursor.getString(10)));
            monitor.setPostcode(cursor.getString(11));
            monitor.setRijksregNr(cursor.getString(12));
            monitor.setStraat(cursor.getString(13));
            monitor.setTelefoon(cursor.getString(14));
            monitor.setVoornaam(cursor.getString(15));

        } else
        {
            monitor = null;
        }
        cursor.close();
        db.close();
        return monitor;
    }
}
