package com.hogent.ti3g05.ti3_g05_joetzapp.Services;

import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

import android.content.Context;
import android.content.Intent;
import android.view.LayoutInflater;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.Filterable;
import android.widget.TextView;

import com.hogent.ti3g05.ti3_g05_joetzapp.ProfielDetail;
import com.hogent.ti3g05.ti3_g05_joetzapp.R;
import com.hogent.ti3g05.ti3_g05_joetzapp.domein.Monitor;
import com.hogent.ti3g05.ti3_g05_joetzapp.domein.Vorming;

public class ProfielAdapter extends ArrayAdapter<Vorming> implements Filterable {

    private Context context;
    private LayoutInflater inflater;
    //private ImageLoader imageLoader;
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
        //imageLoader = new ImageLoader(context);
    }




    public class ViewHolder {
        TextView tv_naam;
        TextView tv_voornaam;
        //TextView straat;
        TextView tv_gemeente;
        TextView tv_header;
        //TextView lidNr;
        //TextView gsm;
        //TextView rijksregNr;
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

            holder.tv_naam = (TextView) view.findViewById(R.id.achternaam);
            holder.tv_voornaam = (TextView) view.findViewById(R.id.voornaam);
            holder.tv_header= (TextView) view.findViewById(R.id.header);
            //holder.straat = (TextView) view.findViewById(R.id.straat);
            holder.tv_gemeente = (TextView) view.findViewById(R.id.gemeente);
            //holder.lidNr = (TextView) view.findViewById(R.id.lidNr);

            view.setTag(holder);
        } else {
            holder = (ViewHolder) view.getTag();
        }
        //TODO geeft error bij getview bij sqlite
        if (profielen.get(position).getEmail() == null){
            holder.tv_header.setVisibility(View.VISIBLE);
            holder.tv_naam.setVisibility(View.GONE);
            holder.tv_voornaam.setVisibility(View.GONE);
            holder.tv_gemeente.setVisibility(View.GONE);

            holder.tv_header.setText(profielen.get(position).getMonitorId());
            view.setOnClickListener(null);
            return view;
        }
        else{
            holder.tv_header.setVisibility(View.GONE);
            holder.tv_naam.setText(profielen.get(position).getNaam());
            holder.tv_voornaam.setText(profielen.get(position).getVoornaam());
            holder.tv_gemeente.setText(profielen.get(position).getGemeente());

            view.setOnClickListener(new OnClickListener() {

                @Override
                public void onClick(View arg0) {
                    Intent intent = new Intent(context, ProfielDetail.class);
                    intent.putExtra("naam",
                            (profielen.get(position).getNaam()));
                    intent.putExtra("voornaam",
                            (profielen.get(position).getVoornaam()));
                    intent.putExtra("gsm", profielen.get(position).getGsmnr());
                    intent.putExtra("email", profielen.get(position).getEmail());
                    intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
                    context.startActivity(intent);
                }
            });
            return view;
        }


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
                if (wp.getNaam().toLowerCase(Locale.getDefault()).contains(charText) || wp.getVoornaam().toLowerCase(Locale.getDefault()).contains(charText))
                {
                    profielen.add(wp);
                }
            }
        }
        notifyDataSetChanged();
    }


}