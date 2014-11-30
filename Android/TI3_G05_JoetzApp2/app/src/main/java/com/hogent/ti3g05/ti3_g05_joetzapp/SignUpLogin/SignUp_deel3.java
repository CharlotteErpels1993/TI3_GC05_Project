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
import com.hogent.ti3g05.ti3_g05_joetzapp.R;
import com.hogent.ti3g05.ti3_g05_joetzapp.navBarMainScreen;
import com.parse.ParseException;
import com.parse.ParseObject;
import com.parse.ParseQuery;

import java.util.List;

public class SignUp_deel3 extends Activity{

	private EditText voornaamText;
	private EditText naamText;
	private EditText straatText;
    private EditText huisnrText;
    private EditText gemeenteText;
    private EditText postcodeText;
    private EditText busText;
    private EditText telefoonText;
    private EditText gsmText;

	private Button volgendeButton;
    private Button terugKerenButton;

	private String voornaam;
	private String naam;
	private String straat;
    private String huisnr;
    private String bus;
    private String gemeente;
    private String postcode;
    private String rijksregnr;
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
		
		voornaamText = (EditText) findViewById(R.id.VoornaamSignu);
		naamText = (EditText) findViewById(R.id.NaamSignu);
		straatText = (EditText) findViewById(R.id.StraatSignu);
        huisnrText = (EditText) findViewById(R.id.HuisnrSignu);
        gemeenteText = (EditText) findViewById(R.id.GemeenteSignu);
        postcodeText = (EditText) findViewById(R.id.PostcodeSignu);
        telefoonText = (EditText) findViewById(R.id.TelefoonSignu);
        gsmText = (EditText) findViewById(R.id.GsmSignu);
        busText = (EditText) findViewById(R.id.BusSignu);

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
                    opslaanGeg();
                }
                else{
                    // Internet connection is not present
                    // Ask user to connect to Internet
                    Toast.makeText(getApplicationContext(), getString(R.string.error_no_internet), Toast.LENGTH_SHORT).show();
                }

                //Intent in = new Intent(getApplicationContext(),SignUp_deel4.class);
                //startActivity(in);

            }
        });

        terugKerenButton = (Button) findViewById(R.id.btnNaarDeel1);

        terugKerenButton.setOnClickListener(new OnClickListener() {
            @Override
            public void onClick(View view) {
                Intent intent1 = new Intent(SignUp_deel3.this, SignUp_deel1.class);
                startActivity(intent1);

                overridePendingTransition(R.anim.left_in, R.anim.right_out);
            }
        });

	}



	private void opslaanGeg(){
		clearErrors();
        cancel = false;

		// Store values at the time of the login attempt.
		voornaam = voornaamText.getText().toString().toLowerCase();
		naam = naamText.getText().toString().toLowerCase();
        straat = straatText.getText().toString();
        huisnr = huisnrText.getText().toString();
        bus = busText.getText().toString();
        gemeente = gemeenteText.getText().toString();
        postcode = postcodeText.getText().toString();
        telefoon = telefoonText.getText().toString();
        gsm = gsmText.getText().toString();

        //hieronder wordt gecontroleerd of alles ingevuld is & eventueel numeriek is.
        //Omgekeerde volgorde, zodat de user naar het eerste verkeerde veld wordt gestuurd.
        if (TextUtils.isEmpty(gsm)) {
            gsmText.setError(getString(R.string.error_field_required));
            focusView = gsmText;
            cancel = true;
        }

        if (!TextUtils.isEmpty(telefoon) && (!telefoon.matches("[0-9]+") || telefoon.length() != 9)){

            telefoonText.setError(getString(R.string.error_incorrect_tel));
            focusView = telefoonText;
            cancel = true;
        }


        if (TextUtils.isEmpty(postcode)) {
            postcodeText.setError(getString(R.string.error_field_required));
            focusView = postcodeText;
            cancel = true;
        } else {
            if (postcode.length() != 4) {
                postcodeText.setError(getString(R.string.error_incorrect_postcode));
                focusView = postcodeText;
                cancel = true;
            }
            if (!postcode.matches("[0-9]+")){
                postcodeText.setError(getString(R.string.error_incorrect_postcode));
                focusView = postcodeText;
                cancel = true;
            }
        }

        if (TextUtils.isEmpty(gemeente)) {
            gemeenteText.setError(getString(R.string.error_field_required));
            focusView = gemeenteText;
            cancel = true;
        }

        /*if (TextUtils.isEmpty(bus)) {
            busText.setError(getString(R.string.error_field_required));
            focusView = busText;
            cancel = true;
        }*/

        if (TextUtils.isEmpty(huisnr)) {
            huisnrText.setError(getString(R.string.error_field_required));
            focusView = huisnrText;
            cancel = true;
        }
        if (!huisnr.matches("[0-9]+") && huisnr.length() >= 1){
            huisnrText.setError(getString(R.string.error_incorrect_huisnr));
            focusView = huisnrText;
            cancel = true;
        }

        if (TextUtils.isEmpty(straat)) {
            straatText.setError(getString(R.string.error_field_required));
            focusView = straatText;
            cancel = true;
        }
		if (TextUtils.isEmpty(naam)) {
			naamText.setError(getString(R.string.error_field_required));
			focusView = naamText;
			cancel = true;
		}

        if (TextUtils.isEmpty(voornaam)) {
            voornaamText.setError(getString(R.string.error_field_required));
            focusView = voornaamText;
            cancel = true;
        }

        ParseQuery<ParseObject> query = ParseQuery.getQuery("Ouder");
        query.whereEqualTo("gsm", gsm);
        try{
            List<ParseObject> lijstObjecten = query.find();
            if (lijstObjecten.size() > 0){
                gsmText.setError("Dit gsm-nummer is reeds in gebruik.");
                focusView = gsmText;
                cancel = true;
            }
        }
        catch(ParseException e){
            Toast.makeText(SignUp_deel3.this,"Er is iets fout gelopen. Onze excuses voor het ongemak.", Toast.LENGTH_SHORT).show();
            cancel = true;
        }
        ParseQuery<ParseObject> query2 = ParseQuery.getQuery("Monitor");
        query.whereEqualTo("gsm", gsm);
        try{
            List<ParseObject> lijstObjecten = query2.find();
            if (lijstObjecten.size() > 0){
                gsmText.setError("Dit gsm-nummer is reeds in gebruik.");
                focusView = gsmText;
                cancel = true;
            }
        }
        catch(ParseException e){
            Toast.makeText(SignUp_deel3.this,"Er is iets fout gelopen. Onze excuses voor het ongemak.", Toast.LENGTH_SHORT).show();
            cancel = true;
        }

		if (cancel) {
			// There was an error; don't attempt login and focus the first
			// form field with an error.
			focusView.requestFocus();
		} else {
			// Show a progress spinner, and kick off a background task to
			// perform the user login attempt.
            opslaan(voornaam ,naam, straat, huisnr, gemeente, postcode, telefoon, gsm, bus);
			//Toast.makeText(getApplicationContext(), "Opgeslagen", Toast.LENGTH_SHORT).show();

		}

	}

    private void opslaan(String voornaam,String naam, String straat, String huisnr, String gemeente, String postcode, String telefoon, String gsm, String bus) {
        Toast.makeText(getApplicationContext(), getString(R.string.loading_message), Toast.LENGTH_SHORT).show();

        Intent in = new Intent(getApplicationContext(),SignUp_deel4.class);

        Bundle extras = getIntent().getExtras();
        if (extras != null) {
            String lidBM = extras.getString("lidVanBondMoyson");
            rijksregnr = extras.getString("rijksregisternr");
            String BMnr = extras.getString("aansluitingsnr");
            String codeGerechtigde = extras.getString("codeGerechtigde");
            String aansluitingsNrOuder2 = extras.getString("aansluitingsnrOuder2");
            in.putExtra("lidVanBondMoyson", lidBM);
            in.putExtra("aansluitingsnr", BMnr);
            in.putExtra("codeGerechtigde", codeGerechtigde);
            in.putExtra("aansluitingsnrOuder2", aansluitingsNrOuder2);
            in.putExtra("rijksregisternr", rijksregnr);
            Toast.makeText(getApplicationContext(), "niet leeg deel3", Toast.LENGTH_SHORT).show();
        }

        in.putExtra("voornaam", voornaam);
        in.putExtra("naam", naam);
        in.putExtra("straat", straat);
        in.putExtra("huisnr", huisnr);
        in.putExtra("bus", bus);
        in.putExtra("gemeente", gemeente);
        in.putExtra("postcode", postcode);
        in.putExtra("telefoon",telefoon);
        in.putExtra("gsm",gsm);

        startActivity(in);

        overridePendingTransition(R.anim.right_in, R.anim.left_out);

    }

	protected void signUpMsg(String msg) {
		Toast.makeText(getApplicationContext(), msg, Toast.LENGTH_SHORT).show();	
	}

	private void clearErrors(){ 
		voornaamText.setError(null);
		naamText.setError(null);
        straatText.setError(null);
        huisnrText.setError(null);
        gemeenteText.setError(null);
        postcodeText.setError(null);
        busText.setError(null);
        telefoonText.setError(null);
        gsmText.setError(null);
	}

   /* private boolean isEmpty(EditText etText) {
        return etText.getText().toString().trim().length() == 0;
    }*/

   /* private boolean isValidRijksregisternr(String rrn){
        String eerste9cijfers, laatste2;
        eerste9cijfers = rrn.substring(0, 9);
        laatste2 = rrn.substring(9, 11);
        int restNaDeling = Integer.parseInt(eerste9cijfers) % 97;
        int controleGetal = 97 - restNaDeling;
        return controleGetal == Integer.parseInt(laatste2);

    }*/

	
}
