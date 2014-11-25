package com.hogent.ti3g05.ti3_g05_joetzapp;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.Spinner;
import android.widget.Toast;

import com.hogent.ti3g05.ti3_g05_joetzapp.Services.ConnectionDetector;
import com.parse.ParseException;
import com.parse.ParseObject;
import com.parse.ParseQuery;
import com.parse.ParseUser;

import java.util.Arrays;
import java.util.List;


public class VormingSignup extends Activity {
    private Button btnInschrijven;
    private Spinner spnDataInschrijven;

    Boolean isInternetPresent = false;
    ConnectionDetector cd;
    private List<String> periodes;

    private String vormingID;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_vorming_signup);
        cd = new ConnectionDetector(getApplicationContext());

        spnDataInschrijven = (Spinner) findViewById(R.id.spnDataVorming);

        Intent i = getIntent();
        String[] voorlopigePeriodes = i.getStringArrayExtra("periodes");
        periodes = Arrays.asList(voorlopigePeriodes);
        vormingID = i.getStringExtra("objectId");

        ArrayAdapter<String> dataAdapter = new ArrayAdapter<String>(this, android.R.layout.simple_spinner_item, periodes);
        dataAdapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
        spnDataInschrijven.setAdapter(dataAdapter);

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
                    opslaanGegevens();
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

    public void opslaanGegevens(){
        //3 gegevens nodig, objectID van Monitor, objectID van Vorming & geselecteerde data.
        String emailToLookFor = ParseUser.getCurrentUser().getEmail();
        ParseQuery<ParseObject> query = ParseQuery.getQuery("Monitor");
        query.whereEqualTo("email", emailToLookFor);
        try{
            List<ParseObject> lijstObjecten = query.find();
            if (lijstObjecten.size() != 1){
                Toast.makeText(getApplicationContext(), "Er is iets fout gelopen. Onze excuses voor het ongemak.", Toast.LENGTH_SHORT).show();
            }
            else{//er is slechts 1 gebruiker in de Monitor tabel, zoals het hoort.
                String monitorID = lijstObjecten.get(0).getObjectId();
                ParseObject nieuweVorming = new ParseObject("InschrijvingVorming");
                nieuweVorming.put("vorming", vormingID);
                nieuweVorming.put("monitor", monitorID);
                nieuweVorming.put("periode", String.valueOf(spnDataInschrijven.getSelectedItem()) );
                nieuweVorming.saveInBackground();

                Toast.makeText(getApplicationContext(), getString(R.string.dialog_ingeschreven_melding), Toast.LENGTH_SHORT).show();
                Intent in = new Intent(getApplicationContext(),navBarMainScreen.class);
                startActivity(in);
            }
        }
        catch(ParseException e){
            Toast.makeText(getApplicationContext(), "Er is iets fout gelopen. Onze excuses voor het ongemak.", Toast.LENGTH_SHORT).show();
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
