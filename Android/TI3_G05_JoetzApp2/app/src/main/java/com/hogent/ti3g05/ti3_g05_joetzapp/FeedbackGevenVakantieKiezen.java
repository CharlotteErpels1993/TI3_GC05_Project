package com.hogent.ti3g05.ti3_g05_joetzapp;

import android.app.Activity;
import android.content.Intent;
import android.os.AsyncTask;
import android.os.Bundle;
import android.util.Log;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.view.animation.Animation;
import android.view.animation.AnimationUtils;
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

/*Naam: FeedbackGevenVakantieKiezen

    Werking: Indien de gebruiker vanuit het feedbackoverzicht feedback wenst toe te voegen moet deze eerst een vakantie kiezen
    */
public class FeedbackGevenVakantieKiezen extends Activity {

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

        spinner = (Spinner) findViewById(R.id.spinnerFeedbackVakanties);
        final Button btnVolgende = (Button) findViewById(R.id.KiesVakantie);
        cd = new ConnectionDetector(this);

        final Animation animAlpha = AnimationUtils.loadAnimation(this, R.anim.alpha);

        isInternetPresent = cd.isConnectingToInternet();
        getActionBar().setTitle(getString(R.string.label_Vakantie_Kiezen));
        btnVolgende.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                btnVolgende.startAnimation(animAlpha);
                if (isInternetPresent) {
                    //Controleer of er internet aanwezig is haal de vakanties op
                    gaVerder();
                } else {
                    Toast.makeText(getApplicationContext(), getString(R.string.error_no_internet), Toast.LENGTH_SHORT).show();

                }
            }
        });

        if (isInternetPresent) {
            new RemoteDataTask().execute();
        } else {
            Toast.makeText(getApplicationContext(), getString(R.string.error_no_internet), Toast.LENGTH_SHORT).show();

        }
    }

    /*Naam: fetchLocalObjects
    Werking: Haal de vakanties op
    */
    public void gaVerder(){

        Vakantie vakantie = new Vakantie();

        for(Vakantie vak : vakanties)
        {

            if(spinner.getSelectedItem().toString().equals(vak.getNaamVakantie()))
            {
                vakantie=vak;
            }
        }
        Intent intentFeedback = new Intent(FeedbackGevenVakantieKiezen.this, FeedbackGeven.class);

        //Geef de nodige gegevens door naar de volgende stap
        intentFeedback.putExtra("vakantie", vakantie.getNaamVakantie());
        intentFeedback.putExtra("vakantieId", vakantie.getVakantieID());
        startActivity(intentFeedback);
        overridePendingTransition(R.anim.right_in, R.anim.left_out);

    }


    /*Naam: fetchLocalObjects
    Werking: Asynchrone taak om vakanties op te halen
    */
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

            ArrayAdapter<String> spinnerArrayAdapter = new ArrayAdapter<String>(FeedbackGevenVakantieKiezen.this, android.R.layout.simple_spinner_item,vakantieArray);
            spinnerArrayAdapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
            spinner.setAdapter(spinnerArrayAdapter);

        }
    }


    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        getMenuInflater().inflate(R.menu.back_2, menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        int id = item.getItemId();
        if (id == R.id.backMenu2) {
            Intent intent1 = new Intent(this, navBarMainScreen.class);
            intent1.putExtra("naarfrag","feedback");
            intent1.putExtra("herladen","nee");
            intent1.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
            startActivity(intent1);

            overridePendingTransition(R.anim.left_in, R.anim.right_out);
        }

        return super.onOptionsItemSelected(item);
    }
    @Override
    public void onBackPressed() {
        Intent setIntent = new Intent(FeedbackGevenVakantieKiezen.this, navBarMainScreen.class);
        setIntent.putExtra("naarfrag","feedback");
        setIntent.putExtra("herladen","nee");
        setIntent.addCategory(Intent.CATEGORY_HOME);
        setIntent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
        startActivity(setIntent);
    }
}
