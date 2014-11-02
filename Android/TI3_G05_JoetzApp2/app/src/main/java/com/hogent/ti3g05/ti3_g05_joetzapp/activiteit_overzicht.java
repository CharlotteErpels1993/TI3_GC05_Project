package com.hogent.ti3g05.ti3_g05_joetzapp;

import java.util.ArrayList;
import java.util.List;
import android.app.Activity;
import android.app.ProgressDialog;
import android.os.AsyncTask;
import android.os.Bundle;
import android.util.Log;
import android.widget.ListView;

import com.hogent.ti3g05.ti3_g05_joetzapp.domein.Vakantie;
import com.parse.Parse;
import com.parse.ParseException;
import com.parse.ParseObject;
import com.parse.ParseQuery;

public class activiteit_overzicht extends Activity {
    // Declare Variables
    ListView listview;
    List<ParseObject> ob;
    ProgressDialog mProgressDialog;
    ListViewAdapter adapter;
    private List<Vakantie> vakanties = null;

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        Parse.initialize(this, "G7iR0ji0Kc1fc2PUwhXi9Gj8HmaqK52Qmhk2ffHy", "gJJgkWD5UxMA80iqZkaUHTy8pc9UwJfdv3alDk9Q");
        // Get the view from listview_main.xml
        setContentView(R.layout.activiteit_overzichtnieuw);
        // Execute RemoteDataTask AsyncTask
        new RemoteDataTask().execute();
    }

    // RemoteDataTask AsyncTask
    private class RemoteDataTask extends AsyncTask<Void, Void, Void> {
        @Override
        protected void onPreExecute() {
            super.onPreExecute();
            // Create a progressdialog
            mProgressDialog = new ProgressDialog(activiteit_overzicht.this);
            // Set progressdialog title
            mProgressDialog.setTitle("Ophalen van vakanties.");
            // Set progressdialog message
            mProgressDialog.setMessage("Aan het laden...");
            mProgressDialog.setIndeterminate(false);
            // Show progressdialog
            mProgressDialog.show();
        }

        @Override
        protected Void doInBackground(Void... params) {
            // Create the array
            vakanties = new ArrayList<Vakantie>();
            try {
                // Locate the class table named "Country" in Parse.com
                ParseQuery<ParseObject> query = new ParseQuery<ParseObject>(
                        "Vakantie");
                // Locate the column named "ranknum" in Parse.com and order list
                // by ascending
                query.orderByAscending("vertrekdatum");
                ob = query.find();
                for (ParseObject vakantie : ob) {
                    // Locate images in flag column
                   // ParseFile image = (ParseFile) vakantie.get("flag");

                    Vakantie map = new Vakantie();
                    map.setNaamVakantie((String) vakantie.get("titel"));
                    map.setLocatie((String) vakantie.get("locatie"));
                    map.setVertrekDatum((java.util.Date) vakantie.get("vertrekdatum"));
                    map.setTerugkeerDatum((java.util.Date) vakantie.get("terugkeerdatum"));
                    map.setKorteBeschrijving((String) vakantie.get("korteBeschrijving"));

                    //map.setFlag(image.getUrl());
                    vakanties.add(map);
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
            listview = (ListView) findViewById(R.id.listview);
            // Pass the results into ListViewAdapter.java
            adapter = new ListViewAdapter(activiteit_overzicht.this, vakanties);
            // Binds the Adapter to the ListView
            listview.setAdapter(adapter);
            // Close the progressdialog
            mProgressDialog.dismiss();
        }
    }
}