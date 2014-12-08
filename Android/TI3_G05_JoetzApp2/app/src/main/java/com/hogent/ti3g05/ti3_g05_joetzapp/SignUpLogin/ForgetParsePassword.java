package com.hogent.ti3g05.ti3_g05_joetzapp.SignUpLogin;

import com.hogent.ti3g05.ti3_g05_joetzapp.R;
import com.parse.ParseException;
import com.parse.ParseUser;
import com.parse.RequestPasswordResetCallback;

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

import java.util.List;

public class ForgetParsePassword extends Activity{
	EditText et_forgetpassword = null;
	Button btn_submitforgetpassword = null;
	String email = null;
	
	
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.forgetpassword);
        getActionBar().setTitle("Wachtwoord vergeten");
		
		et_forgetpassword = (EditText) findViewById(R.id.et_forgetpassword);
		btn_submitforgetpassword = (Button) findViewById(R.id.btn_submitforgetpassword);

		btn_submitforgetpassword.setOnClickListener(new OnClickListener() {
			
			@Override
			public void onClick(View v) {
				email = et_forgetpassword.getText().toString();
                Toast.makeText(getApplicationContext(), "Mail wordt verstuurd", Toast.LENGTH_LONG).show();
				checkEmailID();
				
				
			}
		});
		
	}
	
	protected void checkEmailID() {

        if (TextUtils.isEmpty(email)) {
			et_forgetpassword.setError(getString(R.string.error_field_required));
		} else if (!email.contains("@")) {
			et_forgetpassword.setError(getString(R.string.error_invalid_email));
		}
        List<ParseUser> gebruikers = null;
        try {
            gebruikers = ParseUser.getQuery().find();
        } catch (ParseException e) {
            e.printStackTrace();
        }
        for(ParseUser p : gebruikers)
        {
            if(p.getEmail().equals(email))
                forgotPassword(email);
        }
        et_forgetpassword.setError("E-mail adres bestaat niet");

	}

	public void forgotPassword(String email) {
		//postEvent(new UserForgotPasswordStartEvent());
		ParseUser.requestPasswordResetInBackground(email, new UserForgotPasswordCallback());
	}
	
	private class UserForgotPasswordCallback extends RequestPasswordResetCallback{
		public UserForgotPasswordCallback(){
			super();
		}
		
		@Override
		public void done(ParseException e) {
			if (e == null) {
				Toast.makeText(getApplicationContext(), getString(R.string.passwordForgottenEmailSent), Toast.LENGTH_LONG).show();
                Intent intent1 = new Intent(ForgetParsePassword.this, Login.class);
                startActivity(intent1);

                overridePendingTransition(R.anim.left_in, R.anim.right_out);
			} else {
				Toast.makeText(getApplicationContext(), getString(R.string.passwordForgottenEmailFailed), Toast.LENGTH_LONG).show();
				
			}
		}		
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
            Intent intent1 = new Intent(this, Login.class);
            startActivity(intent1);

            overridePendingTransition(R.anim.left_in, R.anim.right_out);
        }

        return super.onOptionsItemSelected(item);
    }

}
