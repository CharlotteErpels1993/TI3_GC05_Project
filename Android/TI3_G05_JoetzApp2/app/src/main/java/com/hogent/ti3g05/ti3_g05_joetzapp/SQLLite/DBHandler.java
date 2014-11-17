package com.hogent.ti3g05.ti3_g05_joetzapp.SQLLite;

import android.content.ContentValues;
import android.content.Context;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;

import com.hogent.ti3g05.ti3_g05_joetzapp.domein.Vakantie;

import java.awt.font.NumericShaper;
import java.util.ArrayList;
import java.util.List;

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
        sqLiteDatabase.execSQL(CREATE_VAKANTIE_TABLE);
    }

    @Override
    public void onUpgrade(SQLiteDatabase sqLiteDatabase, int i, int i2) {
        sqLiteDatabase.execSQL("DROP TABLE IF EXISTS " + TABLE_VAKANTIE);
        onCreate(sqLiteDatabase);

    }

    public void drop(SQLiteDatabase db)
    {
        db.execSQL("DROP TABLE IF EXISTS " + TABLE_VAKANTIE);
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
        cursor.close();
        db.close();
        return vakantie;
    }

   /* public long toevoegenGegevensVakantie(ContentValues nieuweVakantie) {
        return 0;
    }*/
}
