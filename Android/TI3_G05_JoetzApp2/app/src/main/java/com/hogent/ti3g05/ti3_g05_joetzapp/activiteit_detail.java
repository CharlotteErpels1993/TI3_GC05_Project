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
import android.widget.RelativeLayout;
import android.widget.TextView;
import android.widget.Toast;

import com.parse.ParseUser;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.logging.Handler;

//ingelogde gebr:      titel, korte beschr, periode, locatie, inbegrepen in prijs, doelgroep (met geboortejaren), max aantal deelnemers,
//                     vervoerswijze, formule, prijs (basisprijs, BM prijs & sterprijs) kortingen, gegevens contactpersoon inschrijving & algemene voorwaarden
//niet-ingelogde gebr: titel, korte beschr, periode, locatie, inbegrepen in prijs, doelgroep (met geboortejaren), max aantal deelnemers

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
    String bmLedenPrijs;
    String sterPrijs1Ouder;
    String sterPrijs2Ouders;
    String inbegrepenInPrijs;

    private boolean isIngelogd;

    Button btnInschrijven;
    Button btnmeerInfo;
    Button btnminderInfo;

    //TODO bij doelgroepen moet er volgens de UC ook nog de geboortejaren bij komen -> methode voor maken om dat te berekenen
    //TODO algemene voorwaarden onderaan bijzetten -> string resource, kopieren van JOETZ
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activiteit_detailnieuw);

        if (ParseUser.getCurrentUser() != null){
            //gebruiker is ingelogd
            isIngelogd = true;
        }else{
            //niet ingelogd
            isIngelogd = false;
        }

        Intent i = getIntent();
        naam = i.getStringExtra("naam");
        locatie = i.getStringExtra("locatie");
        vertrekdatum = i.getStringExtra("vertrekdatum");
        terugdatum = i.getStringExtra("terugdatum");
        doelgro = i.getStringExtra("doelgroep");
        afbeelding1 = i.getStringExtra("afbeelding1");
        afbeelding2 = i.getStringExtra("afbeelding2");
        afbeelding3 = i.getStringExtra("afbeelding3");
        formule = i.getStringExtra("formule");
        maxDeeln = i.getStringExtra("maxAantalDeelnemers");
        periode = i.getStringExtra("periode");
        vervoer = i.getStringExtra("vervoer");
        beschrijving = i.getStringExtra("beschrijving");
        inbegrepenInPrijs = i.getStringExtra("InbegrepenInPrijs");



        setTitle(naam);

        final TextView txtNaam = (TextView) findViewById(R.id.titel);
        final TextView txtLocatie = (TextView) findViewById(R.id.locatiev);
        final TextView txtDoelgr = (TextView) findViewById(R.id.doelgroepv);
        final TextView txtformule = (TextView)findViewById(R.id.formule);
        final TextView txtmaxDeeln = (TextView)findViewById(R.id.maxDeelnemers);
        final TextView txtPeriode = (TextView)findViewById(R.id.periode);
        final TextView txtVervoer = (TextView)findViewById(R.id.vervoer);
        final TextView txtPrijs = (TextView)findViewById(R.id.basisprijs);
        final TextView txtBeschrijving = (TextView)findViewById(R.id.beschrijving);
        final TextView txtVertrekDatum = (TextView) findViewById(R.id.vertrekdatum);
        final TextView txtTerugkeerDatum = (TextView) findViewById(R.id.terugkeerdatum);
        final TextView txtInbegrepenInPrijs = (TextView) findViewById(R.id.inbegrepenInPrijs);
        final TextView txtBMledenPrijs = (TextView) findViewById(R.id.bondMoysonLedenPrijs);
        final TextView txtSterPrijs1Ouder = (TextView) findViewById(R.id.sterPrijs1Ouder);
        final TextView txtSterPrijs2Ouders = (TextView) findViewById(R.id.sterPrijs2Ouders);
        final RelativeLayout verberg = (RelativeLayout) findViewById(R.id.verberg2);

        btnInschrijven = (Button)findViewById(R.id.btnInschrijvenV);
        btnmeerInfo = (Button) findViewById(R.id.btnMeerInfo);
        btnminderInfo = (Button) findViewById(R.id.btnMinderInfo);

        btnminderInfo.setVisibility(View.GONE);

        ImageView afbeelding1im = (ImageView) findViewById(R.id.afbeelding1);
        ImageView afbeelding2im = (ImageView) findViewById(R.id.afbeelding2);

        ImageView afbeelding3im = (ImageView) findViewById(R.id.afbeelding3);

        btnInschrijven.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Intent intent3 = new Intent(activiteit_detail.this, InschrijvenVakantiePart1.class);
                startActivity(intent3);

                overridePendingTransition(R.anim.right_in, R.anim.left_out);
            }
        });


        final Animation fadeInAnimation = AnimationUtils.loadAnimation(this, R.anim.fadein);

        final Animation fadeOutAnimation = AnimationUtils.loadAnimation(this, R.anim.fadeout);

        btnmeerInfo.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {

                btnmeerInfo.setVisibility(View.GONE);
                verberg.startAnimation(fadeInAnimation);
                verberg.setVisibility(View.VISIBLE);
                btnminderInfo.setVisibility(View.VISIBLE);
            }
        });

        btnminderInfo.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                fadeOutAnimation.setAnimationListener(new Animation.AnimationListener() {
                    @Override
                    public void onAnimationStart(Animation animation) {

                    }

                    @Override
                    public void onAnimationEnd(Animation animation) {

                        verberg.setVisibility(View.GONE);
                    }

                    @Override
                    public void onAnimationRepeat(Animation animation) {

                    }
                });

                verberg.startAnimation(fadeOutAnimation);
                btnminderInfo.startAnimation(fadeOutAnimation);
                btnminderInfo.setVisibility(View.GONE);
                btnmeerInfo.startAnimation(fadeInAnimation);
                btnmeerInfo.setVisibility(View.VISIBLE);
            }
        });

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

        //hieronder wordt er een leesbare datum geconverteerd
        try{
            SimpleDateFormat dateFormat = new SimpleDateFormat("EEE MMM d HH:mm:ss zz yyyy");
            Calendar cal = Calendar.getInstance();

            Date vertrDate = dateFormat.parse(vertrekdatum);
            cal.setTime(vertrDate);
            vertrekdatum = cal.get(Calendar.DAY_OF_MONTH) + "/" + cal.get(Calendar.MONTH) + "/" + cal.get(Calendar.YEAR);

            Date terugkDate = dateFormat.parse(terugdatum);
            cal.setTime(terugkDate);
            terugdatum = cal.get(Calendar.DAY_OF_MONTH) + "/" + cal.get(Calendar.MONTH) + "/" + cal.get(Calendar.YEAR);
        }
        catch(java.text.ParseException pe){
            Toast.makeText(getApplicationContext(), pe.getMessage(), Toast.LENGTH_SHORT);
        }


        txtNaam.setText(naam);
        txtLocatie.setText("Locatie: " + locatie);
        txtDoelgr.setText("Doelgroep: " + doelgro);

        txtformule.setText("Formule: " + formule);
        txtmaxDeeln.setText("Maximum aantal deelnemers: " + maxDeeln.toString());
        txtPeriode.setText("Periode: " + periode);
        txtVervoer.setText("Vervoer: " + vervoer);
        txtBeschrijving.setText(beschrijving);
        txtVertrekDatum.setText("Vertrek: " + vertrekdatum);
        txtTerugkeerDatum.setText("Terug: " + terugdatum);
        txtInbegrepenInPrijs.setText("Inbegrepen in de prijs: " + inbegrepenInPrijs);

        if (ParseUser.getCurrentUser() == null){
            //niet ingelogd
            btnInschrijven.setVisibility(View.GONE);
            txtPrijs.setVisibility(View.GONE);
            txtBMledenPrijs.setVisibility(View.GONE);
            txtSterPrijs1Ouder.setVisibility(View.GONE);
            txtSterPrijs2Ouders.setVisibility(View.GONE);
            txtformule.setVisibility(View.GONE);
            txtmaxDeeln.setVisibility(View.GONE);
            txtInbegrepenInPrijs.setVisibility(View.GONE);
            btnmeerInfo.setVisibility(View.GONE);
            verberg.setVisibility(View.GONE);


        }else{
            //ingelogd
            btnInschrijven.setVisibility(View.VISIBLE);
            btnmeerInfo.setVisibility(View.VISIBLE);
            verberg.setVisibility(View.GONE);

            //toon normale prijs
            txtPrijs.setVisibility(View.VISIBLE);
            prijs = i.getStringExtra("prijs");
            txtPrijs.setText("Prijs: €" + prijs);
            if (!(prijs.contains(".") || prijs.contains(","))){
                txtPrijs.append(",00");
            }

            bmLedenPrijs = i.getStringExtra("BMledenPrijs");
            sterPrijs1Ouder = i.getStringExtra("SterPrijs1Ouder");
            sterPrijs2Ouders = i.getStringExtra("SterPrijs2Ouders");


            if (!bmLedenPrijs.equals("-1")) {
                txtBMledenPrijs.setVisibility(View.VISIBLE);
                txtBMledenPrijs.setText("Prijs voor leden van Bond Moyson: €" + bmLedenPrijs);
                if (!(bmLedenPrijs.contains(".") || bmLedenPrijs.contains(","))){
                    txtBMledenPrijs.append(",00");
                }
            }

            if (!sterPrijs1Ouder.equals("-1")) {
                txtSterPrijs1Ouder.setVisibility(View.VISIBLE);
                txtSterPrijs1Ouder.setText("Prijs voor leden waarvan 1 ouder deel is van BM: €" + sterPrijs1Ouder);
                if (!(sterPrijs1Ouder.contains(".") || sterPrijs1Ouder.contains(","))){
                    txtSterPrijs1Ouder.append(",00");
                }
            }

          /*  if (!sterPrijs2Ouders.equals("-1")){
                txtSterPrijs2Ouders.setVisibility(View.VISIBLE);
                txtSterPrijs2Ouders.setText("Prijs voor leden waarvan 2 ouders deel zijn van BM: €" + sterPrijs2Ouders);
                if (!(sterPrijs2Ouders.contains(".") || sterPrijs2Ouders.contains(","))){
                    txtSterPrijs2Ouders.append(",00");
                }
            }*/
        }


        // Capture position and set results to the ImageView
        // Passes flag images URL into ImageLoader.class
        imageLoader.DisplayImage(afbeelding1, afbeelding1im);
        imageLoader.DisplayImage(afbeelding2, afbeelding2im);
        imageLoader.DisplayImage(afbeelding3, afbeelding3im);

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
}