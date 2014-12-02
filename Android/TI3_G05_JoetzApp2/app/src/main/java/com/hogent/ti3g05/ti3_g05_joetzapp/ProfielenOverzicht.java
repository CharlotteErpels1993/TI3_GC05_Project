package com.hogent.ti3g05.ti3_g05_joetzapp;

import android.app.Activity;
import android.app.ProgressDialog;
import android.content.Intent;
import android.os.AsyncTask;
import android.os.Bundle;
import android.text.Editable;
import android.text.TextWatcher;
import android.util.Log;
import android.view.Menu;
import android.view.MenuItem;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ListView;
import android.widget.Toast;

import com.hogent.ti3g05.ti3_g05_joetzapp.SQLLite.myDb;
import com.hogent.ti3g05.ti3_g05_joetzapp.Services.ConnectionDetector;
import com.hogent.ti3g05.ti3_g05_joetzapp.Services.ProfielAdapter;
import com.hogent.ti3g05.ti3_g05_joetzapp.domein.InschrijvingVorming;
import com.hogent.ti3g05.ti3_g05_joetzapp.domein.Monitor;
import com.parse.ParseException;
import com.parse.ParseObject;
import com.parse.ParseQuery;
import com.parse.ParseUser;

import java.util.ArrayList;
import java.util.List;
import java.util.Locale;


public class ProfielenOverzicht extends Activity /* implements SwipeRefreshLayout.OnRefreshListener*/ {
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

        new RemoteDataTask().execute();
    }

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
            mProgressDialog = new ProgressDialog(ProfielenOverzicht.this);
            // Set progressdialog title
            mProgressDialog.setTitle("Ophalen van profielen.");
            // Set progressdialog message
            mProgressDialog.setMessage("Aan het laden...");
            mProgressDialog.setIndeterminate(true);
            mProgressDialog.setIndeterminateDrawable(getResources().getDrawable(R.drawable.my_animation));

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
                    for (ParseObject monitor : ob) {

                        Monitor map = new Monitor();
                        map.setNaam((String) monitor.get("naam"));
                        map.setVoornaam((String) monitor.get("voornaam"));
                        map.setStraat((String) monitor.get("straat"));
                        map.setMonitorId( monitor.getObjectId());
                        map.setPostcode((Integer) monitor.get("postcode"));
                        map.setHuisnr((Number) monitor.get("nummer"));
                        if(monitor.get("lidNr") == null)
                        {
                            map.setLidNummer(0);
                        } else
                        {
                            map.setLidNummer((Integer) monitor.get("lidNr"));
                        }
                        map.setEmail((String) monitor.get("email"));
                        map.setGemeente((String) monitor.get("gemeente"));
                        map.setLinkFacebook((String) monitor.get("linkFacebook"));
                        map.setGsmnr((String) monitor.get("gsm"));
                        map.setTelefoonnr((String) monitor.get("telefoon"));
                        map.setRijksregNr((String) monitor.get("rijksregisterNr"));


                        if (map.getEmail().equals(ParseUser.getCurrentUser().getEmail()))
                        {
                            ingelogdeMonitor = map;
                        }

                        profielen.add(map);


                        myDB.insertProfiel(map);

                    }
                }catch (ParseException e) {
                    Log.e("Error", e.getMessage());
                    e.printStackTrace();

                    profielen = myDB.getProfielen();

                }
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
                            iv.setMonitor((String)inschrVorming.get("monitor"));
                            iv.setVorming((String)inschrVorming.get("vorming"));
                            if(ingelogdeMonitor.getMonitorId().equals(iv.getMonitor()))
                            {
                                inschrijvingVormingen.add(iv);
                            }
                            alleIns.add(iv);

                        }
                        profielenMetZelfdeVorming.add(ingelogdeMonitor);
                        for(Monitor m : profielen)
                        {
                            for(InschrijvingVorming inv : alleIns)
                            {
                                for(InschrijvingVorming invm : inschrijvingVormingen)
                                {

                                    if(inv.getMonitor().equals(m.getMonitorId()) && inv.getVorming().equals(invm.getVorming()) && !inv.getMonitor().equals(ingelogdeMonitor.getMonitorId()))
                                    {
                                        profielenMetZelfdeVorming.add(m); //Blijft leeg en zou 1 moeten inzitten
                                        break;
                                    }
                                }


                            }
                            if(!profielenMetZelfdeVorming.contains(m))
                            {
                                profielenAndere.add(m);
                            }

                            /*
                            Monitor map = new Monitor();
                            map.setNaam((String) monitor.get("naam"));
                            map.setVoornaam((String) monitor.get("voornaam"));
                            map.setStraat((String) monitor.get("straat"));

                            map.setPostcode((Integer) monitor.get("postcode"));
                            map.setHuisnr((Number) monitor.get("nummer"));
                            map.setLidNummer((Integer) monitor.get("lidNr"));
                            map.setEmail((String) monitor.get("email"));
                            map.setGemeente((String) monitor.get("gemeente"));
                            map.setLinkFacebook((String) monitor.get("linkFacebook"));
                            map.setGsm((String) monitor.get("telefoon"));
                            map.setRijksregNr((String) monitor.get("rijksregisterNr"));


                            profielen.add(map);*/


                        }


                       // profielenSamen.addAll(profielenMetZelfdeVorming.size(),profielenAndere);
                        profielenSamen.addAll(profielenAndere);
                        profielenSamen.addAll(0,profielenMetZelfdeVorming);


                    }catch (ParseException e)
                    {
                        Toast.makeText(ProfielenOverzicht.this,"Fout bij ophalen vormingen", Toast.LENGTH_SHORT).show();
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

            listview = (ListView) findViewById(R.id.listView);
            adapter = new ProfielAdapter(ProfielenOverzicht.this, profielenSamen);
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


   @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        getMenuInflater().inflate(R.menu.back, menu);
        return true;
    }



    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        int id = item.getItemId();
        if (id == R.id.backMenu) {
            Intent intent1 = new Intent(this, navBarMainScreen.class);
            startActivity(intent1);

            overridePendingTransition(R.anim.left_in, R.anim.right_out);
        }
        if (id == R.id.menu_load) {
            isInternetPresent = cd.isConnectingToInternet();
            if (isInternetPresent) {
                // Internet Connection is Present
                // make HTTP requests
                new RemoteDataTask().execute();
            }
            else{
                // Internet connection is not present
                // Ask user to connect to Internet
                Toast.makeText(ProfielenOverzicht.this, getString(R.string.error_no_internet), Toast.LENGTH_SHORT).show();
            }
        }

        return super.onOptionsItemSelected(item);
    }
    @Override
    public void onBackPressed() {
        Intent setIntent = new Intent(ProfielenOverzicht.this, navBarMainScreen.class);
        setIntent.addCategory(Intent.CATEGORY_HOME);
        setIntent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
        startActivity(setIntent);
    }


}
