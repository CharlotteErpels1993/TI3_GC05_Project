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
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.Spinner;
import android.widget.TextView;
import android.widget.Toast;

import com.hogent.ti3g05.ti3_g05_joetzapp.Services.ConnectionDetector;
import com.hogent.ti3g05.ti3_g05_joetzapp.domein.Vakantie;
import com.parse.ParseException;
import com.parse.ParseObject;
import com.parse.ParseQuery;
import com.parse.ParseUser;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/*Naam: IndienenVoorkeurVakantie

    Werking: Geeft de monitor de gelegenheid om een voorkeur in te dienen
    */
public class IndienenVoorkeurVakantie extends Activity implements AdapterView.OnItemSelectedListener {

    private ArrayList<String> vakantienamen = null;
    private List<Vakantie> vakanties = null;
    private String[] vakantieArray;
    private List<ParseObject> lijstMetParseObjecten;
    private Vakantie vakantie;
    private TextView periodeVakantie;

    private View focusView = null;

    private boolean cancel = false;

    private Spinner spinner;
    private Boolean isInternetPresent = false;
    private ConnectionDetector cd;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.indienen_voorkeur_vakantie);
        periodeVakantie = (TextView)findViewById(R.id.periodeVakantieVoorkeur);

        spinner = (Spinner) findViewById( R.id.spinnerVakanties );
        spinner.setOnItemSelectedListener(this);
        final Button btnVolgende = (Button) findViewById(R.id.BevestigVoorkeur);

        final Animation animAlpha = AnimationUtils.loadAnimation(this, R.anim.alpha);

        cd = new ConnectionDetector(this);
        getActionBar().setTitle(getString(R.string.label_Vakantie_Kiezen));
        btnVolgende.setOnClickListener(new View.OnClickListener() {
            //Bij het klikken op de knop kijk of er internet aanwezig is, zoja dien de voorkeur in, zoneen geef de gepaste melding
            @Override
            public void onClick(View view) {
                btnVolgende.startAnimation(animAlpha);
                if(isInternetPresent)
                {
                    indienenVoorkeur();
                }
                else
                {
                    Toast.makeText(getApplicationContext(), getString(R.string.error_no_internet), Toast.LENGTH_SHORT).show();

                }
            }
        });
        isInternetPresent = cd.isConnectingToInternet();
        if(isInternetPresent)
        {

            new RemoteDataTask().execute();
        }
        else
        {
            Toast.makeText(getApplicationContext(), getString(R.string.error_no_internet), Toast.LENGTH_SHORT).show();

        }

    }

    /*Naam: onItemSelected

    Werking: Plaatst de juiste periode van de vakantie in de textview
    */
    @Override
    public void onItemSelected(AdapterView<?> adapterView, View view, int position, long l) {
        periodeVakantie.setText(vakanties.get(position).getPeriode());
    }

    @Override
    public void onNothingSelected(AdapterView<?> adapterView) {

    }


    /*Naam: RemoteDataTask

    Werking:  Asynchrone taak om vakanties op te halen
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

                    //String prijs = vakantie.get("basisPrijs").toString();
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

        @Override
        protected void onPostExecute(Void result) {
            //Toon de vakanties in de spinner

            vakantieArray = new String[vakantienamen.size()];
            int vakantienamenLengte = vakantienamen.size();
            for(int i = 0 ;i < vakantienamenLengte; i++)
            {
                vakantieArray[i] = vakantienamen.get(i);
            }

            ArrayAdapter<String> spinnerArrayAdapter = new ArrayAdapter<String>(IndienenVoorkeurVakantie.this, android.R.layout.simple_spinner_item,vakantieArray);
            spinnerArrayAdapter.setDropDownViewResource( android.R.layout.simple_spinner_dropdown_item );
            periodeVakantie.setText(vakanties.get(0).getVertrekDatum().toString() + " - " + vakanties.get(0).getTerugkeerDatum().toString());


            spinner.setAdapter(spinnerArrayAdapter);



        }
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        getMenuInflater().inflate(R.menu.back_2, menu);

        //menu.getItem(R.id.menu_load).setVisible(false);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        int id = item.getItemId();
        if (id == R.id.backMenu2) {
            Intent intent1 = new Intent(this, navBarMainScreen.class);
            startActivity(intent1);

            overridePendingTransition(R.anim.left_in, R.anim.right_out);
        }

        return super.onOptionsItemSelected(item);
    }

    /*Naam: indienenVoorkeur
    Werking: Haal de geselecteerde waarde uit de spinner en sla deze op
    */
    public void indienenVoorkeur(){
        Vakantie vakantie = new Vakantie();
         for(Vakantie vak : vakanties)
         {

             if(spinner.getSelectedItem().toString().equals(vak.getNaamVakantie()))
             {
                 vakantie=vak;
             }
         }
        Intent in = new Intent(getApplicationContext(),navBarMainScreen.class);

        if (opslaanVoorkeur(vakantie)){

            startActivity(in);
            overridePendingTransition(R.anim.right_in, R.anim.left_out);
            Toast.makeText(IndienenVoorkeurVakantie.this, getString(R.string.dialog_voorkeur_complete), Toast.LENGTH_LONG).show();
        }else{
            Toast.makeText(getApplicationContext(), getString(R.string.error_generalException), Toast.LENGTH_SHORT).show();
        }
    }


    /*Naam: opslaanVoorkeur
    Werking:
    //Sla de voorkeur op met de bijhorende monitorId
    //Controleer ook of deze gebruiker nog geen voorkeur heeft doorgegeven voor deze vakantie

    Parameters:
     - vakantie: Vakantie - vakantie object dat wordt opgeslagen

    Return: true -> opslaan is succesvol gebeurd
            false -> er is een fout gebeurd
    */
    public boolean opslaanVoorkeur(Vakantie vakantie)
    {
        String monitorId = null;
        try{
            ParseQuery<ParseObject> query = new ParseQuery<ParseObject>(
                    "Monitor");

            query.orderByAscending("naam");
            lijstMetParseObjecten = query.find();
            for (ParseObject monitor : lijstMetParseObjecten) {
                if(monitor.get("email").equals(ParseUser.getCurrentUser().getEmail()))
                {
                    monitorId =monitor.getObjectId();
                }

            }
        }
        catch(Exception e){
            Toast.makeText(this,getString(R.string.error_generalException),Toast.LENGTH_LONG).show();
            return false;
        }
        try{
            ParseQuery<ParseObject> query = new ParseQuery<ParseObject>(
                    "Voorkeur");

            query.orderByAscending("vakantie");
            lijstMetParseObjecten = query.find();
            for (ParseObject voorkeur : lijstMetParseObjecten) {
                if(voorkeur.get("monitor").equals(monitorId) && voorkeur.get("vakantie").equals(vakantie.getVakantieID()))
                {
                    Toast.makeText(IndienenVoorkeurVakantie.this, getString(R.string.dialog_voorkeur_occupied) , Toast.LENGTH_LONG).show();
                    return false;
                }

            }
        }
        catch(Exception e){
            Toast.makeText(this,getString(R.string.error_generalException),Toast.LENGTH_LONG).show();
            return false;
        }
        try{
            ParseObject voorkeurVakantie = new ParseObject("Voorkeur");
            voorkeurVakantie.put("monitor", monitorId);
            voorkeurVakantie.put("vakantie" , vakantie.getVakantieID());

            voorkeurVakantie.saveInBackground();

            return true;
        }
        catch(Exception e){
            Toast.makeText(this,getString(R.string.error_generalException),Toast.LENGTH_LONG).show();
            return false;
        }

    }

    @Override
    public void onBackPressed() {
        Intent setIntent = new Intent(IndienenVoorkeurVakantie.this, navBarMainScreen.class);
        setIntent.putExtra("naarfrag","vakantie");
        setIntent.putExtra("herladen","nee");
        setIntent.addCategory(Intent.CATEGORY_HOME);
        setIntent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
        startActivity(setIntent);
    }

}
