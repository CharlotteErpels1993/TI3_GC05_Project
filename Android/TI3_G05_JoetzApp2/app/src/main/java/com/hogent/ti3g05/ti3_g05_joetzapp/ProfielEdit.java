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
import android.widget.TextView;
import android.widget.Toast;

import com.hogent.ti3g05.ti3_g05_joetzapp.Services.ConnectionDetector;
import com.parse.ParseObject;


public class ProfielEdit extends Activity {
    String initieleNaam;//Email wordt op voorhand op geslagen, want ParseUser klasse moet in dat geval ook gewijzigd worden.
    String initieleVoornaam;
    String initieleEmail;
    String initieleGsm;
    String initieleFacebook;
    private Button btnBevestigen, btnCancel;

    private EditText txtNaam, txtVoornaam, txtEmail, txtGSM, txtFacebook;
    private boolean cancel = false;
    private View focusView = null;

    Boolean isInternetPresent = false;
    ConnectionDetector cd;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_profiel_edit);

        Intent i = getIntent();
        initieleNaam = i.getStringExtra("naam");
        initieleVoornaam = i.getStringExtra("voornaam");
        initieleEmail = i.getStringExtra("email");
        initieleFacebook = i.getStringExtra("facebook");
        initieleGsm= i.getStringExtra("gsm");

        setTitle(initieleNaam + " " + initieleVoornaam);
        cd = new ConnectionDetector(getApplicationContext());

        txtNaam = (EditText) findViewById(R.id.Familienaam);
        txtVoornaam = (EditText) findViewById(R.id.VoorNaam);
        txtEmail = (EditText) findViewById(R.id.Email);
        txtFacebook = (EditText)findViewById(R.id.Facebook);
        txtGSM = (EditText)findViewById(R.id.GSM);

        btnBevestigen = (Button) findViewById(R.id.btnBevestigen);
        btnBevestigen.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                isInternetPresent = cd.isConnectingToInternet();

                if (isInternetPresent) {
                    controleIngevuld();
                } else {
                    Toast.makeText(getApplicationContext(), getString(R.string.error_no_internet), Toast.LENGTH_SHORT).show();
                }
            }
        });

        btnCancel = (Button) findViewById(R.id.btnCancel);
        btnCancel.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                isInternetPresent = cd.isConnectingToInternet();

                Intent inte = new Intent(getApplicationContext(), navBarMainScreen.class);
                inte.putExtra("naam", initieleNaam);
                inte.putExtra("voornaam", initieleVoornaam);
                inte.putExtra("facebook", initieleFacebook);
                inte.putExtra("gsm", initieleGsm);
                inte.putExtra("email", initieleGsm);
                startActivity(inte);
            }
        });

        txtNaam.setText(initieleNaam);
        txtVoornaam.setText(initieleVoornaam);
        txtEmail.setText(initieleEmail);
        txtFacebook.setText(initieleFacebook);
        txtGSM.setText(initieleGsm);
    }

    public void controleIngevuld(){
        clearErrors();
        cancel = false;

        String naam, voornaam, email, gsm, facebook;

        // Store values at the time of the login attempt.
        naam = txtNaam.getText().toString().toLowerCase();
        voornaam = txtVoornaam.getText().toString().toLowerCase();
        email = txtEmail.getText().toString().toLowerCase();
        gsm = txtGSM.getText().toString();
        facebook = txtFacebook.getText().toString();

        //volgens UC is facebook niet verplicht in te vullen, mag dus leeg zijn

        if (TextUtils.isEmpty(gsm)) {
            txtGSM.setError(getString(R.string.error_field_required));
            focusView = txtGSM;
            cancel = true;
        }else{
            //TODO: Moet een nieuw GSM nummer geldig zijn?
            if (!gsm.matches("[0-9]+") || gsm.length() != 10){
                txtGSM.setError(getString(R.string.error_incorrect_gsm));
                focusView = txtGSM;
                cancel = true;
            }
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
            opslaan(naam, voornaam ,email, gsm, facebook);
            //Toast.makeText(getApplicationContext(), "Opgeslagen", Toast.LENGTH_SHORT).show();

        }
    }

    public void opslaan(String objnaam, String objvoornaam, String objemail, String objGSM, String objFB){
        try{
            //TODO: ParseObject ophalen, gegevens wijzigen indien nodig, opslaan en terug sturen



        }
        catch(Exception e){
            Toast.makeText(getApplicationContext(), "Er is een fout opgetreden. Onze excuses voor het ongemak.", Toast.LENGTH_SHORT);
        }
    }

    public void clearErrors(){
        txtNaam.setError(null);
        txtVoornaam.setError(null);
        txtGSM.setError(null);
        txtEmail.setError(null);
        txtFacebook.setError(null);
    }


    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.menu_profiel_edit, menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        // Handle action bar item clicks here. The action bar will
        // automatically handle clicks on the Home/Up button, so long
        // as you specify a parent activity in AndroidManifest.xml.
        int id = item.getItemId();

        //noinspection SimplifiableIfStatement
        if (id == R.id.action_settings) {
            return true;
        }

        return super.onOptionsItemSelected(item);
    }
}
