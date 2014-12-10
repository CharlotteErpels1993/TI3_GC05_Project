package com.hogent.ti3g05.ti3_g05_joetzapp.SignUpLogin;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.text.TextUtils;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;

import com.hogent.ti3g05.ti3_g05_joetzapp.Services.ConnectionDetector;
import com.hogent.ti3g05.ti3_g05_joetzapp.R;
import com.hogent.ti3g05.ti3_g05_joetzapp.navBarMainScreen;
import com.parse.LogInCallback;
import com.parse.ParseException;
import com.parse.ParseUser;

public class Login extends Activity{
    private Button btn_LoginIn = null;
    private Button btn_SignUp = null;
    private Button btn_ForgetPass = null;
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
    private Boolean isInternetPresent = true;
	// Connection detector class
    private ConnectionDetector cd;


	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_login);
        getActionBar().setTitle(getString(R.string.title_activity_Login));

        // creating connection detector class instance
        cd = new ConnectionDetector(getApplicationContext());
        //Calling ParseAnalytics to see Analytics of our app
        //ParseAnalytics.trackAppOpened(getIntent());

        //cd = new ConnectionDetector(getApplicationContext());

        btn_LoginIn = (Button) findViewById(R.id.btn_login);
        btn_SignUp = (Button) findViewById(R.id.btn_signup);
        btn_ForgetPass = (Button) findViewById(R.id.btn_ForgetPass);

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
                    attemptLogin();
                } else {
                    // Internet connection is not present
                    // Ask user to connect to Internet
                    Toast.makeText(getApplicationContext(), getString(R.string.error_no_internet), Toast.LENGTH_SHORT).show();
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

                overridePendingTransition(R.anim.right_in, R.anim.left_out);
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

    //waarden zijn niet leeg -> Parse probeert in te loggen
	private void login(String lowerCase, String password) {
        ParseUser.logInInBackground(lowerCase, password, new LogInCallback() {
            @Override
            public void done(ParseUser user, ParseException e) {
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
        Toast.makeText(getApplicationContext(), getString(R.string.updatingReport), Toast.LENGTH_SHORT).show();

		Intent in =  new Intent(Login.this,navBarMainScreen.class);
		startActivity(in);

        overridePendingTransition(R.anim.left_in, R.anim.right_out);
	}

	protected void loginUnSuccessful() {
		Toast.makeText(getApplicationContext(), getString(R.string.error_incorrectLogin), Toast.LENGTH_SHORT).show();
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

    @Override
    public void onBackPressed() {
        Intent setIntent = new Intent(Login.this, navBarMainScreen.class);
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
            Intent intent1 = new Intent(this, navBarMainScreen.class);
            startActivity(intent1);

            overridePendingTransition(R.anim.left_in, R.anim.right_out);
        }

        return super.onOptionsItemSelected(item);
    }

}
