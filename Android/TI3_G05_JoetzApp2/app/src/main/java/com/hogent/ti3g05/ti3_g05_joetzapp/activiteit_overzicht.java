package com.hogent.ti3g05.ti3_g05_joetzapp;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Locale;

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
import com.hogent.ti3g05.ti3_g05_joetzapp.domein.Vakantie;
import com.parse.ParseException;
import com.parse.ParseFile;
import com.parse.ParseObject;
import com.parse.ParseQuery;

public class activiteit_overzicht extends Fragment /*implements SwipeRefreshLayout.OnRefreshListener*/ {

    private ListView listview;

    private myDb myDB;
    private Vakantie map;
    private ProgressDialog mProgressDialog;
    private ArrayList<String> images = new ArrayList<String>();
    private View rootView;
    private ListViewAdapter adapter;
    private List<Vakantie> vakanties = null;
    private EditText filtertext;

    private Boolean isInternetPresent = false;
    // Connection detector class
    private ConnectionDetector cd;



    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        rootView = inflater.inflate(R.layout.activiteit_overzichtnieuw, container, false);


        listview = (ListView) rootView.findViewById(R.id.listView);
        filtertext = (EditText) rootView.findViewById(R.id.filtertext);

        getActivity().getActionBar().setTitle("Vakanties");


        //swipeLayout = (SwipeRefreshLayout) rootView.findViewById(R.id.swipe_container);
        //onCreateSwipeToRefresh(swipeLayout);
/*
        ActionBar mActionBar = getActivity().getActionBar();
        mActionBar.setDisplayShowHomeEnabled(false);
        mActionBar.setDisplayShowTitleEnabled(false);
        LayoutInflater mInflater = LayoutInflater.from(rootView.getContext());

        View mCustomView = mInflater.inflate(R.layout.actionbar_layout, null);
        TextView mTitleTextView = (TextView) mCustomView.findViewById(R.id.title_text);
        mTitleTextView.setText("Vakanties");

        ImageButton imageButton = (ImageButton) mCustomView
                .findViewById(R.id.imageButton);
        imageButton.setOnClickListener(new OnClickListener() {

            @Override
            public void onClick(View view) {
                isInternetPresent = cd.isConnectingToInternet();

                if (isInternetPresent) {
                    // Internet Connection is Present
                    // make HTTP requests
                    new RemoteDataTask().execute();
                }
                else{
                    // Internet connection is not present
                    // Ask user to connect to Internet
                    Toast.makeText(getActivity(), getString(R.string.error_no_internet), Toast.LENGTH_SHORT).show();
                }
            }
        });

        mActionBar.setCustomView(mCustomView);
        mActionBar.setDisplayShowCustomEnabled(true);

*/

        cd = new ConnectionDetector(rootView.getContext());
        myDB = new myDb(rootView.getContext());
        myDB.open();
        isInternetPresent = cd.isConnectingToInternet();
        if (isInternetPresent) {
            //Toast.makeText(getActivity(), "internet", Toast.LENGTH_SHORT).show();
            new RemoteDataTask().execute();
        }
        else {
            //Toast.makeText(getActivity(), "geen internet", Toast.LENGTH_SHORT).show();
            vakanties = myDB.getVakanties();
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
            try {
                mProgressDialog.setIndeterminate(true);
                mProgressDialog.setIndeterminateDrawable(rootView.getResources().getDrawable(R.drawable.my_animation));
            } catch (OutOfMemoryError er)
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



            try {
                List<ParseObject> lijstAfbeeldingen;
                ParseQuery<ParseObject> afbeeldingenQuery = new ParseQuery<ParseObject>("Afbeelding");
                afbeeldingenQuery.orderByAscending("vakantie");
                lijstAfbeeldingen = afbeeldingenQuery.find();

                // Locate the class table named "vakantie" in Parse.com
                ParseQuery<ParseObject> query = new ParseQuery<ParseObject>(
                        "Vakantie");
                query.orderByAscending("vertrekdatum");
                List<ParseObject> lijstMetVakanties = query.find();
                myDB.drop();
                for (ParseObject vakantie : lijstMetVakanties) {
                    map = new Vakantie();

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
                    map.setLink((String)vakantie.get("link"));

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


/*
                    SimpleDateFormat formatter = new SimpleDateFormat("MMM dd, yyyy");
                    Date date = null;

                    //    date = formatter.parse(now.toString());
                   // Date vakantiedate = formatter.parse(map.getVertrekDatum().toString());

*/
                   // if(Integer.parseInt(map.getVertrekDatum().toString())>Integer.parseInt(now.toString()))
                   /*  if(now.compareTo(map.getVertrekDatum())<0)
                    {*/
                        vakanties.add(map);
                    //}

                    myDB.insertVakantie(map);

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

    public boolean onCreateOptionsMenu(Menu menu) {
        getActivity().getMenuInflater().inflate(R.menu.menu_inschrijven_vakantie_part1, menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        int id = item.getItemId();
        if (id == R.id.menu_loadVak) {
            isInternetPresent = cd.isConnectingToInternet();

            if (isInternetPresent) {
                // Internet Connection is Present
                // make HTTP requests
                new RemoteDataTask().execute();
            }
            else{
                // Internet connection is not present
                // Ask user to connect to Internet
                Toast.makeText(getActivity(), getString(R.string.error_no_internet), Toast.LENGTH_SHORT).show();
            }
        }
        return super.onOptionsItemSelected(item);
    }


}