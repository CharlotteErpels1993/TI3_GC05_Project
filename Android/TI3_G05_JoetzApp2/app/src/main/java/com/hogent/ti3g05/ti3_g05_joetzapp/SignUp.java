package com.hogent.ti3g05.ti3_g05_joetzapp;


import android.app.Activity;
import android.app.AlertDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.os.Bundle;
import android.text.TextUtils;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;

import com.parse.Parse;
import com.parse.ParseException;
import com.parse.ParseUser;
import com.parse.SignUpCallback;

public class SignUp extends Activity{

	private EditText mEmailEditText; 
	private EditText mPasswordEditText;
	private EditText mConfirmPasswordEditText;
	private Button mCreateAccountButton;
    private Button terugKerenButton;

	private String mEmail;
	private String mPassword;
	private String mConfirmPassword;

	// flag for Internet connection status
		Boolean isInternetPresent = false;
		// Connection detector class
		ConnectionDetector cd;
	
	@Override
	protected void onCreate(Bundle savedInstanceState) {
        // TODO Auto-generated method stub
        super.onCreate(savedInstanceState);

		setContentView(R.layout.activity_signup);

		// creating connection detector class instance
				cd = new ConnectionDetector(getApplicationContext());

		
		mEmailEditText = (EditText) findViewById(R.id.etEmail);
		mPasswordEditText = (EditText) findViewById(R.id.etPassword);
		mConfirmPasswordEditText = (EditText) findViewById(R.id.etPasswordConfirm);

		mCreateAccountButton = (Button) findViewById(R.id.btnCreateAccount);
		mCreateAccountButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {

                    // TODO Auto-generated method stub
                    switch (view.getId()) {
                        case R.id.btnCreateAccount:
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
                                Toast.makeText(getApplicationContext(), "Fout bij registreren", Toast.LENGTH_SHORT).show();
                                //showAlertDialog(getApplicationContext(), "No Internet Connection",
                                        //"You don't have internet connection.", false);


                            break;

                        default:
                            break;

                }
            }
        });

        terugKerenButton = (Button) findViewById(R.id.btnBack);

        terugKerenButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Intent intent1 = new Intent(SignUp.this, MainScreen.class);
                startActivity(intent1);
            }
        });

	}



	private void createAccount(){
		clearErrors();

		boolean cancel = false;
		View focusView = null;

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

		if (cancel) {
			// There was an error; don't attempt login and focus the first
			// form field with an error.
			focusView.requestFocus();
		} else {
			// Show a progress spinner, and kick off a background task to
			// perform the user login attempt.
			Toast.makeText(getApplicationContext(), "Registreren", Toast.LENGTH_SHORT).show();
			signUp(mEmail,mEmail, mPassword);

		}

	}

	private void signUp(String username,String mEmail, String mPassword) {
		// TODO Auto-generated method stub
		Toast.makeText(getApplicationContext(), mEmail, Toast.LENGTH_SHORT).show();
		ParseUser user = new ParseUser();
        user.setUsername(username);
		user.setPassword(mPassword);
		user.setEmail(mEmail);
		 
		user.signUpInBackground(new SignUpCallback() {
		  public void done(ParseException e) {
		    if (e == null) {
		      signUpMsg("Aacount aangemaakt.");
		      Intent in = new Intent(getApplicationContext(),MainScreen.class);
		      startActivity(in);
		    } else {
		      // Sign up didn't succeed. Look at the ParseException
		      // to figure out what went wrong
		    	signUpMsg("Account bestaat al.");
		    }
		  }
		});
	}

	protected void signUpMsg(String msg) {
		// TODO Auto-generated method stub
		Toast.makeText(getApplicationContext(), msg, Toast.LENGTH_SHORT).show();	
	}

	private void clearErrors(){ 
		mEmailEditText.setError(null);
		mPasswordEditText.setError(null);
		mConfirmPasswordEditText.setError(null);
	}

	@SuppressWarnings("deprecation")
	public void showAlertDialog(Context context, String title, String message, Boolean status) {
		AlertDialog alertDialog = new AlertDialog.Builder(context).create();

		// Setting Dialog Title
		alertDialog.setTitle(title);

		// Setting Dialog Message
		alertDialog.setMessage(message);

		// Setting alert dialog icon
		alertDialog.setIcon(R.drawable.fail);

		// Setting OK Button
		alertDialog.setButton("OK", new DialogInterface.OnClickListener() {
			public void onClick(DialogInterface dialog, int which) {
			}
		});

		// Showing Alert Message
		alertDialog.show();
	}

	
}
