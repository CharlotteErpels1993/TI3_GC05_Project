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
import com.parse.ParseUser;
import com.parse.SignUpCallback;

import java.util.List;

public class SignUp_deel4 extends Activity{

	private EditText mEmailEditText; 
	private EditText mPasswordEditText;
	private EditText mConfirmPasswordEditText;
	private Button mCreateAccountButton;
    private Button terugKerenButton;

	private String mEmail;
	private String mPassword;
	private String mConfirmPassword;

    private boolean cancel = false;
    private View focusView = null;

	// flag for Internet connection status
    Boolean isInternetPresent = false;
    // Connection detector class
    ConnectionDetector cd;
	
	@Override
	protected void onCreate(Bundle savedInstanceState) {

        super.onCreate(savedInstanceState);

		setContentView(R.layout.activity_signup_deel4);

		// creating connection detector class instance
        cd = new ConnectionDetector(getApplicationContext());

		
		mEmailEditText = (EditText) findViewById(R.id.etEmail);
		mPasswordEditText = (EditText) findViewById(R.id.etPassword);
		mConfirmPasswordEditText = (EditText) findViewById(R.id.etPasswordConfirm);

		mCreateAccountButton = (Button) findViewById(R.id.btnCreateAccount);
		mCreateAccountButton.setOnClickListener(new OnClickListener() {
            @Override
            public void onClick(View view) {


                // get Internet status
                isInternetPresent = cd.isConnectingToInternet();
                // check for Internet status
                // Internet connection is not present
                // Ask user to connect to Internet
                if (isInternetPresent) {
                    // Internet Connection is Present
                    // make HTTP requests
                    createAccount();
                } else
                    Toast.makeText(getApplicationContext(), getString(R.string.error_no_internet), Toast.LENGTH_SHORT).show();
                //showAlertDialog(getApplicationContext(), "No Internet Connection",
                //"You don't have internet connection.", false);
            }
        });

        terugKerenButton = (Button) findViewById(R.id.btnBack);

        terugKerenButton.setOnClickListener(new OnClickListener() {
            @Override
            public void onClick(View view) {
                Intent intent1 = new Intent(SignUp_deel4.this, navBarMainScreen.class);
                startActivity(intent1);
                overridePendingTransition(R.anim.left_in, R.anim.right_out);
            }
        });
	}


	private void createAccount(){
		clearErrors();
        cancel = false;

		//declaratie van focusView & cancel is private gedeclareerd.

		// Store values at the time of the login attempt.
		mEmail = mEmailEditText.getText().toString();
		mPassword = mPasswordEditText.getText().toString();
		mConfirmPassword = mConfirmPasswordEditText.getText().toString();

		// Check for a valid confirm password.
		if (TextUtils.isEmpty(mConfirmPassword)) {
			mConfirmPasswordEditText.setError(getString(R.string.error_field_required));
			focusView = mConfirmPasswordEditText;
			cancel = true;
		} else if (mPassword != null && !mConfirmPassword.equals(mPassword)) {
			mPasswordEditText.setError(getString(R.string.error_invalid_confirm_password));
			focusView = mPasswordEditText;
			cancel = true;
		}
		// Check for a valid password.
		if (TextUtils.isEmpty(mPassword)) {
			mPasswordEditText.setError(getString(R.string.error_field_required));
			focusView = mPasswordEditText;
			cancel = true;
		} else if (mPassword.length() < 4) {
			mPasswordEditText.setError(getString(R.string.error_invalid_password));
			focusView = mPasswordEditText;
			cancel = true;
		}

		// Check for a valid email address.
		if (TextUtils.isEmpty(mEmail)) {
			mEmailEditText.setError(getString(R.string.error_field_required));
			focusView = mEmailEditText;
			cancel = true;
		} else if (!mEmail.contains("@")) {
			mEmailEditText.setError(getString(R.string.error_invalid_email));
			focusView = mEmailEditText;
			cancel = true;
		}

        //check if email adress is already used.
        ParseQuery<ParseObject> query = ParseQuery.getQuery("Ouder");
        query.whereEqualTo("email", mEmail);
        try{
            List<ParseObject> lijstObjecten = query.find();
            if (lijstObjecten.size() > 0){
                mEmailEditText.setError("Dit e-mail adres is reeds in gebruik.");
                focusView = mEmailEditText;
                cancel = true;
            }
        }
        catch(ParseException e){
            signUpMsg("Er is iets fout gelopen. Onze excuses voor het ongemak.");
            cancel = true;
        }

		if (cancel) {
			// There was an error; don't attempt login and focus the first
			// form field with an error.
			focusView.requestFocus();
		} else {
			// Show a progress spinner, and kick off a background task to
			// perform the user login attempt.
			//Toast.makeText(getApplicationContext(), "Registreren", Toast.LENGTH_SHORT).show();
			signUp(mEmail,mEmail, mPassword);

		}

	}

    private void signUp(String username, String mEmail, String mPassword) {
        Toast.makeText(getApplicationContext(), getString(R.string.loading_message), Toast.LENGTH_SHORT).show();

        ParseObject gebruiker = new ParseObject("Ouder");
        gebruiker.put("email", mEmail);
        gebruiker.put("wachtwoord", mPassword);
        gebruiker.put("soort", "ouder");

        Bundle extras = getIntent().getExtras();
        if (extras != null) {
            //String lidBondMoyson = extras.getString("lidVanBondMoyson");
            String codeGerechtigde = extras.getString("codeGerechtigde");
            String aansluitingsnrOuder2 = extras.getString("aansluitingsnrOuder2");
            String aansluitingsnr = extras.getString("aansluitingsnr");
            String voornaam = extras.getString("voornaam");
            String naam = extras.getString("naam");
            String straat = extras.getString("straat");
            String huisnr = extras.getString("huisnr");
            String bus = extras.getString("bus");
            String gemeente = extras.getString("gemeente");
            String postcode = extras.getString("postcode");
            String rijksregnr = extras.getString("rijksregisternr");
            String telefoon = extras.getString("telefoon");
            String gsm = extras.getString("gsm");

            try{
                //gebruiker.put("wachtwoord", lidBondMoyson);
                gebruiker.put("aansluitingsNr", Integer.parseInt(aansluitingsnr));
                gebruiker.put("voornaam", voornaam);
                gebruiker.put("naam", naam);
                gebruiker.put("straat", straat);
                gebruiker.put("nummer", Integer.parseInt(huisnr));
                if (bus != null && !bus.equals(""))
                    gebruiker.put("bus", bus);
                gebruiker.put("gemeente", gemeente);
                gebruiker.put("postcode", Integer.parseInt(postcode));
                gebruiker.put("rijksregisterNr", rijksregnr);
                gebruiker.put("telefoon", telefoon);
                gebruiker.put("gsm", gsm);
                gebruiker.put("aansluitingsNrTweedeOuder", Integer.parseInt(aansluitingsnrOuder2));
                gebruiker.put("codeGerechtigde", Integer.parseInt(codeGerechtigde));
            }
            catch (NumberFormatException nfe){
                Toast.makeText(getApplicationContext(), nfe.getMessage(), Toast.LENGTH_SHORT).show();
            }
        }

        gebruiker.saveInBackground();
        //TODO: data uit vorige schermen ophalen en erin steken.

        ParseUser user = new ParseUser();
        user.setUsername(username);
        user.setPassword(mPassword);
        user.setEmail(mEmail);
        user.signUpInBackground(new SignUpCallback() {
            @Override
            public void done(ParseException e) {
                if (e != null) {
                    // Sign up didn't succeed. Look at the ParseException
                    // to figure out what went wrong
                    signUpMsg(e.getMessage());
                }
            }
        });

        signUpMsg("Account aangemaakt.");
        Intent in = new Intent(getApplicationContext(), navBarMainScreen.class);
        startActivity(in);

        //hieronder is code om data ophalen.
        /*ParseQuery<ParseObject> query = ParseQuery.getQuery("Ouder");
        query.whereEqualTo("Email", mEmail);
        query.findInBackground(new FindCallback<ParseObject>() {
           public void done(List<ParseObject> objects, ParseException e) {
               if (e == null) {
                   // object will be your game score
                   signUpMsg("Email: " + objects.get(0).getString("Email"));
                   signUpMsg("Wachtwoord: " + objects.get(0).getString("Wachtwoord"));
               } else {
                   // something went wrong
                   signUpMsg("Er is een fout gebeurd tijdens de registratie. Gelieve opnieuw te proberen.");
               }
           }
       });*/
    }

	protected void signUpMsg(String msg) {
		Toast.makeText(getApplicationContext(), msg, Toast.LENGTH_SHORT).show();	
	}

	private void clearErrors(){ 
		mEmailEditText.setError(null);
		mPasswordEditText.setError(null);
		mConfirmPasswordEditText.setError(null);
	}

    @Override
    public void onBackPressed() {
        Intent setIntent = new Intent(SignUp_deel4.this, navBarMainScreen.class);
        setIntent.addCategory(Intent.CATEGORY_HOME);
        setIntent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
        startActivity(setIntent);
    }

	
}
