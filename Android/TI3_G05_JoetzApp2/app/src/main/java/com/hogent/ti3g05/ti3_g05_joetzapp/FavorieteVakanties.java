package com.hogent.ti3g05.ti3_g05_joetzapp;

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

import com.hogent.ti3g05.ti3_g05_joetzapp.SQLLite.myDb;
import com.hogent.ti3g05.ti3_g05_joetzapp.Services.ConnectionDetector;
import com.hogent.ti3g05.ti3_g05_joetzapp.Services.VakantieAdapter;
import com.hogent.ti3g05.ti3_g05_joetzapp.domein.FavorieteVakantie;
import com.hogent.ti3g05.ti3_g05_joetzapp.domein.Vakantie;
import com.parse.ParseException;
import com.parse.ParseFile;
import com.parse.ParseObject;
import com.parse.ParseQuery;
import com.parse.ParseUser;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Locale;

//Haalt de favoriete vakanties van de gebruiker op engeeft deze weer
public class FavorieteVakanties extends Fragment{

    private ListView listview;

    private List<FavorieteVakantie> favorieten = null;

    private myDb myDB;
    private Vakantie vakantie;
    private ProgressDialog mProgressDialog;
    private View rootView;
    private VakantieAdapter adapter;
    private List<Vakantie> vakanties = null;
    private List<Vakantie> vakantiesAllemaal = null;
    private EditText filtertext;

    private boolean isInternetPresent = false;
    private ConnectionDetector cd;



        @Override
        public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
            super.onCreate(savedInstanceState);

            rootView = inflater.inflate(R.layout.favoriete_vakanties, container, false);


            listview = (ListView) rootView.findViewById(R.id.listViewFav);
            filtertext = (EditText) rootView.findViewById(R.id.filtertextFav);

            getActivity().getActionBar().setTitle("Favoriete vakanties");


            cd = new ConnectionDetector(rootView.getContext());
            myDB = new myDb(rootView.getContext());
            myDB.open();

            //controleert ofer internet is, zoja, haal de gegevens op uit de database in parse, online
            //Zoneen, haal de gegevens op uit de locale database
            isInternetPresent = cd.isConnectingToInternet();
            if (isInternetPresent) {
                new RemoteDataTask().execute();
            }
            else {
                vakanties = myDB.getFavorieten();
                adapter = new VakantieAdapter(rootView.getContext(), vakanties);
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


            return rootView;
        }


        // Asnynchrone taak om favorieten op te halen
        private class RemoteDataTask extends AsyncTask<Void, Void, Void> {
            @Override
            protected void onPreExecute() {
                super.onPreExecute();
                mProgressDialog = new ProgressDialog(getActivity());

                mProgressDialog.setTitle("Ophalen van vakanties.");

                mProgressDialog.setMessage("Aan het laden...");
                try{
                    mProgressDialog.setIndeterminate(true);
                    mProgressDialog.setIndeterminateDrawable(rootView.getResources().getDrawable(R.drawable.my_animation));
                }
                catch (OutOfMemoryError er)
                {
                    mProgressDialog.setIndeterminate(false);
                }
                //Toon dialoog
                mProgressDialog.show();

            }

            //Haal de gegevens op en stop deze in de locale database Doorgeven aan de adapter om weer te geven.
            @Override
            protected Void doInBackground(Void... params) {
                vakanties = new ArrayList<Vakantie>();
                vakantiesAllemaal = new ArrayList<Vakantie>();
                String ingelogdeGebruiker = "";
                //Haal de favoriete vakanties op van de ingelogde gebruiker
                try {

                    if(ParseUser.getCurrentUser().get("soort").toString().toLowerCase().equals("ouder"))
                    {


                    ParseQuery<ParseObject> queryOuder = new ParseQuery<ParseObject>(
                            "Ouder");

                    List<ParseObject> obOuder = queryOuder.find();

                    for (ParseObject ouder : obOuder) {

                        if (ouder.get("email").equals(ParseUser.getCurrentUser().getEmail())) {
                            ingelogdeGebruiker = ouder.getObjectId();
                        }
                    }
                    }
                    else if(ParseUser.getCurrentUser().get("soort").toString().toLowerCase().equals("monitor")) {
                        ParseQuery<ParseObject> queryMonitor = new ParseQuery<ParseObject>(
                                "Monitor");

                        List<ParseObject> obMonitor = queryMonitor.find();

                        for (ParseObject monitor : obMonitor) {

                            if (monitor.get("email").equals(ParseUser.getCurrentUser().getEmail())) {
                                ingelogdeGebruiker = monitor.getObjectId();
                            }

                        }
                    }

                    //favorieten ophalen
                    List<FavorieteVakantie> favorieten = new ArrayList<FavorieteVakantie>();
                    FavorieteVakantie fav;

                    ParseQuery<ParseObject> favorietenquery = new ParseQuery<ParseObject>("Favoriet");
                    favorietenquery.orderByAscending("vakantie");
                    List<ParseObject> obFav = favorietenquery.find();

                    myDB.dropFavorieten();
                    for(ParseObject favoriet : obFav)
                    {
                        fav = new FavorieteVakantie();

                        fav.setVakantieID((String)favoriet.get("vakantie"));
                        fav.setOuderID((String) favoriet.get("gebruiker"));

                        favorieten.add(fav);
                    }


                    // vakanties allemaal ophalen en filteren

                    List<ParseObject> lijstAfbeeldingen;
                    ParseQuery<ParseObject> afbeeldingenQuery = new ParseQuery<ParseObject>("Afbeelding");
                    afbeeldingenQuery.orderByAscending("vakantie");
                    lijstAfbeeldingen = afbeeldingenQuery.find();

                    ParseQuery<ParseObject> query = new ParseQuery<ParseObject>(
                            "Vakantie");
                    query.orderByAscending("titel");
                    List<ParseObject> qryLijstVakanties = query.find();
                    for (ParseObject v : qryLijstVakanties) {
                        vakantie = new Vakantie();

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
                        //TODO gegevens contactpersoon vakantie
                        vakantie.setMaxDoelgroep((Integer)v.get("maxLeeftijd"));
                        vakantie.setMinDoelgroep((Integer)v.get("minLeeftijd"));

                        ArrayList< String> afbeeldingenLijst = new ArrayList<String>();
                        for (ParseObject afbeelding : lijstAfbeeldingen) {
                            String vakantieID = (String) afbeelding.get("vakantie");
                            if (vakantieID.equals(v.getObjectId())){
                                ParseFile image = (ParseFile)afbeelding.get("afbeelding");
                                afbeeldingenLijst.add(image.getUrl());
                            }
                        }
                        vakantie.setFotos(afbeeldingenLijst);

                        vakantiesAllemaal.add(vakantie);

                    }


                    for(FavorieteVakantie favorieteVakantie : favorieten)
                    {
                        for(Vakantie vakantie: vakantiesAllemaal)
                        {
                            if(favorieteVakantie.getVakantieID().equals(vakantie.getVakantieID()) && favorieteVakantie.getOuderID().equals(ingelogdeGebruiker))
                            {
                                //Voeg de goedgekeurde vakanties toe aan de locale database en aan de favorietenlijst
                                vakanties.add(vakantie);
                                myDB.insertFavoriet(vakantie);
                            }
                        }
                    }

                } catch (ParseException e) {

                    Log.e("Error", e.getMessage());
                    e.printStackTrace();
                }

                return null;

            }

            @Override
            protected void onPostExecute(Void result) {
                //Geef de favorieten mee aan de adapter om deze juist weer te geven
                adapter = new VakantieAdapter(rootView.getContext(), vakanties);
                // de adapter aan de listview binden
                listview.setAdapter(adapter);
                // Dialoog sluiten
                mProgressDialog.dismiss();
               //filter de favorieten
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
