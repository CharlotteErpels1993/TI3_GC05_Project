package com.hogent.ti3g05.ti3_g05_joetzapp;

import android.app.Activity;
import android.app.Fragment;
import android.content.Intent;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.EditText;
import android.widget.ImageView;

import com.parse.ParseUser;

/**
 * Created by Gebruiker on 7/11/2014.
 */
public class afbeeldingUItvergroot extends Activity {
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        // Get the view from listview_main.xml
        setContentView(R.layout.afbeelding_uitvergroot);
        setTitle("");
        // Execute RemoteDataTask AsyncTask
        ImageView im = (ImageView)findViewById(R.id.afbvergroot);

        Intent i = getIntent();
        ImageLoader imageLoader = new ImageLoader(this);
        imageLoader.DisplayImage( i.getStringExtra("afbeelding"),im );
    }

    @Override
    protected void onDestroy()
    {
        super.onDestroy();
        ParseUser.logOut();
    }

}
