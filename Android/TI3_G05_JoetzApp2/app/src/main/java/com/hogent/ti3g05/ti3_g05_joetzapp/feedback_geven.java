package com.hogent.ti3g05.ti3_g05_joetzapp;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.text.TextUtils;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;
import android.widget.Toast;

import com.hogent.ti3g05.ti3_g05_joetzapp.Services.ConnectionDetector;
import com.parse.ParseObject;
import com.parse.ParseQuery;
import com.parse.ParseUser;

import java.util.List;


public class feedback_geven extends Activity {

    private String vakantie;
    private String vakantieId;
    private String gebruiker;

    private EditText feedbackText;
    private EditText scoreText;


    private boolean cancel = false;
    private View focusView = null;
    // flag for Internet connection status
    private Boolean isInternetPresent = false;
    // Connection detector class
    private ConnectionDetector cd;

    private List<ParseObject> lijstMetParseOuders;
    private List<ParseObject> lijstMetParseMonitoren;


    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.feedback_ingeven);

        cd= new ConnectionDetector(feedback_geven.this);
        Button ingeven = (Button) findViewById(R.id.ingevenFeedback);


        setTitle("Funfactor");

        feedbackText = (EditText) findViewById(R.id.feedbackIng);
        scoreText = (EditText) findViewById(R.id.score);

        isInternetPresent = cd.isConnectingToInternet();
        if (isInternetPresent) {
            try {
                String emailToLookFor = ParseUser.getCurrentUser().getEmail();

                // Locate the class table named "Ouder" in Parse.com
                ParseQuery<ParseObject> query = new ParseQuery<ParseObject>("Ouder");
                lijstMetParseOuders = query.find();
                for (ParseObject ouder : lijstMetParseOuders) {

                    if (ouder.get("email").equals(emailToLookFor)) {
                        gebruiker = ouder.getObjectId();
                    }
                }

                ParseQuery<ParseObject> query2 = new ParseQuery<ParseObject>("Monitor");
                lijstMetParseMonitoren = query2.find();
                for (ParseObject monitor : lijstMetParseMonitoren) {

                    if (monitor.get("email").equals(emailToLookFor)) {
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

        TextView vakantieNaam = (TextView) findViewById(R.id.vakantienaamFeedback);
        vakantieNaam.setText(vakantie);
        ingeven.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                String feedback = feedbackText.getText().toString();
                String score = scoreText.getText().toString();
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
        }
    }

    public  void opslaan(String feedback, String score)
    {
        ParseObject feedbackObject = new ParseObject("Feedback");

        feedbackObject.put("vakantie", vakantieId);
        feedbackObject.put("waardering", feedback);
        feedbackObject.put("gebruiker", gebruiker);
        feedbackObject.put("score", Integer.parseInt(score));
        feedbackObject.put("goedgekeurd", false);

        feedbackObject.saveInBackground();

        Toast.makeText(feedback_geven.this, "feedback is succesvol geregistreerd", Toast.LENGTH_SHORT).show();
        Intent intent = new Intent(feedback_geven.this, navBarMainScreen.class);
        startActivity(intent);


    }

    private void clearErrors(){
        feedbackText.setError(null);
        scoreText.setError(null);

    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.back_2, menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        int id = item.getItemId();
        if (id == R.id.backMenu2) {
            Intent intent1 = new Intent(this, navBarMainScreen.class);
            intent1.putExtra("naarfrag", "activiteit");
            intent1.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
            startActivity(intent1);

            overridePendingTransition(R.anim.left_in, R.anim.right_out);
        }

        return super.onOptionsItemSelected(item);
    }

}
