package com.hogent.ti3g05.ti3_g05_joetzapp;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.InflateException;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.view.animation.Animation;
import android.view.animation.AnimationUtils;
import android.widget.Button;
import android.widget.TextView;
import android.widget.Toast;

import com.parse.ParseUser;

import java.util.Arrays;
import java.util.List;

//Geeft de mogelijkheid om naar de detailpagina van een vorming te gaan
public class VormingDetail extends Activity {
    String titel;
    String locatie;
    String betalingswijze;
    String criteriaDeelnemer;
    String korteBeschrijving;
    String prijs;
    String tips;
    String websiteLocatie;
    String inbegrepenInPrijs;
    String objectId;
    List<String> periodes;

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        final Animation animAlpha = AnimationUtils.loadAnimation(this, R.anim.alpha);

        try
        {
        setContentView(R.layout.vorming_detail);
        }catch (OutOfMemoryError e)
        {
            Intent intent1 = new Intent(this, navBarMainScreen.class);
            intent1.putExtra("naarfrag", "vorming");
            intent1.putExtra("herladen", "nee");
            intent1.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
            Toast.makeText(getApplicationContext(), "Er is iets foutgelopen, onze excuses voor het ongemak.", Toast.LENGTH_SHORT);
            startActivity(intent1);

            overridePendingTransition(R.anim.left_in, R.anim.right_out);
        }
        catch (InflateException ex)
        {

            Intent intent1 = new Intent(this, navBarMainScreen.class);
            intent1.putExtra("naarfrag", "vorming");
            intent1.putExtra("herladen", "nee");
            intent1.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
            Toast.makeText(getApplicationContext(),"Er is iets foutgelopen, onze excuses voor het ongemak.",Toast.LENGTH_SHORT);
            startActivity(intent1);

            overridePendingTransition(R.anim.left_in, R.anim.right_out);
        }

        Intent i = getIntent();
        titel = i.getStringExtra("titel");
        locatie = i.getStringExtra("locatie");
        betalingswijze = i.getStringExtra("betalingswijze");
        criteriaDeelnemer = i.getStringExtra("criteriaDeelnemers");
        korteBeschrijving = i.getStringExtra("korteBeschrijving");
        tips = i.getStringExtra("tips");
        prijs = i.getStringExtra("prijs");
        inbegrepenInPrijs = i.getStringExtra("inbegrepenInPrijs");
        objectId = i.getStringExtra("objectId");
        websiteLocatie = i.getStringExtra("websiteLocatie");
        String[] voorlopigePeriodes = i.getStringArrayExtra("periodes");
        periodes = Arrays.asList(voorlopigePeriodes);

        setTitle(titel);

        TextView txtTitel = (TextView) findViewById(R.id.titelVD);
        TextView txtLocatie = (TextView) findViewById(R.id.locatieVD);
        TextView txtbetalingswijze = (TextView) findViewById(R.id.betalingswijzeVD);
        TextView txtCriteriaDeelnemer = (TextView)findViewById(R.id.criteriaDeelnemerVD);
        TextView txtkorteBeschrijving = (TextView)findViewById(R.id.beschrijvingVD);
        TextView txtTips = (TextView)findViewById(R.id.tipsVD);
        TextView txtPrijs = (TextView) findViewById(R.id.prijs);
        TextView txtInbegrepenInPrijs = (TextView) findViewById(R.id.inbegrepenInPrijs);
        TextView txtWebsite = (TextView) findViewById(R.id.websiteLocatieVD);
        TextView txtPeriodes = (TextView) findViewById(R.id.periodesVD);

        txtTitel.setText(titel);
        txtLocatie.setText(locatie);
        txtbetalingswijze.setText(betalingswijze);
        txtCriteriaDeelnemer.setText(criteriaDeelnemer);
        txtkorteBeschrijving.setText(korteBeschrijving);
        txtTips.setText(tips);
        txtPrijs.setText("€ " + prijs);
        txtInbegrepenInPrijs.setText(inbegrepenInPrijs);
        txtWebsite.setText(websiteLocatie);

        StringBuilder periodesBuilder = new StringBuilder();
        for (String obj : periodes){
            periodesBuilder.append(obj + "\n");
        }
        txtPeriodes.setText(periodesBuilder.toString());

        final Button inschrijven = (Button) findViewById(R.id.btnInschrijvenVorming);

        //Enkel een monitor kan zich inschrijven, anders verberg je de knop
        if(ParseUser.getCurrentUser().get("soort").toString().toLowerCase().equals("administrator"))
        {
            inschrijven.setVisibility(View.GONE);
        }
        else
        {
            inschrijven.setVisibility(View.VISIBLE);
        }

        inschrijven.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                inschrijven.startAnimation(animAlpha);
                //Bij klikken op de knop stuur de gebruiker met de nodige gegevens door naar de inschrijvingpagina
                Intent inte = new Intent(getApplicationContext(), VormingInschrijven.class);
                inte.putExtra("periodes", periodes.toArray(new String[periodes.size()]));
                inte.putExtra("objectId", objectId);
                startActivity(inte);
            }
        });
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.back, menu);
        menu.findItem(R.id.menu_load).setVisible(false);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        int id = item.getItemId();
        if (id == R.id.backMenu) {
            Intent intent1 = new Intent(this, navBarMainScreen.class);
            intent1.putExtra("naarfrag", "vorming");
            intent1.putExtra("herladen", "nee");

            startActivity(intent1);
            overridePendingTransition(R.anim.left_in, R.anim.right_out);
        }

        return super.onOptionsItemSelected(item);
    }

    @Override
    public void onBackPressed() {
        Intent setIntent = new Intent(VormingDetail.this, navBarMainScreen.class);
        setIntent.putExtra("naarfrag","vorming");
        setIntent.putExtra("herladen","nee");
        setIntent.addCategory(Intent.CATEGORY_HOME);
        setIntent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
        startActivity(setIntent);
    }

}