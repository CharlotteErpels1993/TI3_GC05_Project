package com.hogent.ti3g05.ti3_g05_joetzapp.SignUpLogin;

import com.hogent.ti3g05.ti3_g05_joetzapp.R;
import com.parse.ParseException;
import com.parse.ParseUser;
import com.parse.RequestPasswordResetCallback;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.text.TextUtils;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;

import java.util.List;

public class ForgetParsePassword extends Activity{
	EditText et_forgetpassword = null;
	Button btn_submitforgetpassword = null;
    Button btn_back = null;
	String email = null;
	
	
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.forgetpassword);
		
		et_forgetpassword = (EditText) findViewById(R.id.et_forgetpassword);
		btn_submitforgetpassword = (Button) findViewById(R.id.btn_submitforgetpassword);
        btn_back = (Button) findViewById(R.id.btn_back);

        btn_back.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Intent intent1 = new Intent(ForgetParsePassword.this, Login.class);
                startActivity(intent1);

                overridePendingTransition(R.anim.left_in, R.anim.right_out);
            }
        });
		
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
        et_forgetpassword.setError("email bestaat niet");

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
				Toast.makeText(getApplicationContext(), "Successfully sent link to your email for reset Password", Toast.LENGTH_LONG).show();
                Intent intent1 = new Intent(ForgetParsePassword.this, Login.class);
                startActivity(intent1);

                overridePendingTransition(R.anim.left_in, R.anim.right_out);
			} else {
				Toast.makeText(getApplicationContext(), "Failed to sent link to your email for reset Password", Toast.LENGTH_LONG).show();
				
			}
		}		
	}

}
