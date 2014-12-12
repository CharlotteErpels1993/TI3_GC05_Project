package com.hogent.ti3g05.ti3_g05_joetzapp;

import android.app.Activity;
import android.content.Intent;
import android.content.pm.ResolveInfo;
import android.net.Uri;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.view.animation.Animation;
import android.view.animation.AnimationUtils;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.RelativeLayout;
import android.widget.TextView;
import android.widget.Toast;

import com.hogent.ti3g05.ti3_g05_joetzapp.Services.ConnectionDetector;
import com.parse.ParseException;
import com.parse.ParseObject;
import com.parse.ParseQuery;
import com.parse.ParseUser;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.ArrayList;

//ouder:      titel, korte beschr, periode, locatie, inbegrepen in prijs, doelgroep (met geboortejaren), max aantal deelnemers,
//                          vervoerswijze, formule, prijs (basisprijs, BM prijs & sterprijs) kortingen, gegevens contactpersoon inschrijving & algemene voorwaarden
//kind en monitor: titel, korte beschr, periode, locatie, inbegrepen in prijs, doelgroep (met geboortejaren), max aantal deelnemers

//Geeft een detailscherm van de vakantie met de juiste informatie per gebruiker
public class Vakantie_detail extends Activity {

    private String naam, locatie, vertrekdatum, terugdatum, formule, maxDeeln, periode, vervoer, prijs, beschrijving;
    private ImageLoader imageLoader = new ImageLoader(this);
    private String maxDoelgroep, minDoelgroep, afbeelding1, afbeelding2, afbeelding3, bmLedenPrijs, sterPrijs1Ouder, sterPrijs2Ouders;
    private String inbegrepenInPrijs, activiteitID;
    private ArrayList<String> fotos = new ArrayList<String>();
    private String link;

    private Button btnInschrijven, btnmeerInfo, btnminderInfo;

    private ImageView favoImage, deleteImage;

    private List<ParseObject> ob;
    private List<ParseObject> obF;

    private List<ParseObject> obD;
    private String ingelogdeGebruiker = "";
    //SwipeRefreshLayout swipeLayout;

    // flag for Internet connection status
    Boolean isInternetPresent = false;
    // Connection detector class
    ConnectionDetector cd;


    //TODO bij doelgroepen moet er volgens de UC ook nog de geboortejaren bij komen -> methode voor maken om dat te berekenen
    //TODO algemene voorwaarden onderaan bijzetten -> string resource, kopieren van JOETZ
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        //inflateexceprion
        setContentView(R.layout.activiteit_detailnieuw);


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

        //afbeeldingen ophalen met een while-lus, die stopt als de nieuwe afbeelding null is, want we weten niet zeker of
        String huidigeAfbeelding = i.getStringExtra("foto0");
        int teller = 0;
        while (huidigeAfbeelding != null) {
            fotos.add(huidigeAfbeelding);
            teller++;
            huidigeAfbeelding = i.getStringExtra("foto" + teller);
        }


        setTitle(getString(R.string.vakantieDetailTitel));

        TextView txtNaam = (TextView) findViewById(R.id.titel);
        TextView txtLocatie = (TextView) findViewById(R.id.locatiev);
        TextView txtDoelgr = (TextView) findViewById(R.id.doelgroepv);
        TextView txtformule = (TextView) findViewById(R.id.formule);
        TextView txtmaxDeeln = (TextView) findViewById(R.id.maxDeelnemers);
        TextView txtPeriode = (TextView) findViewById(R.id.periode);
        TextView txtVervoer = (TextView) findViewById(R.id.vervoer);
        TextView txtPrijs = (TextView) findViewById(R.id.basisprijs);
        TextView txtBeschrijving = (TextView) findViewById(R.id.beschrijving);
        TextView txtVertrekDatum = (TextView) findViewById(R.id.vertrekdatum);
        TextView txtTerugkeerDatum = (TextView) findViewById(R.id.terugkeerdatum);
        TextView txtInbegrepenInPrijs = (TextView) findViewById(R.id.inbegrepenInPrijs);
        TextView txtBMledenPrijs = (TextView) findViewById(R.id.bondMoysonLedenPrijs);
        TextView txtSterPrijs1Ouder = (TextView) findViewById(R.id.sterPrijs1Ouder);
        TextView txtSterPrijs2Ouders = (TextView) findViewById(R.id.sterPrijs2Ouders);
        TextView labelBM = (TextView) findViewById(R.id.ledenPrijsLabel);
        TextView txtExtraInfo = (TextView) findViewById(R.id.ExtraInformatie);
        final RelativeLayout verberg = (RelativeLayout) findViewById(R.id.verberg2);

        btnInschrijven = (Button) findViewById(R.id.btnInschrijvenV);
        btnmeerInfo = (Button) findViewById(R.id.btnMeerInfo);
        btnminderInfo = (Button) findViewById(R.id.btnMinderInfo);

        btnminderInfo.setVisibility(View.GONE);

        cd = new ConnectionDetector(this);

        ImageView afbeelding1im = (ImageView) findViewById(R.id.afbeelding1);
        ImageView afbeelding2im = (ImageView) findViewById(R.id.afbeelding2);
        ImageView afbeelding3im = (ImageView) findViewById(R.id.afbeelding3);
        ImageView share = (ImageView) findViewById(R.id.share);

        share.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                shareFacebook();
            }
        });

        btnInschrijven.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Intent intent3 = new Intent(Vakantie_detail.this, InschrijvenVakantiePart1.class);
                intent3.putExtra("objectId", activiteitID);
                intent3.putExtra("maxdoelgroep", maxDoelgroep);
                intent3.putExtra("mindoelgroep", minDoelgroep);
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

        favoImage = (ImageView) findViewById(R.id.favo);
        deleteImage = (ImageView) findViewById(R.id.delete);
        deleteImage.setVisibility(View.GONE);
        favoImage.setVisibility(View.GONE);

        if (ParseUser.getCurrentUser() != null) {
            if (!ParseUser.getCurrentUser().get("soort").toString().toLowerCase().equals("administrator") && !controleerReedsFavoriet()) {
                favoImage.setVisibility(View.VISIBLE);


            } else if(!ParseUser.getCurrentUser().get("soort").toString().toLowerCase().equals("administrator") && controleerReedsFavoriet()) {
                deleteImage.setVisibility(View.VISIBLE);
            }
        }

        favoImage.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                toevoegenAanFavorieten();
            }
        });

        deleteImage.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                deleteFavoriet();
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

        ImageView btnTwitterShare = (ImageView) findViewById(R.id.shareTwitter);
        btnTwitterShare.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                shareTwitter();
            }
        });

        ImageView feedback = (ImageView) findViewById(R.id.Feedback);
        feedback.setVisibility(View.GONE);

        if (afbeelding1im.getVisibility() == View.VISIBLE) {
            afbeelding1im.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    Intent intent1 = new Intent(Vakantie_detail.this, afbeeldingUItvergroot.class);

                    intent1.putExtra("afbeelding", afbeelding1);
                    startActivity(intent1);

                    overridePendingTransition(R.anim.right_in, R.anim.left_out);
                }
            });
        }
        if (afbeelding2im.getVisibility() == View.VISIBLE) {
            afbeelding2im.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    Intent intent1 = new Intent(Vakantie_detail.this, afbeeldingUItvergroot.class);

                    intent1.putExtra("afbeelding", afbeelding2);
                    startActivity(intent1);

                    overridePendingTransition(R.anim.right_in, R.anim.left_out);
                }
            });
        }
        if (afbeelding3im.getVisibility() == View.VISIBLE) {
            afbeelding3im.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    Intent intent1 = new Intent(Vakantie_detail.this, afbeeldingUItvergroot.class);

                    intent1.putExtra("afbeelding", afbeelding3);
                    startActivity(intent1);

                    overridePendingTransition(R.anim.right_in, R.anim.left_out);
                }
            });
        }

        //hieronder wordt er een leesbare datum geconverteerd
        try {
            SimpleDateFormat dateFormat = new SimpleDateFormat("EEE MMM d HH:mm:ss zz yyyy");
            Calendar cal = Calendar.getInstance();

            Date vertrDate = dateFormat.parse(vertrekdatum);
            cal.setTime(vertrDate);
            vertrekdatum = cal.get(Calendar.DAY_OF_MONTH) + "/" + cal.get(Calendar.MONTH) + "/" + cal.get(Calendar.YEAR);

            Date terugkDate = dateFormat.parse(terugdatum);
            cal.setTime(terugkDate);
            terugdatum = cal.get(Calendar.DAY_OF_MONTH) + "/" + cal.get(Calendar.MONTH) + "/" + cal.get(Calendar.YEAR);
        } catch (java.text.ParseException pe) {
            Toast.makeText(getApplicationContext(), pe.getMessage(), Toast.LENGTH_SHORT).show();
        }

        feedback.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Intent intent  = new Intent(Vakantie_detail.this, feedback_geven.class);
                intent.putExtra("vakantie", naam);
                intent.putExtra("vakantieId", activiteitID);
                startActivity(intent);
            }
        });


        txtNaam.setText(naam);
        txtLocatie.setText(locatie);
        txtDoelgr.setText(minDoelgroep + " - " + maxDoelgroep + " jaar");
        txtformule.setText(formule);
        txtmaxDeeln.setText(maxDeeln + " personen");
        txtPeriode.setText(periode);
        txtVervoer.setText(vervoer);
        txtBeschrijving.setText(beschrijving);
        txtVertrekDatum.setText(vertrekdatum);
        txtTerugkeerDatum.setText(terugdatum);
        txtInbegrepenInPrijs.setText(inbegrepenInPrijs);

        if (ParseUser.getCurrentUser() == null || (ParseUser.getCurrentUser()!= null && ParseUser.getCurrentUser().get("soort").toString().toLowerCase().equals("monitor"))) {
            //niet ingelogd
            btnInschrijven.setVisibility(View.GONE);
            txtPrijs.setVisibility(View.GONE);
            txtBMledenPrijs.setVisibility(View.GONE);
            txtSterPrijs1Ouder.setVisibility(View.GONE);
            txtSterPrijs2Ouders.setVisibility(View.GONE);
            txtformule.setVisibility(View.GONE);
            txtInbegrepenInPrijs.setVisibility(View.GONE);
            btnmeerInfo.setVisibility(View.GONE);
            verberg.setVisibility(View.GONE);
            if(ParseUser.getCurrentUser()!= null && ParseUser.getCurrentUser().get("soort").toString().toLowerCase().equals("monitor"))
                txtExtraInfo.setVisibility(View.GONE);
            else
                txtExtraInfo.setVisibility(View.VISIBLE);

        } else if(ParseUser.getCurrentUser()!= null && (ParseUser.getCurrentUser().get("soort").toString().toLowerCase().equals("ouder") || ParseUser.getCurrentUser().get("soort").toString().toLowerCase().equals("administrator"))) {
            //ingelogd als ouder
            btnInschrijven.setVisibility(View.VISIBLE);
            btnmeerInfo.setVisibility(View.VISIBLE);
            verberg.setVisibility(View.GONE);
            txtExtraInfo.setVisibility(View.GONE);
            //toon normale prijs
            txtPrijs.setVisibility(View.VISIBLE);
            feedback.setVisibility(View.VISIBLE);
            prijs = i.getStringExtra("prijs");
            txtPrijs.setText("€" + prijs);
            if (!(prijs.contains(".") || prijs.contains(","))) {
                txtPrijs.append(",00");
            }

            bmLedenPrijs = i.getStringExtra("BMledenPrijs");
            sterPrijs1Ouder = i.getStringExtra("SterPrijs1Ouder");
            sterPrijs2Ouders = i.getStringExtra("SterPrijs2Ouders");


            if (!bmLedenPrijs.equals("0")) {
                txtBMledenPrijs.setVisibility(View.VISIBLE);
                labelBM.setVisibility(View.VISIBLE);
                txtBMledenPrijs.setText("Prijs voor leden van Bond Moyson: €" + bmLedenPrijs);
                if (!(bmLedenPrijs.contains(".") || bmLedenPrijs.contains(","))) {
                    txtBMledenPrijs.append(",00");
                }
            } else {
                txtBMledenPrijs.setVisibility(View.GONE);
                labelBM.setVisibility(View.GONE);
            }

            if (!sterPrijs1Ouder.equals("0")) {
                txtSterPrijs1Ouder.setVisibility(View.VISIBLE);
                txtSterPrijs1Ouder.setText("Prijs voor leden waarvan 1 ouder deel is van BM: €" + sterPrijs1Ouder);
                if (!(sterPrijs1Ouder.contains(".") || sterPrijs1Ouder.contains(","))) {
                    txtSterPrijs1Ouder.append(",00");
                }
            }

            if (!sterPrijs2Ouders.equals("0")) {
                txtSterPrijs2Ouders.setVisibility(View.VISIBLE);
                txtSterPrijs2Ouders.setText("Prijs voor leden waarvan 2 ouders deel zijn van BM: €" + sterPrijs2Ouders);
                if (!(sterPrijs2Ouders.contains(".") || sterPrijs2Ouders.contains(","))) {
                    txtSterPrijs2Ouders.append(",00");
                }
            }
        } else if (ParseUser.getCurrentUser()!=null && ParseUser.getCurrentUser().get("soort").toString().toLowerCase().equals("monitor"))
        {
            btnInschrijven.setVisibility(View.GONE);
            btnmeerInfo.setVisibility(View.VISIBLE);
            verberg.setVisibility(View.GONE);
            txtExtraInfo.setVisibility(View.GONE);
            feedback.setVisibility(View.VISIBLE);
            //toon normale prijs
            txtPrijs.setVisibility(View.VISIBLE);
            prijs = i.getStringExtra("prijs");
            txtPrijs.setText("€" + prijs);
            if (!(prijs.contains(".") || prijs.contains(","))) {
                txtPrijs.append(",00");
            }

            bmLedenPrijs = i.getStringExtra("BMledenPrijs");
            sterPrijs1Ouder = i.getStringExtra("SterPrijs1Ouder");
            sterPrijs2Ouders = i.getStringExtra("SterPrijs2Ouders");


            if (!bmLedenPrijs.equals("0")) {
                txtBMledenPrijs.setVisibility(View.VISIBLE);
                labelBM.setVisibility(View.VISIBLE);
                txtBMledenPrijs.setText("Prijs voor leden van Bond Moyson: €" + bmLedenPrijs);
                if (!(bmLedenPrijs.contains(".") || bmLedenPrijs.contains(","))) {
                    txtBMledenPrijs.append(",00");
                }
            } else {
                txtBMledenPrijs.setVisibility(View.GONE);
                labelBM.setVisibility(View.GONE);
            }

            if (!sterPrijs1Ouder.equals("0")) {
                txtSterPrijs1Ouder.setVisibility(View.VISIBLE);
                txtSterPrijs1Ouder.setText("Prijs voor leden waarvan 1 ouder deel is van BM: €" + sterPrijs1Ouder);
                if (!(sterPrijs1Ouder.contains(".") || sterPrijs1Ouder.contains(","))) {
                    txtSterPrijs1Ouder.append(",00");
                }
            }

            if (!sterPrijs2Ouders.equals("0")) {
                txtSterPrijs2Ouders.setVisibility(View.VISIBLE);
                txtSterPrijs2Ouders.setText("Prijs voor leden waarvan 2 ouders deel zijn van BM: €" + sterPrijs2Ouders);
                if (!(sterPrijs2Ouders.contains(".") || sterPrijs2Ouders.contains(","))) {
                    txtSterPrijs2Ouders.append(",00");
                }
            }
        }


        // Capture position and set results to the ImageView
        // Passes flag images URL into ImageLoader.class
        int aantalAfbeeldingen = fotos.size();
        if (!fotos.isEmpty()) {
            afbeelding1im.setVisibility(View.VISIBLE);
            afbeelding1 = fotos.get(0);
            imageLoader.DisplayImage(afbeelding1, afbeelding1im);
        } else {

            afbeelding1im.setVisibility(View.GONE);
        }
        if (aantalAfbeeldingen >= 2) {
            afbeelding2im.setVisibility(View.VISIBLE);
            afbeelding2 = fotos.get(1);
            imageLoader.DisplayImage(afbeelding2, afbeelding2im);
        } else {
            afbeelding2im.setVisibility(View.GONE);
        }
        if (aantalAfbeeldingen >= 3) {
            afbeelding3im.setVisibility(View.VISIBLE);
            afbeelding3 = fotos.get(2);
            imageLoader.DisplayImage(afbeelding3, afbeelding3im);
        } else {
            afbeelding3im.setVisibility(View.GONE);
        }

    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.back_2, menu);
        return true;
    }

    public void shareFacebook() {
        isInternetPresent = cd.isConnectingToInternet();

        if(isInternetPresent)
        {
            boolean facebookAppFound = false;
            Intent intent = new Intent(Intent.ACTION_SEND);
            intent.setType("text/plain");
            intent.putExtra(Intent.EXTRA_TEXT, link);

            List<ResolveInfo> matches = getPackageManager().queryIntentActivities(intent, 0);
            for (ResolveInfo info : matches) {
                if (info.activityInfo.packageName.toLowerCase().startsWith("com.facebook")) {
                    intent.setPackage(info.activityInfo.packageName);
                    facebookAppFound = true;
                    break;
                }
            }
            if (!facebookAppFound) {
                String sharerUrl = "https://www.facebook.com/sharer/sharer.php?u=" + link;
                intent = new Intent(Intent.ACTION_VIEW, Uri.parse(sharerUrl));
            }
            startActivity(intent);
        } else {
            Toast.makeText(getApplicationContext(), getString(R.string.error_no_internet), Toast.LENGTH_SHORT).show();
        }

    }

    public void shareTwitter() {

        isInternetPresent = cd.isConnectingToInternet();
        if(isInternetPresent)
        {
            boolean twitterApp = false;
            Intent intent = new Intent(Intent.ACTION_SEND);
            intent.setType("text/plain");
            intent.putExtra(Intent.EXTRA_TEXT, link);

            List<ResolveInfo> matches = getPackageManager().queryIntentActivities(intent, 0);
            for (ResolveInfo info : matches) {
                if (info.activityInfo.packageName.toLowerCase().startsWith("com.twitter")) {
                    intent.setPackage(info.activityInfo.packageName);
                    twitterApp = true;
                    break;
                }
            }
            if (!twitterApp) {
                String sharerUrl = "https://twitter.com/intent/tweet?source=webclient&text=%s" + link;
                intent = new Intent(Intent.ACTION_VIEW, Uri.parse(sharerUrl));
            }
            startActivity(intent);
        }
        else {
            Toast.makeText(getApplicationContext(), getString(R.string.error_no_internet), Toast.LENGTH_SHORT).show();
        }

    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        int id = item.getItemId();
        if (id == R.id.backMenu2) {
            Intent intent1 = new Intent(this, navBarMainScreen.class);
            intent1.putExtra("naarfrag", "activiteit");
            intent1.putExtra("herladen", "nee");
            intent1.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
            startActivity(intent1);

            overridePendingTransition(R.anim.left_in, R.anim.right_out);
        }

        return super.onOptionsItemSelected(item);
    }


    public void toevoegenAanFavorieten() {
        try{


            ParseObject favoriet = new ParseObject("Favoriet");
            if (!controleerReedsFavoriet()) {
                favoriet.put("vakantie", activiteitID);
                favoriet.put("gebruiker", ingelogdeGebruiker);
                favoriet.save();
                Toast.makeText(Vakantie_detail.this, "Favoriet toegevoegd!", Toast.LENGTH_SHORT).show();
                favoImage.setVisibility(View.GONE);
                deleteImage.setVisibility(View.VISIBLE);
            } else {
                Toast.makeText(Vakantie_detail.this, "Is reeds favoriet.", Toast.LENGTH_SHORT).show();
            }

        } catch (ParseException e) {
            e.printStackTrace();
        }
    }

    public boolean controleerReedsFavoriet() {
        isInternetPresent = cd.isConnectingToInternet();
        if (isInternetPresent) try {
            ParseObject favoriet = new ParseObject("Favoriet");


            if(ParseUser.getCurrentUser().get("soort").toString().toLowerCase().equals("ouder"))
            // Locate the class table named "vakantie" in Parse.com
            {
                ParseQuery<ParseObject> query = new ParseQuery<ParseObject>(
                        "Ouder");

                ob = query.find();

                for (ParseObject ouder : ob) {

                    if (ouder.get("email").equals(ParseUser.getCurrentUser().getEmail())) {
                        ingelogdeGebruiker = ouder.getObjectId();
                    }


                }
            }
            else if(ParseUser.getCurrentUser().get("soort").toString().toLowerCase().equals("monitor"))
            {
                ParseQuery<ParseObject> query = new ParseQuery<ParseObject>(
                        "Monitor");

                ob = query.find();

                for (ParseObject monitor : ob) {

                    if (monitor.get("email").equals(ParseUser.getCurrentUser().getEmail())) {
                        ingelogdeGebruiker = monitor.getObjectId();
                    }


                }
            }

            ParseQuery<ParseObject> query2 = new ParseQuery<ParseObject>(
                    "Favoriet");

            obF = query2.find();


            String favId = null;
            for (ParseObject fav : obF) {
                if (fav.get("vakantie").equals(activiteitID) && fav.get("gebruiker").equals(ingelogdeGebruiker)) {
                    favId = fav.getObjectId();
                    return true;
                }
            }
        } catch (ParseException e) {
            e.printStackTrace();
        }
        return false;
    }

    public void deleteFavoriet()
    {
        try{
        ParseQuery<ParseObject> query2 = new ParseQuery<ParseObject>(
                "Favoriet");

        obD = query2.find();


        for (ParseObject fav : obD) {
            if (fav.get("vakantie").equals(activiteitID) && fav.get("gebruiker").equals(ingelogdeGebruiker)) {
                fav.delete();
                Toast.makeText(Vakantie_detail.this, "vakantie is verwijderd van favorieten", Toast.LENGTH_SHORT).show();
                deleteImage.setVisibility(View.GONE);
                favoImage.setVisibility(View.VISIBLE);

            }
        }
    } catch (ParseException e) {
        e.printStackTrace();
    }
    }
}