package com.hogent.ti3g05.ti3_g05_joetzapp;

import android.app.Fragment;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

/**
 * Created by Gebruiker on 7/11/2014.
 */
public class afbeeldingVoor extends Fragment {
    public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        View rootView = inflater.inflate(R.layout.beginscherm, container, false);





      /*  Button inlogButton = (Button) rootView.findViewById(R.id.MainScreen_btnInloggen);

        inlogButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Intent intent1 = new Intent(getActivity(), Login.class);
                startActivity(intent1);
            }
        });

        Button registreerButton = (Button) rootView.findViewById(R.id.MainScreen_btnRegisteren);

        registreerButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Intent intent2 = new Intent(getActivity(), SignUp_deel1.class);
                startActivity(intent2);
            }
        });*/

        return rootView;
    }
}
