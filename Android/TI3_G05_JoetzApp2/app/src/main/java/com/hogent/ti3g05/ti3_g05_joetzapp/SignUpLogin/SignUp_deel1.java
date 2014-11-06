package com.hogent.ti3g05.ti3_g05_joetzapp.SignUpLogin;


import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.RadioButton;
import android.widget.RadioGroup;

import com.hogent.ti3g05.ti3_g05_joetzapp.Services.ConnectionDetector;
import com.hogent.ti3g05.ti3_g05_joetzapp.R;
import com.hogent.ti3g05.ti3_g05_joetzapp.navBarMainScreen;

public class SignUp_deel1 extends Activity{

    private RadioGroup rg = null;
    private Button terugButton;


    // flag for Internet connection status
    Boolean isInternetPresent = false;
    // Connection detector class
    ConnectionDetector cd;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        setContentView(R.layout.activity_signup_deel1);

        rg = (RadioGroup) findViewById(R.id.radioGroup);
        rg.clearCheck();

        // creating connection detector class instance
        cd = new ConnectionDetector(getApplicationContext());

        terugButton = (Button) findViewById(R.id.btn_terugGaan);

        RadioButton rb1 = (RadioButton) findViewById(R.id.radioButtonJa);
        rb1.setOnClickListener(new OnClickListener() {
            @Override
            public void onClick(View view) {
                Intent intentJa = new Intent(getApplicationContext(), SignUp_deel2.class);
                intentJa.putExtra("lidVanBondMoyson", "true");
                startActivity(intentJa);


            }
        });

        RadioButton rb2 = (RadioButton) findViewById(R.id.radioButtonNee);
        rb2.setOnClickListener(new OnClickListener() {
            @Override
            public void onClick(View view) {
                Intent intentNee = new Intent(getApplicationContext(), SignUp_deel3.class);
                intentNee.putExtra("lidVanBondMoyson", "false");
                startActivity(intentNee);
            }
        });


        terugButton = (Button) findViewById(R.id.btn_terugGaan);

        terugButton.setOnClickListener(new OnClickListener() {
            @Override
            public void onClick(View view) {
                Intent intent1 = new Intent(SignUp_deel1.this, navBarMainScreen.class);
                startActivity(intent1);


            }
        });

    }
}
