package com.hogent.ti3g05.ti3_g05_joetzapp.SignUpLogin;


import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.text.TextUtils;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.animation.Animation;
import android.view.animation.AnimationUtils;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;
import android.widget.Toast;
import java.util.List;

import com.hogent.ti3g05.ti3_g05_joetzapp.Services.ConnectionDetector;
import com.hogent.ti3g05.ti3_g05_joetzapp.R;
import com.hogent.ti3g05.ti3_g05_joetzapp.navBarMainScreen;
import com.parse.LogInCallback;
import com.parse.ParseException;
import com.parse.ParseObject;
import com.parse.ParseQuery;
import com.parse.ParseUser;
import com.parse.SignUpCallback;

//Stap 4 van registreren
public class RegistrerenDeel4 extends Activity{

	private EditText mEmailEditText; 
	private EditText mPasswordEditText;
	private EditText mConfirmPasswordEditText;

    private boolean cancel = false;
    private View focusView = null;

    private boolean lidnrJuist;
    private String rijksregisternummer;

	// flag for Internet connection status
    private boolean isInternetPresent = false;
    // Connection detector class
    private ConnectionDetector cd;

	
	@Override
	protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_signup_deel4);
        getActionBar().setTitle(getString(R.string.title_activity_Register));

        final Animation animAlpha = AnimationUtils.loadAnimation(this, R.anim.alpha);

        cd = new ConnectionDetector(getApplicationContext());

		mEmailEditText = (EditText) findViewById(R.id.etEmail);
		mPasswordEditText = (EditText) findViewById(R.id.etPassword);
		mConfirmPasswordEditText = (EditText) findViewById(R.id.etPasswordConfirm);

        Intent in = getIntent();
        rijksregisternummer = in.getStringExtra("rijksregisternr");


        final Button mCreateAccountButton = (Button) findViewById(R.id.btnCreateAccount);
		mCreateAccountButton.setOnClickListener(new OnClickListener() {
            @Override
            public void onClick(View view) {
                mCreateAccountButton.startAnimation(animAlpha);
                //Bij het klikken op de knop wordt gecontroleerd of er internet is, zoja, controleer gegevens
            isInternetPresent = cd.isConnectingToInternet();
            if (isInternetPresent) {
                // Internet Connection is Present
                createAccount();
            } else
                signUpMsg(getString(R.string.error_no_internet));
            }
        });
        //signupEmailLabel
        TextView tvOpvullen = (TextView) findViewById(R.id.signupEmailLabel);
        tvOpvullen.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                mEmailEditText.setText("gilles.devylder@gmail.com");
                mPasswordEditText.setText("abc123");
                mConfirmPasswordEditText.setText("abc123");

            }
        });
	}


	private void createAccount(){
		clearErrors();
        cancel = false;

		// Store values at the time of the onClick event.
        String mEmail = mEmailEditText.getText().toString();
        String mPassword = mPasswordEditText.getText().toString();
        String mConfirmPassword = mConfirmPasswordEditText.getText().toString();


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


        //het opgegevens email adres moet uniek zijn, mag nog niet in de DB voorkomen.

        ParseQuery<ParseObject> query = ParseQuery.getQuery("Ouder");
            query.whereEqualTo("email", mEmail);
            try{
                List<ParseObject> lijstObjecten = query.find();
                if (lijstObjecten.size() > 0){
                    mEmailEditText.setError(getString(R.string.error_occupied_email));
                    focusView = mEmailEditText;
                    cancel = true;
                }
            }
            catch(ParseException e){
                signUpMsg(getString(R.string.error_generalException));
                cancel = true;
            }



		if (cancel) {
			// There was an error; don't attempt login and focus the first
			// form field with an error.
			focusView.requestFocus();
		} else {
			// Show a progress spinner, and kick off a background task to
			// perform the user login attempt.
			signUp(mEmail,mEmail, mPassword);
		}

	}

    //Alle UI input is correct -> gegevens opslaan en registratie afmaken
    private void signUp(String username, String mEmail, String mPassword) {
        Toast.makeText(getApplicationContext(), getString(R.string.loading_message), Toast.LENGTH_SHORT).show();

        String codeGerechtigde = null;
        String aansluitingsnr = null;
        String aansluitingsnrOuder2 = null;
        String voornaam = null;
        String naam = null;
        String straat= null;
        String huisnr=null;
        String bus=null;
        String gemeente=null;
        String postcode=null;
        String telefoon=null;
        String gsm=null;


        Bundle extras = getIntent().getExtras();
        if (extras != null) {
        //gegevens uit vorige schermen ophalen
            codeGerechtigde = extras.getString("codeGerechtigde");
            aansluitingsnrOuder2 = extras.getString("aansluitingsnrOuder2");
            aansluitingsnr = extras.getString("aansluitingsnr");
            voornaam = extras.getString("voornaam");
            naam = extras.getString("naam");
            straat = extras.getString("straat");
            huisnr = extras.getString("huisnr");
            bus = extras.getString("bus");
            gemeente = extras.getString("gemeente");
            postcode = extras.getString("postcode");
            telefoon = extras.getString("telefoon");
            gsm = extras.getString("gsm");
        }
                ParseObject gebruiker = new ParseObject("Ouder");
                gebruiker.put("email", mEmail);

                try{
                if (aansluitingsnr != null && !aansluitingsnr.equals(""))
                    gebruiker.put("aansluitingsNr", Double.parseDouble(aansluitingsnr));
                gebruiker.put("voornaam", voornaam);
                gebruiker.put("naam", naam);
                gebruiker.put("straat", straat);
                gebruiker.put("nummer", Integer.parseInt(huisnr));
                if (bus != null && !bus.equals(""))
                    gebruiker.put("bus", bus);
                gebruiker.put("gemeente", gemeente);
                gebruiker.put("postcode", Integer.parseInt(postcode));
                gebruiker.put("rijksregisterNr", rijksregisternummer);
                gebruiker.put("telefoon", telefoon);
                gebruiker.put("gsm", gsm);
                if (aansluitingsnrOuder2 != null && !aansluitingsnrOuder2.equals(""))
                    gebruiker.put("aansluitingsNrTweedeOuder", Double.parseDouble(aansluitingsnrOuder2));
                if (codeGerechtigde != null && !codeGerechtigde.equals(""))
                    gebruiker.put("codeGerechtigde", Double.parseDouble(codeGerechtigde));
            }
            catch (NumberFormatException nfe){
                Toast.makeText(getApplicationContext(), getString(R.string.error_generalException), Toast.LENGTH_SHORT).show();
            }

            gebruiker.saveInBackground();

            ParseUser user = new ParseUser();
            user.setUsername(username);
            user.setPassword(mPassword);
            user.setEmail(mEmail);
            user.put("soort", "ouder");
            user.signUpInBackground(new SignUpCallback() {
                @Override
                public void done(ParseException e) {
                    if (e != null) {
                        // Sign up didn't succeed. Look at the ParseException
                        // to figure out what went wrong
                        signUpMsg(getString(R.string.error_generalException));
                    }
                }
            });

            signUpMsg(getString(R.string.confirmationSignup));
                ParseUser.logInInBackground(username, mPassword, new LogInCallback() {
                    @Override
                    public void done(ParseUser user, ParseException e) {

                        Intent in = new Intent(getApplicationContext(), navBarMainScreen.class);
                        startActivity(in);
                    }
                });

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
        Intent setIntent = new Intent(RegistrerenDeel4.this, navBarMainScreen.class);
        setIntent.addCategory(Intent.CATEGORY_HOME);
        setIntent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
        startActivity(setIntent);
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
            Intent intent1 = new Intent(this, RegistrerenDeel1.class);
            startActivity(intent1);

            overridePendingTransition(R.anim.left_in, R.anim.right_out);
        }

        return super.onOptionsItemSelected(item);
    }

	
}
