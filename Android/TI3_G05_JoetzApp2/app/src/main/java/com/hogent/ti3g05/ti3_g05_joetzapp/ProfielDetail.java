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

public class ProfielDetail extends Activity {
    String naam;
    String voornaam;
    String straat;
    String huisnr;
    String gemeente;
    String postcode;
    String lidNr;
    String email;
    String gsm;
    String facebook;
    String rijksregisterNr;


    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.profiel_detail);


        Intent i = getIntent();
        naam = i.getStringExtra("naam");
        voornaam = i.getStringExtra("voornaam");
        straat = i.getStringExtra("straat");
        //huisnr = i.getStringExtra("huisnr");
        gemeente = i.getStringExtra("gemeente");
        // periodes = i.getStringExtra("periodes");
        lidNr = i.getStringExtra("lidNr");

        email = i.getStringExtra("email");
        facebook = i.getStringExtra("facebook");
        gsm = i.getStringExtra("gsm");

        rijksregisterNr = i.getStringExtra("rijksregNr");

        setTitle(naam + " " + voornaam);

        TextView txtNaam = (TextView) findViewById(R.id.achternaamP);
        final TextView txtVoornaam = (TextView) findViewById(R.id.voornaamP);
        final TextView txtStraat = (TextView) findViewById(R.id.straatP);
        TextView txtEmail = (TextView) findViewById(R.id.emailP);

        final TextView txtGemeente = (TextView)findViewById(R.id.gemeenteP);
        TextView txtLidNr = (TextView)findViewById(R.id.lidNr);
        TextView txtFacebook = (TextView)findViewById(R.id.facebookL);
        final TextView txtGsm = (TextView)findViewById(R.id.gsmP);
        final TextView txtRijksregNr = (TextView)findViewById(R.id.RijksRegNrP);


        txtNaam.setText(naam);
        txtVoornaam.setText(voornaam);
        txtStraat.setText(straat);
        txtGemeente.setText(gemeente);
        txtEmail.setText(email);
        //txtmaxDeeln.setText(maxDeeln.toString());
        //txtLidNr.setText(lidNr);
        txtFacebook.setText(facebook);
        txtGsm.setText(gsm);
        txtRijksregNr.setText(rijksregisterNr);
        //txtPrijs.setText(prijs.toString());

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
            Intent intent1 = new Intent(this, ProfielenOverzicht.class);
            startActivity(intent1);

            overridePendingTransition(R.anim.left_in, R.anim.right_out);
        }

        return super.onOptionsItemSelected(item);
    }

}