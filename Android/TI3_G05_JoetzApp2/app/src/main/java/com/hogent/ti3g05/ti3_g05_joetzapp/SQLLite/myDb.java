package com.hogent.ti3g05.ti3_g05_joetzapp.SQLLite;

import android.content.ContentValues;
import android.content.Context;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteException;
import android.util.Log;

import com.hogent.ti3g05.ti3_g05_joetzapp.domein.Monitor;
import com.hogent.ti3g05.ti3_g05_joetzapp.domein.Vakantie;

import java.util.List;

import static com.hogent.ti3g05.ti3_g05_joetzapp.SQLLite.Constants.TABLE_VAKANTIE;

/**
 * Created by Gebruiker on 17/11/2014.
 */
public class myDb {

    protected DBHandler db;
    private final Context context;
    private SQLiteDatabase sqLiteDatabase;

    public myDb(Context context) {
        this.context = context;
        db = new DBHandler(context);
    }

    public void open()
    {
        try{
            db.getWritableDatabase();

        }catch(SQLiteException ex)
        {
            Log.e("mydb", "kon db niet openen");
        }
    }

    public void drop()
    {
       db.drop(db.getWritableDatabase());

    }

    public void dropProfielen()
    {
        db.dropProfielen(db.getWritableDatabase());

    }

    public void close()
    {
        try{
            db.close();
        }catch (SQLiteException e)
        {
            Log.e("mydb","kon db niet sluiten");
        }
    }

    public long insertVakantie(Vakantie nieuweVakantie)
    {
        return db.toevoegenGegevensVakantie(nieuweVakantie);
    }

    public List<Vakantie> getVakanties()
    {
        return db.krijgAlleVakanties();
    }

    public Vakantie getVakanie(String naam)
    {
        return db.krijgVakanties(naam);
    }


    //TODO moet ook voor vormingen en profielen, dus nieuwe tabel aanmaken, en functies in helper

    public long insertProfiel(Monitor nieuwProfiel)
    {
        return db.toevoegenGegevensMonitor(nieuwProfiel);
    }

    public List<Monitor> getProfielen()
    {
        return db.krijgProfielen();
    }

    public Monitor getProfiel(String naam)
    {
        return db.krijgProfielen(naam);
    }

}
