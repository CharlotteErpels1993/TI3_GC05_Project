package com.hogent.ti3g05.ti3_g05_joetzapp;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.support.v4.app.DialogFragment;
import android.support.v4.app.FragmentActivity;
import android.text.TextUtils;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;

import com.hogent.ti3g05.ti3_g05_joetzapp.Services.ConnectionDetector;


public class InschrijvenVakantiePart1 extends FragmentActivity {

    private EditText txtVoornaam, txtNaam, txtStraat, txtHuisnr, txtBus, txtGemeente, txtPostcode;
    private Button btnGeboorteDatum;

    private String voornaam, naam, straat, huisnr, bus, gemeente, postcode;

    private Button btnVolgende;
    private Button btnTerug;
    //!!!!!!!!!!!!!!!!!!!!!!!
    //voor date picker:
    //http://developer.android.com/guide/topics/ui/controls/pickers.html#DatePicker
    private boolean cancel = false;
    private View focusView = null;

    // flag for Internet connection status
    Boolean isInternetPresent = false;
    // Connection detector class
    ConnectionDetector cd;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_inschrijven_vakantie_part1);

        cd = new ConnectionDetector(getApplicationContext());

        txtVoornaam = (EditText) findViewById(R.id.VoornaamIns);
        txtNaam = (EditText) findViewById(R.id.NaamIns);
        txtStraat = (EditText) findViewById(R.id.Straat);
        txtHuisnr = (EditText) findViewById(R.id.Huisnr);
        txtBus = (EditText) findViewById(R.id.Bus);
        txtGemeente = (EditText) findViewById(R.id.Gemeente);
        txtPostcode = (EditText) findViewById(R.id.Postcode);

        btnVolgende = (Button)findViewById(R.id.btnNaarDeel2Vak);
        btnVolgende.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                isInternetPresent = cd.isConnectingToInternet();

                if (isInternetPresent) {
                    // Internet Connection is Present
                    // make HTTP requests
                    controlerenOpfouten();
                }
                else{
                    // Internet connection is not present
                    // Ask user to connect to Internet
                    Toast.makeText(getApplicationContext(), getString(R.string.error_no_internet), Toast.LENGTH_SHORT).show();
                }
            }
        });

    }


    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.back, menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        int id = item.getItemId();
        if (id == R.id.backMenu) {
            Intent intent1 = new Intent(this, navBarMainScreen.class);
            startActivity(intent1);

            overridePendingTransition(R.anim.left_in, R.anim.right_out);
        }

        return super.onOptionsItemSelected(item);
    }

    public void showDatePickerDialog(View v) {
        DialogFragment newFragment = new CustomDatePicker();
        newFragment.show(getSupportFragmentManager(), "datePicker");
    }

    public void controlerenOpfouten(){
        clearErrors();
        cancel = false;

        // Store values at the time of the login attempt.
        voornaam = txtVoornaam.getText().toString().toLowerCase();
        naam = txtNaam.getText().toString().toLowerCase();
        straat = txtStraat.getText().toString();
        huisnr = txtHuisnr.getText().toString();
        bus = txtBus.getText().toString();
        gemeente = txtGemeente.getText().toString();
        postcode = txtPostcode.getText().toString();


        if (TextUtils.isEmpty(postcode)) {
            txtPostcode.setError(getString(R.string.error_field_required));
            focusView = txtPostcode;
            cancel = true;
        } else {
            if (postcode.length() != 4) {
                txtPostcode.setError(getString(R.string.error_incorrect_postcode));
                focusView = txtPostcode;
                cancel = true;
            }
            if (!postcode.matches("[0-9]+")){
                txtPostcode.setError(getString(R.string.error_incorrect_postcode));
                focusView = txtPostcode;
                cancel = true;
            }
        }

        if (TextUtils.isEmpty(gemeente)) {
            txtGemeente.setError(getString(R.string.error_field_required));
            focusView = txtGemeente;
            cancel = true;
        }

        //TODO: datepicker toevoegen

        if (TextUtils.isEmpty(huisnr)) {
            txtHuisnr.setError(getString(R.string.error_field_required));
            focusView = txtHuisnr;
            cancel = true;
        }
        if (!huisnr.matches("[0-9]+") && huisnr.length() >= 1){
            txtHuisnr.setError(getString(R.string.error_incorrect_huisnr));
            focusView = txtHuisnr;
            cancel = true;
        }

        if (TextUtils.isEmpty(straat)) {
            txtStraat.setError(getString(R.string.error_field_required));
            focusView = txtStraat;
            cancel = true;
        }

        if (TextUtils.isEmpty(naam)) {
            txtNaam.setError(getString(R.string.error_field_required));
            focusView = txtNaam;
            cancel = true;
        }

        if (TextUtils.isEmpty(voornaam)) {
            txtVoornaam.setError(getString(R.string.error_field_required));
            focusView = txtVoornaam;
            cancel = true;
        }


        if (cancel) {
            // There was an error; don't attempt login and focus the first
            // form field with an error.
            focusView.requestFocus();
        } else {
            // Show a progress spinner, and kick off a background task to
            // perform the user login attempt.
            opslaan(voornaam ,naam, straat, huisnr, bus, gemeente, postcode);
            //Toast.makeText(getApplicationContext(), "Opgeslagen", Toast.LENGTH_SHORT).show();

        }
    }

    private void opslaan(String voornaam,String naam, String straat, String huisnr, String bus, String gemeente, String postcode) {
        Toast.makeText(getApplicationContext(), getString(R.string.loading_message), Toast.LENGTH_SHORT).show();

        Intent in = new Intent(getApplicationContext(),InschrijvenVakantiePart2.class);

        in.putExtra("voornaam", voornaam);
        in.putExtra("naam", naam);
        in.putExtra("straat", straat);
        in.putExtra("huisnr", huisnr);
        in.putExtra("bus", bus);
        in.putExtra("gemeente", gemeente);
        in.putExtra("postcode", postcode);

        startActivity(in);

        overridePendingTransition(R.anim.right_in, R.anim.left_out);

    }

    private void clearErrors(){
        txtVoornaam.setError(null);
        txtNaam.setError(null);
        txtStraat.setError(null);
        txtHuisnr.setError(null);
        txtBus.setError(null);
        txtGemeente.setError(null);
        txtPostcode.setError(null);
    }
}
