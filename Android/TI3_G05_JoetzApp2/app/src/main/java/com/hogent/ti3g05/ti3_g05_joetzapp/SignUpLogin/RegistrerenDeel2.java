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

import com.hogent.ti3g05.ti3_g05_joetzapp.Services.ConnectionDetector;
import com.hogent.ti3g05.ti3_g05_joetzapp.R;

//stap 2 van registreren, enkel voor leden van bons moyson
public class RegistrerenDeel2 extends Activity{
    private EditText et_aansluitingsnummer;
    private EditText et_codeGerechtigde;
    private EditText et_aansluitingsNrOuder2;
    private String rijksRegNr;

    private Boolean isInternetPresent = false;
    private ConnectionDetector cd;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_signup_deel2);

        final Animation animAlpha = AnimationUtils.loadAnimation(this, R.anim.alpha);

        getActionBar().setTitle(getString(R.string.title_activity_Register));

        // creating connection detector class instance
        cd = new ConnectionDetector(getApplicationContext());

        et_aansluitingsnummer = (EditText) findViewById(R.id.aansluitingsnummer);
        et_codeGerechtigde = (EditText) findViewById(R.id.codeGerechtigde);
        et_aansluitingsNrOuder2 = (EditText) findViewById(R.id.aansluitingsNrOuder2);


        final Button volgendeButton = (Button) findViewById(R.id.btn_volgendedeel3);
        //Bij het klikken op de knop, controleer of er internet aanwezig is, zoja controleer het aansluitingsnummer
        volgendeButton.setOnClickListener(new OnClickListener() {
            @Override
            public void onClick(View view) {
                volgendeButton.startAnimation(animAlpha);
            isInternetPresent = cd.isConnectingToInternet();
                if (isInternetPresent) {
                    // Internet Connection is Present
                    controleerGegevens();
                } else
                    Toast.makeText(getApplicationContext(), getString(R.string.error_no_internet), Toast.LENGTH_SHORT).show();
            }
        });

        TextView tvOpvullen = (TextView) findViewById(R.id.signupAansluitingsnummerLabel);
        tvOpvullen.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                et_aansluitingsnummer.setText("9638524561");
                et_codeGerechtigde.setText("12563258");

            }
        });

    }

    //controleren of de ingegeven waarden correct zijn (en ingevuld), zoja sla de gegevens op
    private void controleerGegevens(){
        clearErrors();

        boolean cancel = false;
        View focusView = null;

        String aansluitingsnummerString = et_aansluitingsnummer.getText().toString();
        String codeGerechtigdeStr = et_codeGerechtigde.getText().toString();
        String aansluitingsNrOuder2Str = et_aansluitingsNrOuder2.getText().toString();

        if (TextUtils.isEmpty(aansluitingsnummerString)) {
            et_aansluitingsnummer.setError(getString(R.string.error_field_required));
            focusView = et_aansluitingsnummer;
            cancel = true;
        } else if(aansluitingsnummerString.length() != 10)
        {
            et_aansluitingsnummer.setError(getString(R.string.error_incorrect_aansluitingsnr));
            focusView = et_aansluitingsnummer;
            cancel = true;
        }

        if (TextUtils.isEmpty(codeGerechtigdeStr)) {
            et_codeGerechtigde.setError(getString(R.string.error_field_required));
            focusView = et_codeGerechtigde;
            cancel = true;
        }

        if (!TextUtils.isEmpty(aansluitingsNrOuder2Str)) {
            if( aansluitingsNrOuder2Str.length() != 10)
            {
                et_aansluitingsNrOuder2.setError(getString(R.string.error_incorrect_aansluitingsnr));
                focusView = et_aansluitingsNrOuder2;
                cancel = true;
            }
        }

        if (cancel) {
            focusView.requestFocus();
        } else {
            //alles is correct, sla de gegevens op
           opslaan(aansluitingsnummerString, codeGerechtigdeStr, aansluitingsNrOuder2Str);

        }

    }

    //De waarden worden doorgestuurd naar de volgende stap en de gebruiker gaat door naar stap 3
    private void opslaan(String aansluitingsnummerString, String codeGerechtigdeStr, String aansluitingsNrOuder2Str) {
        Intent intent = new Intent(getApplicationContext(), RegistrerenDeel3.class);
        Bundle extras = getIntent().getExtras();
        if (extras != null) {
            rijksRegNr = extras.getString("rijksregisternr");
            intent.putExtra("rijksregisternr", rijksRegNr);

        }
        intent.putExtra("aansluitingsnr", aansluitingsnummerString);
        intent.putExtra("codeGerechtigde", codeGerechtigdeStr);
        if(aansluitingsNrOuder2Str != null)
        {
            intent.putExtra("aansluitingsnrOuder2", aansluitingsNrOuder2Str);
        }
        else
            intent.putExtra("aansluitingsnrOuder2", "");

        startActivity(intent);

        overridePendingTransition(R.anim.right_in, R.anim.left_out);
    }


    //error verbergen, wordt opgeroepen elke keer de gebruiker opnieuw verder probeert te gaan
    private void clearErrors(){
        et_aansluitingsnummer.setError(null); et_codeGerechtigde.setError(null);
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
