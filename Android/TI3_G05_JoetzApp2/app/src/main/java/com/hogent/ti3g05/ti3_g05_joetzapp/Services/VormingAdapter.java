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

import com.hogent.ti3g05.ti3_g05_joetzapp.ImageLoader;
import com.hogent.ti3g05.ti3_g05_joetzapp.R;
import com.hogent.ti3g05.ti3_g05_joetzapp.VormingDetail;
import com.hogent.ti3g05.ti3_g05_joetzapp.activiteit_detail;
import com.hogent.ti3g05.ti3_g05_joetzapp.domein.Vakantie;
import com.hogent.ti3g05.ti3_g05_joetzapp.domein.Vorming;
import com.parse.ParseUser;

import org.w3c.dom.Text;

public class VormingAdapter extends ArrayAdapter<Vorming> implements Filterable {

    Context context;
    LayoutInflater inflater;
    ImageLoader imageLoader;
    private List<Vorming> vormingen = null;
    private ArrayList<Vorming> arraylist;


    public VormingAdapter(Context context, int resource) {
        super(context, resource);
    }

    public VormingAdapter(Context context,
                           List<Vorming> vormingen) {
        super(context, R.layout.list_view_item_vorming);
        this.context = context;
        this.vormingen = vormingen;
        inflater = LayoutInflater.from(context);
        this.arraylist = new ArrayList<Vorming>();
        this.arraylist.addAll(vormingen);
        imageLoader = new ImageLoader(context);
    }




    public class ViewHolder {
        TextView titel;
        TextView locatie;
        //TextView criteriaDeelnemer;
        //TextView prijs;
        //TextView tips;
        TextView websiteLocatie;
    }

    @Override
    public int getCount() {
        return vormingen.size();
    }

   /* @Override
    public Object getItem(int position) {
        return vakanties.get(position);
    }*/

    @Override
    public long getItemId(int position) {
        return position;
    }

    public View getView(final int position, View view, ViewGroup parent) {
        final ViewHolder holder;
        if (view == null) {
            holder = new ViewHolder();
            view = inflater.inflate(R.layout.list_view_item_vorming, null);
            holder.titel = (TextView) view.findViewById(R.id.titelV);
            holder.locatie = (TextView) view.findViewById(R.id.locatieV);
            //holder.criteriaDeelnemer = (TextView) view.findViewById(R.id.criteriaDeelnemer);
            //holder.tips = (TextView) view.findViewById(R.id.tips);
            //holder.prijs = (TextView) view.findViewById(R.id.prijsV);
            holder.websiteLocatie = (TextView) view.findViewById(R.id.websiteLocatie);
            view.setTag(holder);
        } else {
            holder = (ViewHolder) view.getTag();
        }
        holder.titel.setText(vormingen.get(position).getTitel());
        holder.locatie.setText(vormingen.get(position).getLocatie());
        //holder.prijs.setText("€ " + vormingen.get(position).getPrijs().toString());
        //holder.criteriaDeelnemer.setText(vormingen.get(position).getCriteriaDeelnemers());
        //holder.tips.setText(vormingen.get(position).getTips());
        holder.websiteLocatie.setText(vormingen.get(position).getWebsiteLocatie());

        view.setOnClickListener(new OnClickListener() {

            @Override
            public void onClick(View arg0) {
                Intent intent = new Intent(context, VormingDetail.class);
                intent.putExtra("titel", (vormingen.get(position).getTitel()));
                intent.putExtra("locatie", (vormingen.get(position).getLocatie()));
                intent.putExtra("criteriaDeelnemers", (vormingen.get(position).getCriteriaDeelnemers()));
                intent.putExtra("tips", (vormingen.get(position).getTips()));
                intent.putExtra("prijs", vormingen.get(position).getPrijs().toString());
                intent.putExtra("websiteLocatie", vormingen.get(position).getWebsiteLocatie());
                intent.putExtra("korteBeschrijving", vormingen.get(position).getKorteBeschrijving());
                intent.putExtra("betalingswijze", vormingen.get(position).getBetalingswijze());
                intent.putExtra("inbegrepenInPrijs", vormingen.get(position).getInbegrepenInPrijs());
                intent.putExtra("objectId", vormingen.get(position).getActiviteitID());
                List<String> voorlopigeLijstVormingen = vormingen.get(position).getPeriodes();
                intent.putExtra("periodes", voorlopigeLijstVormingen.toArray(new String[voorlopigeLijstVormingen.size()]));
                intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
                context.startActivity(intent);
            }
        });
        return view;
    }



    public void filter(String charText) {
        charText = charText.toLowerCase(Locale.getDefault());
        vormingen.clear();
        if (charText.length() == 0) {
            vormingen.addAll(arraylist);
        }
        else
        {
            for (Vorming wp : arraylist)
            {
                if (wp.getLocatie().toLowerCase(Locale.getDefault()).contains(charText))
                {
                    vormingen.add(wp);
                }
            }
        }
        notifyDataSetChanged();
    }


}