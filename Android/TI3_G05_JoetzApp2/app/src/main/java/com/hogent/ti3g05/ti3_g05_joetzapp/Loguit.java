package com.hogent.ti3g05.ti3_g05_joetzapp;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.Button;
import android.widget.Toast;

import com.parse.ParseUser;

//Laat de gebruiker uitloggen
public class Loguit extends Activity {


    protected void onCreate(Bundle savedInstanceState) {

        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_logout);


        getActionBar().setTitle("Loguit");

        Button loguitButton = (Button) findViewById(R.id.btnLogUit);

        loguitButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                //Bij het klikken op de knop wordt de gebruiker uitgelogd en doorgestuurd naar het overzicht van de vakanties
                ParseUser.logOut();
                Toast.makeText(getApplicationContext(), "U bent uitgelogd", Toast.LENGTH_SHORT).show();

                Intent intent1 = new Intent(Loguit.this, navBarMainScreen.class);
                startActivity(intent1);

            }
        });

    }

    @Override
    public void onBackPressed() {
        Intent setIntent = new Intent(Loguit.this, navBarMainScreen.class);
        setIntent.addCategory(Intent.CATEGORY_HOME);
        setIntent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
        startActivity(setIntent);
    }

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
            Intent intent1 = new Intent(Loguit.this, navBarMainScreen.class);
            if(ParseUser.getCurrentUser().get("soort").toString().toLowerCase().equals("monitor"))
            {
                intent1.putExtra("naarfrag", "profiel");
            }
            else
            {
                intent1.putExtra("naarfrag", "vakantie");
            }
            intent1.putExtra("herladen", "nee");
            intent1.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
            startActivity(intent1);

            overridePendingTransition(R.anim.left_in, R.anim.right_out);
        }

        return super.onOptionsItemSelected(item);
    }


}
