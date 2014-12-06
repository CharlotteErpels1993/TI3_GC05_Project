package com.hogent.ti3g05.ti3_g05_joetzapp;

import android.app.Activity;
import android.app.Fragment;
import android.app.ProgressDialog;
import android.content.Intent;
import android.os.AsyncTask;
import android.os.Bundle;
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
import com.hogent.ti3g05.ti3_g05_joetzapp.Services.ProfielAdapter;
import com.hogent.ti3g05.ti3_g05_joetzapp.Services.VormingAdapter;
import com.hogent.ti3g05.ti3_g05_joetzapp.domein.InschrijvingVorming;
import com.hogent.ti3g05.ti3_g05_joetzapp.domein.Monitor;
import com.parse.ParseException;
import com.parse.ParseObject;
import com.parse.ParseQuery;
import com.parse.ParseUser;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Locale;


public class ProfielenOverzicht_fragment extends Fragment /* implements SwipeRefreshLayout.OnRefreshListener*/ {
    private ListView listview;
    private List<ParseObject> ob;
    private List<ParseObject> obVorming;
    private ProgressDialog mProgressDialog;
    private ProfielAdapter adapter;
    private List<Monitor> profielen = null;
    private List<Monitor> profielenMetZelfdeVorming = null;
    private List<Monitor> profielenAndere = null;
    private List<Monitor> profielenSamen = null;
    private EditText filtertext;
    private myDb myDB;
    private Button refresh;
    private List<InschrijvingVorming> inschrijvingVormingen = new ArrayList<InschrijvingVorming>();
    private List<InschrijvingVorming> alleIns = new ArrayList<InschrijvingVorming>();

    private Monitor ingelogdeMonitor = new Monitor();
    //SwipeRefreshLayout swipeLayout;

    // flag for Internet connection status
    Boolean isInternetPresent = false;
    // Connection detector class
    ConnectionDetector cd;


    private View rootView;

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        rootView = inflater.inflate(R.layout.profielen_overzicht, container, false);


        listview = (ListView) rootView.findViewById(R.id.listViewp);
        filtertext = (EditText) rootView.findViewById(R.id.filtertextp);
        //swipeLayout = (SwipeRefreshLayout) rootView.findViewById(R.id.swipe_container);
        //onCreateSwipeToRefresh(swipeLayout);
        getActivity().getActionBar().setTitle("Profielen");

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
            profielen = myDB.getProfielen();
            adapter = new ProfielAdapter(rootView.getContext(), profielen);
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
    /*
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        // Get the view from listview_main.xml
        setContentView(R.layout.activiteit_overzichtnieuw);
        setTitle("Monitoren");
        // Execute RemoteDataTask AsyncTask
        filtertext = (EditText) findViewById(R.id.filtertext);
        cd = new ConnectionDetector(getApplicationContext());
        myDB = new myDb(this);
        myDB.open();



        /*swipeLayout = (SwipeRefreshLayout) findViewById(R.id.swipe_container);
        onCreateSwipeToRefresh(swipeLayout);*/

        //new RemoteDataTask().execute();
   // }

   /* private void onCreateSwipeToRefresh(SwipeRefreshLayout refreshLayout) {

        refreshLayout.setOnRefreshListener(this);

        refreshLayout.setColorScheme(
                android.R.color.holo_blue_light,
                android.R.color.holo_orange_light,
                android.R.color.holo_green_light,
                android.R.color.holo_red_light);

    }
    @Override
    public void onRefresh() {
        new Handler().postDelayed(new Runnable() {
            @Override
            public void run() {


                new RemoteDataTask().execute();

            }
        }, 1000);
    }*/


    // RemoteDataTask AsyncTask
    private class RemoteDataTask extends AsyncTask<Void, Void, Void> {
        @Override
        protected void onPreExecute() {
            super.onPreExecute();
            // Create a progressdialog
            mProgressDialog = new ProgressDialog(getActivity());
            // Set progressdialog title
            mProgressDialog.setTitle("Ophalen van profielen.");
            // Set progressdialog message
            mProgressDialog.setMessage("Aan het laden...");
            try {
                mProgressDialog.setIndeterminate(true);
                mProgressDialog.setIndeterminateDrawable(getResources().getDrawable(R.drawable.my_animation));
            }catch (OutOfMemoryError er)
            {
                mProgressDialog.setIndeterminate(false);
            }

            // Show progressdialog
            mProgressDialog.show();
        }

        @Override
        protected Void doInBackground(Void... params) {
            // Create the array
            profielen = new ArrayList<Monitor>();
            profielenAndere = new ArrayList<Monitor>();
            profielenMetZelfdeVorming = new ArrayList<Monitor>();
            profielenSamen = new ArrayList<Monitor>();
            isInternetPresent = cd.isConnectingToInternet();
            if(isInternetPresent) {

                try {
                    // Locate the class table named "vakantie" in Parse.com
                    ParseQuery<ParseObject> query = new ParseQuery<ParseObject>(
                            "Monitor");
                    // Locate the column named "vertrekdatum" in Parse.com and order list
                    // by ascending
                    query.orderByAscending("naam");
                    ob = query.find();

                    myDB.dropProfielen();
                    for (ParseObject monitor : ob) {//alle monitoren ophalen en opslaan

                        Monitor map = new Monitor();
                        map.setNaam((String) monitor.get("naam"));
                        map.setVoornaam((String) monitor.get("voornaam"));
                        map.setStraat((String) monitor.get("straat"));
                        map.setMonitorId( monitor.getObjectId());
                        map.setPostcode((Integer) monitor.get("postcode"));
                        map.setHuisnr((Number) monitor.get("nummer"));
                        if(monitor.get("lidNr") == null)
                        {
                            map.setLidNummer("0");
                        } else
                        {
                            map.setLidNummer(monitor.get("lidNr").toString());
                        }
                        map.setEmail((String) monitor.get("email"));
                        map.setGemeente((String) monitor.get("gemeente"));
                        map.setLinkFacebook((String) monitor.get("linkFacebook"));
                        map.setGsmnr((String) monitor.get("gsm"));
                        map.setTelefoonnr((String) monitor.get("telefoon"));
                        map.setRijksregNr((String) monitor.get("rijksregisterNr"));


                        if(map.getEmail() != null)
                        {
                            if (map.getEmail().equals(ParseUser.getCurrentUser().getEmail()))
                            {
                                ingelogdeMonitor = map;
                            }
                        }


                        profielen.add(map);


                        myDB.insertProfiel(map);

                    }
                }catch (ParseException e) {
                    Log.e("Error", e.getMessage());
                    e.printStackTrace();

                    profielen = myDB.getProfielen();

                }


                if(ParseUser.getCurrentUser().get("soort").toString().toLowerCase().equals("monitor")) {
                    try {

                        ParseQuery<ParseObject> queryVorming = new ParseQuery<ParseObject>(
                                "InschrijvingVorming");
                        // Locate the column named "vertrekdatum" in Parse.com and order list
                        // by ascending
                        //queryVorming.orderByAscending("monitor");
                        obVorming = queryVorming.find();
                        InschrijvingVorming iv;
                        for (ParseObject inschrVorming : obVorming) {
                            iv = new InschrijvingVorming();
                            iv.setMonitor((String) inschrVorming.get("monitor"));
                            iv.setVorming((String) inschrVorming.get("vorming"));
                            if (ingelogdeMonitor.getMonitorId().equals(iv.getMonitor())) {
                                inschrijvingVormingen.add(iv);
                            }
                            alleIns.add(iv);

                        }

                        profielenMetZelfdeVorming.add(ingelogdeMonitor);
                        for (Monitor m : profielen) {
                            for (InschrijvingVorming inv : alleIns) {
                                for (InschrijvingVorming invm : inschrijvingVormingen) {

                                    if (inv.getMonitor().equals(m.getMonitorId()) && inv.getVorming().equals(invm.getVorming()) && !inv.getMonitor().equals(ingelogdeMonitor.getMonitorId())) {
                                        profielenMetZelfdeVorming.add(m); //Blijft leeg en zou 1 moeten inzitten
                                        break;
                                    }
                                }
                            }
                            if (!profielenMetZelfdeVorming.contains(m)) {
                                profielenAndere.add(m);
                            }
                        }

                        //hieronder = enige duplicaten verwijderen
                        profielenMetZelfdeVorming.remove(ingelogdeMonitor);
                        HashSet<Monitor> hs = new HashSet<Monitor>();
                        hs.addAll(profielenMetZelfdeVorming);
                        profielenMetZelfdeVorming.clear();
                        profielenMetZelfdeVorming.addAll(hs);

                        Monitor eigenHeader = new Monitor();
                        eigenHeader.setNaam("Eigen profiel");
                        profielenSamen.add(eigenHeader);

                        profielenSamen.add(ingelogdeMonitor);

                        Monitor eersteHeader = new Monitor();
                        eersteHeader.setNaam("Monitoren met dezelfde vorming");
                        profielenSamen.add(eersteHeader);

                        profielenSamen.addAll(profielenMetZelfdeVorming);

                        Monitor tweedeHeader = new Monitor();
                        tweedeHeader.setNaam("Resterende monitoren");
                        profielenSamen.add(tweedeHeader);

                        // profielenSamen.addAll(profielenMetZelfdeVorming.size(),profielenAndere);
                        profielenSamen.addAll(profielenAndere);


                    } catch (ParseException e) {
                        Toast.makeText(getActivity(), "Fout bij ophalen vormingen", Toast.LENGTH_SHORT).show();
                    }
                }


            } else {
                profielenSamen = myDB.getProfielen();
            }
            return null;
        }

        @Override
        protected void onPostExecute(Void result) {
            // Locate the listview in listview_main.xml
            // Pass the results into ListViewAdapter.java
            //adapter = new ListViewAdapter(activiteit_overzicht.this, vakanties);
            //ArrayAdapter<Profile> profileAdapter = new ArrayAdapter<Profile>(context, resource, profiles)
            //ArrayAdapter<Vakantie> vakantieAdapter = new ArrayAdapter<Vakantie>(activiteit_overzicht.this, R.layout.listview_item , vakanties);

            adapter = new ProfielAdapter(rootView.getContext(), profielenSamen);
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
