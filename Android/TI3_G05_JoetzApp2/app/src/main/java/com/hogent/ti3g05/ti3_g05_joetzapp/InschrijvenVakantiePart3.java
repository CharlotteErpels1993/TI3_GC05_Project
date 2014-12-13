package com.hogent.ti3g05.ti3_g05_joetzapp;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.view.animation.Animation;
import android.view.animation.AnimationUtils;
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
    private EditText et_ExtraInformatie;

    private Boolean isInternetPresent = false;
    private ConnectionDetector cd;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_inschrijven_vakantie_part3);
        cd = new ConnectionDetector(getApplicationContext());

        getActionBar().setTitle("Inschrijven vakantie");
        et_ExtraInformatie = (EditText) findViewById(R.id.ExtraInformatieIns);

        final Animation animAlpha = AnimationUtils.loadAnimation(this, R.anim.alpha);

        final Button btnVolgende = (Button)findViewById(R.id.btnNaarDeel4V);
        btnVolgende.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                btnVolgende.startAnimation(animAlpha);
                //Controleer of er verbinding is met het internet, zoja haal alle gegevens op van de vorige stappen
                isInternetPresent = cd.isConnectingToInternet();

                if (isInternetPresent) {
                    slaGegevensOp();
                }
                else{
                    Toast.makeText(getApplicationContext(), getString(R.string.error_no_internet), Toast.LENGTH_SHORT).show();
                }
            }
        });

    }

    //Haal de gegevens op uit de vorige stappen
    public void slaGegevensOp(){
        Toast.makeText(getApplicationContext(), getString(R.string.loading_message), Toast.LENGTH_SHORT).show();


        String datum = null, voornaam = null, naam = null, straat = null, huisnr = null, bus = null, gemeente = null, postcode = null,
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
            datum = extras.getString("datum");

            voornaamCP = extras.getString("voornaamCP");
            naamCP = extras.getString("naamCP");
            telefoonCP = extras.getString("telefoonCP");
            gsmCP = extras.getString("gsmCP");
            voornaamCPextra = extras.getString("voornaamCPExtra");
            naamCPextra = extras.getString("naamCPExtra");
            telefoonCPextra = extras.getString("telefoonCPExtra");
            gsmCPextra = extras.getString("gsmCPExtra");
        }

        String extraInformatie = et_ExtraInformatie.getText().toString();

        inschrijvingOpslaan(objectId, voornaam, naam, straat, huisnr,  bus, gemeente, postcode, voornaamCP, naamCP, telefoonCP, gsmCP,voornaamCPextra, naamCPextra, telefoonCPextra, gsmCPextra, extraInformatie, datum);

    }

    //Sla de gegevens op in de database
    //Controleer ook of deze gebruiker nog niet is ingeschreven voor deze vakantie
    public void inschrijvingOpslaan(String activiteitID, String voornaam, String naam, String straat, String huisnr, String bus, String gemeente, String postcode,
                                    String voornaamCP, String naamCP, String telefoonCP, String gsmCP,
                                    String voornaamCPextra, String naamCPextra, String telefoonCPextra, String gsmCPextra, String extraInfo,  String datum){
        String ouderID = idVanOuderOphalen();
        if (ouderID == null){
            return;
        }

        SimpleDateFormat formatter = new SimpleDateFormat("MMM dd, yyyy");
        Date date = null;
        try {
            date = formatter.parse(datum);
        } catch (ParseException e) {
            Toast.makeText(InschrijvenVakantiePart3.this, "Fout bij datum omzetten",Toast.LENGTH_SHORT).show();
        }
        try{
            ParseObject contactPers = new ParseObject("ContactpersoonNood");
            ParseObject inschrijving = new ParseObject("InschrijvingVakantie");
            ParseObject deeln = new ParseObject("Deelnemer");

            String deelnemerId = null;
            String contactpersoonId = null;
            String vakantieId = null;

                ParseQuery<ParseObject> querry = new ParseQuery<ParseObject>(
                        "Deelnemer");

                querry.orderByAscending("naam");
                List<ParseObject> lijstVdeelnemers = querry.find();
                for (ParseObject deelnemer : lijstVdeelnemers) {
                    if (deelnemer.get("naam").equals(naam) && deelnemer.get("voornaam").equals(voornaam)) {
                        deelnemerId = deelnemer.getObjectId();

                    }

                }
            if(deelnemerId== null)
            {
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

                deelnemerId = deeln.getObjectId();
            }


                ParseQuery<ParseObject> qryContactPersoonInNood = new ParseQuery<ParseObject>(
                        "ContactpersoonNood");

            qryContactPersoonInNood.orderByAscending("naam");
                List<ParseObject> lijstContactPersoonInNood = qryContactPersoonInNood.find();
                for (ParseObject contactp : lijstContactPersoonInNood) {
                    if (contactp.get("naam").equals(naamCP) && contactp.get("voornaam").equals(voornaamCP)) {

                        contactpersoonId = contactp.getObjectId();


                    }

                }
            if(contactpersoonId == null)
            {
                contactPers.put("voornaam" , voornaamCP);
                contactPers.put("naam" , naamCP);
                contactPers.put("telefoon" , telefoonCP);
                contactPers.put("gsm" , gsmCP);
                //contactPers.put("inschrijvingVakantie", inschrijving.getObjectId());
                contactPers.save();

                contactpersoonId = contactPers.getObjectId();

            }
            ParseQuery<ParseObject> queryI = new ParseQuery<ParseObject>(
                    "InschrijvingVakantie");


            List<ParseObject> lijstInschrijvingenVakantie = queryI.find();
            for (ParseObject ins : lijstInschrijvingenVakantie) {
                if (ins.get("contactpersoon1").equals(contactpersoonId) && ins.get("deelnemer").equals(deelnemerId)) {

                    vakantieId =(String) ins.get("vakantie");

                }

            }


            if(vakantieId == null || !vakantieId.equals(activiteitID))
            {
                ParseObject deelnExtra = new ParseObject("ContactpersoonNood");
                if(gsmCPextra != null){
                    deelnExtra.put("voornaam" , voornaamCPextra);
                    deelnExtra.put("naam" , naamCPextra);
                    deelnExtra.put("telefoon" , telefoonCPextra);
                    deelnExtra.put("gsm" , gsmCPextra);
                    deelnExtra.save();
                }
                inschrijving.put("vakantie", activiteitID);
                inschrijving.put("extraInformatie" , extraInfo);
                inschrijving.put("ouder", ouderID);
                inschrijving.put("contactpersoon1", contactpersoonId);
                if (gsmCPextra != null)
                    inschrijving.put("contactpersoon2", deelnExtra.getObjectId());
                inschrijving.put("deelnemer", deelnemerId);
                inschrijving.saveInBackground();

                Intent in = new Intent(getApplicationContext(),navBarMainScreen.class);
                Toast.makeText(getApplicationContext(), getString(R.string.dialog_ingeschreven_melding), Toast.LENGTH_LONG).show();
                startActivity(in);

                overridePendingTransition(R.anim.right_in, R.anim.left_out);
            }
            else
            {
                    Toast.makeText(getApplicationContext(), "U bent al ingeschreven voor deze vakantie", Toast.LENGTH_SHORT).show();

            }

        }
        catch(Exception e){
            Toast.makeText(getApplicationContext(), "Er is een fout opgetreden. Onze excuses voor het ongemak.", Toast.LENGTH_SHORT).show();
        }

    }

    //haal de id op van de ouder
    public String idVanOuderOphalen(){
        String emailToLookFor = ParseUser.getCurrentUser().getEmail();
        ParseQuery<ParseObject> query = ParseQuery.getQuery("Ouder");
        query.whereEqualTo("email", emailToLookFor);

        try{
            List<ParseObject> lijstOuders = query.find();
            if (lijstOuders.size() != 1){
                Toast.makeText(getApplicationContext(), "Er is iets fout gelopen. Onze excuses voor het ongemak.", Toast.LENGTH_SHORT).show();
                return null;
            }
            else{
                return lijstOuders.get(0).getObjectId();

            }
        }
        catch(com.parse.ParseException e){
            return null;

        }

    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        getMenuInflater().inflate(R.menu.back_2, menu);
        return true;
    }
    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        int id = item.getItemId();
        if (id == R.id.backMenu2) {
            Intent intent1 = new Intent(this, navBarMainScreen.class);
            startActivity(intent1);

            overridePendingTransition(R.anim.left_in, R.anim.right_out);
        }

        return super.onOptionsItemSelected(item);
    }


}
