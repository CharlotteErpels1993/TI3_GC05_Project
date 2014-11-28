package com.hogent.ti3g05.ti3_g05_joetzapp.SignUpLogin;


import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.text.TextUtils;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.inputmethod.InputMethodManager;
import android.widget.Button;
import android.widget.EditText;
import android.widget.RadioButton;
import android.widget.RadioGroup;
import android.widget.Toast;

import com.hogent.ti3g05.ti3_g05_joetzapp.Services.ConnectionDetector;
import com.hogent.ti3g05.ti3_g05_joetzapp.R;
import com.hogent.ti3g05.ti3_g05_joetzapp.navBarMainScreen;
import com.parse.ParseException;
import com.parse.ParseObject;
import com.parse.ParseQuery;

import java.util.List;

public class SignUp_deel1 extends Activity{

    private RadioGroup rg = null;
    private Button terugButton;

    EditText rijksregisterNr;

    // flag for Internet connection status
    Boolean isInternetPresent = false;
    // Connection detector class
    ConnectionDetector cd;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        setContentView(R.layout.activity_signup_deel1);

        cd = new ConnectionDetector(getApplicationContext());
        rg = (RadioGroup) findViewById(R.id.radioGroup);
        rg.clearCheck();

        rijksregisterNr = (EditText) findViewById(R.id.rijksRegNrRegistreren);

        rijksregisterNr.setOnFocusChangeListener(new View.OnFocusChangeListener() {
            @Override
            public void onFocusChange(View v, boolean hasFocus) {
                if (!hasFocus) {
                    hideKeyboard(v);
                }
            }
        });

        // creating connection detector class instance
        //cd = new ConnectionDetector(getApplicationContext());

        terugButton = (Button) findViewById(R.id.btn_terugGaan);

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


        terugButton = (Button) findViewById(R.id.btn_terugGaan);

        terugButton.setOnClickListener(new OnClickListener() {
            @Override
            public void onClick(View view) {
                Intent intent1 = new Intent(SignUp_deel1.this, navBarMainScreen.class);
                startActivity(intent1);

                overridePendingTransition(R.anim.left_in, R.anim.right_out);


            }
        });

    }

    public void hideKeyboard(View view) {
        InputMethodManager inputMethodManager =(InputMethodManager)getSystemService(Activity.INPUT_METHOD_SERVICE);
        inputMethodManager.hideSoftInputFromWindow(view.getWindowToken(), 0);
    }


    private boolean controleRijksregnr()
    {
        clearErrors();

        boolean cancel = false;
        View focusView = null;

        String rijksregnr = rijksregisterNr.getText().toString();
        // Internet Connection is Present
        // make HTTP requests

        if (TextUtils.isEmpty(rijksregnr)) {
            rijksregisterNr.setError(getString(R.string.error_field_required));
            focusView = rijksregisterNr;
            cancel = true;
        }


        if(!TextUtils.isEmpty(rijksregnr))
        {
            if (!rijksregnr.matches("[0-9]+") || rijksregnr.length() != 11){
                rijksregisterNr.setError(getString(R.string.error_incorrect_rijksregisternummer));
                focusView = rijksregisterNr;
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

                for(int i = 0; i<=(rijksregnr.length()-3);i++)
                {
                    tecontrolerenCijfers += rijksregnr.charAt(i);

                }

               tecontrolerenGetal = Integer.parseInt(tecontrolerenCijfers);

               rest = tecontrolerenGetal % 97;


                int controle = rest + laatste2;

                if(controle < 97)
                {
                    rijksregisterNr.setError(getString(R.string.error_incorrect_rijksregisternummer));
                    focusView = rijksregisterNr;
                    cancel = true;
                }

                ParseQuery<ParseObject> query = ParseQuery.getQuery("Ouder");
                query.whereEqualTo("rijksregisterNr", rijksregnr);
                try{
                    List<ParseObject> lijstObjecten = query.find();
                    if (lijstObjecten.size() > 0){
                        rijksregisterNr.setError("Dit rijksregisternummer is reeds in gebruik.");
                        focusView = rijksregisterNr;
                        cancel = true;
                    }
                }
                catch(ParseException e){
                    Toast.makeText(SignUp_deel1.this,"Er is iets fout gelopen. Onze excuses voor het ongemak.", Toast.LENGTH_SHORT).show();
                    cancel = true;
                }

            }


        }


        if (cancel) {
            // There was an error; don't attempt login and focus the first
            // form field with an error.
            focusView.requestFocus();
            rg.clearCheck();
            return false;
        } else {
            return true;

        }
    }

    private void jaOpslaanRijksregNr() {

        Intent intentJa = new Intent(getApplicationContext(), SignUp_deel2.class);
        intentJa.putExtra("lidVanBondMoyson", "true");
        intentJa.putExtra("rijksregisternr", rijksregisterNr.getText().toString());
        startActivity(intentJa);

        overridePendingTransition(R.anim.right_in, R.anim.left_out);

    }

    private void neeOpslaanRijksregNr() {
        Intent intentNee = new Intent(getApplicationContext(), SignUp_deel3.class);
        intentNee.putExtra("lidVanBondMoyson", "false");

        intentNee.putExtra("rijksregisternr", rijksregisterNr.getText().toString());
        startActivity(intentNee);

        overridePendingTransition(R.anim.right_in, R.anim.left_out);
    }



    private void clearErrors(){
        rijksregisterNr.setError(null);
    }
}
