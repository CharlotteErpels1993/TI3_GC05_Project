package com.hogent.ti3g05.ti3_g05_joetzapp;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.text.TextUtils;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.view.animation.Animation;
import android.view.animation.AnimationUtils;
import android.widget.Button;
import android.widget.EditText;
import android.widget.RatingBar;
import android.widget.TextView;
import android.widget.Toast;

import com.hogent.ti3g05.ti3_g05_joetzapp.Services.ConnectionDetector;
import com.parse.ParseObject;
import com.parse.ParseQuery;
import com.parse.ParseUser;

import java.util.Date;
import java.util.List;

//Geeft de ingelogde gebruiker de mogelijkheid om feedback toe te voegen over een vakantie
public class FeedbackGeven extends Activity {

    private String vakantie;
    private String vakantieId;
    private String gebruiker = null;

    private EditText feedbackText;
    private TextView error;


    private boolean cancel = false;
    private View focusView = null;
    private Boolean isInternetPresent = false;
    private ConnectionDetector cd;
    private RatingBar ratingBar;
    private List<ParseObject> lijstMetParseOuders;
    private List<ParseObject> lijstMetParseMonitoren;


    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.feedback_ingeven);

        cd= new ConnectionDetector(FeedbackGeven.this);
        final Button ingeven = (Button) findViewById(R.id.ingevenFeedback);

        final Animation animAlpha = AnimationUtils.loadAnimation(this, R.anim.alpha);

        ratingBar = (RatingBar) findViewById(R.id.ratingBar);
        setTitle("Funfactor");

        error = (TextView)findViewById(R.id.Error);
        feedbackText = (EditText) findViewById(R.id.feedbackIng);

        isInternetPresent = cd.isConnectingToInternet();
        //Kijkt of er internet aanwezig is, zoja haal de gebruikerId op van de ingelogde gebruiker
        if (isInternetPresent) {
            try {
                String emailOmNaarTeZoeken = ParseUser.getCurrentUser().getEmail();

                // Kijk eerst in ouder, als hier het emailadres van de ingelogde gebruiker niet gevonden is, kijk dan in de monitor tabel
                ParseQuery<ParseObject> query = new ParseQuery<ParseObject>("Ouder");
                lijstMetParseOuders = query.find();
                for (ParseObject ouder : lijstMetParseOuders) {

                    if (ouder.get("email").equals(emailOmNaarTeZoeken)) {
                        gebruiker = ouder.getObjectId();
                    }
                }

                if(gebruiker == null)
                {
                    ParseQuery<ParseObject> query2 = new ParseQuery<ParseObject>("Monitor");
                    lijstMetParseMonitoren = query2.find();
                    for (ParseObject monitor : lijstMetParseMonitoren) {

                        if (monitor.get("email").equals(emailOmNaarTeZoeken)) {
                            gebruiker = monitor.getObjectId();
                        }
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
            //haal de vakantie op en het id van de vorige activiteit
            vakantie = extras.getString("vakantie");
            vakantieId = extras.getString("vakantieId");
        }

        TextView vakantieNaam = (TextView) findViewById(R.id.vakantienaamFeedback);
        vakantieNaam.setText(vakantie);
        ingeven.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {

                ingeven.startAnimation(animAlpha);
                //Bij het drukken op de knop kijk of er internet is, zoja haal de rating op van de ratingbar en controleer de ingegeven waarden
                //Zoneen geef een gepaste melding
                if(isInternetPresent)
                {
                    String feedback = feedbackText.getText().toString();
                    String score = (String.valueOf(ratingBar.getRating()));
                    valideerGegevens(feedback, score);
                }
                else
                {
                    Toast.makeText(getApplicationContext(), getString(R.string.error_no_internet), Toast.LENGTH_SHORT).show();

                }

            }
        });

    }

    //valideer de waarden
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
            error.setText("Moet ingevuld worden");
            cancel = true;
        }else{
            if ((int)Double.parseDouble(score)== 0){

                error.setText("Moet ingevuld worden");
                cancel = true;
            }
        }


        if (cancel) {

            focusView.requestFocus();
        } else {

            opslaan(feedback, score);
        }
    }

    //Sla de feedback op in de tabel in parse en stuur de gebruiker met de juiste melding door naar het vakantieoverzicht
    public  void opslaan(String feedback, String score)
    {
        Date dateVandaag = new Date();
        ParseObject feedbackObject = new ParseObject("Feedback");

        feedbackObject.put("vakantie", vakantieId);
        feedbackObject.put("waardering", feedback);
        feedbackObject.put("gebruiker", gebruiker);
        feedbackObject.put("score", (int)Double.parseDouble(score));
        feedbackObject.put("goedgekeurd", false);
        feedbackObject.put("datum", dateVandaag);

        feedbackObject.saveInBackground();

        Toast.makeText(FeedbackGeven.this, "feedback is succesvol geregistreerd", Toast.LENGTH_SHORT).show();
        Intent intent = new Intent(FeedbackGeven.this, navBarMainScreen.class);
        startActivity(intent);


    }

    private void clearErrors(){
        feedbackText.setError(null);

    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        getMenuInflater().inflate(R.menu.back_2, menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        int id = item.getItemId();
        if (id == R.id.backMenu2) {
            Intent intent1 = new Intent(this, navBarMainScreen.class);
            intent1.putExtra("naarfrag", "feedback");
            intent1.putExtra("herladen","nee");
            intent1.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
            startActivity(intent1);

            overridePendingTransition(R.anim.left_in, R.anim.right_out);
        }

        return super.onOptionsItemSelected(item);
    }

    @Override
    public void onBackPressed() {
        Intent setIntent = new Intent(FeedbackGeven.this, navBarMainScreen.class);
        setIntent.putExtra("naarfrag","feedback");
        setIntent.putExtra("herladen","nee");
        setIntent.addCategory(Intent.CATEGORY_HOME);
        setIntent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
        startActivity(setIntent);
    }
}
