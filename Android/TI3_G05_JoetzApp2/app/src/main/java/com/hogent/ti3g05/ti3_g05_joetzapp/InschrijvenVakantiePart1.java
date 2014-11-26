package com.hogent.ti3g05.ti3_g05_joetzapp;

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
import android.widget.TextView;
import android.widget.Toast;

import com.hogent.ti3g05.ti3_g05_joetzapp.Services.ConnectionDetector;
import com.parse.ParseUser;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;


public class InschrijvenVakantiePart1 extends FragmentActivity {

    private EditText txtVoornaam, txtNaam, txtStraat, txtHuisnr, txtBus, txtGemeente, txtPostcode;
    private Button btnGeboorteDatum;

    private String maandI, datum ,voornaam, naam, straat, huisnr, bus, gemeente, postcode;
    private Date geboorteDatum;
    private String maxdoelgroep, mindoelgroep;

    private TextView dag;
    private TextView maand;
    private TextView jaar;
    private Button btnVolgende;

    private TextView errorDate;

    private TextView gebDatum;
    //!!!!!!!!!!!!!!!!!!!!!!!
    //voor date picker:
    //http://developer.android.com/guide/topics/ui/controls/pickers.html#DatePicker
    private boolean cancel = false;
    private View focusView = null;
    CustomDatePicker customDatePicker;

    // flag for Internet connection status
    Boolean isInternetPresent = false;
    // Connection detector class
    ConnectionDetector cd;

    Date now = new Date();

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
        btnGeboorteDatum = (Button) findViewById(R.id.uitlegVoorData);
        gebDatum = (TextView) findViewById(R.id.DateIns);
        dag = (TextView) findViewById(R.id.dagIns);
        jaar = (TextView) findViewById(R.id.jaarIns);
        maand = (TextView) findViewById(R.id.maandIns);
        errorDate = (TextView) findViewById(R.id.ErrorDate);
        errorDate.setVisibility(View.GONE);

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
        datum = gebDatum.getText().toString();
        maandI = maand.getText().toString();
        Intent i = getIntent();
        mindoelgroep = i.getStringExtra("mindoelgroep");
        maxdoelgroep = i.getStringExtra("maxdoelgroep");



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

        //TODO: datepicker toevoegen, waarde ophalen en controleren of ie is ingevuld. Plus controle op deftige waarde? (niet 100+ jaar oud of 5 jaar in de toekomst)

        SimpleDateFormat formatter = new SimpleDateFormat("MMM dd, yyyy");
        Date date = null;
        try {
            date = formatter.parse(maandI);

        } catch (ParseException e) {
            Toast.makeText(InschrijvenVakantiePart1.this, "Fout bij datum omzetten",Toast.LENGTH_SHORT).show();
        }



        int age = getAge(date.getYear(), date.getMonth(), date.getDay());
        //TODO kijken of age groter is dan mindoelgroep en kleiner dan maxdoelgr

        if(age < Integer.parseInt(mindoelgroep) || age > Integer.parseInt(maxdoelgroep))
        {
            gebDatum.setError("De leeftijd valt niet binnen de doelgroep");
            focusView = gebDatum;
            errorDate.setText("De leeftijd valt niet binnen de doelgroep");
            errorDate.setVisibility(View.VISIBLE);
            cancel = true;
        }

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

        if(gebDatum.getText().equals(""))
        {
            gebDatum.setError(getString(R.string.error_field_required));
            focusView = gebDatum;
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
        in.putExtra("objectId", getIntent().getStringExtra("objectId"));
        in.putExtra("jaar", maandI);

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
        errorDate.setVisibility(View.GONE);
    }

    public int getAge(int DOByear, int DOBmonth, int DOBday) {

        int age;

        final Calendar calenderToday = Calendar.getInstance();
        int currentYear = calenderToday.get(Calendar.YEAR);
        int currentMonth = 1 + calenderToday.get(Calendar.MONTH);
        int todayDay = calenderToday.get(Calendar.DAY_OF_MONTH);

        age = currentYear - DOByear;

        if(DOBmonth > currentMonth){
            --age;
        }
        else if(DOBmonth == currentMonth){
            if(DOBday > todayDay){
                --age;
            }
        }
        return age;
    }
}
