package com.hogent.ti3g05.ti3_g05_joetzapp;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.widget.ImageView;

import java.util.ArrayList;

//geeft de geselecteerde afbeelding vergroot weer
public class AfbeeldingVergroot extends Activity {
    private String naam, locatie, vertrekdatum, terugdatum, formule, maxDeeln, periode, vervoer, prijs, beschrijving;
    private String maxDoelgroep, minDoelgroep, afbeelding1, afbeelding2, afbeelding3, bmLedenPrijs, sterPrijs1Ouder, sterPrijs2Ouders;
    private String inbegrepenInPrijs, activiteitID;
    private ArrayList<String> fotos = new ArrayList<String>();
    private String link;
    private String gemiddeldeScore;

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        setContentView(R.layout.afbeelding_uitvergroot);
        setTitle("");

        ImageView im = (ImageView)findViewById(R.id.afbvergroot);

        Intent i = getIntent();
        naam = i.getStringExtra("naam");
        locatie = i.getStringExtra("locatie");
        vertrekdatum = i.getStringExtra("vertrekdatum");
        terugdatum = i.getStringExtra("terugdatum");
        maxDoelgroep = i.getStringExtra("maxdoelgroep");
        minDoelgroep = i.getStringExtra("mindoelgroep");
        formule = i.getStringExtra("formule");
        maxDeeln = i.getStringExtra("maxAantalDeelnemers");
        periode = i.getStringExtra("periode");
        vervoer = i.getStringExtra("vervoer");
        beschrijving = i.getStringExtra("beschrijving");
        inbegrepenInPrijs = i.getStringExtra("InbegrepenInPrijs");
        activiteitID = i.getStringExtra("objectId");
        link = i.getStringExtra("link");
        vervoer = i.getStringExtra("vervoer");
        prijs = i.getStringExtra("prijs");

        bmLedenPrijs = i.getStringExtra("BMledenPrijs");
        sterPrijs1Ouder = i.getStringExtra("SterPrijs1Ouder");
        sterPrijs2Ouders = i.getStringExtra("SterPrijs2Ouders");

        gemiddeldeScore = i.getStringExtra("gemiddeldeScore");



        //afbeeldingen ophalen met een while-lus, die stopt als de nieuwe afbeelding null is, want we weten niet zeker of
        String huidigeAfbeelding = i.getStringExtra("foto0");
        int teller = 0;
        while (huidigeAfbeelding != null) {
            fotos.add(huidigeAfbeelding);
            teller++;
            huidigeAfbeelding = i.getStringExtra("foto" + teller);
        }

        ImageLoader imageLoader = new ImageLoader(this);
        imageLoader.DisplayImage( i.getStringExtra("afbeelding"),im );
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
            terugNaarDetail();
        }

        return super.onOptionsItemSelected(item);
    }

    @Override
    public void onBackPressed() {
        terugNaarDetail();
    }

    //Stuurt de gebruiker terig naar detailscherm en geeft juiste gegevens mee
    public void terugNaarDetail()
    {
        Intent intent1 = new Intent(this, VakantieDetail.class);
        intent1.putExtra("naam",naam);
        intent1.putExtra("locatie",locatie);
        intent1.putExtra("vertrekdatum",vertrekdatum);
        intent1.putExtra("terugdatum", terugdatum);
        intent1.putExtra("maxdoelgroep", maxDoelgroep);
        intent1.putExtra("mindoelgroep", minDoelgroep);
        intent1.putExtra("formule", formule);
        intent1.putExtra("maxAantalDeelnemers", maxDeeln);
        intent1.putExtra("periode", periode);
        intent1.putExtra("beschrijving", beschrijving);
        intent1.putExtra("InbegrepenInPrijs", inbegrepenInPrijs);
        intent1.putExtra("objectId", activiteitID);
        intent1.putExtra("link", link);


        intent1.putExtra("vervoer", vervoer);

        intent1.putExtra("prijs", prijs);


        intent1.putExtra("BMledenPrijs",bmLedenPrijs);
        intent1.putExtra("SterPrijs1Ouder", sterPrijs1Ouder);
        intent1.putExtra("SterPrijs2Ouders", sterPrijs2Ouders);

        intent1.putExtra("gemiddeldeScore",gemiddeldeScore);

        String keyVoorIntent;
        ArrayList<String> lijstFotos = fotos;
        int lijstFotosLengte = lijstFotos.size()-1;
        for (int i = 0; i <= lijstFotosLengte; i++){
            keyVoorIntent = "foto" + i;
            intent1.putExtra(keyVoorIntent, lijstFotos.get(i));
        }
        intent1.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
        startActivity(intent1);

        overridePendingTransition(R.anim.left_in, R.anim.right_out);
    }
}
