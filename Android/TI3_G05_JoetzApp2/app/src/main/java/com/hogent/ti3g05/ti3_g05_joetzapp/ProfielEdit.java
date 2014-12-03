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
import com.parse.ParseException;
import com.parse.ParseObject;
import com.parse.ParseQuery;
import com.parse.ParseUser;

import java.util.List;


public class ProfielEdit extends Activity {
    String initieleNaam;//Email wordt op voorhand op geslagen, want ParseUser klasse moet in dat geval ook gewijzigd worden.
    String initieleVoornaam;
    String initieleEmail;
    String initieleGsm;
    String initieleFacebook;

    private EditText txtNaam, txtVoornaam, txtEmail, txtGSM, txtFacebook;
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

        Button btnBevestigen = (Button) findViewById(R.id.btnBevestigen);
        btnBevestigen.setTextColor(getResources().getColor(R.color.Rood));
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

        txtNaam.setText(initieleNaam);
        txtVoornaam.setText(initieleVoornaam);
        txtEmail.setText(initieleEmail);
        txtFacebook.setText(initieleFacebook);
        txtGSM.setText(initieleGsm);
    }

    public void controleIngevuld(){
        clearErrors();
        boolean cancel = false;

        String naam, voornaam, email, gsm, facebook;

        // Store values at the time of the login attempt.
        naam = txtNaam.getText().toString();
        voornaam = txtVoornaam.getText().toString();
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
            focusView.requestFocus();
        } else {
            opslaan(naam, voornaam ,email, gsm, facebook);
        }
    }

    public void opslaan(String objnaam, String objvoornaam, String objemail, String objGSM, String objFB){
        //eerst kijken of de gebruiker iets heeft gewijzigd, zo ja, sla alles op, zo niet, stuur direct door
        if (isErIetsGewijzigd(objnaam, objvoornaam, objemail, objGSM, objFB)){
            try{
                ParseQuery<ParseObject> query = ParseQuery.getQuery("Monitor");
                query.whereEqualTo("email", initieleEmail);

                List<ParseObject> lijstObjecten = query.find();
                if (lijstObjecten.size() != 1){
                    throw new Exception();
                }
                ParseObject teVeranderenGebruiker = lijstObjecten.get(0);
                teVeranderenGebruiker.put("email", objemail);
                teVeranderenGebruiker.put("naam", objnaam);
                teVeranderenGebruiker.put("voornaam", objvoornaam);
                teVeranderenGebruiker.put("gsm", objGSM);
                teVeranderenGebruiker.put("linkFacebook", objFB);
                teVeranderenGebruiker.saveInBackground();

                ParseUser.getCurrentUser().setEmail(objemail);
                ParseUser.getCurrentUser().setUsername(objemail);
                ParseUser.getCurrentUser().saveInBackground();
                //TODO: extra save?

                terugSturenNaarProfielDetail(objnaam, objvoornaam, objemail, objGSM, objFB);

            }
            catch(ParseException e){
                Toast.makeText(getApplicationContext(), "Er is een fout opgetreden. Onze excuses voor het ongemak.", Toast.LENGTH_SHORT).show();
            }
            catch(Exception e){
                Toast.makeText(getApplicationContext(), "Er is een fout opgetreden. Onze excuses voor het ongemak.", Toast.LENGTH_SHORT).show();
            }
        }
        else{
            terugSturenNaarProfielDetail(objnaam, objvoornaam, objemail, objGSM, objFB);
        }

    }

    public void clearErrors(){
        txtNaam.setError(null);
        txtVoornaam.setError(null);
        txtGSM.setError(null);
        txtEmail.setError(null);
        txtFacebook.setError(null);
    }

    public void terugSturenNaarProfielDetail(String objnaam, String objvoornaam, String objemail, String objGSM, String objFB){
        Intent inte = new Intent(getApplicationContext(), ProfielDetail.class);
        inte.putExtra("naam", objnaam);
        inte.putExtra("voornaam", objvoornaam);
        inte.putExtra("facebook", objFB);
        inte.putExtra("gsm", objGSM);
        inte.putExtra("email", objemail);
        startActivity(inte);
    }

    public boolean isErIetsGewijzigd(String nieuweNaam, String nieuweVoornaam, String nieuweEmail, String nieuweGSM, String nieuweFB){
        if (!nieuweNaam.equals(initieleNaam))
            return true;
        if (!nieuweVoornaam.equals(initieleVoornaam))
            return true;
        if (!nieuweEmail.equals(initieleEmail))
            return true;
        if (!nieuweGSM.equals(initieleGsm))
            return true;
        if (!nieuweFB.equals(initieleFacebook))
            return true;

        return false;
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
            terugSturenNaarProfielDetail(initieleNaam, initieleVoornaam, initieleEmail, initieleGsm, initieleFacebook);
        }

        return super.onOptionsItemSelected(item);
    }

    @Override
    protected void onDestroy()
    {
        super.onDestroy();
        ParseUser.logOut();
    }
}
