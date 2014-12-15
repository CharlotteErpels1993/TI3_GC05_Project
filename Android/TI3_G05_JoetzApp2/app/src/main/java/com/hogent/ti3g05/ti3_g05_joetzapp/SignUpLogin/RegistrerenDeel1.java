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

//Eerste deel van het registreren
public class RegistrerenDeel1 extends Activity{
    private RadioGroup rg = null;
    private EditText et_rijksregisterNr;

    private String rijksregnr;

    private Boolean isInternetPresent = false;
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
        //Verbergt het toetsenbord bij klikken op ander veld
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
                //Kijk of er internet aanwezig is zoja, ga door naar controle van het rijksregisternummer
                //Gebruiker wordt doorgestuurd naar de juiste pagina
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
                //Kijk of er internet aanwezig is zoja, ga door naar controle van het rijksregisternummer
                //Gebruiker wordt doorgestuurd naar de juiste pagina
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

    //rijksregisternummer controleren, indien correct wordt de gebruiker doorgestuurd naar de juiste pagina
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


        if(!TextUtils.isEmpty(rijksregnr)) {
            if (!rijksregnr.matches("[0-9]+") || rijksregnr.length() != 11) {
                et_rijksregisterNr.setError(getString(R.string.error_incorrect_rijksregnr));
                focusView = et_rijksregisterNr;
                cancel = true;
            } else {
                boolean geldigRijksregisterNummer = Gebruiker.isDitEenGeldigRijksregisternummer(rijksregnr);


                if (geldigRijksregisterNummer == false) {
                    et_rijksregisterNr.setError(getString(R.string.error_incorrect_rijksregisternummer));
                    focusView = et_rijksregisterNr;
                    cancel = true;
                } else {
                    //hieronder wordt gekeken of het rijksregisternummer reeds bestaat in database. Indien dit zo is wordt een foutboodschap getoond
                    //Dit gebeurt enkel wanneer we zeker zijn dat het rijksregisternummer geldig is, om onnodige database requests te vermijden
                    ParseQuery<ParseObject> query = ParseQuery.getQuery("Ouder");
                    query.whereEqualTo("rijksregisterNr", rijksregnr);
                    try {
                        List<ParseObject> lijstObjecten = query.find();
                        if (lijstObjecten.size() > 0) {
                            et_rijksregisterNr.setError(getString(R.string.error_occupied_rijksregnr));
                            focusView = et_rijksregisterNr;
                            cancel = true;
                        }
                    } catch (ParseException e) {
                        Toast.makeText(RegistrerenDeel1.this, getString(R.string.error_generalException), Toast.LENGTH_SHORT).show();
                        cancel = true;
                    }
                    ParseQuery<ParseObject> query2 = ParseQuery.getQuery("Monitor");
                    query2.whereEqualTo("rijksregisterNr", rijksregnr);
                    try {
                        List<ParseObject> lijstObjecten = query2.find();
                        if (lijstObjecten.size() > 0) {
                            et_rijksregisterNr.setError(getString(R.string.error_occupied_rijksregnr));
                            focusView = et_rijksregisterNr;
                            cancel = true;
                        }
                    } catch (ParseException e) {
                        Toast.makeText(RegistrerenDeel1.this, getString(R.string.error_generalException), Toast.LENGTH_SHORT).show();
                        cancel = true;
                    }
                }
            }


        }
            if (cancel) {
                focusView.requestFocus();
                rg.clearCheck();
                return false;
            } else {
                return true;

            }

    }

    //Stuurt de gebruiker naar de volgende stap (stap 2 aangezien deze lid is van bond moyson
    // en geeft het rijksregisternummer mee
    private void jaOpslaanRijksregNr() {
        Intent intentJa = new Intent(getApplicationContext(), RegistrerenDeel2.class);
        intentJa.putExtra("rijksregisternr", rijksregnr);
        startActivity(intentJa);

        overridePendingTransition(R.anim.right_in, R.anim.left_out);

    }

    //Stuurt de gebruiker naar de volgende stap (stap 3 aangezien deze geen lid is van bond moyson)
    // en geeft het rijksregisternummer mee
    private void neeOpslaanRijksregNr() {
        Intent intentNee = new Intent(getApplicationContext(), RegistrerenDeel3.class);
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
            intent1.putExtra("naarfrag", "vakantie");
            intent1.putExtra("herladen", "nee");

            overridePendingTransition(R.anim.left_in, R.anim.right_out);
        }

        return super.onOptionsItemSelected(item);
    }
}
