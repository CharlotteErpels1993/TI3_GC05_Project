package com.hogent.ti3g05.ti3_g05_joetzapp;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.support.v4.app.DialogFragment;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.view.animation.Animation;
import android.view.animation.AnimationUtils;
import android.widget.Button;
import android.widget.ImageButton;
import android.widget.ImageView;
import android.widget.TextView;

import com.hogent.ti3g05.ti3_g05_joetzapp.domein.InschrijvingVorming;

public class VormingDetail extends Activity {
    String titel;
    String locatie;
    String betalingswijze;
    String criteriaDeelnemer;
    String korteBeschrijving;
    String periodes;
    String prijs;
    String tips;
    String websiteLocatie;
    private Button inschrijven;

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.vorming_detail);


        Intent i = getIntent();
        titel = i.getStringExtra("titel");
        locatie = i.getStringExtra("locatie");
        betalingswijze = i.getStringExtra("betalingsWijze");
        criteriaDeelnemer = i.getStringExtra("criteriaDeelnemer");
        korteBeschrijving = i.getStringExtra("korteBeschrijving");
       // periodes = i.getStringExtra("periodes");
        tips = i.getStringExtra("tips");

        websiteLocatie = i.getStringExtra("websiteLocatie");

        setTitle(titel);

        TextView txtTitel = (TextView) findViewById(R.id.titelVD);
        final TextView txtLocatie = (TextView) findViewById(R.id.locatieVD);
        final TextView txtbetalingswijze = (TextView) findViewById(R.id.betalingswijzeVD);

        final TextView txtCriteriaDeelnemer = (TextView)findViewById(R.id.criteriaDeelnemerVD);
        TextView txtkorteBeschrijving = (TextView)findViewById(R.id.beschrijvingVD);
        final TextView txtTips = (TextView)findViewById(R.id.tipsVD);


        txtTitel.setText(titel);
        txtLocatie.setText(locatie);
        txtbetalingswijze.setText(betalingswijze);
        txtCriteriaDeelnemer.setText(criteriaDeelnemer);
        //txtmaxDeeln.setText(maxDeeln.toString());
        txtkorteBeschrijving.setText(korteBeschrijving);
        txtTips.setText(tips);
        //txtPrijs.setText(prijs.toString());
        inschrijven = (Button) findViewById(R.id.btnInschrijven);
        inschrijven.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Intent inte = new Intent(getApplicationContext(), InschrijvingVorming.class);
                startActivity(inte);
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
            Intent intent1 = new Intent(this, Vormingen_Overzicht.class);
            startActivity(intent1);

            overridePendingTransition(R.anim.left_in, R.anim.right_out);
        }

        return super.onOptionsItemSelected(item);
    }

}