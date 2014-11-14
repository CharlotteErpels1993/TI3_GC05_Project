package com.hogent.ti3g05.ti3_g05_joetzapp;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.text.TextUtils;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;

import com.hogent.ti3g05.ti3_g05_joetzapp.Services.ConnectionDetector;


public class InschrijvenVakantiePart3 extends Activity {

    private EditText editExtraInformatie;

    private String extraInformatie;

    private Button btnVolgende;
    private Button btnTerug;

    // flag for Internet connection status
    Boolean isInternetPresent = false;
    // Connection detector class
    ConnectionDetector cd;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_inschrijven_vakantie_part3);

        editExtraInformatie = (EditText) findViewById(R.id.ExtraInformatie);

        btnVolgende = (Button)findViewById(R.id.btnNaarDeel3V);
        btnVolgende.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                isInternetPresent = cd.isConnectingToInternet();

                if (isInternetPresent) {
                    doorsturenNaarDeel4();
                }
                else{
                    // Internet connection is not present
                    // Ask user to connect to Internet
                    Toast.makeText(getApplicationContext(), getString(R.string.error_no_internet), Toast.LENGTH_SHORT).show();
                }
            }
        });

        btnTerug = (Button) findViewById(R.id.btnNaarDeel1V);
        btnTerug.setOnClickListener(new View.OnClickListener(){
            @Override
            public void onClick(View view){
                Intent intent = new Intent(InschrijvenVakantiePart3.this, activiteit_overzicht.class);
                startActivity(intent);

                overridePendingTransition(R.anim.right_in, R.anim.left_out);
            }
        });
    }


    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.back, menu);
        return true;
    }
    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        int id = item.getItemId();
        if (id == R.id.backMenu) {
            Intent intent1 = new Intent(this, navBarMainScreen.class);
            startActivity(intent1);

            overridePendingTransition(R.anim.left_in, R.anim.right_out);
        }

        return super.onOptionsItemSelected(item);
    }

    public void doorsturenNaarDeel4(){
        Toast.makeText(getApplicationContext(), getString(R.string.loading_message), Toast.LENGTH_SHORT).show();
        Intent in = new Intent(getApplicationContext(),activiteit_overzicht.class);


        /*Bundle extras = getIntent().getExtras();
        if (extras != null) {
            String lidBM = extras.getString("lidVanBondMoyson");
            String BMnr = extras.getString("aansluitingsnr");
            in.putExtra("lidVanBondMoyson", lidBM);
            in.putExtra("aansluitingsnr", BMnr);
        }*/

        extraInformatie = editExtraInformatie.getText().toString();
        if (!TextUtils.isEmpty(extraInformatie)){
            //er zit iets in -> doorgeven
            in.putExtra("extraInformatie", extraInformatie);
        }

        Toast.makeText(getApplicationContext(), getString(R.string.dialog_ingeschreven_melding), Toast.LENGTH_SHORT).show();
        startActivity(in);

        overridePendingTransition(R.anim.right_in, R.anim.left_out);


    }
}
