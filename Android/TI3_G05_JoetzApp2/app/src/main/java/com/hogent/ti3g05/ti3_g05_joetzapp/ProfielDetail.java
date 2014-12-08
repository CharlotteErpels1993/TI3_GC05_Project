package com.hogent.ti3g05.ti3_g05_joetzapp;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.net.Uri;
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
import android.widget.Toast;

import com.hogent.ti3g05.ti3_g05_joetzapp.Services.ConnectionDetector;
import com.parse.ParseUser;

//UC: naam en voornaam van de monitor, emailadres, gsm nummer en eventueel link naar facebookprofiel.
public class ProfielDetail extends Activity {
    String naam;
    String voornaam;
    String email;
    String gsm;
    /*String straat;
    String huisnr;
    String gemeente;
    String postcode;
    String lidNr;
    String rijksregisterNr;*/
    private Button btnProfielEdit;

    Boolean isInternetPresent = false;
    ConnectionDetector cd;

    @Override
    public void onCreate(final Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.profiel_detail);


        Intent i = getIntent();
        naam = i.getStringExtra("naam");
        voornaam = i.getStringExtra("voornaam");
        email = i.getStringExtra("email");
        gsm = i.getStringExtra("gsm");
        /*straat = i.getStringExtra("straat");
        //huisnr = i.getStringExtra("huisnr");
        gemeente = i.getStringExtra("gemeente");
        // periodes = i.getStringExtra("periodes");
        rijksregisterNr = i.getStringExtra("rijksregNr");
        lidNr = i.getStringExtra("lidNr");*/

        setTitle(naam + " " + voornaam);
        cd = new ConnectionDetector(getApplicationContext());

        TextView txtNaam = (TextView) findViewById(R.id.achternaamP);
        final TextView txtVoornaam = (TextView) findViewById(R.id.voornaamP);
        TextView txtEmail = (TextView) findViewById(R.id.emailP);

        final TextView txtGsm = (TextView)findViewById(R.id.gsmP);
        if(ParseUser.getCurrentUser().getEmail().equals(email))

        {
            btnProfielEdit = (Button) findViewById(R.id.btnProfielEdit);
            btnProfielEdit.setVisibility(View.VISIBLE);
            btnProfielEdit.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    isInternetPresent = cd.isConnectingToInternet();

                    if (isInternetPresent) {
                        Intent inte = new Intent(getApplicationContext(), ProfielEdit.class);
                        inte.putExtra("naam", naam);
                        inte.putExtra("voornaam", voornaam);
                        inte.putExtra("gsm", gsm);
                        inte.putExtra("email", email);
                        startActivity(inte);
                    } else {
                        Toast.makeText(getApplicationContext(), getString(R.string.error_no_internet), Toast.LENGTH_SHORT).show();
                    }


                }
            });
        }


        /*final TextView txtStraat = (TextView) findViewById(R.id.straatP);
        final TextView txtGemeente = (TextView)findViewById(R.id.gemeenteP);
        TextView txtLidNr = (TextView)findViewById(R.id.lidNr);
        final TextView txtRijksregNr = (TextView)findViewById(R.id.RijksRegNrP);*/


        txtNaam.setText(naam);
        txtVoornaam.setText(voornaam);
        txtEmail.setText(email);
        txtGsm.setText(gsm);

        Button mail = (Button) findViewById(R.id.mail);

        mail.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Intent i = new Intent(Intent.ACTION_SEND);
                i.setType("text/plain");
                i.putExtra(Intent.EXTRA_EMAIL, new String[]{ email });
                i.putExtra(Intent.EXTRA_SUBJECT, "onderwerp");
                startActivity(i);
            }
        });

        /*ImageView naarProf = (ImageView)findViewById(R.id.naarprofiel);
        naarProf.setVisibility(View.GONE);
        naarProf.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Intent fb = getOpenFacebookIntent(getApplicationContext(), voornaam, naam);
                startActivity(fb);
            }
        });*/
        /*//txtmaxDeeln.setText(maxDeeln.toString());
        //txtLidNr.setText(lidNr);
        txtStraat.setText(straat);
        txtGemeente.setText(gemeente);
        txtRijksregNr.setText(rijksregisterNr);*/

    }

    /*public static Intent getOpenFacebookIntent(Context context, String voornaam, String achternaam) {

        try {
            context.getPackageManager().getPackageInfo("com.facebook.katana", 0);
            achternaam.replaceAll("\\s+","");
            //return new Intent(Intent.ACTION_VIEW, Uri.parse("fb://profile/" + voornaam +"."+achternaam));
            return new Intent(Intent.ACTION_VIEW, Uri.parse("https://www.facebook.com/" + voornaam+"."+achternaam));
        } catch (Exception e) {
            return new Intent(Intent.ACTION_VIEW, Uri.parse("https://www.facebook.com/" + voornaam+"."+achternaam));
        }
    }*/
    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.back_2, menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        int id = item.getItemId();
        if (id == R.id.backMenu2) {
            Intent intent1 = new Intent(this, navBarMainScreen.class);
            intent1.putExtra("naarfrag", "profiel");
            intent1.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
            startActivity(intent1);

            overridePendingTransition(R.anim.left_in, R.anim.right_out);
        }

        return super.onOptionsItemSelected(item);
    }

}