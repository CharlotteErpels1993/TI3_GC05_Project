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
import android.widget.RatingBar;
import android.widget.TextView;
import android.widget.Toast;

import com.hogent.ti3g05.ti3_g05_joetzapp.ImageLoader;
import com.hogent.ti3g05.ti3_g05_joetzapp.R;
import com.hogent.ti3g05.ti3_g05_joetzapp.VakantieDetail;
import com.hogent.ti3g05.ti3_g05_joetzapp.domein.Vakantie;

//Deze klasse zal de vakantie gegevens op de juiste plaats zetten en de juiste gegevens weergeven en doorgeven
public class VakantieAdapter extends ArrayAdapter<Vakantie> implements Filterable {

    private Context context;
    private LayoutInflater inflater;
    private ImageLoader imageLoader;
    private List<Vakantie> vakanties = null;
    private ArrayList<Vakantie> vakantieArrayList;

    public VakantieAdapter(Context context,
                           List<Vakantie> vakanties) {
        super(context, R.layout.listview_item);
        this.context = context;
        if(vakanties == null || vakanties.isEmpty())
        {
            Toast.makeText(context, "U heeft nog geen favoriete vakanties", Toast.LENGTH_LONG).show();
        }
        this.vakanties = vakanties;
        inflater = LayoutInflater.from(context);
        this.vakantieArrayList = new ArrayList<Vakantie>();
        this.vakantieArrayList.addAll(vakanties);
        imageLoader = new ImageLoader(context);
    }




    public class ViewHolder {
        TextView et_naamVakantie;
        TextView et_locatie;
        ImageView et_vakantiefto;
        TextView et_doelgroep;
        RatingBar gemiddeldeScore;
    }


    //Geeft het aantal vakanties terug
    @Override
    public int getCount() {
        return vakanties.size();
    }


    //Geeft het juiste item terug op basis van de positie
    @Override
    public long getItemId(int position) {
        return position;
    }

    //Maakt een holder aan voor de view, zodat er minder overhead komt en de view niet steeds herladen moet worden, Hier wordt alles ingevuld op de juiste plaats
    //De juiste gegevens worden opgehaald door de positie, de view wordt ingevuld
    public View getView(final int position, View view, ViewGroup parent) {
        final ViewHolder holder;
        if (view == null) {
            holder = new ViewHolder();
            view = inflater.inflate(R.layout.listview_item_nieuwe_layout, null);
            holder.et_naamVakantie = (TextView) view.findViewById(R.id.naam);
            holder.et_locatie = (TextView) view.findViewById(R.id.locatie);
            //holder.et_vertrekdatum = (TextView) view.findViewById(R.id.vertrekdatum);
            //holder.et_terugdatum = (TextView) view.findViewById(R.id.terugdatum);
            holder.et_vakantiefto = (ImageView) view.findViewById(R.id.afbeelding);
            //holder.et_prijs = (TextView) view.findViewById(R.id.prijs);
            holder.et_doelgroep = (TextView) view.findViewById(R.id.doelgroep);
            holder.gemiddeldeScore = (RatingBar) view.findViewById(R.id.gemiddeldeRating);
            view.setTag(holder);
        } else {
            holder = (ViewHolder) view.getTag();
        }
        holder.et_naamVakantie.setText(vakanties.get(position).getNaamVakantie());
        holder.et_locatie.setText(vakanties.get(position).getLocatie());

        holder.et_doelgroep.setText(vakanties.get(position).getMinDoelgroep() + " - " + vakanties.get(position).getMaxDoelgroep() + " jaar");
        holder.gemiddeldeScore.setRating(vakanties.get(position).getGemiddeldeRating());

        imageLoader.DisplayImage(vakanties.get(position).getFoto1(),  holder.et_vakantiefto);

        view.setOnClickListener(new OnClickListener() {

            @Override
            public void onClick(View arg0) {

                //Geeft de nodige gegevens mee bij het klikken op een item in de lijst, dit verwijst door naar de detail pagina
                Intent intent = new Intent(context, VakantieDetail.class);
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
                intent.putExtra("link", (vakanties.get(position).getLink()));
                intent.putExtra("gemiddeldeScore",String.valueOf(vakanties.get(position).getGemiddeldeRating()));
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


    //Filtert de lijst van vakanties door gebruik te maken van de meegegeven zoekcharacters
    public void filter(String charText) {
        charText = charText.toLowerCase(Locale.getDefault());
        vakanties.clear();
        if (charText.length() == 0) {
            vakanties.addAll(vakantieArrayList);
        }
        else
        {
            for (Vakantie wp : vakantieArrayList)
            {
                if (wp.getLocatie().toLowerCase(Locale.getDefault()).contains(charText) || wp.getNaamVakantie().toLowerCase(Locale.getDefault()).contains(charText))
                {
                    vakanties.add(wp);
                }
            }
        }
        notifyDataSetChanged();
    }


}