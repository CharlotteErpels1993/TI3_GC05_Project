package com.hogent.ti3g05.ti3_g05_joetzapp;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import android.app.Fragment;
import android.app.ProgressDialog;
import android.os.AsyncTask;
import android.os.Bundle;
import android.text.Editable;
import android.text.TextWatcher;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.EditText;
import android.widget.ListView;

import com.hogent.ti3g05.ti3_g05_joetzapp.SQLLite.SqliteDatabase;
import com.hogent.ti3g05.ti3_g05_joetzapp.Services.ConnectionDetector;
import com.hogent.ti3g05.ti3_g05_joetzapp.Services.VakantieAdapter;
import com.hogent.ti3g05.ti3_g05_joetzapp.domein.Feedback;
import com.hogent.ti3g05.ti3_g05_joetzapp.domein.Vakantie;
import com.parse.ParseException;
import com.parse.ParseFile;
import com.parse.ParseObject;
import com.parse.ParseQuery;

//Toont een lijst van vakanties
public class VakantieOverzicht extends Fragment {

    private ListView listview;

    private SqliteDatabase sqliteDatabase;
    private Vakantie vakantie;
    private ProgressDialog mProgressDialog;
    private ArrayList<String> images = new ArrayList<String>();
    private View rootView;
    private VakantieAdapter adapter;
    private List<Vakantie> vakanties = null;
    private EditText filtertext;

    private Boolean isInternetPresent = false;
    private ConnectionDetector cd;



    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        rootView = inflater.inflate(R.layout.activiteit_overzichtnieuw, container, false);



        listview = (ListView) rootView.findViewById(R.id.listView);
        filtertext = (EditText) rootView.findViewById(R.id.filtertext);

        getActivity().getActionBar().setTitle(getString(R.string.mainTitlePart1));


        cd = new ConnectionDetector(rootView.getContext());
        sqliteDatabase = new SqliteDatabase(rootView.getContext());
        sqliteDatabase.open();
        isInternetPresent = cd.isConnectingToInternet();
        //kijkt of het scherm al eens is geladen, en gebruikt dan de locale database, dit voorkomt teveel overhead
        if(getActivity().getIntent().getStringExtra("herladen")!= null && getActivity().getIntent().getStringExtra("herladen").toLowerCase().equals("nee"))
        {
            getVakanties();
        }
        //Kijkt of er internet is, indien ja haalt hij de gegevens op uit de database van parse online,
        //Zoneen, dan worden de gegevens opgehaald uit de locale database
        else if (isInternetPresent ||(getActivity().getIntent().getStringExtra("refresh")!= null && getActivity().getIntent().getStringExtra("refresh").toLowerCase().equals("ja"))) {
            new RemoteDataTask().execute();
        }
        else {
          getVakanties();
        }


        return rootView;
    }

    /*Naam: getVakanties
    Werking: Haalt de vakanties op uit de locale database
    */

     public void getVakanties()
     {
         //Toast.makeText(getActivity(), "geen internet", Toast.LENGTH_SHORT).show();
         vakanties = sqliteDatabase.getVakanties();
         adapter = new VakantieAdapter(rootView.getContext(), vakanties);
         // Binds the Adapter to the ListView
         listview.setAdapter(adapter);

         filtertext.addTextChangedListener(new TextWatcher() {
             @Override
             public void beforeTextChanged(CharSequence charSequence, int i, int i2, int i3) {                }

             @Override
             public void onTextChanged(CharSequence charSequence, int i, int i2, int i3) {                }

             @Override
             public void afterTextChanged(Editable editable) {
                 String text = filtertext.getText().toString().toLowerCase(Locale.getDefault());
                 adapter.filter(text);
             }
         });
     }


    // De asynctask om de vakanties op te halen
    private class RemoteDataTask extends AsyncTask<Void, Void, Void> {
        @Override
        protected void onPreExecute() {
            super.onPreExecute();
            // Create a progressdialog
            mProgressDialog = new ProgressDialog(getActivity());
            
            // Set progressdialog title
            mProgressDialog.setTitle(getString(R.string.loadingMSG_vakanties));

            // Set progressdialog message
            mProgressDialog.setMessage(getString(R.string.loading_message));
            try {
                mProgressDialog.setIndeterminate(true);
                mProgressDialog.setIndeterminateDrawable(rootView.getResources().getDrawable(R.drawable.my_animation));
            } catch (OutOfMemoryError er)
            {
                mProgressDialog.setIndeterminate(false);
            }
            //Toon dialoog
            mProgressDialog.show();

        }

        @Override
        protected Void doInBackground(Void... params) {
            // Create the array
            vakanties = new ArrayList<Vakantie>();

            //Haal de vakanties op
            try {
                List<ParseObject> lijstAfbeeldingen;
                ParseQuery<ParseObject> afbeeldingenQuery = new ParseQuery<ParseObject>("Afbeelding");
                afbeeldingenQuery.orderByAscending("vakantie");
                lijstAfbeeldingen = afbeeldingenQuery.find();

                ParseQuery<ParseObject> query = new ParseQuery<ParseObject>(
                        "Vakantie");
                query.orderByAscending("vertrekdatum");
                List<ParseObject> lijstMetVakanties = query.find();

                ParseQuery<ParseObject> queryFeedback = new ParseQuery<ParseObject>(
                        "Feedback");
                queryFeedback.orderByAscending("vakantie");


                List<ParseObject> lijstFeedback = queryFeedback.find();

                //Maak de locale database klaar om alle vakanties erin te stoppen
                sqliteDatabase.dropVakanties();

                for (ParseObject v : lijstMetVakanties) {
                    vakantie = new Vakantie();
                    int totaalScore = 0 ;
                    int aantal = 0;
                    int gemiddeldeScore = 0;

                    for(ParseObject f: lijstFeedback)
                    {
                        Feedback feedback = new Feedback();
                        feedback.setVakantieId((String) f.get("vakantie"));
                        feedback.setFeedback((String) f.get("waardering"));
                        feedback.setGebruikerId((String) f.get("gebruiker"));
                        feedback.setGoedgekeurd((Boolean) f.get("goedgekeurd"));

                        if(f.get("vakantie").equals(v.getObjectId()) && feedback.getGoedgekeurd())
                        {
                            aantal += 1;
                            totaalScore += (Integer)f.get("score");
                        }
                    }
                    if(aantal!=0)
                    {

                         gemiddeldeScore = totaalScore/aantal;
                    }

                    //String prijs = vakantie.get("basisPrijs").toString();
                    vakantie.setNaamVakantie((String) v.get("titel"));
                    vakantie.setVakantieID(v.getObjectId());
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
                    if (v.get("bondMoysonLedenPrijs") != null)
                        vakantie.setBondMoysonLedenPrijs((Number) v.get("bondMoysonLedenPrijs"));
                    if (v.get("sterPrijs1ouder") != null)
                        vakantie.setSterPrijs1Ouder((Number) v.get("sterPrijs1ouder"));
                    if (v.get("sterPrijs2ouders") != null)
                        vakantie.setSterPrijs2Ouder((Number) v.get("sterPrijs2ouders"));

                    vakantie.setMaxDoelgroep((Integer)v.get("maxLeeftijd"));
                    vakantie.setMinDoelgroep((Integer)v.get("minLeeftijd"));
                    vakantie.setLink((String)v.get("link"));
                    vakantie.setGemiddeldeRating((gemiddeldeScore));

                    ArrayList< String> afbeeldingenLijst = new ArrayList<String>();
                    for (ParseObject afbeelding : lijstAfbeeldingen) {
                        String vakantieID = (String) afbeelding.get("vakantie");
                        if (vakantieID.equals(v.getObjectId())){
                            //de huidige afbeelding hoort bij de huidige vakantie
                            ParseFile image = (ParseFile)afbeelding.get("afbeelding");
                            afbeeldingenLijst.add(image.getUrl());
                        }
                    }
                    vakantie.setFotos(afbeeldingenLijst);


                        vakanties.add(vakantie);
                    //Voeg de vakantie toe aan de locale database
                    sqliteDatabase.insertVakantie(vakantie);

                 }

                } catch (ParseException e) {

                    Log.e("Error", e.getMessage());
                    e.printStackTrace();
                }

            return null;
        }

        @Override
        protected void onPostExecute(Void result) {
            //Steek de vakanties in de adapter om zo in de juiste velden weer te geven
            adapter = new VakantieAdapter(rootView.getContext(), vakanties);
            // de adapter aan de listview binden
            listview.setAdapter(adapter);
            // Dialoog sluiten
            mProgressDialog.dismiss();

            //Filter de vakanties
            filtertext.addTextChangedListener(new TextWatcher() {
                @Override
                public void beforeTextChanged(CharSequence charSequence, int i, int i2, int i3) {                }

                @Override
                public void onTextChanged(CharSequence charSequence, int i, int i2, int i3) {                }

                @Override
                public void afterTextChanged(Editable editable) {
                    String text = filtertext.getText().toString().toLowerCase(Locale.getDefault());
                    adapter.filter(text);
                }
            });
        }
    }


}