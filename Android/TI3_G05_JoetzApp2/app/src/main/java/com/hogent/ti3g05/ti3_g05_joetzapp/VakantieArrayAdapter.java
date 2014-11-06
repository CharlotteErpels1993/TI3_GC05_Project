package com.hogent.ti3g05.ti3_g05_joetzapp;

import java.util.ArrayList;
import java.util.List;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.TextView;

import com.hogent.ti3g05.ti3_g05_joetzapp.domein.Vakantie;
import com.parse.ParseUser;

public class VakantieArrayAdapter extends ArrayAdapter<Vakantie> {
    public VakantieArrayAdapter(Context context, List<Vakantie> vakanties) {
        super(context, 0, vakanties);
    }

    @Override
    public View getView(int position, View convertView, ViewGroup parent) {
        // Get the data item for this position
        Vakantie vakantie = getItem(position);
        // Check if an existing view is being reused, otherwise inflate the view
        if (convertView == null) {
            convertView = LayoutInflater.from(getContext()).inflate(R.layout.listview_item, parent, false);
        }
        // Lookup view for data population
        TextView tvNaam = (TextView) convertView.findViewById(R.id.txtTitelKamp);
        TextView tvLoc = (TextView) convertView.findViewById(R.id.locatie);
        TextView tvPrijs = (TextView) convertView.findViewById(R.id.prijs);
        if(ParseUser.getCurrentUser() != null)
            tvPrijs.setText((int) vakantie.getBasisprijs());

        // Populate the data into the template view using the data object
        tvNaam.setText(vakantie.getNaamVakantie());
        tvLoc.setText(vakantie.getLocatie());
        // Return the completed view to render on screen
        return convertView;
    }
}