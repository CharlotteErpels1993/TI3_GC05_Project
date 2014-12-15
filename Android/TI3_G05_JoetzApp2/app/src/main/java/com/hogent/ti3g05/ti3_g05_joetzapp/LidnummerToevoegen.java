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
import com.hogent.ti3g05.ti3_g05_joetzapp.SignUpLogin.RegistrerenDeel1;
import com.hogent.ti3g05.ti3_g05_joetzapp.domein.Gebruiker;
import com.parse.ParseException;
import com.parse.ParseObject;
import com.parse.ParseQuery;

import java.util.List;

public class LidnummerToevoegen extends Activity {
    private EditText et_lidnummer;
    private EditText et_rijksregisternr;
    private EditText et_email;

    private Boolean cancel;

    private View focusView = null;
    private final int MINIMAAL_LIDNR_LENGTE = 5;
    // flag for Internet connection status
    private Boolean isInternetPresent = false;
    // Connection detector class
    private ConnectionDetector cd;

    @Override
    protected void onCreate(Bundle savedInstanceState) {

        super.onCreate(savedInstanceState);

        setContentView(R.layout.toevoegen_lidnummer);

        // creating connection detector class instance
        cd = new ConnectionDetector(getApplicationContext());

        getActionBar().setTitle("Lidnummer toevoegen");


        et_email = (EditText) findViewById(R.id.etEmailLidnummerToevoegen);
        et_rijksregisternr = (EditText) findViewById(R.id.rijksRegNrLidnummerToevoegen);
        et_lidnummer = (EditText) findViewById(R.id.lidnrToevoegen);




        Button btnToevoegen = (Button) findViewById(R.id.btnVoegLidnrToe);
        //mCreateAccountButton.setTextColor(getResources().getColor(R.color.Rood));
        btnToevoegen.setOnClickListener(new View.OnClickListener() {
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

        String Email = et_email.getText().toString().toLowerCase();
        String rijksregisternummer = et_rijksregisternr.getText().toString();
        String lidnr = et_lidnummer.getText().toString();

        //CONTROLE: lidnr, mag niet leeg zijn en mag nog niet voorkomen in tabel
       if(TextUtils.isEmpty((lidnr)))
       {
            et_lidnummer.setError(getString(R.string.error_field_required));
            focusView = et_lidnummer;
            cancel = true;
       }
        else{
           if (lidnr.length() < MINIMAAL_LIDNR_LENGTE) {
               et_lidnummer.setError(getString(R.string.error_invalid_lidnummer));
               focusView = et_lidnummer;
               cancel = true;
           }
           else{
               ParseQuery<ParseObject> qryCheckOfLidNRbestaat = ParseQuery.getQuery("NieuweMonitor");
               qryCheckOfLidNRbestaat.whereEqualTo("lidnummer", lidnr);
               try{
                   List<ParseObject> lijstObjecten = qryCheckOfLidNRbestaat.find();
                   if (lijstObjecten.size() > 0){
                       et_lidnummer.setError(getString(R.string.error_lidnr_used));
                       focusView = et_lidnummer;
                       cancel = true;
                   }
               }
               catch(ParseException e){
                   Toast.makeText(LidnummerToevoegen.this,getString(R.string.error_generalException), Toast.LENGTH_SHORT).show();
                   cancel = true;
               }
           }

        }

        //CONTROLE: email, mag niet leeg zijn en mag niet in de DB voorkomen
        if (TextUtils.isEmpty(Email)) {
            et_email.setError(getString(R.string.error_field_required));
            focusView = et_email;
            cancel = true;
        }
        else{
            ParseQuery<ParseObject> qryCheckOfEmailBestaat = ParseQuery.getQuery("NieuweMonitor");
            qryCheckOfEmailBestaat.whereEqualTo("email", Email);
            try{
                List<ParseObject> lijstObjecten = qryCheckOfEmailBestaat.find();
                if (lijstObjecten.size() > 0){
                    et_email.setError(getString(R.string.error_email_used));
                    focusView = et_email;
                    cancel = true;
                }
            }
            catch(ParseException e){
                Toast.makeText(LidnummerToevoegen.this,getString(R.string.error_generalException), Toast.LENGTH_SHORT).show();
                cancel = true;
            }
        }

        //CONTROLE: rijksregisternummer, mag niet leeg zijn, correct aantal nummers, correct formaat en mag niet in gebruik zijn
        if (TextUtils.isEmpty(rijksregisternummer)) {
            et_rijksregisternr.setError(getString(R.string.error_field_required));
            focusView = et_rijksregisternr;
            cancel = true;
        }
        else{
            //RRN is ingevuld, nu kijken of het een correct formaat is.
            if (!rijksregisternummer.matches("[0-9]+") || rijksregisternummer.length() != 11){
                et_rijksregisternr.setError(getString(R.string.error_incorrect_rijksregnr));
                focusView = et_rijksregisternr;
                cancel = true;
            }
            else{
                //RRN is correct formaat, kijken of het ook geldig is
                boolean geldigRRN = Gebruiker.isDitEenGeldigRijksregisternummer(rijksregisternummer);
                if (!geldigRRN){
                    et_rijksregisternr.setError(getString(R.string.error_incorrect_rijksregisternummer));
                    focusView = et_rijksregisternr;
                    cancel = true;
                }
                else{//Geldig RRN, maar mag nog niet in de DB voorkomen = niet in de Monitor, NieuweMonitor of Ouder tabel
                    ParseQuery<ParseObject> qryCheckOfRRNbestaatNieuwM = ParseQuery.getQuery("NieuweMonitor");
                    qryCheckOfRRNbestaatNieuwM.whereEqualTo("rijksregisterNr", rijksregisternummer);
                    try{
                        List<ParseObject> lijstObjecten = qryCheckOfRRNbestaatNieuwM.find();
                        if (lijstObjecten.size() > 0){
                            et_rijksregisternr.setError(getString(R.string.error_occupied_rijksregnr));
                            focusView = et_rijksregisternr;
                            cancel = true;
                        }
                    }
                    catch(ParseException e){
                        Toast.makeText(LidnummerToevoegen.this,getString(R.string.error_generalException), Toast.LENGTH_SHORT).show();
                        cancel = true;
                    }

                    ParseQuery<ParseObject> qryCheckOfRRNbestaatOuder = ParseQuery.getQuery("Ouder");
                    qryCheckOfRRNbestaatOuder.whereEqualTo("rijksregisterNr", rijksregisternummer);
                    try{
                        List<ParseObject> lijstObjecten = qryCheckOfRRNbestaatOuder.find();
                        if (lijstObjecten.size() > 0){
                            et_rijksregisternr.setError(getString(R.string.error_occupied_rijksregnr));
                            focusView = et_rijksregisternr;
                            cancel = true;
                        }
                    }catch(ParseException e){
                        Toast.makeText(LidnummerToevoegen.this,getString(R.string.error_generalException), Toast.LENGTH_SHORT).show();
                        cancel = true;
                    }

                    ParseQuery<ParseObject> qryCheckOfRRNbestaatInMonitor = ParseQuery.getQuery("Monitor");
                    qryCheckOfRRNbestaatInMonitor.whereEqualTo("rijksregisterNr", rijksregisternummer);
                    try{
                        List<ParseObject> lijstObjecten = qryCheckOfRRNbestaatInMonitor.find();
                        if (lijstObjecten.size() > 0){
                            et_rijksregisternr.setError(getString(R.string.error_occupied_rijksregnr));
                            focusView = et_rijksregisternr;
                            cancel = true;
                        }
                    }catch(ParseException e){
                        Toast.makeText(LidnummerToevoegen.this,getString(R.string.error_generalException), Toast.LENGTH_SHORT).show();
                        cancel = true;
                    }

                }

            }
        }


        if (cancel) {
            // There was an error; don't attempt login and focus the first
            // form field with an error.
            focusView.requestFocus();
        } else {
            // Show a progress spinner, and kick off a background task to
            // perform the user login attempt.
            signUp(Email,lidnr, rijksregisternummer);


        }

    }

    //alle velden zijn goed ingevuld -> info opslaan
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
        et_email.setError(null);
        et_lidnummer.setError(null);
        et_rijksregisternr.setError(null);
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
            Intent intent1 = new Intent(this, RegistrerenDeel1.class);
            startActivity(intent1);

            overridePendingTransition(R.anim.left_in, R.anim.right_out);
        }

        return super.onOptionsItemSelected(item);
    }


}
