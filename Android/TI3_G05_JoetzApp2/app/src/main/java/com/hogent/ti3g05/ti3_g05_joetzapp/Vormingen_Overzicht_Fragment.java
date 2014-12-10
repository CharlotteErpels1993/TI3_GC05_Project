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

public class Vormingen_Overzicht_Fragment extends Fragment /*implements SwipeRefreshLayout.OnRefreshListener*/ {

    private ListView listview;
    private ProgressDialog mProgressDialog;
    private VormingAdapter adapter;
    private myDb myDB;
    private List<Vorming> vormingen = null;
    private EditText et_filtertext;
    // SwipeRefreshLayout swipeLayout;
    // flag for Internet connection status
    private Boolean isInternetPresent = false;
    // Connection detector class
    private ConnectionDetector cd;
    private View rootView;


    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        rootView = inflater.inflate(R.layout.vorming_overzicht, container, false);

        getActivity().getActionBar().setTitle("Vormingen");

        listview = (ListView) rootView.findViewById(R.id.listViewv);
        et_filtertext = (EditText) rootView.findViewById(R.id.filtertextv);
        //swipeLayout = (SwipeRefreshLayout) rootView.findViewById(R.id.swipe_container);
        //onCreateSwipeToRefresh(swipeLayout);

        cd = new ConnectionDetector(rootView.getContext());
        myDB = new myDb(rootView.getContext());
        myDB.open();
        isInternetPresent = cd.isConnectingToInternet();

        if(getActivity().getIntent().getStringExtra("herladen")!= null && getActivity().getIntent().getStringExtra("herladen").toLowerCase().equals("nee"))
        {
            getVormingen();
        }

        if (isInternetPresent) {
            //Toast.makeText(getActivity(), "internet", Toast.LENGTH_SHORT).show();
            new RemoteDataTask().execute();
        }
        else {
            getVormingen();
        }

        return rootView;
    }

    public void getVormingen()
    {
        //Toast.makeText(getActivity(), "geen internet", Toast.LENGTH_SHORT).show();
        vormingen = myDB.getVormingen();
        adapter = new VormingAdapter(rootView.getContext(), vormingen);
        // Binds the Adapter to the ListView
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


    // 'Laden' schermpje tonen
    private class RemoteDataTask extends AsyncTask<Void, Void, Void> {
        @Override
        protected void onPreExecute() {
            super.onPreExecute();
            // Create a progressdialog
            mProgressDialog = new ProgressDialog(getActivity());
            // Set progressdialog title
            mProgressDialog.setTitle("Ophalen van vormingen.");
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

            // Show progressdialog
            mProgressDialog.show();
        }

        //lijst van Vormingen ophalen in de achtergrond en tonen via de custom adapter. Kan eventueel onderbroken worden
        @Override
        protected Void doInBackground(Void... params) {
            // Create the array
            vormingen = new ArrayList<Vorming>();

                try {
                    // Locate the class table named "vakantie" in Parse.com
                    ParseQuery<ParseObject> query = new ParseQuery<ParseObject>(
                            "Vorming");
                    // Locate the column named "vertrekdatum" in Parse.com and order list
                    // by ascending
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
            // Locate the listview in listview_main.xml
            //listview = (ListView) findViewById(R.id.listView);
            // Pass the results into ListViewAdapter.java
            //adapter = new ListViewAdapter(activiteit_overzicht.this, vakanties);
            //ArrayAdapter<Profile> profileAdapter = new ArrayAdapter<Profile>(context, resource, profiles)
            //ArrayAdapter<Vakantie> vakantieAdapter = new ArrayAdapter<Vakantie>(activiteit_overzicht.this, R.layout.listview_item , vakanties);

            adapter = new VormingAdapter(rootView.getContext(), vormingen);
            // Binds the Adapter to the ListView
            listview.setAdapter(adapter);
            // Close the progressdialog
            mProgressDialog.dismiss();

            //swipeLayout.setRefreshing(false);

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