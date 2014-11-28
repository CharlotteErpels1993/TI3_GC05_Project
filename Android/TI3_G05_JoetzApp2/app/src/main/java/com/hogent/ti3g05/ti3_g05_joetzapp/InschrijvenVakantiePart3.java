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
import com.parse.ParseQuery;
import com.parse.ParseUser;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;


public class InschrijvenVakantiePart3 extends Activity {

    private EditText editExtraInformatie;

    private String extraInformatie;

    private List<ParseObject> ob2;

    private List<ParseObject> ob;
    private List<ParseObject> ob3;
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

        String dag = null, maand = null, jaar = null, voornaam = null, naam = null, straat = null, huisnr = null, bus = null, gemeente = null, postcode = null,
                voornaamCP = null, naamCP = null, telefoonCP = null, gsmCP = null, objectId = null,
                voornaamCPextra = null, naamCPextra = null, telefoonCPextra = null, gsmCPextra = null;
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
            voornaamCPextra = extras.getString("voornaamCPExtra");
            naamCPextra = extras.getString("naamCPExtra");
            telefoonCPextra = extras.getString("telefoonCPExtra");
            gsmCPextra = extras.getString("gsmCPExtra");
        }

        extraInformatie = editExtraInformatie.getText().toString();

        if (inschrijvingOpslaan(objectId, voornaam, naam, straat, huisnr,  bus, gemeente, postcode, voornaamCP, naamCP, telefoonCP, gsmCP,voornaamCPextra, naamCPextra, telefoonCPextra, gsmCPextra, extraInformatie, jaar)){
            Toast.makeText(getApplicationContext(), getString(R.string.dialog_ingeschreven_melding), Toast.LENGTH_LONG).show();
            startActivity(in);

            overridePendingTransition(R.anim.right_in, R.anim.left_out);
        }else{
            Toast.makeText(getApplicationContext(), "Er is een fout opgetreden. Onze excuses voor het ongemak.", Toast.LENGTH_SHORT).show();
        }

    }

    public boolean inschrijvingOpslaan(String activiteitID, String voornaam, String naam, String straat, String huisnr, String bus, String gemeente, String postcode,
                                    String voornaamCP, String naamCP, String telefoonCP, String gsmCP,
                                    String voornaamCPextra, String naamCPextra, String telefoonCPextra, String gsmCPextra, String extraInfo,  String jaar){
        String ouderID;
        ouderID = objectIDvanOuderOphalen();
        if (ouderID == null)
            return false;

        SimpleDateFormat formatter = new SimpleDateFormat("MMM dd, yyyy");
        Date date = null;
        try {
            date = formatter.parse(jaar);
        } catch (ParseException e) {
            Toast.makeText(InschrijvenVakantiePart3.this, "Fout bij datum omzetten",Toast.LENGTH_SHORT).show();
        }
        try{

           String deelnemerId = null;
            String contactpersoonId = null;

                ParseQuery<ParseObject> querry = new ParseQuery<ParseObject>(
                        "Deelnemer");

                querry.orderByAscending("naam");
                ob = querry.find();
                for (ParseObject deelnemer : ob) {
                    if (deelnemer.get("naam").equals(naam) && deelnemer.get("voornaam").equals(voornaam)) {
                        deelnemerId = deelnemer.getObjectId();

                        Toast.makeText(InschrijvenVakantiePart3.this, deelnemerId, Toast.LENGTH_LONG).show();
                        //inscchrijvingVakantie = (String) deelnemer.get("inschrijvingVakantie");

                        //wordt opgevuld
                    }

                }


                ParseQuery<ParseObject> queryV = new ParseQuery<ParseObject>(
                        "ContactpersoonNood");

                queryV.orderByAscending("naam");
                ob2 = queryV.find();
                for (ParseObject contactp : ob2) {
                    if (contactp.get("naam").equals(naamCP) && contactp.get("voornaam").equals(voornaamCP)) {
                        //Toast.makeText(InschrijvenVakantiePart3.this, "U heeft zich al ingeschreven voor deze vorming.", Toast.LENGTH_LONG).show();
                        //return false;

                        contactpersoonId = contactp.getObjectId();
                        Toast.makeText(InschrijvenVakantiePart3.this, contactpersoonId, Toast.LENGTH_LONG).show();

                        //wordt opgevuld

                    }

                }
            ParseQuery<ParseObject> queryI = new ParseQuery<ParseObject>(
                    "InschrijvingVakantie");

            ob3 = queryI.find();
            for (ParseObject inschrijving : ob3) {
                if (inschrijving.get("contactpersoon1").equals(contactpersoonId) && inschrijving.get("deelnemer").equals(deelnemerId) && inschrijving.get("vakantie").equals(activiteitID)) {
                    Toast.makeText(InschrijvenVakantiePart3.this, "U heeft zich al ingeschreven voor deze vorming.", Toast.LENGTH_LONG).show();
                    return false;

                }

            }


            ParseObject contactPers = new ParseObject("ContactpersoonNood");
            ParseObject inschrijving = new ParseObject("InschrijvingVakantie");
            ParseObject deeln = new ParseObject("Deelnemer");

            ParseObject deelnExtra = new ParseObject("ContactpersoonNood");
            if(gsmCPextra != null){
                deelnExtra.put("voornaam" , voornaamCPextra);
                deelnExtra.put("naam" , naamCPextra);
                deelnExtra.put("telefoon" , telefoonCPextra);
                deelnExtra.put("gsm" , gsmCPextra);
                deelnExtra.save();
            }


            contactPers.put("voornaam" , voornaamCP);
            contactPers.put("naam" , naamCP);
            contactPers.put("telefoon" , telefoonCP);
            contactPers.put("gsm" , gsmCP);
            //contactPers.put("inschrijvingVakantie", inschrijving.getObjectId());
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
            //deeln.put("inschrijvingVakantie", inschrijving.getObjectId());
            deeln.save();

            inschrijving.put("vakantie", activiteitID);
            inschrijving.put("extraInformatie" , extraInfo);
            inschrijving.put("contactpersoon1", contactPers.getObjectId());
            inschrijving.put("ouder", ouderID);
            if (gsmCPextra != null)
                inschrijving.put("contactpersoon2", deelnExtra.getObjectId());
            inschrijving.put("deelnemer", deeln.getObjectId());
            inschrijving.saveInBackground(); //thread hoeft niet te wachten op het opslaan van Inschrijving object, op de rest wel

            return true;
        }
        catch(Exception e){
            return false;
        }

    }

    public String objectIDvanOuderOphalen(){
        String emailToLookFor = ParseUser.getCurrentUser().getEmail();
        ParseQuery<ParseObject> query = ParseQuery.getQuery("Ouder");
        query.whereEqualTo("email", emailToLookFor);
        try{
            List<ParseObject> lijstObjecten = query.find();
            if (lijstObjecten.size() != 1){
                return null;
            }
            else{//er is slechts 1 gebruiker in de Monitor tabel, zoals het hoort.
                return lijstObjecten.get(0).getObjectId();
            }
        }
        catch(com.parse.ParseException e){
            return null;
        }
    }


}
