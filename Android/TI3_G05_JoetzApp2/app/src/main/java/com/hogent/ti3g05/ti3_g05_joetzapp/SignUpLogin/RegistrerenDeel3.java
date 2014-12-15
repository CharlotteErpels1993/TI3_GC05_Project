package com.hogent.ti3g05.ti3_g05_joetzapp.SignUpLogin;


import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.text.TextUtils;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.animation.Animation;
import android.view.animation.AnimationUtils;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;
import java.util.List;

import com.hogent.ti3g05.ti3_g05_joetzapp.Services.ConnectionDetector;
import com.hogent.ti3g05.ti3_g05_joetzapp.R;
import com.parse.ParseException;
import com.parse.ParseObject;
import com.parse.ParseQuery;

//stap 3 van registreren
public class RegistrerenDeel3 extends Activity{

	private EditText voornaamText;
	private EditText naamText;
	private EditText straatText;
    private EditText huisnrText;
    private EditText gemeenteText;
    private EditText postcodeText;
    private EditText busText;
    private EditText telefoonText;
    private EditText gsmText;

    private boolean cancel = false;
    private View focusView = null;

    private Boolean isInternetPresent = false;
    private ConnectionDetector cd;
	
	@Override
	protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_signup_deel3);

        getActionBar().setTitle(getString(R.string.title_activity_Register));

		cd = new ConnectionDetector(getApplicationContext());
        final Animation animAlpha = AnimationUtils.loadAnimation(this, R.anim.alpha);

        voornaamText = (EditText) findViewById(R.id.VoornaamSignu);
		naamText = (EditText) findViewById(R.id.NaamSignu);
		straatText = (EditText) findViewById(R.id.StraatSignu);
        huisnrText = (EditText) findViewById(R.id.HuisnrSignu);
        gemeenteText = (EditText) findViewById(R.id.GemeenteSignu);
        postcodeText = (EditText) findViewById(R.id.PostcodeSignu);
        telefoonText = (EditText) findViewById(R.id.TelefoonSignu);
        gsmText = (EditText) findViewById(R.id.GsmSignu);
        busText = (EditText) findViewById(R.id.BusSignu);

        final Button volgendeButton = (Button) findViewById(R.id.btnNaarDeel4);
		volgendeButton.setOnClickListener(new OnClickListener() {
            @Override
            public void onClick(View view) {

                volgendeButton.startAnimation(animAlpha);
                //Bij het klikken op de knop wordt gecontroleerd of er internet aanwezig is, zoja, controleer de ingevulde gegevens
                isInternetPresent = cd.isConnectingToInternet();

                if (isInternetPresent) {
                    controleerGegevens();
                }
                else{
                    Toast.makeText(getApplicationContext(), getString(R.string.error_no_internet), Toast.LENGTH_SHORT).show();
                }
            }
        });
	}
    //De ingevulde gegevens worden gecontroleerd, als deze ingevuld zijn en correct sla de gegevens op
	private void controleerGegevens(){
		clearErrors();
        cancel = false;

		// Store values at the time of the onClick event.
        String voornaam = voornaamText.getText().toString().toLowerCase();
        String naam = naamText.getText().toString().toLowerCase();
        String straat = straatText.getText().toString();
        String huisnr = huisnrText.getText().toString();
        String bus = busText.getText().toString();
        String gemeente = gemeenteText.getText().toString();
        String postcode = postcodeText.getText().toString();
        String telefoon = telefoonText.getText().toString();
        String gsm = gsmText.getText().toString();

        //hieronder wordt gecontroleerd of alles ingevuld is en in het juiste formaat
        if (TextUtils.isEmpty(gsm)) {
            gsmText.setError(getString(R.string.error_field_required));
            focusView = gsmText;
            cancel = true;
        }

        if (!TextUtils.isEmpty(telefoon) && (!telefoon.matches("[0-9]+") || telefoon.length() != 9)){
            telefoonText.setError(getString(R.string.error_incorrect_tel));
            focusView = telefoonText;
            cancel = true;
        }


        if (TextUtils.isEmpty(postcode)) {
            postcodeText.setError(getString(R.string.error_field_required));
            focusView = postcodeText;
            cancel = true;
        } else {
            if (postcode.length() != 4) {
                postcodeText.setError(getString(R.string.error_incorrect_postcode));
                focusView = postcodeText;
                cancel = true;
            }
            if (!postcode.matches("[0-9]+")){
                postcodeText.setError(getString(R.string.error_incorrect_postcode));
                focusView = postcodeText;
                cancel = true;
            }
        }

        if (TextUtils.isEmpty(gemeente)) {
            gemeenteText.setError(getString(R.string.error_field_required));
            focusView = gemeenteText;
            cancel = true;
        }

        if (TextUtils.isEmpty(huisnr)) {
            huisnrText.setError(getString(R.string.error_field_required));
            focusView = huisnrText;
            cancel = true;
        }
        if (!huisnr.matches("[0-9]+") && huisnr.length() >= 1){
            huisnrText.setError(getString(R.string.error_incorrect_huisnr));
            focusView = huisnrText;
            cancel = true;
        }

        if (TextUtils.isEmpty(straat)) {
            straatText.setError(getString(R.string.error_field_required));
            focusView = straatText;
            cancel = true;
        }
		if (TextUtils.isEmpty(naam)) {
			naamText.setError(getString(R.string.error_field_required));
			focusView = naamText;
			cancel = true;
		}

        if (TextUtils.isEmpty(voornaam)) {
            voornaamText.setError(getString(R.string.error_field_required));
            focusView = voornaamText;
            cancel = true;
        }

        //Haal de gegevens op en kijk of dit nummer uniek is het gsm nummer moet uniek zijn
        ParseQuery<ParseObject> queryOuder = ParseQuery.getQuery("Ouder");
        queryOuder.whereEqualTo("gsm", gsm);
        try{
            List<ParseObject> ouders = queryOuder.find();
            if (ouders.size() > 0){
                gsmText.setError("Dit gsm-nummer is reeds in gebruik.");
                focusView = gsmText;
                cancel = true;
            }
        }
        catch(ParseException e){
            Toast.makeText(RegistrerenDeel3.this,getString(R.string.error_generalException), Toast.LENGTH_SHORT).show();
            cancel = true;
        }
        ParseQuery<ParseObject> queryMonitoren = ParseQuery.getQuery("Monitor");
        queryMonitoren.whereEqualTo("gsm", gsm);
        try{
            List<ParseObject> monitoren = queryMonitoren.find();
            if (monitoren.size() > 0){
                gsmText.setError("Dit gsm-nummer is reeds in gebruik.");
                focusView = gsmText;
                cancel = true;
            }
        }
        catch(ParseException e){
            Toast.makeText(RegistrerenDeel3.this,getString(R.string.error_generalException), Toast.LENGTH_SHORT).show();
            cancel = true;
        }

		if (cancel) {
			focusView.requestFocus();
		} else {
            opslaan(voornaam ,naam, straat, huisnr, gemeente, postcode, telefoon, gsm, bus);

		}

	}

    //Geeft alle gegevens door naar de juiste pagina
    private void opslaan(String voornaam,String naam, String straat, String huisnr, String gemeente, String postcode, String telefoon, String gsm, String bus) {
        Toast.makeText(getApplicationContext(), getString(R.string.loading_message), Toast.LENGTH_SHORT).show();

        Intent in = new Intent(getApplicationContext(),RegistrerenDeel4.class);

        Bundle extras = getIntent().getExtras();
        if (extras != null) {
            String rijksregnr = extras.getString("rijksregisternr");
            String BMnr = extras.getString("aansluitingsnr");
            String codeGerechtigde = extras.getString("codeGerechtigde");
            String aansluitingsNrOuder2 = extras.getString("aansluitingsnrOuder2");

            in.putExtra("aansluitingsnr", BMnr);
            in.putExtra("codeGerechtigde", codeGerechtigde);
            in.putExtra("aansluitingsnrOuder2", aansluitingsNrOuder2);
            in.putExtra("rijksregisternr", rijksregnr);
        }

        in.putExtra("voornaam", voornaam);
        in.putExtra("naam", naam);
        in.putExtra("straat", straat);
        in.putExtra("huisnr", huisnr);
        in.putExtra("bus", bus);
        in.putExtra("gemeente", gemeente);
        in.putExtra("postcode", postcode);
        in.putExtra("telefoon",telefoon);
        in.putExtra("gsm",gsm);

        startActivity(in);

        overridePendingTransition(R.anim.right_in, R.anim.left_out);

    }


    //error verbergen, wordt opgeroepen elke keer de gebruiker opnieuw verder probeert te gaan
	private void clearErrors(){ 
		voornaamText.setError(null);
		naamText.setError(null);
        straatText.setError(null);
        huisnrText.setError(null);
        gemeenteText.setError(null);
        postcodeText.setError(null);
        busText.setError(null);
        telefoonText.setError(null);
        gsmText.setError(null);
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
            Intent intent1 = new Intent(this, RegistrerenDeel1.class);
            startActivity(intent1);

            overridePendingTransition(R.anim.left_in, R.anim.right_out);
        }

        return super.onOptionsItemSelected(item);
    }

	
}
