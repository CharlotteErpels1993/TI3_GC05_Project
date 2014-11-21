package com.hogent.ti3g05.ti3_g05_joetzapp;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.AdapterView;
import android.widget.Button;
import android.widget.Spinner;
import android.widget.Toast;

import com.hogent.ti3g05.ti3_g05_joetzapp.Services.ConnectionDetector;
import com.parse.ParseObject;



public class VormingSignup extends Activity {
    private Button btnInschrijven;
    private Spinner spnDataInschrijven;

    Boolean isInternetPresent = false;
    ConnectionDetector cd;

    private String vormingID;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_vorming_signup);

        spnDataInschrijven = (Spinner) findViewById(R.id.spnDataVorming);

        btnInschrijven = (Button) findViewById(R.id.btnInschrijven);
        btnInschrijven.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                // get Internet status
                isInternetPresent = cd.isConnectingToInternet();
                // check for Internet status

                if (isInternetPresent) {
                    // Internet Connection is Present
                    // make HTTP requests
                    controlerenIngevuld();
                }
                else{
                    // Internet connection is not present
                    // Ask user to connect to Internet
                    Toast.makeText(getApplicationContext(), getString(R.string.error_no_internet), Toast.LENGTH_SHORT).show();
                }

                //Intent in = new Intent(getApplicationContext(),SignUp_deel4.class);
                //startActivity(in);

            }
        });

    }

    public void controlerenIngevuld(){
        if (spnDataInschrijven.getSelectedItem() != null && spnDataInschrijven.getSelectedItemPosition() != AdapterView.INVALID_POSITION){
            //er is een deftige waarde geselecteerd

            //TODO: monitorID ophalen aan de hand van email
            String monitorID = "";

            ParseObject nieuweVorming = new ParseObject("InschrijvingVorming");
            nieuweVorming.put("vorming", vormingID);
            nieuweVorming.put("monitor", monitorID);
            nieuweVorming.put("periode", String.valueOf(spnDataInschrijven.getSelectedItem()) );
            nieuweVorming.saveInBackground();

            Toast.makeText(getApplicationContext(), getString(R.string.dialog_ingeschreven_melding), Toast.LENGTH_SHORT);
            Intent in = new Intent(getApplicationContext(),navBarMainScreen.class);
            startActivity(in);
        }
    }


    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.menu_vorming_signup, menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        // Handle action bar item clicks here. The action bar will
        // automatically handle clicks on the Home/Up button, so long
        // as you specify a parent activity in AndroidManifest.xml.
        int id = item.getItemId();

        //noinspection SimplifiableIfStatement
        if (id == R.id.action_settings) {
            return true;
        }

        return super.onOptionsItemSelected(item);
    }
}
