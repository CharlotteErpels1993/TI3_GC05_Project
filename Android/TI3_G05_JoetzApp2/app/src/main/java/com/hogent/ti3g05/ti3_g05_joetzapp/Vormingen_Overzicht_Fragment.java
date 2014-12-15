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
import com.hogent.ti3g05.ti3_g05_joetzapp.Services.VormingAdapter;
import com.hogent.ti3g05.ti3_g05_joetzapp.domein.Vorming;
import com.parse.ParseException;
import com.parse.ParseObject;
import com.parse.ParseQuery;

import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

//Geeft een overzicht van de vormingen weer
public class Vormingen_Overzicht_Fragment extends Fragment  {

    private ListView listview;
    private ProgressDialog mProgressDialog;
    private VormingAdapter adapter;
    private myDb myDB;
    private List<Vorming> vormingen = null;
    private EditText et_filtertext;
    private Boolean isInternetPresent = false;
    private ConnectionDetector cd;
    private View rootView;


    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        rootView = inflater.inflate(R.layout.vorming_overzicht, container, false);

        getActivity().getActionBar().setTitle("Vormingen");

        listview = (ListView) rootView.findViewById(R.id.listViewv);
        et_filtertext = (EditText) rootView.findViewById(R.id.filtertextv);

        cd = new ConnectionDetector(rootView.getContext());
        myDB = new myDb(rootView.getContext());
        myDB.open();
        isInternetPresent = cd.isConnectingToInternet();
        //indien er internet aanwezig is haal vormingen op, anders haal de vormingen uit de locale database
        if(getActivity().getIntent().getStringExtra("herladen")!= null && getActivity().getIntent().getStringExtra("herladen").toLowerCase().equals("nee"))
        {
            getVormingen();
        }

        if (isInternetPresent) {
            new RemoteDataTask().execute();
        }
        else {
            getVormingen();
        }

        return rootView;
    }

    //Haal de ormingen uit de locale database
    public void getVormingen()
    {
        vormingen = myDB.getVormingen();
        adapter = new VormingAdapter(rootView.getContext(), vormingen);
        listview.setAdapter(adapter);

        et_filtertext.addTextChangedListener(new TextWatcher() {
            @Override
            public void beforeTextChanged(CharSequence charSequence, int i, int i2, int i3) {                }

            @Override
            public void onTextChanged(CharSequence charSequence, int i, int i2, int i3) {                }

            @Override
            public void afterTextChanged(Editable editable) {
                String text = et_filtertext.getText().toString().toLowerCase(Locale.getDefault());
                adapter.filter(text);
            }
        });
    }


    //Asynchrone taak om de vormingen op te halen
    private class RemoteDataTask extends AsyncTask<Void, Void, Void> {
        @Override
        protected void onPreExecute() {
            super.onPreExecute();
            mProgressDialog = new ProgressDialog(getActivity());

            mProgressDialog.setTitle("Ophalen van vormingen.");

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

        //Ophalen van vormingen en opslaan in locale database. Doorgeven aan de adapter om weer te geven.
        @Override
        protected Void doInBackground(Void... params) {
            vormingen = new ArrayList<Vorming>();

                try {
                    ParseQuery<ParseObject> query = new ParseQuery<ParseObject>(
                            "Vorming");
                    query.orderByAscending("prijs");
                    List<ParseObject> lijstVormingen = query.find();


                    myDB.dropVormingen();
                    for (ParseObject vorming : lijstVormingen) {

                        Vorming map = new Vorming();
                        map.setBetalingswijze((String) vorming.get("betalingswijze"));
                        map.setLocatie((String) vorming.get("locatie"));
                        map.setCriteriaDeelnemers((String) vorming.get("criteriaDeelnemers"));
                        map.setKorteBeschrijving((String) vorming.get("korteBeschrijving"));
                        map.setPrijs((Integer) vorming.get("prijs"));
                        map.setInbegrepenInPrijs((String) vorming.get("inbegrepenInPrijs"));
                        map.setTips((String) vorming.get("tips"));
                        map.setTitel((String) vorming.get("titel"));
                        map.setWebsiteLocatie((String) vorming.get("websiteLocatie"));
                        map.setActiviteitID(vorming.getObjectId());
                        List<String> lijstPeriodes = vorming.getList("periodes") ;
                        map.setPeriodes(  lijstPeriodes);

                        vormingen.add(map);

                        myDB.insertVorming(map);

                    }
                } catch (ParseException e) {
                    Log.e("Error", e.getMessage());
                    e.printStackTrace();
                }
            return null;


        }

        @Override
        protected void onPostExecute(Void result) {

            adapter = new VormingAdapter(rootView.getContext(), vormingen);
            listview.setAdapter(adapter);
            mProgressDialog.dismiss();

            //Filter de vormingen
            et_filtertext.addTextChangedListener(new TextWatcher() {
                @Override
                public void beforeTextChanged(CharSequence charSequence, int i, int i2, int i3) {                }

                @Override
                public void onTextChanged(CharSequence charSequence, int i, int i2, int i3) {                }

                @Override
                public void afterTextChanged(Editable editable) {
                    String text = et_filtertext.getText().toString().toLowerCase(Locale.getDefault());
                    adapter.filter(text);
                }
            });
        }
    }


    /*@Override
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
    }*/
}