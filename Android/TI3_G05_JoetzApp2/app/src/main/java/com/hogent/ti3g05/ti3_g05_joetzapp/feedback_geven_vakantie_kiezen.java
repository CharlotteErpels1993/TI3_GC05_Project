package com.hogent.ti3g05.ti3_g05_joetzapp;

import android.app.Activity;
import android.content.Intent;
import android.os.AsyncTask;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.Spinner;
import android.widget.TextView;

import com.hogent.ti3g05.ti3_g05_joetzapp.domein.Vakantie;
import com.parse.ParseException;
import com.parse.ParseObject;
import com.parse.ParseQuery;

import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

/**
 * Created by Gebruiker on 10/12/2014.
 */


public class feedback_geven_vakantie_kiezen extends Activity {


    private Spinner spinner;
    private List<Vakantie> vakanties;
    private List<String> vakantienamen;
    private List<ParseObject> lijstMetParseObjecten;
    private Vakantie map;
    private String[] array;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.feedback_geven_vakantie_kiezen);

        spinner = (Spinner) findViewById( R.id.spinnerFeedbackVakanties );
        Button btnVolgende = (Button) findViewById(R.id.KiesVakantie);

        getActionBar().setTitle("Kies een vakantie");
        btnVolgende.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                gaVerder();
            }
        });
        new RemoteDataTask().execute();

    }
    public void gaVerder(){

        Iterator<Vakantie> vakantieIt = vakanties.iterator();
        Vakantie vakantie = new Vakantie();

        for(Vakantie vak : vakanties)//while(vakantieIt.hasNext())
        {

            //Toast.makeText(IndienenVoorkeurVakantie.this, spinner.getSelectedItem().toString(), Toast.LENGTH_LONG).show();
            if(spinner.getSelectedItem().toString().equals(vak.getNaamVakantie()))
            {
                vakantie=vak;
            }
        }
        Intent intentFeedback = new Intent(feedback_geven_vakantie_kiezen.this, feedback_geven.class);

        intentFeedback.putExtra("vakantie", vakantie.getNaamVakantie());
        intentFeedback.putExtra("vakantieId", vakantie.getVakantieID());
        startActivity(intentFeedback);
        overridePendingTransition(R.anim.right_in, R.anim.left_out);

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
                lijstMetParseObjecten = query.find();
                for (ParseObject vakantie : lijstMetParseObjecten) {

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

                    map.setVakantieID(vakantie.getObjectId());
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

            // Binds the Adapter to the ListView

            array = new String[vakantienamen.size()];
            int vakantienamenLengte = vakantienamen.size();
            for(int i = 0 ;i < vakantienamenLengte; i++)
            {
                array[i] = vakantienamen.get(i);
            }

            ArrayAdapter<String> spinnerArrayAdapter = new ArrayAdapter<String>(feedback_geven_vakantie_kiezen.this, android.R.layout.simple_spinner_item,array);
            spinnerArrayAdapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
            spinner.setAdapter(spinnerArrayAdapter);

        }
    }
}
