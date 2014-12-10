package com.hogent.ti3g05.ti3_g05_joetzapp.Services;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.Filterable;
import android.widget.TextView;
import android.widget.Toast;

import com.hogent.ti3g05.ti3_g05_joetzapp.R;
import com.hogent.ti3g05.ti3_g05_joetzapp.domein.Feedback;
import com.hogent.ti3g05.ti3_g05_joetzapp.domein.Vakantie;

import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

public class FeedbackAdapter extends ArrayAdapter<Vakantie> implements Filterable {

    private Context context;
    private LayoutInflater inflater;
    //private ImageLoader imageLoader;
    private List<Feedback> feedback = null;
    private ArrayList<Feedback> arraylist;
    private final String MAXIMALE_SCORE = "5";

    public FeedbackAdapter(Context context,
                           List<Feedback> feedback) {
        super(context, R.layout.listview_item);
        this.context = context;
        if(feedback == null || feedback.isEmpty())
        {
            Toast.makeText(context, "Er is nog geen feedback", Toast.LENGTH_LONG).show();
        }
        this.feedback = feedback;
        inflater = LayoutInflater.from(context);
        this.arraylist = new ArrayList<Feedback>();
        this.arraylist.addAll(feedback);
        //imageLoader = new ImageLoader(context);
    }




    public class ViewHolder {
        TextView tv_naamVakantie;
        TextView tv_feedback;
        TextView tv_score;
        TextView tv_gebruiker;
    }

    @Override
    public int getCount() {
        return feedback.size();
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
            view = inflater.inflate(R.layout.feedback_list_item, null);
            holder.tv_naamVakantie = (TextView) view.findViewById(R.id.vakantienaamFeedbackOverzicht);
            holder.tv_feedback = (TextView) view.findViewById(R.id.feedbackOverzicht);
            holder.tv_score = (TextView) view.findViewById(R.id.scoreOverzicht);
            holder.tv_gebruiker = (TextView) view.findViewById(R.id.gebruikerOverzicht);
            view.setTag(holder);
        } else {
            holder = (ViewHolder) view.getTag();
        }
        holder.tv_naamVakantie.setText(feedback.get(position).getVakantieNaam());
        holder.tv_feedback.setText(feedback.get(position).getFeedback());
        holder.tv_gebruiker.setText(feedback.get(position).getGebruiker());
        holder.tv_score.setText("Score: " + feedback.get(position).getScore().toString() + "/" + MAXIMALE_SCORE);
        return view;
    }
/*
        view.setOnClickListener(new View.OnClickListener() {

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
*/


    public void filter(String charText) {
        charText = charText.toLowerCase(Locale.getDefault());
        feedback.clear();
        if (charText.length() == 0) {
            feedback.addAll(arraylist);
        }
        else
        {
            for (Feedback wp : arraylist)
            {
                if (wp.getVakantieNaam().toLowerCase(Locale.getDefault()).contains(charText))
                {
                    feedback.add(wp);
                }
            }
        }
        notifyDataSetChanged();
    }
}
