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
import android.widget.ImageView;
import android.widget.TextView;
import android.widget.Toast;

import com.hogent.ti3g05.ti3_g05_joetzapp.ImageLoader;
import com.hogent.ti3g05.ti3_g05_joetzapp.R;
import com.hogent.ti3g05.ti3_g05_joetzapp.activiteit_detail;
import com.hogent.ti3g05.ti3_g05_joetzapp.domein.Vakantie;

public class ListViewAdapter extends ArrayAdapter<Vakantie> implements Filterable {

    Context context;
    LayoutInflater inflater;
    ImageLoader imageLoader;
    private List<Vakantie> vakanties = null;
    private ArrayList<Vakantie> arraylist;

    public ListViewAdapter(Context context,
                           List<Vakantie> vakanties) {
        super(context, R.layout.listview_item);
        this.context = context;
        if(vakanties == null || vakanties.isEmpty())
        {
            Toast.makeText(context, "U heeft nog geen favoriete vakanties", Toast.LENGTH_LONG).show();
        }
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
            view = inflater.inflate(R.layout.listview_item_nieuwe_layout, null);
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

        holder.doelgroep.setText(vakanties.get(position).getMinDoelgroep() + " - " + vakanties.get(position).getMaxDoelgroep() + " jaar");


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
                intent.putExtra("maxdoelgroep", (vakanties.get(position).getMaxDoelgroep()).toString());
                intent.putExtra("mindoelgroep", vakanties.get(position).getMinDoelgroep().toString());
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
                intent.putExtra("link", (vakanties.get(position).getLink().toString()));

                String keyVoorIntent;
                ArrayList<String> lijstFotos = vakanties.get(position).getFotos();
                int lijstFotosLengte = lijstFotos.size()-1;
                for (int i = 0; i <= lijstFotosLengte; i++){
                    keyVoorIntent = "foto" + i;
                    intent.putExtra(keyVoorIntent, lijstFotos.get(i));
                }

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