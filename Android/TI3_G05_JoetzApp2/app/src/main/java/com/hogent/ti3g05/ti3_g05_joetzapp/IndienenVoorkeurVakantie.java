package com.hogent.ti3g05.ti3_g05_joetzapp;

import android.app.Activity;
import android.app.ProgressDialog;
import android.content.Intent;
import android.os.AsyncTask;
import android.os.Bundle;
import android.util.Log;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.view.inputmethod.InputMethodManager;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.Spinner;
import android.widget.TextView;
import android.widget.Toast;

import com.hogent.ti3g05.ti3_g05_joetzapp.Services.ListViewAdapter;
import com.hogent.ti3g05.ti3_g05_joetzapp.domein.Vakantie;
import com.parse.ParseException;
import com.parse.ParseObject;
import com.parse.ParseQuery;
import com.parse.ParseUser;

import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

public class IndienenVoorkeurVakantie extends Activity implements AdapterView.OnItemSelectedListener {

    private ListViewAdapter adapter;
    private ArrayList<String> vakantienamen = null;
    private List<Vakantie> vakanties = null;
    private String[] array;
    private ProgressDialog mProgressDialog;
    private List<ParseObject> ob;
    Vakantie map;
    TextView periodeVakantie;

    private View focusView = null;


    private boolean cancel = false;
    private String periodes;

    private Button btnVolgende;
    Spinner spinner;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.indienen_voorkeur_vakantie);
        periodeVakantie = (TextView)findViewById(R.id.periodeVakantieVoorkeur);

        spinner = (Spinner) findViewById( R.id.spinnerVakanties );
        spinner.setOnItemSelectedListener(this);
        btnVolgende = (Button) findViewById(R.id.BevestigVoorkeur);

        getActionBar().setTitle("Kies uw vakantie");
        btnVolgende.setTextColor(getResources().getColor(R.color.Rood));
        btnVolgende.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                indienenVoorkeur();
            }
        });
        //periodesVoorkeur.setBackgroundResource(R.drawable.drawable);
       /* periodesVoorkeur.setOnFocusChangeListener(new View.OnFocusChangeListener() {
            @Override
            public void onFocusChange(View v, boolean hasFocus) {
                if (!hasFocus) {
                    hideKeyboard(v);
                }
            }
        });*/
        new RemoteDataTask().execute();

    }

    public void hideKeyboard(View view) {
        InputMethodManager inputMethodManager =(InputMethodManager)getSystemService(Activity.INPUT_METHOD_SERVICE);
        inputMethodManager.hideSoftInputFromWindow(view.getWindowToken(), 0);
    }

    @Override
    public void onItemSelected(AdapterView<?> adapterView, View view, int i, long l) {
        periodeVakantie.setText(vakanties.get(i).getPeriode());
    }

    @Override
    public void onNothingSelected(AdapterView<?> adapterView) {

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

            ArrayAdapter<String> spinnerArrayAdapter = new ArrayAdapter<String>(IndienenVoorkeurVakantie.this, android.R.layout.simple_spinner_item,array);
            spinnerArrayAdapter.setDropDownViewResource( android.R.layout.simple_spinner_dropdown_item );
            periodeVakantie.setText(vakanties.get(0).getPeriode());


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

    public void indienenVoorkeur(){


        String periodes;

        periodes = periodeVakantie.getText().toString();

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
        controlerenOpfouten(vakantie, periodes);

    }

    public void controlerenOpfouten(Vakantie v,String periodes){
        //clearErrors();
        cancel = false;
        Intent in = new Intent(getApplicationContext(),navBarMainScreen.class);

        // Store values at the time of the login attempt.



        if (cancel) {
            // There was an error; don't attempt login and focus the first
            // form field with an error.
            focusView.requestFocus();
        } else {
            // Show a progress spinner, and kick off a background task to
            // perform the user login attempt.
            Toast.makeText(getApplicationContext(), getString(R.string.doorgeven_message), Toast.LENGTH_SHORT).show();

            if (opslaanVoorkeur(v ,periodes)){

                startActivity(in);
                overridePendingTransition(R.anim.right_in, R.anim.left_out);
                Toast.makeText(IndienenVoorkeurVakantie.this, "Uw voorkeur is succesvol doorgegeven", Toast.LENGTH_SHORT).show();
            }else{
                Toast.makeText(getApplicationContext(), "Er is een fout opgetreden. Onze excuses voor het ongemak.", Toast.LENGTH_SHORT).show();
            }
            //Toast.makeText(getApplicationContext(), "Opgeslagen", Toast.LENGTH_SHORT).show();

        }
    }


    public boolean opslaanVoorkeur(Vakantie vakantie, String periodes)
    {
        String monitorId = null;
        try{
            ParseQuery<ParseObject> query = new ParseQuery<ParseObject>(
                    "Monitor");

            query.orderByAscending("naam");
            ob = query.find();
            for (ParseObject monitor : ob) {
                if(monitor.get("email").equals(ParseUser.getCurrentUser().getEmail()))
                {
                    monitorId =monitor.getObjectId();
                }

            }
        }
        catch(Exception e){
            Toast.makeText(this,"fout bij ophalen monitoren",Toast.LENGTH_LONG).show();
            return false;
        }
        try{
            ParseQuery<ParseObject> query = new ParseQuery<ParseObject>(
                    "Voorkeur");

            query.orderByAscending("vakantie");
            ob = query.find();
            for (ParseObject voorkeur : ob) {
                if(voorkeur.get("monitor").equals(monitorId) && voorkeur.get("vakantie").equals(vakantie.getVakantieID()))
                {
                    Toast.makeText(IndienenVoorkeurVakantie.this, "U heeft al voorkeuren ingediend voor deze vakantie" , Toast.LENGTH_LONG).show();
                    return false;
                }

            }
        }
        catch(Exception e){
            Toast.makeText(this,"fout bij ophalen voorkeuren",Toast.LENGTH_LONG).show();
            return false;
        }
        try{
            ParseObject voorkeurVakantie = new ParseObject("Voorkeur");
            voorkeurVakantie.put("monitor", monitorId);
            //voorkeurVakantie.put("periodes" , periodes);
            voorkeurVakantie.put("vakantie" , vakantie.getVakantieID());

            voorkeurVakantie.saveInBackground();

            return true;
        }
        catch(Exception e){
            Toast.makeText(this,"fout bij opslaan",Toast.LENGTH_LONG).show();
            return false;
        }

    }

}
