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

public class SignUp_deel2 extends Activity{
    private EditText et_aansluitingsnummer;
    private EditText et_codeGerechtigde;
    private EditText et_aansluitingsNrOuder2;
    private String rijksRegNr;


    // flag for Internet connection status
    private Boolean isInternetPresent = false;
    // Connection detector class
    private ConnectionDetector cd;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_signup_deel2);

        getActionBar().setTitle(getString(R.string.title_activity_Register));

        // creating connection detector class instance
        cd = new ConnectionDetector(getApplicationContext());

        et_aansluitingsnummer = (EditText) findViewById(R.id.aansluitingsnummer);
        et_codeGerechtigde = (EditText) findViewById(R.id.codeGerechtigde);
        et_aansluitingsNrOuder2 = (EditText) findViewById(R.id.aansluitingsNrOuder2);


        Button volgendeButton = (Button) findViewById(R.id.btn_volgendedeel3);
        volgendeButton.setOnClickListener(new OnClickListener() {
            @Override
            public void onClick(View view) {
            isInternetPresent = cd.isConnectingToInternet();
                if (isInternetPresent) {
                    // Internet Connection is Present
                    opslaanAansluitingsnummer();
                } else
                    Toast.makeText(getApplicationContext(), getString(R.string.error_no_internet), Toast.LENGTH_SHORT).show();
            }
        });
    }

    //controleren of de textvakken correct zijn ingevuld. Zo niet -> foutmelding & niet doorgaan
    private void opslaanAansluitingsnummer(){
        clearErrors();

        boolean cancel = false;
        View focusView = null;

        // Store values at the time of the onClick event.
        String aansluitingsnummerString = et_aansluitingsnummer.getText().toString();
        String codeGerechtigdeStr = et_codeGerechtigde.getText().toString();
        String aansluitingsNrOuder2Str = et_aansluitingsNrOuder2.getText().toString();

        //aansluitingsnr moet ingevuld zijn en 10 karakters lang zijn
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

        if (cancel) { //error
            focusView.requestFocus();
        } else { //geen error -> doorgaan naar volgend scherm
           opslaan(aansluitingsnummerString, codeGerechtigdeStr, aansluitingsNrOuder2Str);

        }

    }

    //User gaf geen foute input en mag dus door naar volgende stap v inschrijven. Waarden van dit en vorig scherm moeten meegegeven worden
    private void opslaan(String aansluitingsnummerString, String codeGerechtigdeStr, String aansluitingsNrOuder2Str) {
        Intent intent = new Intent(getApplicationContext(), SignUp_deel3.class);
        Bundle extras = getIntent().getExtras();
        if (extras != null) {
            String value = extras.getString("lidVanBondMoyson");
            String lidnrja = extras.getString("lidnrja");
            if(lidnrja != null && lidnrja.equals("true"))
                intent.putExtra("lidnrja", lidnrja);
            rijksRegNr = extras.getString("rijksregisternr");
            intent.putExtra("lidVanBondMoyson", value);
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
            Intent intent1 = new Intent(this, SignUp_deel1.class);
            startActivity(intent1);

            overridePendingTransition(R.anim.left_in, R.anim.right_out);
        }

        return super.onOptionsItemSelected(item);
    }



}
