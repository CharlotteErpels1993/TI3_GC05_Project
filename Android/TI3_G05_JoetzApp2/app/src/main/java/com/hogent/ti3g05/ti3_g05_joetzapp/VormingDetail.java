package com.hogent.ti3g05.ti3_g05_joetzapp;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;

import java.util.Arrays;
import java.util.List;

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
    private Button inschrijven;

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.vorming_detail);


        Intent i = getIntent();
        titel = i.getStringExtra("titel");
        locatie = i.getStringExtra("locatie");
        betalingswijze = i.getStringExtra("betalingswijze");
        criteriaDeelnemer = i.getStringExtra("criteriaDeelnemers");
        korteBeschrijving = i.getStringExtra("korteBeschrijving");
       // periodes = i.getStringExtra("periodes");
        tips = i.getStringExtra("tips");
        prijs = i.getStringExtra("prijs");
        inbegrepenInPrijs = i.getStringExtra("inbegrepenInPrijs");
        objectId = i.getStringExtra("objectId");
        websiteLocatie = i.getStringExtra("websiteLocatie");
        String[] voorlopigePeriodes = i.getStringArrayExtra("periodes");
        periodes = Arrays.asList(voorlopigePeriodes);

        setTitle(titel);

        TextView txtTitel = (TextView) findViewById(R.id.titelVD);
        final TextView txtLocatie = (TextView) findViewById(R.id.locatieVD);
        final TextView txtbetalingswijze = (TextView) findViewById(R.id.betalingswijzeVD);
        final TextView txtCriteriaDeelnemer = (TextView)findViewById(R.id.criteriaDeelnemerVD);
        TextView txtkorteBeschrijving = (TextView)findViewById(R.id.beschrijvingVD);
        final TextView txtTips = (TextView)findViewById(R.id.tipsVD);
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
        txtPrijs.setText("€" + prijs);
        txtInbegrepenInPrijs.setText(inbegrepenInPrijs);
        txtWebsite.setText(websiteLocatie);

        StringBuilder periodesBuilder = new StringBuilder();
        periodesBuilder.append(getString(R.string.periode) + ": ");
        for (String obj : periodes){
            periodesBuilder.append("\n" + obj);
        }
        txtPeriodes.setText(periodesBuilder.toString());

        inschrijven = (Button) findViewById(R.id.btnInschrijvenVorming);
        inschrijven.setTextColor(getResources().getColor(R.color.Rood));
        inschrijven.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Intent inte = new Intent(getApplicationContext(), VormingSignup.class);
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

            startActivity(intent1);
            overridePendingTransition(R.anim.left_in, R.anim.right_out);
        }

        return super.onOptionsItemSelected(item);
    }

}