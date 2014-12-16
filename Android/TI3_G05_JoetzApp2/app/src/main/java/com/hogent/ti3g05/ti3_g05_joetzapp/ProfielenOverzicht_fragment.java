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
import android.widget.Toast;

import com.hogent.ti3g05.ti3_g05_joetzapp.SQLLite.SqliteDatabase;
import com.hogent.ti3g05.ti3_g05_joetzapp.Services.ConnectionDetector;
import com.hogent.ti3g05.ti3_g05_joetzapp.Services.ProfielAdapter;
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

//Geeft een overzicht van alle monitoren
public class ProfielenOverzicht_fragment extends Fragment /* implements SwipeRefreshLayout.OnRefreshListener*/ {
    private ListView listview;
    private ProgressDialog mProgressDialog;
    private ProfielAdapter adapter;
    private List<Monitor> alleProfielenUitParse = null;
    private List<Monitor> profielenMetZelfdeVorming = null;
    private List<Monitor> profielenAndere = null;
    private List<Monitor> profielenSamen = null;
    private EditText filtertext;
    private SqliteDatabase sqliteDatabase;
    private List<InschrijvingVorming> inschrijvingVormingen = new ArrayList<InschrijvingVorming>();
    private List<InschrijvingVorming> alleIns = new ArrayList<InschrijvingVorming>();

    private Monitor ingelogdeMonitor = new Monitor();
    Boolean isInternetPresent = false;
    ConnectionDetector cd;


    private View rootView;

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        rootView = inflater.inflate(R.layout.profielen_overzicht, container, false);


        listview = (ListView) rootView.findViewById(R.id.listViewp);
        filtertext = (EditText) rootView.findViewById(R.id.filtertextp);

        getActivity().getActionBar().setTitle("Profielen");

        cd = new ConnectionDetector(rootView.getContext());
        sqliteDatabase = new SqliteDatabase(rootView.getContext());
        sqliteDatabase.open();
        //Kijk of er internet aanwezig is, zoja haal de monitoren op, zoneen haal de gegevens op uit de locale database
        isInternetPresent = cd.isConnectingToInternet();
        if(getActivity().getIntent().getStringExtra("herladen")!= null && getActivity().getIntent().getStringExtra("herladen").toLowerCase().equals("nee"))
        {
            getProfielen();
        }

        if (isInternetPresent) {
             new RemoteDataTask().execute();
        }
        else {
        getProfielen();
        }

        return rootView;
    }

    //Haal de profielen op uit de locale database
    public void getProfielen()
    {
        alleProfielenUitParse = sqliteDatabase.getProfielen();
        adapter = new ProfielAdapter(rootView.getContext(), alleProfielenUitParse);
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


    // Asynchrone taak om monitoren op te halen
    private class RemoteDataTask extends AsyncTask<Void, Void, Void> {
        @Override
        protected void onPreExecute() {
            super.onPreExecute();
            mProgressDialog = new ProgressDialog(getActivity());

            mProgressDialog.setTitle(getString(R.string.loadingMSG_profielen));

            mProgressDialog.setMessage(getString(R.string.loading_message));
            try {
                mProgressDialog.setIndeterminate(true);
                mProgressDialog.setIndeterminateDrawable(getResources().getDrawable(R.drawable.my_animation));
            }catch (OutOfMemoryError er)
            {
                mProgressDialog.setIndeterminate(false);
            }

            // Toon dialoog
            mProgressDialog.show();
        }

        //Haal de gegevens op en stop deze in de locale database Doorgeven aan de adapter om weer te geven.
        @Override
        protected Void doInBackground(Void... params) {
            alleProfielenUitParse = new ArrayList<Monitor>();
            profielenAndere = new ArrayList<Monitor>();
            profielenMetZelfdeVorming = new ArrayList<Monitor>();
            profielenSamen = new ArrayList<Monitor>();

            isInternetPresent = cd.isConnectingToInternet();
            if(isInternetPresent) {

                try {
                   ParseQuery<ParseObject> query = new ParseQuery<ParseObject>(
                            "Monitor");
                    query.orderByAscending("naam");
                    List<ParseObject> lijstMetMonitoren = query.find();

                    sqliteDatabase.dropProfielen();
                    for (ParseObject monitor : lijstMetMonitoren) {

                        Monitor map = new Monitor();
                        map.setNaam((String) monitor.get("naam"));
                        map.setVoornaam((String) monitor.get("voornaam"));
                        map.setStraat((String) monitor.get("straat"));
                        map.setMonitorId(monitor.getObjectId());
                        map.setPostcode((Integer) monitor.get("postcode"));
                        map.setHuisnr((Number) monitor.get("nummer"));
                        if (monitor.get("lidNr") == null) {
                            map.setLidNummer("0");
                        } else {
                            map.setLidNummer(monitor.get("lidNr").toString());
                        }
                        map.setEmail((String) monitor.get("email"));
                        map.setGemeente((String) monitor.get("gemeente"));
                        map.setGsmnr((String) monitor.get("gsm"));
                        map.setTelefoonnr((String) monitor.get("telefoon"));
                        map.setRijksregNr((String) monitor.get("rijksregisterNr"));


                        if (map.getEmail() != null) {
                            if (map.getEmail().equals(ParseUser.getCurrentUser().getEmail())) {
                                ingelogdeMonitor = map;
                            }
                        }

                        alleProfielenUitParse.add(map);

                        sqliteDatabase.insertProfiel(map);

                    }
                } catch (ParseException e) {
                    Log.e("Error", e.getMessage());
                    e.printStackTrace();

                    alleProfielenUitParse = sqliteDatabase.getProfielen();

                }

                if (ParseUser.getCurrentUser().get("soort").toString().toLowerCase().equals("monitor")) {
                    try {

                        //Sorteer de gegevens om juist weer te geven met de bijhorende headers
                        ParseQuery<ParseObject> queryVorming = new ParseQuery<ParseObject>(
                                "InschrijvingVorming");
                        List<ParseObject> lijstInschrijvingenVorming = queryVorming.find();
                        InschrijvingVorming iv;
                        for (ParseObject inschrVorming : lijstInschrijvingenVorming) {
                            iv = new InschrijvingVorming();
                            iv.setMonitor((String) inschrVorming.get("monitor"));
                            iv.setVorming((String) inschrVorming.get("vorming"));
                            if (ingelogdeMonitor.getMonitorId().equals(iv.getMonitor())) {
                                inschrijvingVormingen.add(iv);
                            }
                            alleIns.add(iv);

                        }

                        profielenMetZelfdeVorming.add(ingelogdeMonitor);
                        for (Monitor m : alleProfielenUitParse) {
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

                        //Verwijder duplicaten
                        profielenMetZelfdeVorming.remove(ingelogdeMonitor);
                        HashSet<Monitor> hs = new HashSet<Monitor>();
                        hs.addAll(profielenMetZelfdeVorming);
                        profielenMetZelfdeVorming.clear();
                        profielenMetZelfdeVorming.addAll(hs);

                        //er worden 3 'monitoren' toegevoegd aan de lijst. Deze dienen enkel als header gebbruikt te worden. Kan niet op geklikt worden.
                        //naam & voornaam wordt leeg gelaten, want null geeft een fout bij filtering
                        Monitor eigenHeader = new Monitor();
                        eigenHeader.setNaam("");
                        eigenHeader.setVoornaam("");
                        eigenHeader.setMonitorId(getString(R.string.profielHeaderEen));
                        profielenSamen.add(eigenHeader);

                        profielenSamen.add(ingelogdeMonitor);

                        Monitor eersteHeader = new Monitor();
                        eersteHeader.setNaam("");
                        eersteHeader.setVoornaam("");
                        eersteHeader.setMonitorId(getString(R.string.profielHeaderTwee));
                        profielenSamen.add(eersteHeader);

                        profielenSamen.addAll(profielenMetZelfdeVorming);

                        Monitor tweedeHeader = new Monitor();
                        tweedeHeader.setNaam("");
                        tweedeHeader.setVoornaam("");
                        tweedeHeader.setMonitorId(getString(R.string.profielHeaderDrie));
                        profielenSamen.add(tweedeHeader);

                        // profielenSamen.addAll(profielenMetZelfdeVorming.size(),profielenAndere);
                        profielenSamen.addAll(profielenAndere);


                    } catch (ParseException e) {
                        Toast.makeText(getActivity(), getString(R.string.error_generalException), Toast.LENGTH_SHORT).show();
                    }
                } else {
                    profielenSamen = alleProfielenUitParse;


                }
            }else {
                profielenSamen = sqliteDatabase.getProfielen();
            }
            return null;
        }

        @Override
        protected void onPostExecute(Void result) {

            adapter = new ProfielAdapter(rootView.getContext(), profielenSamen);

            listview.setAdapter(adapter);

            mProgressDialog.dismiss();

            //Filter de profielen
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
