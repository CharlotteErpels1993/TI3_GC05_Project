package com.hogent.ti3g05.ti3_g05_joetzapp;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.widget.TextView;

public class activiteit_detail extends Activity {
    String naam;
    String locatie;
    String vertrekdatum;
    String terugdatum;
    //ImageLoader imageLoader = new ImageLoader(this);

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activiteit_detailnieuw);

        Intent i = getIntent();
        naam = i.getStringExtra("naam");
        locatie = i.getStringExtra("locatie");
        vertrekdatum = i.getStringExtra("vertrekdatum");
        terugdatum = i.getStringExtra("terugdatum");
       // flag = i.getStringExtra("flag");

        TextView txtNaam = (TextView) findViewById(R.id.naam);
        TextView txtLocatie = (TextView) findViewById(R.id.loc);
        TextView txtVertrekdatum = (TextView) findViewById(R.id.vertrek);
        TextView txtTerugdatum = (TextView) findViewById(R.id.terug);

        //ImageView imgflag = (ImageView) findViewById(R.id.flag);

        txtNaam.setText(naam);
        txtLocatie.setText(locatie);
        txtVertrekdatum.setText(vertrekdatum);
        txtTerugdatum.setText(terugdatum);

        // Capture position and set results to the ImageView
        // Passes flag images URL into ImageLoader.class
        //imageLoader.DisplayImage(flag, imgflag);
    }
}