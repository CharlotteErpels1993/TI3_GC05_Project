package com.hogent.ti3g05.ti3_g05_joetzapp;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.view.animation.Animation;
import android.view.animation.AnimationUtils;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.RelativeLayout;
import android.widget.TextView;
import android.widget.Toast;

import com.hogent.ti3g05.ti3_g05_joetzapp.Services.ConnectionDetector;
import com.parse.ParseObject;
import com.parse.ParseQuery;
import com.parse.ParseUser;

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
    private String gebruiker;

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

        ingeven = (Button) findViewById(R.id.feedbackIng);

        isInternetPresent = cd.isConnectingToInternet();
        if (isInternetPresent) {
            try {
               // ParseObject monitor = new ParseObject("Monitor");

                // Locate the class table named "vakantie" in Parse.com
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



            Intent i = getIntent();
        vakantie = i.getStringExtra("vakantie");



    }

}
