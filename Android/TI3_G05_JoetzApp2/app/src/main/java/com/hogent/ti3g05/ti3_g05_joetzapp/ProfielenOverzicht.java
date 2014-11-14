package com.hogent.ti3g05.ti3_g05_joetzapp;

import android.app.Activity;
import android.app.Fragment;
import android.app.ProgressDialog;
import android.content.Intent;
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
import android.widget.EditText;
import android.widget.ListView;

import com.hogent.ti3g05.ti3_g05_joetzapp.Services.ProfielAdapter;
import com.hogent.ti3g05.ti3_g05_joetzapp.domein.Monitor;
import com.parse.ParseException;
import com.parse.ParseObject;
import com.parse.ParseQuery;

import java.util.ArrayList;
import java.util.List;
import java.util.Locale;


public class ProfielenOverzicht extends Activity implements SwipeRefreshLayout.OnRefreshListener  {
    private ListView listview;
    private List<ParseObject> ob;
    private ProgressDialog mProgressDialog;
    private ProfielAdapter adapter;
    private List<Monitor> profielen = null;
    private EditText filtertext;

    SwipeRefreshLayout swipeLayout;

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        // Get the view from listview_main.xml
        setContentView(R.layout.activiteit_overzichtnieuw);
        setTitle("Profielen");
        // Execute RemoteDataTask AsyncTask
        filtertext = (EditText) findViewById(R.id.filtertext);

        swipeLayout = (SwipeRefreshLayout) findViewById(R.id.swipe_container);
        onCreateSwipeToRefresh(swipeLayout);

        new RemoteDataTask().execute();
    }

    private void onCreateSwipeToRefresh(SwipeRefreshLayout refreshLayout) {

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
    }





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
            mProgressDialog.setIndeterminate(false);
            // Show progressdialog
            mProgressDialog.show();
        }

        @Override
        protected Void doInBackground(Void... params) {
            // Create the array
            profielen = new ArrayList<Monitor>();
            try {
                // Locate the class table named "vakantie" in Parse.com
                ParseQuery<ParseObject> query = new ParseQuery<ParseObject>(
                        "Monitor");
                // Locate the column named "vertrekdatum" in Parse.com and order list
                // by ascending
                query.orderByAscending("naam");
                ob = query.find();
                for (ParseObject monitor : ob) {

                    Monitor map = new Monitor();
                    //String prijs = vakantie.get("basisPrijs").toString();
                    map.setNaam((String) monitor.get("naam"));
                    map.setVoornaam((String) monitor.get("voornaam"));
                    map.setStraat((String) monitor.get("straat"));
                    //map.setPostcode((String) monitor.get("postcode"));
                    //map.setHuisnr((Number) monitor.get("nummer"));
                     //map.setLidNummer((Integer) monitor.get("lidNr"));
                    map.setEmail((String) monitor.get("email"));
                    map.setGemeente((String) monitor.get("gemeente"));
                    map.setLinkFacebook((String) monitor.get("linkFacebook"));
                    map.setGsm((String) monitor.get("telefoon"));
                    map.setRijksregNr((String) monitor.get("rijksregisterNr"));


                    profielen.add(map);

                }
            } catch (ParseException e) {
                Log.e("Error", e.getMessage());
                e.printStackTrace();
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
            adapter = new ProfielAdapter(ProfielenOverzicht.this, profielen);
            // Binds the Adapter to the ListView
            listview.setAdapter(adapter);
            // Close the progressdialog
            mProgressDialog.dismiss();

            swipeLayout.setRefreshing(false);

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

        return super.onOptionsItemSelected(item);
    }
}
