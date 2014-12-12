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
import android.widget.Toast;

import com.hogent.ti3g05.ti3_g05_joetzapp.Services.ConnectionDetector;
import com.hogent.ti3g05.ti3_g05_joetzapp.domein.Vakantie;
import com.parse.ParseException;
import com.parse.ParseObject;
import com.parse.ParseQuery;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

//Indien de gebruiker vanuit het feedbackoverzicht feedback wenst toe te voegen moet deze eerst een vakantie kiezen
public class feedbac_geven_vakantie_kiezen extends Activity {

    private Spinner spinner;
    private List<Vakantie> vakanties;
    private List<String> vakantienamen;
    private List<ParseObject> lijstMetParseObjecten;
    private Vakantie vakantie;
    private String[] vakantieArray;
    private Boolean isInternetPresent = false;
    private ConnectionDetector cd;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.feedback_geven_vakantie_kiezen);

        spinner = (Spinner) findViewById( R.id.spinnerFeedbackVakanties );
        Button btnVolgende = (Button) findViewById(R.id.KiesVakantie);
        cd= new ConnectionDetector(this);

        isInternetPresent = cd.isConnectingToInternet();
        getActionBar().setTitle("Kies een vakantie");
        btnVolgende.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                if (isInternetPresent) {
                    //Controleer of er internet aanwezig is haal de vakanties op
                    gaVerder();
                } else {
                    Toast.makeText(getApplicationContext(), getString(R.string.error_no_internet), Toast.LENGTH_SHORT).show();

                }
            }
        });

        if(isInternetPresent) {
            new RemoteDataTask().execute();
        }else {
            Toast.makeText(getApplicationContext(), getString(R.string.error_no_internet), Toast.LENGTH_SHORT).show();

        }
    }
    //Haal de vakanties op
    public void gaVerder(){

        Vakantie vakantie = new Vakantie();

        for(Vakantie vak : vakanties)
        {

            if(spinner.getSelectedItem().toString().equals(vak.getNaamVakantie()))
            {
                vakantie=vak;
            }
        }
        Intent intentFeedback = new Intent(feedbac_geven_vakantie_kiezen.this, feedback_geven.class);

        //Geef de nodige gegevens door naar de volgende stap
        intentFeedback.putExtra("vakantie", vakantie.getNaamVakantie());
        intentFeedback.putExtra("vakantieId", vakantie.getVakantieID());
        startActivity(intentFeedback);
        overridePendingTransition(R.anim.right_in, R.anim.left_out);

    }


    // Asynchrone taak om vakanties op te halen
    private class RemoteDataTask extends AsyncTask<Void, Void, Void> {
        @Override
        protected void onPreExecute() {
            super.onPreExecute();
        }

        @Override
        protected Void doInBackground(Void... params) {
            vakanties = new ArrayList<Vakantie>();
            vakantienamen = new ArrayList<String>();

            try {
                ParseQuery<ParseObject> query = new ParseQuery<ParseObject>(
                        "Vakantie");

                query.orderByAscending("vertrekdatum");
                lijstMetParseObjecten = query.find();
                for (ParseObject v : lijstMetParseObjecten) {

                    vakantie = new Vakantie();

                    vakantie.setNaamVakantie((String) v.get("titel"));

                    vakantie.setLocatie((String) v.get("locatie"));
                    vakantie.setKorteBeschrijving((String) v.get("korteBeschrijving"));
                    vakantie.setDoelGroep((String) v.get("doelgroep"));
                    vakantie.setBasisprijs((Number) v.get("basisPrijs"));
                    vakantie.setMaxAantalDeelnemers((Number) v.get("maxAantalDeelnemers"));
                    vakantie.setPeriode((String) v.get("aantalDagenNachten"));
                    vakantie.setFormule((String) v.get("formule"));
                    vakantie.setVervoerswijze((String) v.get("vervoerwijze"));
                    vakantie.setVertrekDatum((Date) v.get("vertrekdatum"));
                    vakantie.setTerugkeerDatum((Date) v.get("terugkeerdatum"));
                    vakantie.setInbegrepenInPrijs((String) v.get("inbegrepenPrijs"));

                    vakantie.setVakantieID(v.getObjectId());
                    if (v.get("bondMoysonLedenPrijs") != null)
                        vakantie.setBondMoysonLedenPrijs((Number) v.get("bondMoysonLedenPrijs"));
                    if (v.get("sterPrijs1ouder") != null)
                        vakantie.setSterPrijs1Ouder((Number) v.get("sterPrijs1ouder"));
                    if (v.get("sterPrijs2ouders") != null)
                        vakantie.setSterPrijs2Ouder((Number) v.get("sterPrijs2ouders"));


                    vakanties.add(vakantie);
                    vakantienamen.add(vakantie.getNaamVakantie());

                }

            } catch (ParseException e) {

                Log.e("Error", e.getMessage());
                e.printStackTrace();
            }
            return null;
        }

        //Zet de vakanties in de spinner
        @Override
        protected void onPostExecute(Void result) {

            vakantieArray = new String[vakantienamen.size()];
            int vakantienamenLengte = vakantienamen.size();
            for(int i = 0 ;i < vakantienamenLengte; i++)
            {
                vakantieArray[i] = vakantienamen.get(i);
            }

            ArrayAdapter<String> spinnerArrayAdapter = new ArrayAdapter<String>(feedbac_geven_vakantie_kiezen.this, android.R.layout.simple_spinner_item,vakantieArray);
            spinnerArrayAdapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
            spinner.setAdapter(spinnerArrayAdapter);

        }
    }
}
