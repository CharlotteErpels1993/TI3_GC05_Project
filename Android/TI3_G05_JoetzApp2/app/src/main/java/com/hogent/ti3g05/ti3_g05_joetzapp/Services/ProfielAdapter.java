package com.hogent.ti3g05.ti3_g05_joetzapp.Services;

import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

import android.content.Context;
import android.content.Intent;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.BaseAdapter;
import android.widget.Filter;
import android.widget.Filterable;
import android.widget.ImageView;
import android.widget.TextView;
import android.widget.Toast;

import com.hogent.ti3g05.ti3_g05_joetzapp.ImageLoader;
import com.hogent.ti3g05.ti3_g05_joetzapp.ProfielDetail;
import com.hogent.ti3g05.ti3_g05_joetzapp.R;
import com.hogent.ti3g05.ti3_g05_joetzapp.VormingDetail;
import com.hogent.ti3g05.ti3_g05_joetzapp.activiteit_detail;
import com.hogent.ti3g05.ti3_g05_joetzapp.domein.Monitor;
import com.hogent.ti3g05.ti3_g05_joetzapp.domein.Vakantie;
import com.hogent.ti3g05.ti3_g05_joetzapp.domein.Vorming;
import com.parse.ParseUser;

import org.w3c.dom.Text;

public class ProfielAdapter extends ArrayAdapter<Vorming> implements Filterable {

    Context context;
    LayoutInflater inflater;
    ImageLoader imageLoader;
    private List<Monitor> profielen = null;
    private ArrayList<Monitor> arraylist;


    public ProfielAdapter(Context context, int resource) {
        super(context, resource);
    }

    public ProfielAdapter(Context context,
                          List<Monitor> profielen) {
        super(context, R.layout.profiel_listview_item);
        this.context = context;
        this.profielen = profielen;
        inflater = LayoutInflater.from(context);
        this.arraylist = new ArrayList<Monitor>();
        this.arraylist.addAll(profielen);
        imageLoader = new ImageLoader(context);
    }




    public class ViewHolder {
        TextView naam;
        TextView voornaam;
        TextView straat;
        TextView gemeente;
        TextView lidNr;
        TextView gsm;
        TextView rijksregNr;
    }

    @Override
    public int getCount() {
        return profielen.size();
    }

    @Override
    public long getItemId(int position) {
        return position;
    }

    public View getView(final int position, View view, ViewGroup parent) {
        final ViewHolder holder;
        if (view == null) {
            holder = new ViewHolder();
            view = inflater.inflate(R.layout.profiel_listview_item, null);

            holder.naam = (TextView) view.findViewById(R.id.achternaam);
            holder.voornaam = (TextView) view.findViewById(R.id.voornaam);
            holder.straat = (TextView) view.findViewById(R.id.straat);
            holder.gemeente = (TextView) view.findViewById(R.id.gemeente);
            holder.lidNr = (TextView) view.findViewById(R.id.lidNr);

            view.setTag(holder);
        } else {
            holder = (ViewHolder) view.getTag();
        }
        //TODO geeft error bij getview bij sqlite

        holder.naam.setText(profielen.get(position).getNaam());
        holder.voornaam.setText(profielen.get(position).getVoornaam());

        holder.straat.setText(profielen.get(position).getStraat());
        holder.gemeente.setText(profielen.get(position).getGemeente());
        //holder.lidNr.setText(profielen.get(position).getLidNummer());

        view.setOnClickListener(new OnClickListener() {

            @Override
            public void onClick(View arg0) {
                Intent intent = new Intent(context, ProfielDetail.class);
                intent.putExtra("naam",
                        (profielen.get(position).getNaam()));
                intent.putExtra("voornaam",
                        (profielen.get(position).getVoornaam()));
                /*intent.putExtra("straat", (profielen.get(position).getStraat()));
                intent.putExtra("gemeente", (profielen.get(position).getGemeente()));
                intent.putExtra("rijksregNr", profielen.get(position).getRijksregNr());
                //intent.putExtra("lidNr", profielen.get(position).getLidNummer());*/
                intent.putExtra("facebook", profielen.get(position).getLinkFacebook());
                intent.putExtra("gsm", profielen.get(position).getGsm());
                intent.putExtra("email", profielen.get(position).getEmail());
                context.startActivity(intent);
            }
        });
        return view;
    }



    public void filter(String charText) {
        charText = charText.toLowerCase(Locale.getDefault());
        profielen.clear();
        if (charText.length() == 0) {
            profielen.addAll(arraylist);
        }
        else
        {
            for (Monitor wp : arraylist)
            {
                if (wp.getNaam().toLowerCase(Locale.getDefault()).contains(charText))
                {
                    profielen.add(wp);
                }
            }
        }
        notifyDataSetChanged();
    }


}