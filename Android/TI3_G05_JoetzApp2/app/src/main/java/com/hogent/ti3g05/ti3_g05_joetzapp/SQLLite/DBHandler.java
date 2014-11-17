package com.hogent.ti3g05.ti3_g05_joetzapp.SQLLite;

import android.content.ContentValues;
import android.content.Context;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;

import com.hogent.ti3g05.ti3_g05_joetzapp.domein.Vakantie;

import java.awt.font.NumericShaper;

public class DBHandler extends SQLiteOpenHelper {

    private static final int DATABASE_VERSION = 1;
    private static final String DATABASE_NAAM = "joetz.db";
    private static final String TABLE_VAKANTIE = "vakantie";

    public static final String COLUMN_ID = "_id";
    public static final String COLUMN_VAKANTIENAAM = "titel";
    public static final String COLUMN_LOCATIE = "locatie";
    public static final String COLUMN_VERTREKDATUM = "vertrekdatum";
    public static final String COLUMN_TERUGDATUM = "terugdatum";
    public static final String COLUMN_PRIJS = "basisPrijs";
    public static final String COLUMN_AFBEELDING1 = "afbeelding1";
    public static final String COLUMN_AFBEELDING2 = "afbeelding2";
    public static final String COLUMN_AFBEELDING3 = "afbeelding3";
    public static final String COLUMN_DOELGROEP = "doelgroep";
    public static final String COLUMN_BESCHRIJVING = "beschrijving";
    public static final String COLUMN_PERIODE = "periode";
    public static final String COLUMN_VERVOER = "vervoer";
    public static final String COLUMN_FORMULE = "formule";
    public static final String COLUMN_MAXDEELNEMERS = "maxAantalDeelnemers";
    public static final String COLUMN_INBEGREPENINPRIJS = "inbegrepenInPrijs";
    public static final String COLUMN_BMLEDENPRIJS = "BMLedenPrijs";
    public static final String COLUMN_STERPRIJSOUDER1 = "sterPrijsOuder1";
    public static final String COLUMN_STERPRIJS2OUDERS = "sterPrijs2Ouders";


    public DBHandler(Context context, SQLiteDatabase.CursorFactory factory){
        super(context, DATABASE_NAAM,factory,DATABASE_VERSION);
    }

    @Override
    public void onCreate(SQLiteDatabase sqLiteDatabase) {
        String CREATE_VAKANTIE_TABLE = "CREATE TABLE " + TABLE_VAKANTIE + "(" +COLUMN_ID + " INTEGER PRIMARY KEY," +COLUMN_VAKANTIENAAM + " TEXT," + COLUMN_LOCATIE + " TEXT," + COLUMN_VERTREKDATUM + " TEXT," +
                COLUMN_TERUGDATUM + " TEXT," + COLUMN_PRIJS + " NUMERIC," + COLUMN_AFBEELDING1 + " TEXT," +COLUMN_AFBEELDING2 + " TEXT," +COLUMN_AFBEELDING3 + " TEXT," +
                COLUMN_DOELGROEP + " TEXT," + COLUMN_BESCHRIJVING + " TEXT," + COLUMN_PERIODE + " TEXT," + COLUMN_VERVOER + " TEXT," +
                COLUMN_FORMULE + " TEXT," + COLUMN_MAXDEELNEMERS + " NUMERIC," + COLUMN_INBEGREPENINPRIJS + " TEXT," + COLUMN_BMLEDENPRIJS + " NUMERIC," +
                COLUMN_STERPRIJSOUDER1 + " NUMERIC" + COLUMN_STERPRIJS2OUDERS + " NUMERIC" + ")";
        sqLiteDatabase.execSQL(CREATE_VAKANTIE_TABLE);
    }

    @Override
    public void onUpgrade(SQLiteDatabase sqLiteDatabase, int i, int i2) {
        sqLiteDatabase.execSQL("DROP TABLE IF EXISTS " + TABLE_VAKANTIE);
        onCreate(sqLiteDatabase);

    }

    public void toevoegenGegevensVakantie(Vakantie vakantie)
    {
        ContentValues values = new ContentValues();
        values.put(COLUMN_VAKANTIENAAM, vakantie.getNaamVakantie());
        values.put(COLUMN_LOCATIE, vakantie.getLocatie());
        values.put(COLUMN_VERTREKDATUM, vakantie.getVertrekDatum().toString());
        values.put(COLUMN_TERUGDATUM, vakantie.getTerugkeerDatum().toString());

        values.put(COLUMN_PRIJS,(Integer) vakantie.getBasisprijs());
        values.put(COLUMN_AFBEELDING1, vakantie.getFoto1());
        values.put(COLUMN_AFBEELDING2, vakantie.getFoto2());
        values.put(COLUMN_AFBEELDING3, vakantie.getFoto3());
        values.put(COLUMN_DOELGROEP, vakantie.getDoelGroep());

        values.put(COLUMN_BESCHRIJVING, vakantie.getKorteBeschrijving());
        values.put(COLUMN_PERIODE, vakantie.getPeriode());
        values.put(COLUMN_VERVOER, vakantie.getVervoerswijze());

        values.put(COLUMN_FORMULE, vakantie.getFormule());
        values.put(COLUMN_MAXDEELNEMERS, (Integer) vakantie.getMaxAantalDeelnemers());
        values.put(COLUMN_INBEGREPENINPRIJS, vakantie.getInbegrepenInPrijs());
        values.put(COLUMN_BMLEDENPRIJS,(Integer) vakantie.getBondMoysonLedenPrijs());

        values.put(COLUMN_STERPRIJSOUDER1,(Integer) vakantie.getSterPrijs1Ouder());
        values.put(COLUMN_STERPRIJS2OUDERS,(Integer) vakantie.getSterPrijs2Ouder());
        SQLiteDatabase db = this.getWritableDatabase();

        db.insert(TABLE_VAKANTIE, null, values);
        db.close();
    }

    public Vakantie krijgVakanties(String vakantienaam)
    {
        String query = "Select * FROM " + TABLE_VAKANTIE + " WHERE " + COLUMN_VAKANTIENAAM + " = \"" + vakantienaam + "\"";
        SQLiteDatabase db = this.getWritableDatabase();

        Cursor cursor = db.rawQuery(query, null);

        Vakantie vakantie = new Vakantie();

        if(cursor.moveToFirst())
        {
            cursor.moveToFirst();
            vakantie.setNaamVakantie(cursor.getString(1));
            vakantie.setLocatie(cursor.getString(2));
            //vakantie.setVertrekDatum(cursor.getString(3));
            //vakantie.setTerugdatum(cursor.getString(4));
            vakantie.setBasisprijs(Integer.parseInt(cursor.getString(5)));
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
        db.close();
        return vakantie;
    }
}
