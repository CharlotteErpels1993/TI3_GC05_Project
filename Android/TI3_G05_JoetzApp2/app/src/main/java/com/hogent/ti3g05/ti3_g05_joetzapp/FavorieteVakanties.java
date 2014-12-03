package com.hogent.ti3g05.ti3_g05_joetzapp;

import android.app.Activity;
import android.app.Fragment;
import android.app.ProgressDialog;
import android.os.AsyncTask;
import android.os.Bundle;
import android.os.Handler;
import android.support.v4.widget.SwipeRefreshLayout;
import android.text.Editable;
import android.text.TextWatcher;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ListView;
import android.widget.Toast;

import com.hogent.ti3g05.ti3_g05_joetzapp.SQLLite.myDb;
import com.hogent.ti3g05.ti3_g05_joetzapp.Services.ConnectionDetector;
import com.hogent.ti3g05.ti3_g05_joetzapp.Services.ListViewAdapter;
import com.hogent.ti3g05.ti3_g05_joetzapp.Services.ListViewAdapterFavorieten;
import com.hogent.ti3g05.ti3_g05_joetzapp.domein.FavorieteVakantie;
import com.hogent.ti3g05.ti3_g05_joetzapp.domein.Vakantie;
import com.parse.ParseException;
import com.parse.ParseFile;
import com.parse.ParseObject;
import com.parse.ParseQuery;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Locale;

/**
 * Created by Gebruiker on 3/12/2014.
 */
public class FavorieteVakanties extends Fragment{

    // opgeslagen id's ophalen en daarmee vakanties ophalen en weergeven zoals bij vakantie overzicht,
    // bij geen vakanties zet in tabel => geen favorieten gevonden, wil je vakanties bekijken? ja => naar overzicht vakanties


        private ListView listview;
        private List<ParseObject> ob;

    private List<ParseObject> obFav;


    private List<FavorieteVakantie> favorieten = null;

        private Button refresh;

        private myDb myDB;
        Vakantie map;
        private ProgressDialog mProgressDialog;
        private ArrayList<String> images = new ArrayList<String>();
        private View rootView;
        private ListViewAdapter adapter;
        private List<Vakantie> vakanties = null;
    private List<Vakantie> vakantiesAllemaal = null;
        private EditText filtertext;
        SwipeRefreshLayout swipeLayout;

        Boolean isInternetPresent = false;
        // Connection detector class
        ConnectionDetector cd;



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
            isInternetPresent = cd.isConnectingToInternet();
            if (isInternetPresent) {
                new RemoteDataTask().execute();
            }
            else {
                favorieten = myDB.getFavorieten();
                adapter = new ListViewAdapter(rootView.getContext(), vakanties);
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


            return rootView;
        }
   /* private void onCreateSwipeToRefresh(SwipeRefreshLayout refreshLayout) {

        //refreshLayout.setOnRefreshListener(this);

        refreshLayout.setColorScheme(
                android.R.color.holo_blue_light,
                android.R.color.holo_orange_light,
                android.R.color.holo_green_light,
                android.R.color.holo_red_light);

    }*/

        public void onRefresh() {
            new Handler().postDelayed(new Runnable() {
                @Override
                public void run() {


                    new RemoteDataTask().execute();

                }
            }, 1000);
        }


        // RemoteDataTask AsyncTask
        private class RemoteDataTask extends AsyncTask<Void, Void, Void> {
            @Override
            protected void onPreExecute() {
                super.onPreExecute();
                // Create a progressdialog
                mProgressDialog = new ProgressDialog(getActivity());

                // Set progressdialog title
                mProgressDialog.setTitle("Ophalen van vakanties.");

                // Set progressdialog message
                mProgressDialog.setMessage("Aan het laden...");
                try{
                    mProgressDialog.setIndeterminate(true);
                    mProgressDialog.setIndeterminateDrawable(rootView.getResources().getDrawable(R.drawable.my_animation));
                }
                catch (OutOfMemoryError er)
                {
                    mProgressDialog.setIndeterminate(false);
                }

                //Show progressdialog


                mProgressDialog.show();

            }

            @Override
            protected Void doInBackground(Void... params) {
                // Create the array
                vakanties = new ArrayList<Vakantie>();
                vakantiesAllemaal = new ArrayList<Vakantie>();
                try {

                    //favorieten ophalen
                    List<FavorieteVakantie> favorieten = new ArrayList<FavorieteVakantie>();
                    FavorieteVakantie fav = null;

                    ParseQuery<ParseObject> favorietenquery = new ParseQuery<ParseObject>("Favoriet");
                    favorietenquery.orderByAscending("vakantieId");
                    obFav = favorietenquery.find();

                    myDB.dropFavorieten();
                    for(ParseObject favoriet : obFav)
                    {
                        fav = new FavorieteVakantie();

                        fav.setVakantieID((String)favoriet.get("vakantieId"));
                        fav.setOuderID((String) favoriet.get("ouderId"));

                        favorieten.add(fav);
                    }


                    // vakanties allemaal ophalen en filteren

                    List<ParseObject> lijstAfbeeldingen;
                    ParseQuery<ParseObject> afbeeldingenQuery = new ParseQuery<ParseObject>("Afbeelding");
                    afbeeldingenQuery.orderByAscending("vakantie");
                    lijstAfbeeldingen = afbeeldingenQuery.find();

                    ParseQuery<ParseObject> query = new ParseQuery<ParseObject>(
                            "Vakantie");
                    query.orderByAscending("vertrekdatum");
                    ob = query.find();
                    for (ParseObject vakantie : ob) {
                        map = new Vakantie();


                        if(vakantie.getObjectId().equals(favorieten))
                        //String prijs = vakantie.get("basisPrijs").toString();
                        map.setNaamVakantie((String) vakantie.get("titel"));
                        map.setVakantieID(vakantie.getObjectId());
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
                        if (vakantie.get("bondMoysonLedenPrijs") != null)
                            map.setBondMoysonLedenPrijs((Number) vakantie.get("bondMoysonLedenPrijs"));
                        if (vakantie.get("sterPrijs1ouder") != null)
                            map.setSterPrijs1Ouder((Number) vakantie.get("sterPrijs1ouder"));
                        if (vakantie.get("sterPrijs2ouders") != null)
                            map.setSterPrijs2Ouder((Number) vakantie.get("sterPrijs2ouders"));
                        //TODO gegevens contactpersoon vakantie
                        map.setMaxDoelgroep((Integer)vakantie.get("maxLeeftijd"));
                        map.setMinDoelgroep((Integer)vakantie.get("minLeeftijd"));

                        ArrayList< String> afbeeldingenLijst = new ArrayList<String>();
                        for (ParseObject afbeelding : lijstAfbeeldingen) {
                            String vakantieID = (String) afbeelding.get("vakantie");
                            if (vakantieID.equals(vakantie.getObjectId())){
                                //de huidige afbeelding hoort bij de huidige vakantie
                                ParseFile image = (ParseFile)afbeelding.get("afbeelding");
                                afbeeldingenLijst.add(image.getUrl());
                            }
                        }
                        map.setFotos(afbeeldingenLijst);

                        vakantiesAllemaal.add(map);



                    }

                    for(FavorieteVakantie favorieteVakantie : favorieten)
                    {
                        for(Vakantie vakantie: vakantiesAllemaal)
                        {
                            if(favorieteVakantie.getVakantieID().equals(vakantie.getVakantieID()))
                            {
                                vakanties.add(vakantie);
                                myDB.insertFavoriet(vakantie);
                            }
                        }
                    }




                } catch (ParseException e) {

                    Log.e("Error", e.getMessage());
                    e.printStackTrace();
                }/* catch (java.text.ParseException e) {
                e.printStackTrace();
            }*/

                return null;
            }

            @Override
            protected void onPostExecute(Void result) {
                // Locate the listview in listview_main.xml
                // Pass the results into ListViewAdapter.java
                //adapter = new ListViewAdapter(activiteit_overzicht.this, vakanties);
                //ArrayAdapter<Profile> profileAdapter = new ArrayAdapter<Profile>(context, resource, profiles)
                //ArrayAdapter<Vakantie> vakantieAdapter = new ArrayAdapter<Vakantie>(activiteit_overzicht.this, R.layout.listview_item , vakanties);


                adapter = new ListViewAdapter(rootView.getContext(), vakanties);
                // Binds the Adapter to the ListView
                listview.setAdapter(adapter);
                // Close the progressdialog
                mProgressDialog.dismiss();
                //swipeLayout.setRefreshing(false);

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
