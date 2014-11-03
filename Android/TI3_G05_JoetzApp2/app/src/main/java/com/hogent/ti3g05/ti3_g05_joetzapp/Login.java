package com.hogent.ti3g05.ti3_g05_joetzapp;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.text.TextUtils;
import android.view.Menu;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;

import com.parse.LogInCallback;
import com.parse.ParseException;
import com.parse.ParseUser;

public class Login extends Activity{
	Button btn_LoginIn = null;
	Button btn_SignUp = null;
	Button btn_ForgetPass = null;
    Button btn_Return = null;
	private EditText mUserNameEditText;
	private EditText mPasswordEditText;
   /* public final Pattern EMAIL_ADDRESS_PATTERN = Pattern.compile(
            "[a-zA-Z0-9+._%-+]{1,256}" +
                    "@" +
                    "[a-zA-Z0-9][a-zA-Z0-9-]{0,64}" +
                    "(" +
                    "." +
                    "[a-zA-Z0-9][a-zA-Z0-9-]{0,25}" +
                    ")+"
    );*/

	// flag for Internet connection status
	Boolean isInternetPresent = false;
	// Connection detector class
	ConnectionDetector cd;

   /* private boolean checkEmail(String email) {
        return EMAIL_ADDRESS_PATTERN.matcher(email).matches();
    }*/

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);

        setContentView(R.layout.activity_login);

        //Calling ParseAnalytics to see Analytics of our app
        //ParseAnalytics.trackAppOpened(getIntent());

        // creating connection detector class instance
        cd = new ConnectionDetector(getApplicationContext());

        btn_LoginIn = (Button) findViewById(R.id.btn_login);
        btn_SignUp = (Button) findViewById(R.id.btn_signup);
        btn_ForgetPass = (Button) findViewById(R.id.btn_ForgetPass);
        btn_Return = (Button) findViewById(R.id.btn_return);
        mUserNameEditText = (EditText) findViewById(R.id.username);
        mPasswordEditText = (EditText) findViewById(R.id.password);

        btn_LoginIn.setOnClickListener(new OnClickListener() {

            @Override
            public void onClick(View v) {
                // get Internet status
                isInternetPresent = cd.isConnectingToInternet();
                // check for Internet status
                if (isInternetPresent) {
                    // Internet Connection is Present
                    // make HTTP requests
                    attemptLogin();
                } else {
                    // Internet connection is not present
                    // Ask user to connect to Internet
                    Toast.makeText(getApplicationContext(), "Geen internetconnectie", Toast.LENGTH_SHORT).show();
                }

            }
        });

        btn_SignUp.setOnClickListener(new OnClickListener() {

            @Override
            public void onClick(View v) {
                Intent in = new Intent(Login.this, SignUp_deel1.class);
                startActivity(in);
            }
        });

        btn_ForgetPass.setOnClickListener(new OnClickListener() {

            @Override
            public void onClick(View v) {
                Intent in = new Intent(Login.this, ForgetParsePassword.class);
                startActivity(in);
            }
        });

        btn_Return.setOnClickListener(new OnClickListener() {
            @Override
            public void onClick(View view) {
                Intent intent = new Intent(Login.this, MainScreen.class);
                startActivity(intent);
            }
        });

	}


	public void attemptLogin() {
		clearErrors();

		// Store values at the time of the login attempt.
		String username = mUserNameEditText.getText().toString();
		String password = mPasswordEditText.getText().toString();

		boolean cancel = false;
		View focusView = null;


		// Check for a valid password.
		if (TextUtils.isEmpty(password)) {
			mPasswordEditText.setError(getString(R.string.error_field_required));
			focusView = mPasswordEditText;
			cancel = true;
		}

		// Check for a valid email address.
        if (TextUtils.isEmpty(username)) {
            mUserNameEditText.setError(getString(R.string.error_field_required));
            focusView = mUserNameEditText;
            cancel = true;
        } else if (!username.contains("@")) {
            mUserNameEditText.setError(getString(R.string.error_invalid_email));
            focusView = mUserNameEditText;
            cancel = true;
        }

       /* if(!checkEmail(username))
        {
            mUserNameEditText.setError(getString(R.string.error_invalid_email));
            focusView = mUserNameEditText;
            cancel = true;
        }*/

		if (cancel) {
			// There was an error; don't attempt login and focus the first
			// form field with an error.
			focusView.requestFocus();
		} else {
			// perform the user login attempt.
			login(username.toLowerCase(), password);
		}
	}

	private void login(String lowerCase, String password) {
        ParseUser.logInInBackground(lowerCase, password, new LogInCallback() {
            @Override
            public void done(ParseUser user, ParseException e) {
                // TODO Auto-generated method stub
                if(e == null){
                    loginSuccessful();
                }
                else{
                    loginUnSuccessful();
                }
            }
        });
	}

	protected void loginSuccessful() {
        Toast.makeText(getApplicationContext(), "U bent succesvol ingelogd", Toast.LENGTH_SHORT).show();

		Intent in =  new Intent(Login.this,MainScreen.class);
		startActivity(in);
	}
	protected void loginUnSuccessful() {
		Toast.makeText(getApplicationContext(), "Email of wachtwoord is ongeldig", Toast.LENGTH_SHORT).show();
	}

	private void clearErrors(){
		mUserNameEditText.setError(null);
		mPasswordEditText.setError(null);
	}

   /* private boolean bestaatDezeEmailReeds(String email){
        try{
            ParseQuery<ParseUser> query = ParseUser.getQuery();
            query.whereEqualTo("email", email);
            List<ParseUser> lijstUsers = query.find();

            return (lijstUsers.size() > 0);
        }
        catch(ParseException pe){
            Toast.makeText(getApplicationContext(),"Er is iets fout gelopen. Onze excuses voor het ongemak.", Toast.LENGTH_SHORT);
        }

    }*/

}
