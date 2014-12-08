package com.hogent.ti3g05.ti3_g05_joetzapp;

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
import com.hogent.ti3g05.ti3_g05_joetzapp.Services.FeedbackAdapter;
import com.hogent.ti3g05.ti3_g05_joetzapp.Services.ListViewAdapter;
import com.hogent.ti3g05.ti3_g05_joetzapp.domein.Feedback;
import com.hogent.ti3g05.ti3_g05_joetzapp.domein.Vakantie;
import com.parse.ParseException;
import com.parse.ParseFile;
import com.parse.ParseObject;
import com.parse.ParseQuery;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Locale;

/**
 * Created by Gebruiker on 8/12/2014.
 */
public class feedbackOverzicht extends Fragment {

    private ListView listview;
    private List<ParseObject> ob;


    private List<ParseObject> ob2;
    private List<ParseObject> ob3;

    private List<ParseObject> ob4;
    private myDb myDB;
    Feedback map;
    private ProgressDialog mProgressDialog;
    private View rootView;
    private FeedbackAdapter adapter;
    private List<Feedback> feedback = null;
    private EditText filtertext;

    Boolean isInternetPresent = false;
    // Connection detector class
    ConnectionDetector cd;



    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        rootView = inflater.inflate(R.layout.feedback_listview, container, false);


        listview = (ListView) rootView.findViewById(R.id.listView);
        filtertext = (EditText) rootView.findViewById(R.id.filtertext);

        getActivity().getActionBar().setTitle("Joetz funfactor");

        cd = new ConnectionDetector(rootView.getContext());
        myDB = new myDb(rootView.getContext());
        myDB.open();
        isInternetPresent = cd.isConnectingToInternet();
        if (isInternetPresent) {
            //Toast.makeText(getActivity(), "internet", Toast.LENGTH_SHORT).show();
            new RemoteDataTask().execute();
        }/*
        else {
            //Toast.makeText(getActivity(), "geen internet", Toast.LENGTH_SHORT).show();
            feedback = myDB.getFeedback();

            adapter = new FeedbackAdapter(rootView.getContext(), feedback);
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
            });*/
        //}


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
            mProgressDialog.setTitle("Ophalen van funFactoren.");

            // Set progressdialog message
            mProgressDialog.setMessage("Aan het laden...");
            try {
                mProgressDialog.setIndeterminate(true);
                mProgressDialog.setIndeterminateDrawable(rootView.getResources().getDrawable(R.drawable.my_animation));
            } catch (OutOfMemoryError er)
            {
                mProgressDialog.setIndeterminate(false);
            }

            mProgressDialog.show();

        }

        @Override
        protected Void doInBackground(Void... params) {
            // Create the array
            feedback = new ArrayList<Feedback>();


            try {

                String vakantieId;
                String vakantieNaam;

                // Locate the class table named "vakantie" in Parse.com
                ParseQuery<ParseObject> query = new ParseQuery<ParseObject>(
                        "Vakantie");
                query.orderByAscending("vertrekdatum");
                ob = query.find();

                ParseQuery<ParseObject> queryOuder = new ParseQuery<ParseObject>(
                        "Ouder");
                ob3 = queryOuder.find();

                ParseQuery<ParseObject> queryMonitor = new ParseQuery<ParseObject>(
                        "Monitor");
                ob4 = queryMonitor.find();


                ParseQuery<ParseObject> queryFeedback = new ParseQuery<ParseObject>(
                        "Feedback");
                ob2 = queryFeedback.find();
                myDB.drop();
                if (ob2.isEmpty()) {
                    Toast.makeText(getActivity(), "Nog geen funfactor gegeven.", Toast.LENGTH_SHORT).show();
                } else {


                    for (ParseObject feedback : ob2) {
                        map = new Feedback();
                        map.setVakantieId((String) feedback.get("vakantie"));
                        map.setFeedback((String) feedback.get("waardering"));
                        map.setScore((Number) feedback.get("score"));
                        map.setGebruikerId((String) feedback.get("gebruiker"));
                        map.setGoedgekeurd((Boolean) feedback.get("goedgekeurd"));


                        for (ParseObject vakantie : ob) {
                            if (feedback.get("vakantie").toString().equals(vakantie.getObjectId())) {
                                map.setVakantieNaam((String) vakantie.get("titel"));
                            }
                        }

                        for (ParseObject ouder : ob3) {
                            if (feedback.get("gebruiker").toString().equals(ouder.getObjectId())) {
                                map.setGebruiker((String) ouder.get("email"));
                            }


                        }

                        for (ParseObject monitor : ob4) {
                            if (feedback.get("gebruiker").toString().equals(monitor.getObjectId())) {
                                map.setGebruiker((String) monitor.get("email"));
                            }


                        }

                    }
                    if (map.getGoedgekeurd()) {
                        feedback.add(map);
                    }
                }

                }catch(ParseException e){

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

            adapter = new FeedbackAdapter(rootView.getContext(), feedback);
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
/*
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
*/
}
