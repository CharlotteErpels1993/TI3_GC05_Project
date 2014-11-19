package com.hogent.ti3g05.ti3_g05_joetzapp;

import android.app.Activity;
import android.app.ProgressDialog;
import android.os.AsyncTask;
import android.os.Bundle;
import android.support.v4.app.DialogFragment;
import android.support.v4.app.FragmentActivity;
import android.text.Editable;
import android.text.TextWatcher;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.NumberPicker;
import android.widget.TextView;
import android.widget.Toast;

import com.hogent.ti3g05.ti3_g05_joetzapp.Services.ConnectionDetector;
import com.hogent.ti3g05.ti3_g05_joetzapp.Services.ListViewAdapter;
import com.hogent.ti3g05.ti3_g05_joetzapp.domein.Vakantie;
import com.parse.ParseException;
import com.parse.ParseFile;
import com.parse.ParseObject;
import com.parse.ParseQuery;

import java.sql.Array;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Locale;

/**
 * Created by Gebruiker on 19/11/2014.
 */
public class IndienenVoorkeurVakantie extends Activity {

    private ListViewAdapter adapter;
    private ArrayList<String> vakantienamen = null;
    private List<Vakantie> vakanties = null;
    private String[] array;
    private ProgressDialog mProgressDialog;
    private List<ParseObject> ob;
    Vakantie map;
    TextView indienenVoorkeurVakantie;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.indienen_voorkeur_vakantie);
        new RemoteDataTask().execute();


       indienenVoorkeurVakantie = (TextView)findViewById(R.id.IndienenVoorkeurVak);



    }


    public void showVakantiePickerDialog(View v) {
        NumberPicker picker = new NumberPicker(this);
        picker.setMinValue(0);
        picker.setMaxValue(vakantienamen.size());
        array = new String[vakantienamen.size()];
        for(int i = 0 ;i < vakantienamen.size(); i++)
        {
            array[i] = vakantienamen.get(i);
        }
        picker.setDisplayedValues(array);

    }

    // RemoteDataTask AsyncTask
    private class RemoteDataTask extends AsyncTask<Void, Void, Void> {
        @Override
        protected void onPreExecute() {
            super.onPreExecute();
        }

        @Override
        protected Void doInBackground(Void... params) {
            // Create the array
            vakanties = new ArrayList<Vakantie>();
            vakantienamen = new ArrayList<String>();

            try {
                // Locate the class table named "vakantie" in Parse.com
                ParseQuery<ParseObject> query = new ParseQuery<ParseObject>(
                        "Vakantie");

                query.orderByAscending("vertrekdatum");
                ob = query.find();
                for (ParseObject vakantie : ob) {

                    map = new Vakantie();

                    //String prijs = vakantie.get("basisPrijs").toString();
                    map.setNaamVakantie((String) vakantie.get("titel"));

                    map.setLocatie((String) vakantie.get("locatie"));
                    map.setKorteBeschrijving((String) vakantie.get("korteBeschrijving"));
                    map.setDoelGroep((String) vakantie.get("doelgroep"));
                    map.setBasisprijs((Number) vakantie.get("basisPrijs"));
                    map.setMaxAantalDeelnemers((Number) vakantie.get("maxAantalDeelnemers"));
                    map.setPeriode((String) vakantie.get("aantalDagenNachten"));
                    map.setFormule((String) vakantie.get("formule"));
                    map.setVervoerswijze((String) vakantie.get("vervoerwijze"));
                    map.setVertrekDatum((Date) vakantie.get("vertrekdatum"));
                    map.setTerugkeerDatum((Date) vakantie.get("terugkeerdatum"));
                    map.setInbegrepenInPrijs((String) vakantie.get("inbegrepenPrijs"));
                    map.setVakantieID((String) vakantie.get("objectId"));
                    if (vakantie.get("bondMoysonLedenPrijs") != null)
                        map.setBondMoysonLedenPrijs((Number) vakantie.get("bondMoysonLedenPrijs"));
                    if (vakantie.get("sterPrijs1ouder") != null)
                        map.setSterPrijs1Ouder((Number) vakantie.get("sterPrijs1ouder"));
                    if (vakantie.get("sterPrijs2ouders") != null)
                        map.setSterPrijs2Ouder((Number) vakantie.get("sterPrijs2ouders"));


                    vakanties.add(map);
                    vakantienamen.add(map.getNaamVakantie());

                }

            } catch (ParseException e) {

                Log.e("Error", e.getMessage());
                e.printStackTrace();
            }
            return null;
        }

        @Override
        protected void onPostExecute(Void result) {

            indienenVoorkeurVakantie.setText(vakantienamen.get(0));
            // Binds the Adapter to the ListView



        }
    }
}
