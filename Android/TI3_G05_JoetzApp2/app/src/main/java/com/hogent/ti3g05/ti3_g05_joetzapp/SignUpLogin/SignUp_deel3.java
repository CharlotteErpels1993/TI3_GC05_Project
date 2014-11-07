package com.hogent.ti3g05.ti3_g05_joetzapp.SignUpLogin;


import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.text.TextUtils;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;

import com.hogent.ti3g05.ti3_g05_joetzapp.Services.ConnectionDetector;
import com.hogent.ti3g05.ti3_g05_joetzapp.MainScreen;
import com.hogent.ti3g05.ti3_g05_joetzapp.R;

public class SignUp_deel3 extends Activity{

	private EditText voornaamText;
	private EditText naamText;
	private EditText straatText;
    private EditText huisnrText;
    private EditText gemeenteText;
    private EditText postcodeText;
    private EditText busText;
    private EditText rijksregnrText;
    private EditText telefoonText;
    private EditText gsmText;

	private Button volgendeButton;
    private Button terugKerenButton;

	private String voornaam;
	private String naam;
	private String straat;
    private int huisnr;
    private String bus;
    private String gemeente;
    private int postcode;
    private int rijksregnr;
    private String telefoon;
    private String gsm;

    private boolean cancel = false;
    private View focusView = null;

	// flag for Internet connection status
    Boolean isInternetPresent = false;
    // Connection detector class
    ConnectionDetector cd;
	
	@Override
	protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

		setContentView(R.layout.activity_signup_deel3);

		// creating connection detector class instance
		cd = new ConnectionDetector(getApplicationContext());
		
		voornaamText = (EditText) findViewById(R.id.Voornaam);
		naamText = (EditText) findViewById(R.id.Naam);
        rijksregnrText = (EditText) findViewById(R.id.RijksRegNr);
		straatText = (EditText) findViewById(R.id.Straat);
        huisnrText = (EditText) findViewById(R.id.Huisnr);
        gemeenteText = (EditText) findViewById(R.id.Gemeente);
        postcodeText = (EditText) findViewById(R.id.Postcode);
        telefoonText = (EditText) findViewById(R.id.Telefoon);
        gsmText = (EditText) findViewById(R.id.Gsm);
        busText = (EditText) findViewById(R.id.Bus);

		volgendeButton = (Button) findViewById(R.id.btnNaarDeel4);
		volgendeButton.setOnClickListener(new OnClickListener() {
            @Override
            public void onClick(View view) {
                // get Internet status
                isInternetPresent = cd.isConnectingToInternet();
                // check for Internet status

                if (isInternetPresent) {
                    // Internet Connection is Present
                    // make HTTP requests
                    opslaagGeg();
                }
                else{
                    // Internet connection is not present
                    // Ask user to connect to Internet
                    Toast.makeText(getApplicationContext(), "Fout bij registreren", Toast.LENGTH_SHORT).show();
                }

                //Intent in = new Intent(getApplicationContext(),SignUp_deel4.class);
                //startActivity(in);

            }
        });

        terugKerenButton = (Button) findViewById(R.id.btnNaarDeel1);

        terugKerenButton.setOnClickListener(new OnClickListener() {
            @Override
            public void onClick(View view) {
                Intent intent1 = new Intent(getApplicationContext(), MainScreen.class);
                startActivity(intent1);
            }
        });

	}



	private void opslaagGeg(){
		clearErrors();
        cancel = false;

		// Store values at the time of the login attempt.
		voornaam = voornaamText.getText().toString().toLowerCase();
		naam = naamText.getText().toString().toLowerCase();
        if (isEmpty(rijksregnrText))
            rijksregnr = -1;
        else
		    rijksregnr = Integer.parseInt(rijksregnrText.getText().toString());
        straat = straatText.getText().toString();
        if (isEmpty(huisnrText))
            huisnr = -1;
        else
            huisnr = Integer.parseInt( huisnrText.getText().toString());
        bus = busText.getText().toString();
        gemeente = gemeenteText.getText().toString();
        if (isEmpty(postcodeText))
            postcode = -1;
        else
            postcode = Integer.parseInt( postcodeText.getText().toString());
        telefoon = telefoonText.getText().toString();
        gsm = gsmText.getText().toString();

        if (TextUtils.isEmpty(voornaam)) {
            voornaamText.setError(getString(R.string.error_field_required));
            focusView = voornaamText;
            cancel = true;
        }

		if (TextUtils.isEmpty(naam)) {
			naamText.setError(getString(R.string.error_field_required));
			focusView = naamText;
			cancel = true;
		}
/*  ToDo controle of rijksregisternr niet leeg is en cijfers zijn*/
		if (TextUtils.isEmpty(Integer.toString(rijksregnr)) || rijksregnr == -1) {
            rijksregnrText.setError(getString(R.string.error_field_required));
            focusView = rijksregnrText;
            cancel = true;
        }

        if (TextUtils.isEmpty(straat)) {
            straatText.setError(getString(R.string.error_field_required));
            focusView = straatText;
            cancel = true;
        }

        if (TextUtils.isEmpty(Integer.toString(huisnr)) || huisnr == -1) {
            huisnrText.setError(getString(R.string.error_field_required));
            focusView = huisnrText;
            cancel = true;
        }
        if (Integer.toString(huisnr).matches("[0-9]+") && Integer.toString(huisnr).length() >= 1){
            huisnrText.setError("U moet een geldig huisnummer invoeren.");
            focusView = huisnrText;
            cancel = true;
        }

        /*if (TextUtils.isEmpty(bus)) {
            busText.setError(getString(R.string.error_field_required));
            focusView = busText;
            cancel = true;
        }*/
        if (TextUtils.isEmpty(gemeente)) {
            gemeenteText.setError(getString(R.string.error_field_required));
            focusView = gemeenteText;
            cancel = true;
        }

        if (TextUtils.isEmpty(Integer.toString(postcode)) || postcode == -1) {
            postcodeText.setError(getString(R.string.error_field_required));
            focusView = postcodeText;
            cancel = true;
        } else {
            if (Integer.toString(postcode).length() != 4) {
                postcodeText.setError(getString(R.string.error_incorrect_postcode));
                focusView = postcodeText;
                cancel = true;
            }
            if (Integer.toString(postcode).matches("[0-9]+")){
                postcodeText.setError("U moet een geldige postcode invoeren.");
                focusView = postcodeText;
                cancel = true;
            }
        }

        if (TextUtils.isEmpty(telefoon)) {
            telefoonText.setError(getString(R.string.error_field_required));
            focusView = telefoonText;
            cancel = true;
        }

        if (TextUtils.isEmpty(gsm)) {
            gsmText.setError(getString(R.string.error_field_required));
            focusView = gsmText;
            cancel = true;
        }

		if (cancel) {
			// There was an error; don't attempt login and focus the first
			// form field with an error.
			focusView.requestFocus();
		} else {
			// Show a progress spinner, and kick off a background task to
			// perform the user login attempt.
            opslaan(voornaam ,naam, rijksregnr, straat, huisnr, gemeente, postcode, telefoon, gsm, bus);
			Toast.makeText(getApplicationContext(), "Opgeslagen", Toast.LENGTH_SHORT).show();

		}

	}

    private void opslaan(String voornaam,String naam, int rijksregnr, String straat, int huisnr, String gemeente, int postcode, String telefoon, String gsm, String bus) {
        //Toast.makeText(getApplicationContext(), mEmail, Toast.LENGTH_SHORT).show();

        Intent in = new Intent(getApplicationContext(),SignUp_deel4.class);

        Bundle extras = getIntent().getExtras();
        if (extras != null) {
            String lidBM = extras.getString("lidVanBondMoyson");
            String BMnr = extras.getString("aansluitingsnr");
            in.putExtra("lidVanBondMoyson", lidBM);
            in.putExtra("aansluitingsnr", BMnr);
        }

        in.putExtra("voornaam", voornaam);
        in.putExtra("naam", naam);
        in.putExtra("straat", straat);
        in.putExtra("huisnr", Integer.toString(huisnr));
        in.putExtra("bus", bus);
        in.putExtra("gemeente", gemeente);
        in.putExtra("postcode", Integer.toString(postcode));
        in.putExtra("rijksregnr", Integer.toString(rijksregnr));
        in.putExtra("telefoon",telefoon);
        in.putExtra("gsm",gsm);

        startActivity(in);

    }

	protected void signUpMsg(String msg) {
		Toast.makeText(getApplicationContext(), msg, Toast.LENGTH_SHORT).show();	
	}

	private void clearErrors(){ 
		voornaamText.setError(null);
		naamText.setError(null);
		rijksregnrText.setError(null);
        straatText.setError(null);
        huisnrText.setError(null);
        gemeenteText.setError(null);
        postcodeText.setError(null);
        busText.setError(null);
        telefoonText.setError(null);
        gsmText.setError(null);
	}

    private boolean isEmpty(EditText etText) {
        return etText.getText().toString().trim().length() == 0;
    }

    private boolean isValidRijksregisternr(int rrn){
        String tekstrrn = Integer.toString(rrn);
        if (tekstrrn.length() != 11)
            return false;
        else{
            String eerste9cijfers, laatste2;
            eerste9cijfers = tekstrrn.substring(0, 10);
            laatste2 = tekstrrn.substring(10, 11);
            int restNaDeling = Integer.parseInt(eerste9cijfers) % 97;
            int controleGetal = 97 - restNaDeling;
            return controleGetal == Integer.parseInt(laatste2);
        }
    }

	
}
