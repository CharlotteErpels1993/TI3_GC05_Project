package com.hogent.ti3g05.ti3_g05_joetzapp.SignUpLogin;


import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.text.TextUtils;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.Toast;

import com.hogent.ti3g05.ti3_g05_joetzapp.Services.ConnectionDetector;
import com.hogent.ti3g05.ti3_g05_joetzapp.R;
import com.parse.ParseUser;

public class SignUp_deel2 extends Activity{

    private EditText aansluitingsnummer;
    private Button volgendeButton;
    private Button terugGaanButton;

    private String aansluitingsnummerString;
    private ImageView imageView;


    // flag for Internet connection status
    Boolean isInternetPresent = false;
    // Connection detector class
    ConnectionDetector cd;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        setContentView(R.layout.activity_signup_deel2);


        // creating connection detector class instance
        cd = new ConnectionDetector(getApplicationContext());


        aansluitingsnummer = (EditText) findViewById(R.id.aansluitingsnummer);

        volgendeButton = (Button) findViewById(R.id.btn_volgendedeel3);

        terugGaanButton = (Button) findViewById(R.id.btn_terugNaarDeel1);


        volgendeButton.setOnClickListener(new OnClickListener() {
            @Override
            public void onClick(View view) {

                        // get Internet status
                        isInternetPresent = cd.isConnectingToInternet();
                        // check for Internet status
                        // Internet connection is not present
                        // Ask user to connect to Internet
                        if (isInternetPresent) {
                            // Internet Connection is Present
                            // make HTTP requests
                            opslaanAansluitingsnummer();
                        } else
                            Toast.makeText(getApplicationContext(), "Fout bij registreren", Toast.LENGTH_SHORT).show();
                        //showAlertDialog(getApplicationContext(), "No Internet Connection",
                        //"You don't have internet connection.", false);




            }
        });


        terugGaanButton.setOnClickListener(new OnClickListener() {
            @Override
            public void onClick(View view) {
                Intent intent1 = new Intent(SignUp_deel2.this, SignUp_deel1.class);
                startActivity(intent1);
            }
        });

    }



    private void opslaanAansluitingsnummer(){
        clearErrors();

        boolean cancel = false;
        View focusView = null;

        // Store values at the time of the login attempt.
        aansluitingsnummerString = aansluitingsnummer.getText().toString();

        // Check for a valid email address.
        if (TextUtils.isEmpty(aansluitingsnummerString)) {
            aansluitingsnummer.setError(getString(R.string.error_field_required));
            focusView = aansluitingsnummer;
            cancel = true;
        }

        if (cancel) {
            // There was an error; don't attempt login and focus the first
            // form field with an error.
            focusView.requestFocus();
        } else {
           opslaan(aansluitingsnummerString);

        }

    }

    private void opslaan(String aansluitingsnummerString) {
        // TODO aansluitingsnummer opslaan
        ParseUser user = new ParseUser();

        //Hier moet het aansluitingsnummer doormiddelvan parse naar de db of opslaan in een tijde

        Intent intent = new Intent(SignUp_deel2.this, SignUp_deel3.class);
        startActivity(intent);
        /*user.signUpInBackground(new SignUpCallback() {
            public void done(ParseException e) {
                if (e == null) {
                //+ opslaan naar db!!

                    Intent intent = new Intent(SignUp_deel2.this, SignUp_deel3.class);
                    startActivity(intent);
                } else {
                    // Sign up didn't succeed. Look at the ParseException
                    // to figure out what went wrong

                    //of weglaten?
                    signUpMsg("Aansluitingsnummer verkeerd");
                }
            }
        });*/
    }

    protected void signUpMsg(String msg) {
        Toast.makeText(getApplicationContext(), msg, Toast.LENGTH_SHORT).show();
    }

    private void clearErrors(){
        aansluitingsnummer.setError(null);
    }



}
