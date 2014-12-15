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

//Deze klasse stuurt een mail om het wachtwoord van de gebruiker te resetten
public class WachtwoordVergeten extends Activity{
    private EditText et_forgetpassword = null;
    private Button btn_submitforgetpassword = null;
    private String email = null;
	
	
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
                //Bij het klikken op de knop zal het email gecontroleerd worden
				email = et_forgetpassword.getText().toString();
				checkEmailID();
				
			}
		});
		
	}

    //kijk of het Email ingevuld & geldig is. Zo ja, kijk of het email in de DB voor komt. Zo ja dan word de functie aangeroepen die een mail verstuurd
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

    //Stuurt een mail naar de gebruiker naar het opgegeven email adres
	public void forgotPassword(String email) {
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
                Intent intent1 = new Intent(WachtwoordVergeten.this, Login.class);
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
