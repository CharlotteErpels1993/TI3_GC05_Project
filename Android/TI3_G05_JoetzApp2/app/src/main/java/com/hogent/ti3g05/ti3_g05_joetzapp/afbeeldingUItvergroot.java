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

//geeft de geselecteerde afbeelding vergroot weer
public class afbeeldingUItvergroot extends Activity {
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        setContentView(R.layout.afbeelding_uitvergroot);
        setTitle("");

        ImageView im = (ImageView)findViewById(R.id.afbvergroot);

        Intent i = getIntent();
        ImageLoader imageLoader = new ImageLoader(this);
        imageLoader.DisplayImage( i.getStringExtra("afbeelding"),im );
    }



}
