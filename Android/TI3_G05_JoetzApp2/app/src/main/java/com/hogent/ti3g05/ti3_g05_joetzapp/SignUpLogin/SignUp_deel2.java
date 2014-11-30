package com.hogent.ti3g05.ti3_g05_joetzapp.SignUpLogin;


import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.text.TextUtils;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.Toast;

import com.hogent.ti3g05.ti3_g05_joetzapp.Services.ConnectionDetector;
import com.hogent.ti3g05.ti3_g05_joetzapp.R;
import com.hogent.ti3g05.ti3_g05_joetzapp.navBarMainScreen;
import com.parse.ParseUser;

public class SignUp_deel2 extends Activity{

    private EditText aansluitingsnummer;
    private Button volgendeButton;
    private Button terugGaanButton;

    private String aansluitingsnummerString;
    private String codeGerechtigdeStr;
    private EditText codeGerechtigde;
    private EditText aansluitingsNrOuder2;
    private String aansluitingsNrOuder2Str;
    String rijksRegNr;
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
        codeGerechtigde = (EditText) findViewById(R.id.codeGerechtigde);
        aansluitingsNrOuder2 = (EditText) findViewById(R.id.aansluitingsNrOuder2);

        volgendeButton = (Button) findViewById(R.id.btn_volgendedeel3);


        getActionBar().setTitle("Registreren");

        volgendeButton.setTextColor(getResources().getColor(R.color.darkRed));


        volgendeButton.setOnClickListener(new OnClickListener() {
            @Override
            public void onClick(View view) {

                        // get Internet status
                        //isInternetPresent = cd.isConnectingToInternet();
                        // check for Internet status
                        // Internet connection is not present
                        // Ask user to connect to Internet
                isInternetPresent = cd.isConnectingToInternet();
                        if (isInternetPresent) {
                            // Internet Connection is Present
                            // make HTTP requests
                            opslaanAansluitingsnummer();
                        } else
                            Toast.makeText(getApplicationContext(), getString(R.string.error_no_internet), Toast.LENGTH_SHORT).show();
                        //showAlertDialog(getApplicationContext(), "No Internet Connection",
                        //"You don't have internet connection.", false);




            }
        });


    }



    private void opslaanAansluitingsnummer(){
        clearErrors();

        boolean cancel = false;
        View focusView = null;

        // Store values at the time of the login attempt.
        aansluitingsnummerString = aansluitingsnummer.getText().toString();
        codeGerechtigdeStr = codeGerechtigde.getText().toString();
        aansluitingsNrOuder2Str = aansluitingsNrOuder2.getText().toString();


        // Check for a valid email address.
        if (TextUtils.isEmpty(aansluitingsnummerString)) {
            aansluitingsnummer.setError(getString(R.string.error_field_required));
            focusView = aansluitingsnummer;
            cancel = true;
        } else if(aansluitingsnummerString.length() != 10)
        {
            aansluitingsnummer.setError(getString(R.string.error_incorrect_aansluitingsnr));
            focusView = aansluitingsnummer;
            cancel = true;
        }
        if (TextUtils.isEmpty(codeGerechtigdeStr)) {
            codeGerechtigde.setError(getString(R.string.error_field_required));
            focusView = codeGerechtigde;
            cancel = true;
        }

        if (!TextUtils.isEmpty(aansluitingsNrOuder2Str)) {
            if( aansluitingsNrOuder2Str.length() != 10)
            {
                aansluitingsNrOuder2.setError(getString(R.string.error_incorrect_aansluitingsnr));
                focusView = aansluitingsNrOuder2;
                cancel = true;
            }

        }

        if (cancel) {
            // There was an error; don't attempt login and focus the first
            // form field with an error.
            focusView.requestFocus();
        } else {
           opslaan(aansluitingsnummerString, codeGerechtigdeStr, aansluitingsNrOuder2Str);

        }

    }

    private void opslaan(String aansluitingsnummerString, String codeGerechtigdeStr, String aansluitingsNrOuder2Str) {
        Intent intent = new Intent(getApplicationContext(), SignUp_deel3.class);
        Bundle extras = getIntent().getExtras();
        if (extras != null) {
            String value = extras.getString("lidVanBondMoyson");
            rijksRegNr = extras.getString("rijksregisternr");
            intent.putExtra("lidVanBondMoyson", value);
            intent.putExtra("rijksregisternr", rijksRegNr);

            Toast.makeText(getApplicationContext(), "niet leeg deel2", Toast.LENGTH_SHORT).show();
        }
        intent.putExtra("aansluitingsnr", aansluitingsnummerString);
        intent.putExtra("codeGerechtigde", codeGerechtigdeStr);
        if(aansluitingsNrOuder2Str != null)
        {
            intent.putExtra("aansluitingsnrOuder2", aansluitingsNrOuder2Str);
        }
        else
            intent.putExtra("aansluitingsnrOuder2", "");

        startActivity(intent);

        overridePendingTransition(R.anim.right_in, R.anim.left_out);
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
        aansluitingsnummer.setError(null); codeGerechtigde.setError(null);
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
            Intent intent1 = new Intent(this, SignUp_deel1.class);
            startActivity(intent1);

            overridePendingTransition(R.anim.left_in, R.anim.right_out);
        }

        return super.onOptionsItemSelected(item);
    }



}
