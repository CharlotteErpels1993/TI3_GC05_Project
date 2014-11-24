package com.hogent.ti3g05.ti3_g05_joetzapp.Services;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;

import android.content.Context;
import android.content.Intent;
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
import com.hogent.ti3g05.ti3_g05_joetzapp.activiteit_detail;
import com.hogent.ti3g05.ti3_g05_joetzapp.domein.Vakantie;
import com.parse.ParseFile;
import com.parse.ParseUser;

import org.w3c.dom.Text;

public class ListViewAdapter extends ArrayAdapter<Vakantie> implements Filterable {

    Context context;
    LayoutInflater inflater;
    ImageLoader imageLoader;
    private List<Vakantie> vakanties = null;
    private ArrayList<Vakantie> arraylist;
    private HashMap<String, ArrayList<ParseFile>> afbeeldingenMap;



    public ListViewAdapter(Context context,
                           List<Vakantie> vakanties) {
        super(context, R.layout.listview_item);
        this.context = context;
        this.vakanties = vakanties;
        inflater = LayoutInflater.from(context);
        this.arraylist = new ArrayList<Vakantie>();
        this.arraylist.addAll(vakanties);
        imageLoader = new ImageLoader(context);
    }




    public class ViewHolder {
        TextView naamVakantie;
        TextView locatie;
        TextView vertrekdatum;
        TextView terugdatum;
        TextView prijs;
        ImageView vakantiefto;
        TextView doelgroep;
    }

    @Override
    public int getCount() {
        return vakanties.size();
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
            view = inflater.inflate(R.layout.listview_item, null);
            holder.naamVakantie = (TextView) view.findViewById(R.id.naam);
            holder.locatie = (TextView) view.findViewById(R.id.locatie);
            holder.vertrekdatum = (TextView) view.findViewById(R.id.vertrekdatum);
            holder.terugdatum = (TextView) view.findViewById(R.id.terugdatum);
            holder.vakantiefto = (ImageView) view.findViewById(R.id.afbeelding);
            holder.prijs = (TextView) view.findViewById(R.id.prijs);
            holder.doelgroep = (TextView) view.findViewById(R.id.doelgroep);
            view.setTag(holder);
        } else {
            holder = (ViewHolder) view.getTag();
        }
        holder.naamVakantie.setText(vakanties.get(position).getNaamVakantie());
        holder.locatie.setText(vakanties.get(position).getLocatie());
       /* if(ParseUser.getCurrentUser() != null)
        {
            holder.prijs.setText((int) vakanties.get(position).getBasisprijs());
        }*/
        //holder.vertrekdatum.setText(( vakanties.get(position).getVertrekDatum().toString()));
        //holder.terugdatum.setText(( vakanties.get(position).getTerugkeerDatum().toString()));
        holder.doelgroep.setText(vakanties.get(position).getDoelGroep());
        imageLoader.DisplayImage(vakanties.get(position).getFoto1(),  holder.vakantiefto);
        view.setOnClickListener(new OnClickListener() {

            @Override
            public void onClick(View arg0) {
                Intent intent = new Intent(context, activiteit_detail.class);
                intent.putExtra("naam", (vakanties.get(position).getNaamVakantie()));
                intent.putExtra("locatie", (vakanties.get(position).getLocatie()));
                if(vakanties.get(position).getVertrekDatum() == null || vakanties.get(position).getTerugkeerDatum() == null)
                {
                    intent.putExtra("vertrekdatum", (vakanties.get(position).getVertrekDatumString()));
                    intent.putExtra("terugdatum", (vakanties.get(position).getTerugDatumString()));
                }
                else
                {
                    intent.putExtra("vertrekdatum", (vakanties.get(position).getVertrekDatum()).toString());
                    intent.putExtra("terugdatum", (vakanties.get(position).getTerugkeerDatum()).toString());
                }
                intent.putExtra("prijs", vakanties.get(position).getBasisprijs().toString());
                intent.putExtra("afbeelding1", vakanties.get(position).getFoto1());
                intent.putExtra("afbeelding2", vakanties.get(position).getFoto2());
                intent.putExtra("afbeelding3", vakanties.get(position).getFoto3());
                //intent.putExtra("fotos", vakanties.get(position).getFotos());
                intent.putExtra("doelgroep", vakanties.get(position).getDoelGroep());
                intent.putExtra("objectId", vakanties.get(position).getVakantieID());
                intent.putExtra("beschrijving", vakanties.get(position).getKorteBeschrijving());
                intent.putExtra("periode", vakanties.get(position).getPeriode());
                intent.putExtra("vervoer", vakanties.get(position).getVervoerswijze());
                intent.putExtra("formule", vakanties.get(position).getFormule());
                intent.putExtra("maxAantalDeelnemers",(vakanties.get(position).getMaxAantalDeelnemers()).toString());
                intent.putExtra("InbegrepenInPrijs", (vakanties.get(position).getInbegrepenInPrijs()));
                intent.putExtra("BMledenPrijs", (vakanties.get(position).getBondMoysonLedenPrijs()).toString());
                intent.putExtra("SterPrijs1Ouder", (vakanties.get(position).getSterPrijs1Ouder()).toString());
                intent.putExtra("SterPrijs2Ouders", (vakanties.get(position).getSterPrijs2Ouder()).toString());

                intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
                context.startActivity(intent);
            }
        });
        return view;
    }



    public void filter(String charText) {
        charText = charText.toLowerCase(Locale.getDefault());
        vakanties.clear();
        if (charText.length() == 0) {
            vakanties.addAll(arraylist);
        }
        else
        {
            for (Vakantie wp : arraylist)
            {
                if (wp.getLocatie().toLowerCase(Locale.getDefault()).contains(charText))
                {
                    vakanties.add(wp);
                }
            }
        }
        notifyDataSetChanged();
    }


}