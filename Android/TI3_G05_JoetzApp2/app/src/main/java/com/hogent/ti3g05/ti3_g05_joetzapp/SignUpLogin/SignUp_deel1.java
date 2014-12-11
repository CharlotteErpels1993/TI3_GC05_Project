package com.hogent.ti3g05.ti3_g05_joetzapp.SignUpLogin;


import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.text.TextUtils;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.inputmethod.InputMethodManager;
import android.widget.Button;
import android.widget.EditText;
import android.widget.RadioButton;
import android.widget.RadioGroup;
import android.widget.TextView;
import android.widget.Toast;

import com.hogent.ti3g05.ti3_g05_joetzapp.Services.ConnectionDetector;
import com.hogent.ti3g05.ti3_g05_joetzapp.R;
import com.hogent.ti3g05.ti3_g05_joetzapp.domein.Gebruiker;
import com.hogent.ti3g05.ti3_g05_joetzapp.navBarMainScreen;
import com.parse.ParseException;
import com.parse.ParseObject;
import com.parse.ParseQuery;

import java.util.List;

public class SignUp_deel1 extends Activity{
    private RadioGroup rg = null;
    private EditText et_rijksregisterNr;

    private String rijksregnr;

    // flag for Internet connection status
    private Boolean isInternetPresent = false;
    // Connection detector class
    private ConnectionDetector cd;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_signup_deel1);

        getActionBar().setTitle(getString(R.string.title_activity_Register));


        cd = new ConnectionDetector(getApplicationContext());
        rg = (RadioGroup) findViewById(R.id.radioGroup);
        rg.clearCheck();

        et_rijksregisterNr = (EditText) findViewById(R.id.rijksRegNrRegistreren);
        et_rijksregisterNr.setOnFocusChangeListener(new View.OnFocusChangeListener() {
            @Override
            public void onFocusChange(View v, boolean hasFocus) {
                if (!hasFocus) {
                    hideKeyboard(v);
                }
            }
        });

        TextView tekst = (TextView) findViewById(R.id.txtWaarschuwingMonitor);
        tekst.setOnClickListener(new OnClickListener() {
            @Override
            public void onClick(View view) {
                hideKeyboard(view);
            }
        });

        RadioButton rb1 = (RadioButton) findViewById(R.id.radioButtonJa);
        rb1.setOnClickListener(new OnClickListener() {
            @Override
            public void onClick(View view) {
                isInternetPresent = cd.isConnectingToInternet();
                if (isInternetPresent) {
                    if(controleRijksregnr())
                    {
                        jaOpslaanRijksregNr();
                    }
                } else
                    Toast.makeText(getApplicationContext(), getString(R.string.error_no_internet), Toast.LENGTH_SHORT).show();
            }



        });

        RadioButton rb2 = (RadioButton) findViewById(R.id.radioButtonNee);
        rb2.setOnClickListener(new OnClickListener() {
            @Override
            public void onClick(View view) {
                isInternetPresent = cd.isConnectingToInternet();
                if (isInternetPresent) {
                    if(controleRijksregnr())
                    {
                        neeOpslaanRijksregNr();
                    }
                } else
                    Toast.makeText(getApplicationContext(), getString(R.string.error_no_internet), Toast.LENGTH_SHORT).show();
            }
        });


    }

    public void hideKeyboard(View view) {
        InputMethodManager inputMethodManager =(InputMethodManager)getSystemService(Activity.INPUT_METHOD_SERVICE);
        inputMethodManager.hideSoftInputFromWindow(view.getWindowToken(), 0);
    }

    //Controleer of het RRN ingevuld is en geldig is, zo niet -> foutmelding geven en niet doorgaan naar volgend scherm
    private boolean controleRijksregnr()
    {
        clearErrors();

        boolean cancel = false;
        View focusView = null;

        rijksregnr = et_rijksregisterNr.getText().toString();
        // Internet Connection is Present
        // make HTTP requests

        if (TextUtils.isEmpty(rijksregnr)) {
            et_rijksregisterNr.setError(getString(R.string.error_field_required));
            focusView = et_rijksregisterNr;
            cancel = true;
        }


        if(!TextUtils.isEmpty(rijksregnr))
        {
            if (!rijksregnr.matches("[0-9]+") || rijksregnr.length() != 11){
                et_rijksregisterNr.setError(getString(R.string.error_incorrect_rijksregnr));
                focusView = et_rijksregisterNr;
                cancel = true;
            }
            else
            {
                boolean geldigRRN = Gebruiker.isDitEenGeldigRRN(rijksregnr);

                /*int rest;

                int tecontrolerenGetal;
                String tecontrolerenCijfers = "";

                int laatste2, eerste2;
                laatste2 = Integer.parseInt(rijksregnr.substring(9, 11));
                eerste2 = Integer.parseInt(rijksregnr.substring(0,2));

                //TODO na 1999 controle; moet dan met 2 beginnen :/

                if(eerste2 < 14  ) //>99
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
                */

                if(geldigRRN == false)
                {
                    et_rijksregisterNr.setError(getString(R.string.error_incorrect_rijksregisternummer));
                    focusView = et_rijksregisterNr;
                    cancel = true;
                }
                else{
                    //hieronder wordt gekeken of het RRN reeds bestaat in DB. Zo ja -> fout
                    //Dit gebeurt enkel wanneer we zeker zijn dat het RRN geldig is, om onnodige DB requests te vermijden
                    ParseQuery<ParseObject> query = ParseQuery.getQuery("Ouder");
                    query.whereEqualTo("rijksregisterNr", rijksregnr);
                    try{
                        List<ParseObject> lijstObjecten = query.find();
                        if (lijstObjecten.size() > 0){
                            et_rijksregisterNr.setError(getString(R.string.error_occupied_rijksregnr));
                            focusView = et_rijksregisterNr;
                            cancel = true;
                        }
                    }
                    catch(ParseException e){
                        Toast.makeText(SignUp_deel1.this,getString(R.string.error_generalException), Toast.LENGTH_SHORT).show();
                        cancel = true;
                    }
                    ParseQuery<ParseObject> query2 = ParseQuery.getQuery("Monitor");
                    query2.whereEqualTo("rijksregisterNr", rijksregnr);
                    try{
                        List<ParseObject> lijstObjecten = query2.find();
                        if (lijstObjecten.size() > 0){
                            et_rijksregisterNr.setError(getString(R.string.error_occupied_rijksregnr));
                            focusView = et_rijksregisterNr;
                            cancel = true;
                        }
                    }
                    catch(ParseException e){
                        Toast.makeText(SignUp_deel1.this,getString(R.string.error_generalException), Toast.LENGTH_SHORT).show();
                        cancel = true;
                    }
                }//einde if statement


            }
        }


        if (cancel) {
            // There was an error; don't attempt to continue and focus the first
            // form field with an error.
            focusView.requestFocus();
            rg.clearCheck();
            return false;
        } else {
            return true;

        }
    }

    //Ga door naar stap 2 van inschrijven. Je geeft RRN mee en of de gebruiker lid is van BM
    private void jaOpslaanRijksregNr() {
        Intent intentJa = new Intent(getApplicationContext(), SignUp_deel2.class);
        intentJa.putExtra("lidVanBondMoyson", "true");
        intentJa.putExtra("rijksregisternr", rijksregnr);
        startActivity(intentJa);

        overridePendingTransition(R.anim.right_in, R.anim.left_out);

    }

    //Ga door naar stap 2 van inschrijven. Je geeft RRN mee en of de gebruiker lid is van BM
    private void neeOpslaanRijksregNr() {
        Intent intentNee = new Intent(getApplicationContext(), SignUp_deel3.class);
        intentNee.putExtra("lidVanBondMoyson", "false");
        intentNee.putExtra("rijksregisternr", rijksregnr);
        startActivity(intentNee);

        overridePendingTransition(R.anim.right_in, R.anim.left_out);
    }



    //error verbergen, wordt opgeroepen elke keer de gebruiker opnieuw verder probeert te gaan
    private void clearErrors(){
        et_rijksregisterNr.setError(null);
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
            startActivity(intent1);

            overridePendingTransition(R.anim.left_in, R.anim.right_out);
        }

        return super.onOptionsItemSelected(item);
    }
}
