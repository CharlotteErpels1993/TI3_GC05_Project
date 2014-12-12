package com.hogent.ti3g05.ti3_g05_joetzapp;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.Spinner;
import android.widget.Toast;

import com.hogent.ti3g05.ti3_g05_joetzapp.Services.ConnectionDetector;
import com.parse.ParseObject;
import com.parse.ParseQuery;
import com.parse.ParseUser;

import java.util.Arrays;
import java.util.List;

public class VormingSignup extends Activity {
    private Spinner spnDataInschrijven;

    private ConnectionDetector cd;
    private Boolean isInternetPresent = false;

    private String vormingID;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_vorming_signup);
        cd = new ConnectionDetector(getApplicationContext());

        getActionBar().setTitle(getString(R.string.maintitle_Inschrijven_Vorming));

        Intent i = getIntent();
        String[] voorlopigePeriodes = i.getStringArrayExtra("periodes");
        List<String> periodes = Arrays.asList(voorlopigePeriodes);
        vormingID = i.getStringExtra("objectId");

        ArrayAdapter<String> dataAdapter = new ArrayAdapter<String>(this, android.R.layout.simple_spinner_item, periodes);
        dataAdapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
        spnDataInschrijven = (Spinner) findViewById(R.id.spnDataVorming);
        spnDataInschrijven.setAdapter(dataAdapter);

        Button btnInschrijven = (Button) findViewById(R.id.btnInschrijven);
        btnInschrijven.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                // get Internet status
                isInternetPresent = cd.isConnectingToInternet();
                // check for Internet status

                if (isInternetPresent) {
                    // Internet Connection is Present
                    // make HTTP requests
                    if(opslaanGegevens())
                    {
                        Toast.makeText(getApplicationContext(), getString(R.string.dialog_ingeschreven_melding), Toast.LENGTH_SHORT).show();
                        Intent in = new Intent(getApplicationContext(),navBarMainScreen.class);
                        //TODO: gebruiker doorsturen naar Vormingen i p v Vakanties
                        startActivity(in);
                    }
                }
                else{
                    // Internet connection is not present
                    // Ask user to connect to Internet
                    Toast.makeText(getApplicationContext(), getString(R.string.error_no_internet), Toast.LENGTH_SHORT).show();
                }
            }
        });

    }

    //alle gegevens worden opgeslagen en doorgestuurd naar de DB.
    // Indien alles is gelukt -> return true en ga door naar volgend scherm Indien er een fout is gebeurd -> return false;
    public boolean opslaanGegevens(){
        //3 gegevens nodig, objectID van Monitor, objectID van Vorming & geselecteerde data.
        String geselecteerdeData = String.valueOf(spnDataInschrijven.getSelectedItem());
        String monitorId;
        //vormingID werd in OnCreate reeds gedefinieerd

        String emailToLookFor = ParseUser.getCurrentUser().getEmail();
        try{
            ParseQuery<ParseObject> queryVanMonitor = ParseQuery.getQuery("Monitor");
            queryVanMonitor.whereEqualTo("email", emailToLookFor);
            List<ParseObject> lijstObjecten = queryVanMonitor.find();
            if (lijstObjecten.isEmpty()){
                Toast.makeText(getApplicationContext(), getString(R.string.error_generalException), Toast.LENGTH_SHORT).show();
                return false;
            }
            else{//er is slechts 1 gebruiker in de Monitor tabel, zoals het hoort.
                monitorId = lijstObjecten.get(0).getObjectId();
            }

            ParseQuery<ParseObject> queryVanInschrijvingen = new ParseQuery<ParseObject>("InschrijvingVorming");
            queryVanInschrijvingen.whereEqualTo("monitor", monitorId);
            queryVanInschrijvingen.whereEqualTo("vorming", vormingID);
            queryVanInschrijvingen.whereEqualTo("periode", geselecteerdeData);
            List<ParseObject> lijstInschrijvingVormingen = queryVanInschrijvingen.find();
            if (lijstInschrijvingVormingen.size() > 0){
                //de combinatie van een gelijke monitorID, vormingID en periode zorgt voor een error
                Toast.makeText(VormingSignup.this, getString(R.string.error_duplicateSignupVorming) , Toast.LENGTH_LONG).show();
                return false;
            }

            ParseObject nieuweVorming = new ParseObject("InschrijvingVorming");
            nieuweVorming.put("vorming", vormingID);
            nieuweVorming.put("monitor", monitorId);
            nieuweVorming.put("periode", geselecteerdeData );
            nieuweVorming.saveInBackground();
            return true;
        }
        catch(Exception e){
            Toast.makeText(this,getString(R.string.error_generalException),Toast.LENGTH_LONG).show();
        }

        return false;
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
            intent1.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
            startActivity(intent1);

            overridePendingTransition(R.anim.left_in, R.anim.right_out);
        }

        return super.onOptionsItemSelected(item);
    }


}
