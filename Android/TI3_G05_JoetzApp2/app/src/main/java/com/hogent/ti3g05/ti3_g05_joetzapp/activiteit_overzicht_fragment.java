package com.hogent.ti3g05.ti3_g05_joetzapp;

import android.app.Activity;
import android.app.Fragment;
import android.app.ListFragment;
import android.app.ProgressDialog;
import android.os.AsyncTask;
import android.os.Bundle;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.EditText;
import android.widget.ListView;

import com.hogent.ti3g05.ti3_g05_joetzapp.Services.ListViewAdapter;
import com.hogent.ti3g05.ti3_g05_joetzapp.domein.Vakantie;
import com.parse.ParseException;
import com.parse.ParseObject;
import com.parse.ParseQuery;

import java.util.ArrayList;
import java.util.List;

public class activiteit_overzicht_fragment extends Fragment {

    private ListView listview;
    private List<ParseObject> ob;
    private ProgressDialog mProgressDialog;
   // private ListViewAdapter adapter;
    private List<Vakantie> vakanties = null;
    private View rootView;
    private ListViewAdapter adapter;

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        rootView = inflater.inflate(R.layout.activity_main_screen, container, false);

        new RemoteDataTask().execute();
        listview = (ListView) rootView.findViewById(R.id.listView);
        return rootView;
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
            mProgressDialog.setIndeterminate(false);
            // Show progressdialog
            mProgressDialog.show();
        }

        @Override
        protected Void doInBackground(Void... params) {
            // Create the array
            vakanties = new ArrayList<Vakantie>();
            try {
                // Locate the class table named "vakantie" in Parse.com
                ParseQuery<ParseObject> query = new ParseQuery<ParseObject>(
                        "Vakantie");
                // Locate the column named "vertrekdatum" in Parse.com and order list
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
            // Pass the results into ListViewAdapter.java
            //adapter = new ListViewAdapter(activiteit_overzicht.this, vakanties);
            //ArrayAdapter<Profile> profileAdapter = new ArrayAdapter<Profile>(context, resource, profiles)
           //ArrayAdapter vakantieAdapter = new ArrayAdapter(getActivity(),android.R.layout.activity_list_item, vakanties );

            //    ListViewAdapter adapter = new ListViewAdapter(rootView, vakanties);

            ListViewAdapter adapter = new ListViewAdapter(getActivity(), vakanties);
            // Binds the Adapter to the ListView
            listview.setAdapter(adapter);

            // Close the progressdialog
            mProgressDialog.dismiss();

          /*  filtertext.addTextChangedListener(new TextWatcher() {
                @Override
                public void beforeTextChanged(CharSequence charSequence, int i, int i2, int i3) {                }

                @Override
                public void onTextChanged(CharSequence charSequence, int i, int i2, int i3) {                }

                @Override
                public void afterTextChanged(Editable editable) {
                    String text = filtertext.getText().toString().toLowerCase(Locale.getDefault());
                    adapter.filter(text);
                }*/
          //  });
        }
    }
}