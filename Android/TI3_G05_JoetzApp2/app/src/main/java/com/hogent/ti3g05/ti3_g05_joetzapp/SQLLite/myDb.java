package com.hogent.ti3g05.ti3_g05_joetzapp.SQLLite;

import android.content.ContentValues;
import android.content.Context;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteException;
import android.util.Log;

/**
 * Created by Gebruiker on 17/11/2014.
 */
public class myDb {

    protected DBHandler db;
    private final Context context;
    private SQLiteDatabase sqLiteDatabase;

    public myDb(Context context) {
        this.context = context;
        db = new DBHandler(context,null);
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

    public void close()
    {
        try{
            db.close();
        }catch (SQLiteException e)
        {
            Log.e("mydb","kon db niet sluiten");
        }
    }

    public long insertVakantie(ContentValues nieuweVakantie)
    {
        return db.toevoegenGegevensVakantie(nieuweVakantie);
    }

    public Cursor getVakanties()
    {
        String query = "SELECT * FROM" + Constants.TABLE_VAKANTIE;
        Cursor c = sqLiteDatabase.rawQuery(query,null);

        return c;
    }


}
