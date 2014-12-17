package com.hogent.ti3g05.ti3_g05_joetzapp;

import android.content.Intent;
import android.os.Bundle;
import android.support.v4.app.DialogFragment;
import android.support.v4.app.FragmentActivity;
import android.text.TextUtils;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.view.animation.Animation;
import android.view.animation.AnimationUtils;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;
import android.widget.Toast;

import com.hogent.ti3g05.ti3_g05_joetzapp.Services.ConnectionDetector;
import com.hogent.ti3g05.ti3_g05_joetzapp.domein.Activiteit;

import org.w3c.dom.Text;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

//Biedt de ouder de mogelijkheid tot inschrijven in een vakantie,
// stap 1
public class InschrijvenVakantieDeel1 extends FragmentActivity {

    private EditText txtVoornaam, txtNaam, txtStraat, txtHuisnr, txtBus, txtGemeente, txtPostcode;

    private String maandI, datum ,voornaam, naam, straat, huisnr, bus, gemeente, postcode, objectID;
    private String maxdoelgroep, mindoelgroep, vakantieNaam;

    private TextView tv_maand;
    private Button btnVolgende;

    private TextView tv_errorDate;

    private TextView vakantie;
    private TextView minLeeftijd;

    private TextView gebDatum;
    private boolean cancel = false;
    private View focusView = null;

    private Boolean isInternetPresent = false;
    private ConnectionDetector cd;
    private Calendar cal = Calendar.getInstance();

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_inschrijven_vakantie_part1);

        cd = new ConnectionDetector(getApplicationContext());
        final Animation animAlpha = AnimationUtils.loadAnimation(this, R.anim.alpha);


        Intent i = getIntent();
        mindoelgroep = i.getStringExtra("mindoelgroep");
        maxdoelgroep = i.getStringExtra("maxdoelgroep");
        objectID =  i.getStringExtra("objectId");
        vakantieNaam = i.getStringExtra("vakantieNaam");

        txtVoornaam = (EditText) findViewById(R.id.VoornaamIns);
        txtNaam = (EditText) findViewById(R.id.NaamIns);
        txtStraat = (EditText) findViewById(R.id.Straat);
        txtHuisnr = (EditText) findViewById(R.id.Huisnr);
        txtBus = (EditText) findViewById(R.id.Bus);
        txtGemeente = (EditText) findViewById(R.id.Gemeente);
        txtPostcode = (EditText) findViewById(R.id.Postcode);
        gebDatum = (TextView) findViewById(R.id.DateIns);
        tv_maand = (TextView) findViewById(R.id.maandIns);
        tv_errorDate = (TextView) findViewById(R.id.ErrorDate);
        tv_errorDate.setVisibility(View.GONE);
        vakantie = (TextView) findViewById(R.id.vakantie);
        minLeeftijd = (TextView) findViewById(R.id.minLeeftijd);

        vakantie.setText(vakantieNaam);
        minLeeftijd.setText(getString(R.string.doelgroep) + " " + mindoelgroep + " - " + maxdoelgroep + getString(R.string.vakantieAantalJaar));

        getActionBar().setTitle(getString(R.string.title_activity_inschrijven));
        btnVolgende = (Button)findViewById(R.id.btnNaarDeel2Vak);
        btnVolgende.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                btnVolgende.startAnimation(animAlpha);
                //Bij het klikken op de knop controleer of er internet aanwezig is, zoja controleer de gegevens
                //Zoneen toon een gepaste melding
                isInternetPresent = cd.isConnectingToInternet();

                if (isInternetPresent) {
                    controlerenOpfouten();
                }
                else{
                    Toast.makeText(getApplicationContext(), getString(R.string.error_no_internet), Toast.LENGTH_SHORT).show();
                }
            }
        });

        TextView tvOpvullen = (TextView) findViewById(R.id.AlgemeneUitleg);
        tvOpvullen.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                txtVoornaam.setText("Peter");
                txtNaam.setText("Bosman");
                txtStraat.setText("Mandellaan");
                txtHuisnr.setText("85");
                txtGemeente.setText("Roesselare");
                txtPostcode.setText("8800");
                gebDatum.setText("Nov 24, 1998");
                maandI = "Nov 24, 1998";
                tv_maand.setText("Nov 24, 1998");
                TextView dag = (TextView) findViewById(R.id.dagIns);
                TextView jaar = (TextView) findViewById(R.id.jaarIns);
                dag.setText("24");
                jaar.setText("1998");

            }
        });
    }



    //Toon de datepicker dialoog
    public void showDatePickerDialog(View v) {
        DialogFragment newFragment = new CustomDatePicker();
        newFragment.show(getSupportFragmentManager(), "datePicker");
    }

    //Controleer de ingegeven waarden en sla deze op indien juist
    public void controlerenOpfouten(){
        clearErrors();
        cancel = false;

        voornaam = txtVoornaam.getText().toString().toLowerCase();
        naam = txtNaam.getText().toString().toLowerCase();
        straat = txtStraat.getText().toString();
        huisnr = txtHuisnr.getText().toString();
        bus = txtBus.getText().toString();
        gemeente = txtGemeente.getText().toString();
        postcode = txtPostcode.getText().toString();
        datum = gebDatum.getText().toString();
        maandI = tv_maand.getText().toString();



        if (TextUtils.isEmpty(postcode)) {
            txtPostcode.setError(getString(R.string.error_field_required));
            focusView = txtPostcode;
            cancel = true;
        } else {
            if (postcode.length() != 4) {
                txtPostcode.setError(getString(R.string.error_incorrect_postcode));
                focusView = txtPostcode;
                cancel = true;
            }
            if (Integer.parseInt(postcode) > 9992) {
                txtPostcode.setError(getString(R.string.error_incorrect_postcode));
                focusView = txtPostcode;
                cancel = true;
            }
        }

        if (TextUtils.isEmpty(gemeente)) {
            txtGemeente.setError(getString(R.string.error_field_required));
            focusView = txtGemeente;
            cancel = true;
        }else if (Activiteit.containsNumbers(gemeente)){
            txtGemeente.setError(getString(R.string.error_noNumbers));
            focusView = txtGemeente;
            cancel = true;
        }

        if(gebDatum.getText().equals(""))
        {
            gebDatum.setError(getString(R.string.error_field_required));
            focusView = gebDatum;
            tv_errorDate.setText(getString(R.string.error_field_required));
            tv_errorDate.setVisibility(View.VISIBLE);
            cancel = true;
        }
        else{
            //Zet de datum in het juiste formaat voor opslag
            SimpleDateFormat formatter = new SimpleDateFormat("MMM dd, yyyy");
            Date date = null;
            try {
                date = formatter.parse(maandI);

            } catch (ParseException e) {
                gebDatum.setError(getString(R.string.error_generalException));
                focusView = gebDatum;
                tv_errorDate.setText(getString(R.string.error_generalException));
                tv_errorDate.setVisibility(View.VISIBLE);
                cancel = true;
                Toast.makeText(InschrijvenVakantieDeel1.this, getString(R.string.error_generalException),Toast.LENGTH_SHORT).show();
            }

            cal.setTime(date);
            int year = cal.get(Calendar.YEAR);
            int month = cal.get(Calendar.MONTH);
            int day = cal.get(Calendar.DAY_OF_MONTH);

            int age = getAge(year, month, day);

            //Controleer of de geboortedatum binnen de doelgroep valt
            if(age < Integer.parseInt(mindoelgroep) || age > Integer.parseInt(maxdoelgroep))
            {
                gebDatum.setError(getString(R.string.error_incorrecte_leeftijd));
                focusView = gebDatum;
                tv_errorDate.setText(getString(R.string.error_incorrecte_leeftijd));
                tv_errorDate.setVisibility(View.VISIBLE);
                cancel = true;
            }
        }


        if (TextUtils.isEmpty(huisnr)) {
            txtHuisnr.setError(getString(R.string.error_field_required));
            focusView = txtHuisnr;
            cancel = true;
        }
        else{
            if (!(huisnr.length() >= 1)){
                txtHuisnr.setError(getString(R.string.error_incorrect_huisnr));
                focusView = txtHuisnr;
                cancel = true;
            }
        }


        if (TextUtils.isEmpty(straat)) {
            txtStraat.setError(getString(R.string.error_field_required));
            focusView = txtStraat;
            cancel = true;
        } else if (Activiteit.containsNumbers(straat)){
            txtStraat.setError(getString(R.string.error_noNumbers));
            focusView = txtStraat;
            cancel = true;
        }

        if (TextUtils.isEmpty(voornaam)) {
            txtVoornaam.setError(getString(R.string.error_field_required));
            focusView = txtVoornaam;
            cancel = true;
        }else if (Activiteit.containsNumbers(voornaam)){
            txtVoornaam.setError(getString(R.string.error_noNumbers));
            focusView = txtVoornaam;
            cancel = true;
        }

        if (TextUtils.isEmpty(naam)) {
            txtNaam.setError(getString(R.string.error_field_required));
            focusView = txtNaam;
            cancel = true;
        }else if (Activiteit.containsNumbers(naam)){
            txtNaam.setError(getString(R.string.error_noNumbers));
            focusView = txtNaam;
            cancel = true;
        }

        if (cancel){
            focusView.requestFocus();
        } else {
            opslaan(voornaam ,naam, straat, huisnr, bus, gemeente, postcode);

        }
    }

    //Sla de gegevens op en stuur deze door naar de volgende stap
    private void opslaan(String voornaam,String naam, String straat, String huisnr, String bus, String gemeente, String postcode) {
        Toast.makeText(getApplicationContext(), getString(R.string.loading_message), Toast.LENGTH_SHORT).show();

        Intent in = new Intent(getApplicationContext(),InschrijvenVakantieDeel2.class);

        in.putExtra("voornaam", voornaam);
        in.putExtra("naam", naam);
        in.putExtra("straat", straat);
        in.putExtra("huisnr", huisnr);
        in.putExtra("bus", bus);
        in.putExtra("gemeente", gemeente);
        in.putExtra("postcode", postcode);
        in.putExtra("objectId", objectID);
        in.putExtra("datum", maandI);

        startActivity(in);

        overridePendingTransition(R.anim.right_in, R.anim.left_out);

    }

    //Verwijder de error's
    private void clearErrors(){
        txtVoornaam.setError(null);
        txtNaam.setError(null);
        txtStraat.setError(null);
        txtHuisnr.setError(null);
        txtBus.setError(null);
        txtGemeente.setError(null);
        txtPostcode.setError(null);
        gebDatum.setError(null);
        tv_errorDate.setVisibility(View.GONE);
    }

    //Controle of de leeftijd binnen de doelgroep valt
    public int getAge(int DOByear, int DOBmonth, int DOBday) {

        int age;

        final Calendar calenderToday = Calendar.getInstance();
        int currentYear = calenderToday.get(Calendar.YEAR);
        int currentMonth = 1 + calenderToday.get(Calendar.MONTH);
        int todayDay = calenderToday.get(Calendar.DAY_OF_MONTH);

        age = currentYear - DOByear;

        if(DOBmonth > currentMonth){
            --age;
        }
        else if(DOBmonth == currentMonth){
            if(DOBday > todayDay){
                --age;
            }
        }
        return age;
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
            Intent intent1 = new Intent(this, navBarMainScreen.class);
            startActivity(intent1);

            overridePendingTransition(R.anim.left_in, R.anim.right_out);
        }

        return super.onOptionsItemSelected(item);
    }

    @Override
    public void onBackPressed() {
        Intent setIntent = new Intent(InschrijvenVakantieDeel1.this, navBarMainScreen.class);
        setIntent.putExtra("naarfrag","vakantie");
        setIntent.putExtra("herladen","nee");
        setIntent.addCategory(Intent.CATEGORY_HOME);
        setIntent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
        startActivity(setIntent);
    }
}
