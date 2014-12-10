package com.hogent.ti3g05.ti3_g05_joetzapp;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.Toast;

import com.parse.ParseUser;


public class Loguit extends Activity {


    protected void onCreate(Bundle savedInstanceState) {

        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_logout);


        getActionBar().setTitle("Loguit");

        Button loguitButton = (Button) findViewById(R.id.btnLogUit);
        Button terugButton = (Button) findViewById(R.id.btnTerug);

        loguitButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                ParseUser.logOut();
                Toast.makeText(getApplicationContext(), "U bent uitgelogd", Toast.LENGTH_SHORT).show();

                Intent intent1 = new Intent(Loguit.this, navBarMainScreen.class); //navBarMainScreen
                startActivity(intent1);

            }
        });

        terugButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Intent intent1 = new Intent(Loguit.this, navBarMainScreen.class); //navBarMainScreen
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



}
