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
import android.widget.Toast;

import com.hogent.ti3g05.ti3_g05_joetzapp.Services.ConnectionDetector;
import com.hogent.ti3g05.ti3_g05_joetzapp.SignUpLogin.SignUp_deel1;
import com.parse.ParseException;
import com.parse.ParseObject;
import com.parse.ParseQuery;
import com.parse.ParseUser;
import com.parse.SignUpCallback;

import java.util.List;

/**
 * Created by Gebruiker on 5/12/2014.
 */
public class LidnummerToevoegen extends Activity {
    private EditText lidnummer;
    private EditText rijksregisternr;
    private EditText email;

    private Button toevoegen;
    private Boolean cancel;

    private View focusView = null;

    // flag for Internet connection status
    Boolean isInternetPresent = false;
    // Connection detector class
    ConnectionDetector cd;

    @Override
    protected void onCreate(Bundle savedInstanceState) {

        super.onCreate(savedInstanceState);

        setContentView(R.layout.toevoegen_lidnummer);

        // creating connection detector class instance
        cd = new ConnectionDetector(getApplicationContext());

        getActionBar().setTitle("Lidnummer toevoegen");


        email = (EditText) findViewById(R.id.etEmailLidnummerToevoegen);
        rijksregisternr = (EditText) findViewById(R.id.rijksRegNrLidnummerToevoegen);
        lidnummer = (EditText) findViewById(R.id.lidnrToevoegen);




        toevoegen = (Button) findViewById(R.id.btnVoegLidnrToe);
        //mCreateAccountButton.setTextColor(getResources().getColor(R.color.Rood));
        toevoegen.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                isInternetPresent = cd.isConnectingToInternet();
                if (isInternetPresent) {
                    // Internet Connection is Present
                    // make HTTP requests
                    voegLidnrToe();
                } else
                    Toast.makeText(getApplicationContext(), getString(R.string.error_no_internet), Toast.LENGTH_SHORT).show();
                //showAlertDialog(getApplicationContext(), "No Internet Connection",
                //"You don't have internet connection.", false);
            }
        });


    }


    private void voegLidnrToe(){
        clearErrors();
        cancel = false;

        String Email = email.getText().toString();
        String rijksregisternummer = rijksregisternr.getText().toString();
        String lidnr = lidnummer.getText().toString();
        Boolean lidnrJuist = null;
        Boolean gebruiker = false;
        Boolean rijksRegnr = false;


       if(TextUtils.isEmpty((lidnr)))
       {
            lidnummer.setError(getString(R.string.error_field_required));
            focusView = lidnummer;
            cancel = true;
       }
        ParseQuery<ParseObject> query2 = ParseQuery.getQuery("NieuweMonitor");
        query2.whereEqualTo("rijksregisterNr", rijksregisternummer);
        try{
            List<ParseObject> lijstObjecten = query2.find();
            if (lijstObjecten.size() > 0){
                rijksregisternr.setError(getString(R.string.error_occupied_rijksregnr));
                focusView = rijksregisternr;
                cancel = true;
            }
        }
        catch(ParseException e){
            Toast.makeText(LidnummerToevoegen.this,getString(R.string.error_generalException), Toast.LENGTH_SHORT).show();
            cancel = true;
        }

        ParseQuery<ParseObject> query3 = ParseQuery.getQuery("NieuweMonitor");
        query3.whereEqualTo("lidnummer", lidnr);
        try{
            List<ParseObject> lijstObjecten = query3.find();
            if (lijstObjecten.size() > 0){
                lidnummer.setError(getString(R.string.error_lidnr_used));
                focusView = lidnummer;
                cancel = true;
            }
        }
        catch(ParseException e){
            Toast.makeText(LidnummerToevoegen.this,getString(R.string.error_generalException), Toast.LENGTH_SHORT).show();
            cancel = true;
        }

        ParseQuery<ParseObject> query4 = ParseQuery.getQuery("NieuweMonitor");
        query4.whereEqualTo("email", Email);
        try{
            List<ParseObject> lijstObjecten = query4.find();
            if (lijstObjecten.size() > 0){
                email.setError(getString(R.string.error_email_used));
                focusView = email;
                cancel = true;
            }
        }
        catch(ParseException e){
            Toast.makeText(LidnummerToevoegen.this,getString(R.string.error_generalException), Toast.LENGTH_SHORT).show();
            cancel = true;
        }


        if (TextUtils.isEmpty(Email)) {
            email.setError(getString(R.string.error_field_required));
            focusView = email;
            cancel = true;
        }
        if (TextUtils.isEmpty(rijksregisternummer)) {
            lidnummer.setError(getString(R.string.error_field_required));
            focusView = lidnummer;
            cancel = true;
        } else if (lidnr.length() < 5) {
            lidnummer.setError(getString(R.string.error_invalid_lidnummer));
            focusView = lidnummer;
            cancel = true;
        }



        if (cancel) {
            // There was an error; don't attempt login and focus the first
            // form field with an error.
            focusView.requestFocus();
        } else {
            // Show a progress spinner, and kick off a background task to
            // perform the user login attempt.
            //Toast.makeText(getApplicationContext(), "Registreren", Toast.LENGTH_SHORT).show();
            if(controleRijksregnr())
            {
                signUp(Email,lidnr, rijksregisternummer);
            }

        }

    }

    private boolean controleRijksregnr()
    {
        clearErrors();

        boolean cancel = false;
        View focusView = null;

        String rijksregnr = rijksregisternr.getText().toString();
        // Internet Connection is Present
        // make HTTP requests

        if (TextUtils.isEmpty(rijksregnr)) {
            rijksregisternr.setError(getString(R.string.error_field_required));
            focusView = rijksregisternr;
            cancel = true;
        }


        if(!TextUtils.isEmpty(rijksregnr))
        {
            if (!rijksregnr.matches("[0-9]+") || rijksregnr.length() != 11){
                rijksregisternr.setError(getString(R.string.error_incorrect_rijksregisternummer));
                focusView = rijksregisternr;
                cancel = true;
            }
            else
            {
                int rest;

                int tecontrolerenGetal;
                String tecontrolerenCijfers = "";

                int laatste2, eerste2;
                laatste2 = Integer.parseInt(rijksregnr.substring(9, 11));
                eerste2 = Integer.parseInt(rijksregnr.substring(0,2));

                //TODO na 1999 controle; moet dan met 2 beginnen :/

                if(eerste2 < 14  /*> 99*/ )
                {
                    tecontrolerenCijfers = "2";
                }
                int rijksregnrLengte = rijksregnr.length() - 3;
                for(int i = 0; i<=(rijksregnrLengte);i++)
                {
                    tecontrolerenCijfers += rijksregnr.charAt(i);

                }

                tecontrolerenGetal = Integer.parseInt(tecontrolerenCijfers);

                rest = tecontrolerenGetal % 97;


                int controle = rest + laatste2;

                if(controle < 97)
                {
                    rijksregisternr.setError(getString(R.string.error_incorrect_rijksregisternummer));
                    focusView = rijksregisternr;
                    cancel = true;
                }

                ParseQuery<ParseObject> query = ParseQuery.getQuery("Ouder");
                query.whereEqualTo("rijksregisterNr", rijksregnr);
                try{
                    List<ParseObject> lijstObjecten = query.find();
                    if (lijstObjecten.size() > 0){
                        rijksregisternr.setError(getString(R.string.error_occupied_rijksregnr));
                        focusView = rijksregisternr;
                        cancel = true;
                    }
                }catch(ParseException e){
                    Toast.makeText(LidnummerToevoegen.this,getString(R.string.error_generalException), Toast.LENGTH_SHORT).show();
                    cancel = true;
                }

                ParseQuery<ParseObject> query2 = ParseQuery.getQuery("Monitor");
                query2.whereEqualTo("rijksregisterNr", rijksregnr);
                try{
                    List<ParseObject> lijstObjecten = query2.find();
                    if (lijstObjecten.size() > 0){
                        rijksregisternr.setError(getString(R.string.error_occupied_rijksregnr));
                        focusView = rijksregisternr;
                        cancel = true;
                    }
                }
                catch(ParseException e){
                    Toast.makeText(LidnummerToevoegen.this,getString(R.string.error_generalException), Toast.LENGTH_SHORT).show();
                    cancel = true;
                }

            }


        }


        if (cancel) {
            // There was an error; don't attempt login and focus the first
            // form field with an error.
            focusView.requestFocus();
            return false;
        } else {
            return true;

        }
    }

    private void signUp(String email, String lidnummer, String rijksregisternummer) {
        Toast.makeText(getApplicationContext(), getString(R.string.loading_message), Toast.LENGTH_SHORT).show();

            ParseObject nieuweMonitor = new ParseObject("NieuweMonitor");
            nieuweMonitor.put("email", email);
            nieuweMonitor.put("lidnummer", lidnummer);
            nieuweMonitor.put("rijksregisternummer", rijksregisternummer);

            nieuweMonitor.saveInBackground();

            signUpMsg("Lidnummer toegevoegd.");
            Intent in = new Intent(getApplicationContext(), navBarMainScreen.class);
            startActivity(in);
        }


    protected void signUpMsg(String msg) {
        Toast.makeText(getApplicationContext(), msg, Toast.LENGTH_SHORT).show();
    }

    private void clearErrors(){
        email.setError(null);
        lidnummer.setError(null);
        rijksregisternr.setError(null);
    }

    @Override
    public void onBackPressed() {
        Intent setIntent = new Intent(LidnummerToevoegen.this, navBarMainScreen.class);
        setIntent.addCategory(Intent.CATEGORY_HOME);

        setIntent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
        startActivity(setIntent);
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
