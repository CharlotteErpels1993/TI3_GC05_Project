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
import com.hogent.ti3g05.ti3_g05_joetzapp.Services.FeedbackAdapter;
import com.hogent.ti3g05.ti3_g05_joetzapp.domein.Feedback;
import com.parse.ParseException;
import com.parse.ParseObject;
import com.parse.ParseQuery;

import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

//Geeft een overzicht weer van feedback
public class FeedbackOverzicht extends Fragment {

    private ListView listview;

    private List<ParseObject> lijstMetParseVakanties;
    private List<ParseObject> lijstMetParseFeedback;

    private SqliteDatabase sqliteDatabase;
    private Feedback feedback;
    private ProgressDialog mProgressDialog;
    private View rootView;
    private FeedbackAdapter adapter;
    private List<Feedback> feedbackList = null;
    private EditText filtertext;

    private Boolean isInternetPresent = false;
    private ConnectionDetector cd;

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        rootView = inflater.inflate(R.layout.feedback_listview, container, false);


        listview = (ListView) rootView.findViewById(R.id.listView);
        filtertext = (EditText) rootView.findViewById(R.id.filtertext);

        getActivity().getActionBar().setTitle(getString(R.string.mainTitle_Funfactor));

        cd = new ConnectionDetector(rootView.getContext());
        sqliteDatabase = new SqliteDatabase(rootView.getContext());
        sqliteDatabase.open();
        //als internet aanwezig is haal alle feedbacks op, zoneen haal alle feedbacks op uit de locale database
        isInternetPresent = cd.isConnectingToInternet();
        if (isInternetPresent) {
            new RemoteDataTask().execute();
        }
        else {
            feedbackList = sqliteDatabase.getFeedback();

            adapter = new FeedbackAdapter(rootView.getContext(), feedbackList);
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

    // Asynchrone taak om feedbacks op te halen
    private class RemoteDataTask extends AsyncTask<Void, Void, Void> {
        @Override
        protected void onPreExecute() {
            super.onPreExecute();
            mProgressDialog = new ProgressDialog(getActivity());

            mProgressDialog.setTitle(getString(R.string.loadingMSG_feedback));

            mProgressDialog.setMessage(getString(R.string.loading_message));
            try {
                mProgressDialog.setIndeterminate(true);
                mProgressDialog.setIndeterminateDrawable(rootView.getResources().getDrawable(R.drawable.my_animation));
            } catch (OutOfMemoryError er)
            {
                mProgressDialog.setIndeterminate(false);
            }

            //Toon de dialoog
            mProgressDialog.show();

        }


        //Haal de gegevens op en stop deze in de locale database Doorgeven aan de adapter om weer te geven.
        @Override
        protected Void doInBackground(Void... params) {
            feedbackList = new ArrayList<Feedback>();

            try {

                ParseQuery<ParseObject> queryFeedback = new ParseQuery<ParseObject>("Feedback");
                queryFeedback.orderByAscending("vakantie");
                lijstMetParseFeedback = queryFeedback.find();
                sqliteDatabase.dropFeedback();
                if (lijstMetParseFeedback.isEmpty()) {
                    Toast.makeText(getActivity(), getString(R.string.message_no_feedback), Toast.LENGTH_SHORT).show();
                } else {

                    ParseQuery<ParseObject> qryVakantiesOphalen = new ParseQuery<ParseObject>( "Vakantie");
                    qryVakantiesOphalen.orderByAscending("vertrekdatum");
                    lijstMetParseVakanties = qryVakantiesOphalen.find();

                    for (ParseObject f : lijstMetParseFeedback) {
                        feedback = new Feedback();
                        feedback.setVakantieId((String) f.get("vakantie"));
                        feedback.setFeedback((String) f.get("waardering"));
                        feedback.setScore((Number) f.get("score"));
                        feedback.setGebruikerId((String) f.get("gebruiker"));
                        feedback.setGoedgekeurd((Boolean) f.get("goedgekeurd"));


                        for (ParseObject vakantie : lijstMetParseVakanties) {
                            if (f.get("vakantie").toString().equals(vakantie.getObjectId())) {
                                feedback.setVakantieNaam((String) vakantie.get("titel"));
                            }
                        }
                        if (feedback.getGoedgekeurd()) {
                            feedbackList.add(feedback);
                            sqliteDatabase.insertFeedback(feedback);
                        }

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

            //geeft de feedbacklijst door aan de adapter om deze juist weer te geven
            adapter = new FeedbackAdapter(rootView.getContext(), feedbackList);
            // De adapter aan de listview binden
            listview.setAdapter(adapter);
            // Sluit de dialoog
            mProgressDialog.dismiss();

            // Filter de feedbacklijst
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
