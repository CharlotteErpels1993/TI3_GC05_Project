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

/*
Naam: ProfielAdapter klasse

Werking: Deze klasse zal de profielen in de lijst goed weergeven en de juiste gegevens doorgeven naar profieldetail
*/
public class ProfielAdapter extends ArrayAdapter<Vorming> implements Filterable {

    private Context context;
    private LayoutInflater inflater;
    private List<Monitor> profielen = null;
    private ArrayList<Monitor> profielenArrayList;

    public ProfielAdapter(Context context, List<Monitor> profielen) {
        super(context, R.layout.profiel_listview_item);
        this.context = context;
        this.profielen = profielen;
        inflater = LayoutInflater.from(context);
        this.profielenArrayList = new ArrayList<Monitor>();
        this.profielenArrayList.addAll(profielen);
    }

    public class ViewHolder {
        TextView tv_naam;
        TextView tv_voornaam;
        TextView tv_gemeente;
        TextView tv_header;
    }

    /*
    Naam: getCount
    Werking: deze methode geeft het aantal elementen in de lijst terug
    Return: aantal elementen van de profiel lijst
    */
    @Override
    public int getCount() {
        return profielen.size();
    }

    /*
    Naam: getItemId
    Werking: Geeft het juiste item terug op basis van de positie
    Return: ID van het profielItem, nl. hetzelfde als de position
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
            view = inflater.inflate(R.layout.profiel_listview_item, null);

            holder.tv_naam = (TextView) view.findViewById(R.id.achternaam);
            holder.tv_voornaam = (TextView) view.findViewById(R.id.voornaam);
            holder.tv_header= (TextView) view.findViewById(R.id.header);
            holder.tv_gemeente = (TextView) view.findViewById(R.id.gemeente);

            view.setTag(holder);
        } else {
            holder = (ViewHolder) view.getTag();
        }
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
                    //Geeft de juiste gegevens mee naar het detail van het profiel
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


    /*
    Naam: filter
    Werking: Filtert de lijst van profielen door gebruik te maken van de meegegeven zoekcharacters
    Parameters:
     - charText: String - Het stuk tekst waar de gebruiker op wilt filteren.
    Return: niets. Lijst met profielen wordt auto. aangepast
    */
    public void filter(String charText) {
        charText = charText.toLowerCase(Locale.getDefault());
        profielen.clear();
        if (charText.length() == 0) {
            profielen.addAll(profielenArrayList);
        }
        else
        {
            for (Monitor wp : profielenArrayList)
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