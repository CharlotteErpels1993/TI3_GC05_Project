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

import com.hogent.ti3g05.ti3_g05_joetzapp.ImageLoader;
import com.hogent.ti3g05.ti3_g05_joetzapp.R;
import com.hogent.ti3g05.ti3_g05_joetzapp.VormingDetail;
import com.hogent.ti3g05.ti3_g05_joetzapp.domein.Vorming;

/*
Naam: VormingAdapter klasse

Werking: Deze klasse zal de juiste gegevens weergeven in het vormingoverzicht en de juiste gegevens doorgeven naar het vormingdetail
*/
public class VormingAdapter extends ArrayAdapter<Vorming> implements Filterable {

    private Context context;
    private LayoutInflater inflater;
    private List<Vorming> vormingen = null;
    private ArrayList<Vorming> vormingArrayList;


    public VormingAdapter(Context context, int resource) {
        super(context, resource);
    }

    public VormingAdapter(Context context,
                           List<Vorming> vormingen) {
        super(context, R.layout.list_view_item_vorming);
        this.context = context;
        this.vormingen = vormingen;
        inflater = LayoutInflater.from(context);
        this.vormingArrayList = new ArrayList<Vorming>();
        this.vormingArrayList.addAll(vormingen);
    }




    public class ViewHolder {
        TextView tv_titel;
        TextView tv_locatie;
        TextView tv_websiteLocatie;
    }

    /*
    Naam: getCount
    Werking: Geeft het aantal vormingen terug
    Return: aantal elementen van de vorming lijst
    */
    @Override
    public int getCount() {
        return vormingen.size();
    }


    /*
    Naam: getItemId
    Werking: Geeft het juiste item terug op basis van de positie
    Return: ID van het vormingItem, nl. hetzelfde als de position
    */
    @Override
    public long getItemId(int position) {
        return position;
    }

    /*
    Naam: getView
    Werking: Maakt een holder aan voor de view, zodat er minder overhead komt en de view niet steeds herladen moet worden,
    Hier wordt alles ingevuld op de juiste plaats. De juiste gegevens worden opgehaald door de positie, de view wordt ingevuld

    Parameters:
     - position: int - positie van het te constructeren item
     - view: View - de view die uiteindelijk zal geretourneerd worden.
     - parent: ViewGroup - de viewgroup waar het element in zit
    Return: De view die de gebruiker te zien krijgt, ingevuld met de juiste info op de juiste plek
    */
    public View getView(final int position, View view, ViewGroup parent) {
        final ViewHolder holder;
        if (view == null) {
            holder = new ViewHolder();
            view = inflater.inflate(R.layout.list_view_item_vorming, null);
            holder.tv_titel = (TextView) view.findViewById(R.id.titelV);
            holder.tv_locatie = (TextView) view.findViewById(R.id.locatieV);
            //holder.criteriaDeelnemer = (TextView) view.findViewById(R.id.criteriaDeelnemer);
            //holder.tips = (TextView) view.findViewById(R.id.tips);
            //holder.prijs = (TextView) view.findViewById(R.id.prijsV);
            holder.tv_websiteLocatie = (TextView) view.findViewById(R.id.websiteLocatie);
            view.setTag(holder);
        } else {
            holder = (ViewHolder) view.getTag();
        }
        holder.tv_titel.setText(vormingen.get(position).getTitel());
        holder.tv_locatie.setText(vormingen.get(position).getLocatie());
        //holder.prijs.setText("€ " + vormingen.get(position).getPrijs().toString());
        //holder.criteriaDeelnemer.setText(vormingen.get(position).getCriteriaDeelnemers());
        //holder.tips.setText(vormingen.get(position).getTips());
        holder.tv_websiteLocatie.setText(vormingen.get(position).getWebsiteLocatie());

        view.setOnClickListener(new OnClickListener() {

            @Override
            public void onClick(View arg0) {
                //Geeft de juiste gegevens door naar de detail activity van de vorming
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


    /*
    Naam: filter
    Werking: Filtert de lijst van vormingen door gebruik te maken van de meegegeven zoekcharacters
    Parameters:
     - charText: String - Het stuk tekst waar de gebruiker op wilt filteren.
    Return: niets. Lijst met vormingen wordt auto. aangepast
    */
    public void filter(String charText) {
        charText = charText.toLowerCase(Locale.getDefault());
        vormingen.clear();
        if (charText.length() == 0) {
            vormingen.addAll(vormingArrayList);
        }
        else
        {
            for (Vorming wp : vormingArrayList)
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