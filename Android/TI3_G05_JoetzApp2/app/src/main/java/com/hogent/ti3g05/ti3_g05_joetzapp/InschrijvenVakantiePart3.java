package com.hogent.ti3g05.ti3_g05_joetzapp;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;

import com.hogent.ti3g05.ti3_g05_joetzapp.Services.ConnectionDetector;
import com.parse.ParseObject;
import com.parse.ParseUser;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.Locale;


public class InschrijvenVakantiePart3 extends Activity {

    private EditText editExtraInformatie;

    private String extraInformatie;

    private Button btnVolgende;

    // flag for Internet connection status
    Boolean isInternetPresent = false;
    // Connection detector class
    ConnectionDetector cd;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_inschrijven_vakantie_part3);
        cd = new ConnectionDetector(getApplicationContext());

        editExtraInformatie = (EditText) findViewById(R.id.ExtraInformatie);

        btnVolgende = (Button)findViewById(R.id.btnNaarDeel4V);
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
        Intent in = new Intent(getApplicationContext(),navBarMainScreen.class);

        String dag = null, maand = null, jaar = null, voornaam = null, naam = null, straat = null, huisnr = null, bus = null, gemeente = null, postcode = null, voornaamCP = null, naamCP = null, telefoonCP = null, gsmCP = null, objectId = null;
        Bundle extras = getIntent().getExtras();
        if (extras != null) {
            objectId = extras.getString("objectId");
            voornaam = extras.getString("voornaam");
            naam = extras.getString("naam");
            straat = extras.getString("straat");
            huisnr = extras.getString("huisnr");
            bus = extras.getString("bus");
            gemeente = extras.getString("gemeente");
            postcode = extras.getString("postcode");
            jaar = extras.getString("jaar");

            voornaamCP = extras.getString("voornaamCP");
            naamCP = extras.getString("naamCP");
            telefoonCP = extras.getString("telefoonCP");
            gsmCP = extras.getString("gsmCP");
        }

        extraInformatie = editExtraInformatie.getText().toString();

        if (inschrijvingOpslaan(objectId, voornaam, naam, straat, huisnr,  bus, gemeente, postcode, voornaamCP, naamCP, telefoonCP, gsmCP, extraInformatie, jaar)){
            Toast.makeText(getApplicationContext(), getString(R.string.dialog_ingeschreven_melding), Toast.LENGTH_LONG).show();
            startActivity(in);

            overridePendingTransition(R.anim.right_in, R.anim.left_out);
        }else{
            Toast.makeText(getApplicationContext(), "Er is een fout opgetreden. Onze excuses voor het ongemak.", Toast.LENGTH_SHORT).show();
        }

    }

    public boolean inschrijvingOpslaan(String activiteitID, String voornaam, String naam, String straat, String huisnr, String bus, String gemeente, String postcode,
                                    String voornaamCP, String naamCP, String telefoonCP, String gsmCP, String extraInfo,  String jaar){

        SimpleDateFormat formatter = new SimpleDateFormat("MMM dd, yyyy");
        Date date = null;
        try {
            date = formatter.parse(jaar);
        } catch (ParseException e) {
            Toast.makeText(InschrijvenVakantiePart3.this, "Fout bij datum omzetten",Toast.LENGTH_SHORT).show();
        }
        try{
            ParseObject contactPers = new ParseObject("ContactpersoonNood");
            ParseObject inschrijving = new ParseObject("InschrijvingVakantie");
            ParseObject deeln = new ParseObject("Deelnemer");

            contactPers.put("voornaam" , voornaamCP);
            contactPers.put("naam" , naamCP);
            contactPers.put("telefoon" , telefoonCP);
            contactPers.put("gsm" , gsmCP);
            contactPers.save();

            //deeln.put("contactPersoonInNood", contactPers.getObjectId());
            deeln.put("voornaam", voornaam);
            deeln.put("naam" , naam);
            deeln.put("straat" , straat);
            deeln.put("nummer" , Integer.parseInt(huisnr));
            deeln.put("bus" , bus);
            deeln.put("gemeente" , gemeente);
            deeln.put("postcode" , Integer.parseInt(postcode));
            deeln.put("geboortedatum", date);
            deeln.save();

            inschrijving.put("deelnemerID", deeln.getObjectId());
            inschrijving.put("contactpersoonID", contactPers.getObjectId());
            inschrijving.put("vakantie", activiteitID);
            inschrijving.put("extraInformatie" , extraInfo);
            inschrijving.save();

            contactPers.put("inschrijvingVakantie", inschrijving.getObjectId());
            contactPers.saveInBackground();
            deeln.put("inschrijvingVakantie", inschrijving.getObjectId());
            deeln.saveInBackground();

            return true;
        }
        catch(Exception e){
            return false;
        }

    }

    @Override
    protected void onDestroy()
    {
        super.onDestroy();
        ParseUser.logOut();
    }
}
