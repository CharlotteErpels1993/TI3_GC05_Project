package com.hogent.ti3g05.ti3_g05_joetzapp;

import android.app.Activity;
import android.app.FragmentManager;
import android.app.FragmentTransaction;
import android.content.Intent;
import android.os.Bundle;
import android.support.v4.app.ActionBarDrawerToggle;
import android.support.v4.widget.DrawerLayout;
import android.view.View;
import android.webkit.WebViewFragment;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.ListView;
import android.widget.Toast;

import com.parse.ParseUser;

/**
 * Created by Gebruiker on 14/11/2014.
 */
public class Loguit extends Activity {

    private Button loguitButton;
    private Button terugButton;



    protected void onCreate(Bundle savedInstanceState) {

        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_logout);


        getActionBar().setTitle("");

        loguitButton = (Button) findViewById(R.id.btnLogUit);
        terugButton = (Button) findViewById(R.id.btnTerug);

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
