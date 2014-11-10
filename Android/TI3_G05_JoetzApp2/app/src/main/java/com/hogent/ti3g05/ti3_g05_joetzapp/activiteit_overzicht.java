package com.hogent.ti3g05.ti3_g05_joetzapp;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Locale;

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
import android.widget.ArrayAdapter;
import android.widget.EditText;
import android.widget.ListView;
import android.widget.TextView;

import com.hogent.ti3g05.ti3_g05_joetzapp.Services.ListViewAdapter;
import com.hogent.ti3g05.ti3_g05_joetzapp.SignUpLogin.Login;
import com.hogent.ti3g05.ti3_g05_joetzapp.SignUpLogin.SignUp_deel1;
import com.hogent.ti3g05.ti3_g05_joetzapp.domein.Vakantie;
import com.parse.ParseException;
import com.parse.ParseFile;
import com.parse.ParseObject;
import com.parse.ParseQuery;

public class activiteit_overzicht extends Fragment {

    private ListView listview;
    private List<ParseObject> ob;
    private ProgressDialog mProgressDialog;
    private ListViewAdapter adapter;

    private View rootView;
    private List<Vakantie> vakanties = null;
    private EditText filtertext;

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        rootView = inflater.inflate(R.layout.activiteit_overzichtnieuw, container, false);

        new RemoteDataTask().execute();
        listview = (ListView) rootView.findViewById(R.id.listView);
        filtertext = (EditText) rootView.findViewById(R.id.filtertext);
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
                    ParseFile image = (ParseFile) vakantie.get("vakAfbeelding1");
                    ParseFile image2 = (ParseFile) vakantie.get("vakAfbeelding2");
                    ParseFile image3 = (ParseFile) vakantie.get("vakAfbeelding3");

                    Vakantie map = new Vakantie();
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
                    if (vakantie.get("bondMoysonLedenPrijs") != null)
                        map.setBondMoysonLedenPrijs((Number) vakantie.get("bondMoysonLedenPrijs"));
                    if (vakantie.get("sterPrijs1ouder") != null)
                        map.setSterPrijs1Ouder((Number) vakantie.get("sterPrijs1ouder"));
                    if (vakantie.get("sterPrijs2ouders") != null)
                        map.setSterPrijs2Ouder((Number) vakantie.get("sterPrijs2ouders"));
                    //TODO gegevens contactpersoon vakantie


                    map.setFoto1(image.getUrl());
                    map.setFoto2(image2.getUrl());
                    map.setFoto3(image3.getUrl());

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
            //ArrayAdapter<Vakantie> vakantieAdapter = new ArrayAdapter<Vakantie>(activiteit_overzicht.this, R.layout.listview_item , vakanties);

            adapter = new ListViewAdapter(getActivity(), vakanties);
            // Binds the Adapter to the ListView
            listview.setAdapter(adapter);
            // Close the progressdialog
            mProgressDialog.dismiss();

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


   /* @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        getMenuInflater().inflate(R.menu.back, menu);
        return true;
    }*/

  /*  @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        int id = item.getItemId();
        if (id == R.id.backMenu) {
            Intent intent1 = new Intent(this, navBarMainScreen.class);
            startActivity(intent1);

            overridePendingTransition(R.anim.left_in, R.anim.right_out);
        }

        return super.onOptionsItemSelected(item);
    }*/
}