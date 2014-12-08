package com.hogent.ti3g05.ti3_g05_joetzapp;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.text.TextUtils;
import android.view.View;
import android.view.animation.Animation;
import android.view.animation.AnimationUtils;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ExpandableListView;
import android.widget.ImageView;
import android.widget.RelativeLayout;
import android.widget.TextView;
import android.widget.Toast;

import com.hogent.ti3g05.ti3_g05_joetzapp.Services.ConnectionDetector;
import com.parse.ParseObject;
import com.parse.ParseQuery;
import com.parse.ParseUser;

import org.w3c.dom.Text;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

/**
 * Created by Gebruiker on 8/12/2014.
 */
public class feedback_geven extends Activity {

    private String vakantie;
    private String vakantieId;
    private String gebruiker;

    private EditText feedbackText;
    private EditText scoreText;

    TextView vakantieNaam;


    private boolean cancel = false;
    private View focusView = null;
    // flag for Internet connection status
    Boolean isInternetPresent = false;
    // Connection detector class
    ConnectionDetector cd;


    Button ingeven;
    private List<ParseObject> ob;
    private List<ParseObject> ob2;


    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.feedback_ingeven);

        cd= new ConnectionDetector(feedback_geven.this);
        ingeven = (Button) findViewById(R.id.ingevenFeedback);

        feedbackText = (EditText) findViewById(R.id.feedbackIng);
        scoreText = (EditText) findViewById(R.id.score);

        isInternetPresent = cd.isConnectingToInternet();
        if (isInternetPresent) {
            try {

                // Locate the class table named "Ouder" in Parse.com
                ParseQuery<ParseObject> query = new ParseQuery<ParseObject>(
                        "Ouder");

                ob = query.find();

                for (ParseObject ouder : ob) {

                    if (ouder.get("email").equals(ParseUser.getCurrentUser().getEmail())) {
                        gebruiker = ouder.getObjectId();
                    }
                }

                ParseQuery<ParseObject> query2 = new ParseQuery<ParseObject>(
                        "Monitor");

                ob2 = query2.find();

                for (ParseObject monitor : ob2) {

                    if (monitor.get("email").equals(ParseUser.getCurrentUser().getEmail())) {
                        gebruiker = monitor.getObjectId();
                    }
                }
            } catch (com.parse.ParseException e) {
                e.printStackTrace();
            }
        }
        else
        {
            Toast.makeText(getApplicationContext(), getString(R.string.error_no_internet), Toast.LENGTH_SHORT).show();
        }


        Bundle extras = getIntent().getExtras();
        if(extras != null)
        {
            vakantie = extras.getString("vakantie");
            vakantieId = extras.getString("vakantieId");
        }

        vakantieNaam = (TextView) findViewById(R.id.vakantienaamFeedback);
        vakantieNaam.setText(vakantie);
        ingeven.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                String feedback;
                String score;

                feedback = feedbackText.getText().toString();
                score = scoreText.getText().toString();
                valideerGegevens(feedback, score);
            }
        });



    }

    public void valideerGegevens(String feedback, String score)
    {
        clearErrors();
        cancel = false;

        if (TextUtils.isEmpty(feedback)) {
            feedbackText.setError(getString(R.string.error_field_required));
            focusView = feedbackText;
            cancel = true;
        }else{
            if (feedback.length() > 300){
                feedbackText.setError(getString(R.string.error_incorrect_feedback));
                focusView = feedbackText;
                cancel = true;
            }
        }

        if(TextUtils.isEmpty(score))
        {
            scoreText.setError(getString(R.string.error_field_required));
            focusView = scoreText;
            cancel = true;
        }else{
            if (Integer.parseInt(score) > 5){
                scoreText.setError(getString(R.string.error_incorrect_score));
                focusView = scoreText;
                cancel = true;
            }
        }


        if (cancel) {
            // There was an error; don't attempt login and focus the first
            // form field with an error.
            focusView.requestFocus();
        } else {
            // Show a progress spinner, and kick off a background task to
            // perform the user login attempt.
            opslaan(feedback, score);
            //Toast.makeText(getApplicationContext(), "Opgeslagen", Toast.LENGTH_SHORT).show();

        }
    }

    public  void opslaan(String feedback, String score)
    {

        try {
        ParseObject feedbackObject = new ParseObject("Feedback");

        feedbackObject.put("vakantie", vakantieId);
        feedbackObject.put("waardering", feedback);
        feedbackObject.put("gebruiker", gebruiker);
        feedbackObject.put("score", Integer.parseInt(score));
        feedbackObject.put("goedgekeurd", false);

            feedbackObject.save();

            Toast.makeText(feedback_geven.this, "feedback is succesvol geregistreerd", Toast.LENGTH_SHORT).show();
            Intent intent = new Intent(feedback_geven.this, navBarMainScreen.class);
            startActivity(intent);

        } catch (com.parse.ParseException e) {
            e.printStackTrace();
        }
    }

    private void clearErrors(){
        feedbackText.setError(null);
        scoreText.setError(null);

    }

}
