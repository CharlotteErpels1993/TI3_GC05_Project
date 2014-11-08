package com.hogent.ti3g05.ti3_g05_joetzapp;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.view.animation.Animation;
import android.view.animation.AnimationUtils;
import android.widget.Button;
import android.widget.ImageButton;
import android.widget.ImageView;
import android.widget.TextView;

public class activiteit_detail extends Activity {
    String naam;
    String locatie;
    String vertrekdatum;
    String terugdatum;
    String formule;
    String maxDeeln;
    String periode;
    String vervoer;
    String prijs;
    String beschrijving;
    ImageLoader imageLoader = new ImageLoader(this);
    String afbeelding1;
    String doelgro;
    String afbeelding2;
    String afbeelding3;

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activiteit_detailnieuw);

        final Button buttonFadeIn = (Button)findViewById(R.id.fadein);


        Button buttonFadeOut = (Button)findViewById(R.id.fadeout);

        Intent i = getIntent();
        naam = i.getStringExtra("naam");
        locatie = i.getStringExtra("locatie");
        vertrekdatum = i.getStringExtra("vertrekdatum");
        terugdatum = i.getStringExtra("terugdatum");
        afbeelding1 = i.getStringExtra("afbeelding1");
        doelgro = i.getStringExtra("doelgroep");
        afbeelding2 = i.getStringExtra("afbeelding2");

        afbeelding3 = i.getStringExtra("afbeelding3");

        formule = i.getStringExtra("formule");
         maxDeeln = i.getStringExtra("maxAantalDeelnemers");
         periode = i.getStringExtra("periode");
         vervoer = i.getStringExtra("vervoer");
         prijs = i.getStringExtra("prijs");
        beschrijving = i.getStringExtra("beschrijving");

        setTitle(naam);

        TextView txtNaam = (TextView) findViewById(R.id.titel);
        final TextView txtLocatie = (TextView) findViewById(R.id.locatiev);
        final TextView txtDoelgr = (TextView) findViewById(R.id.doelgroepv);

        final TextView txtformule = (TextView)findViewById(R.id.formule);
        TextView txtmaxDeeln = (TextView)findViewById(R.id.maxDeelnemers);
        final TextView txtPeriode = (TextView)findViewById(R.id.periode);
        final TextView txtVervoer = (TextView)findViewById(R.id.vervoer);
        TextView txtPrijs = (TextView)findViewById(R.id.prijs);
        TextView txtBeschrijving = (TextView)findViewById(R.id.beschrijving);

        ImageView afbeelding1im = (ImageView) findViewById(R.id.afbeelding1);
        ImageView afbeelding2im = (ImageView) findViewById(R.id.afbeelding2);

        ImageView afbeelding3im = (ImageView) findViewById(R.id.afbeelding3);

        afbeelding1im.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Intent intent1 = new Intent(activiteit_detail.this, afbeeldingUItvergroot.class);

                intent1.putExtra("afbeelding", afbeelding1);
                startActivity(intent1);

                overridePendingTransition(R.anim.right_in, R.anim.left_out);
            }
        });
        afbeelding2im.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Intent intent1 = new Intent(activiteit_detail.this, afbeeldingUItvergroot.class);

                intent1.putExtra("afbeelding",afbeelding2);
                startActivity(intent1);

                overridePendingTransition(R.anim.right_in, R.anim.left_out);
            }
        });

        afbeelding3im.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Intent intent1 = new Intent(activiteit_detail.this, afbeeldingUItvergroot.class);

                intent1.putExtra("afbeelding",afbeelding3);
                startActivity(intent1);

                overridePendingTransition(R.anim.right_in, R.anim.left_out);
            }
        });



        txtNaam.setText(naam);
        txtLocatie.setText(locatie);
        txtDoelgr.setText(doelgro);
        txtformule.setText(formule);
        //txtmaxDeeln.setText(maxDeeln.toString());
        txtPeriode.setText(periode);
        txtVervoer.setText(vervoer);
        //txtPrijs.setText(prijs.toString());
        txtBeschrijving.setText(beschrijving);

        // Capture position and set results to the ImageView
        // Passes flag images URL into ImageLoader.class
        imageLoader.DisplayImage(afbeelding1, afbeelding1im);
        imageLoader.DisplayImage(afbeelding2, afbeelding2im);
        imageLoader.DisplayImage(afbeelding3, afbeelding3im);

    }
}