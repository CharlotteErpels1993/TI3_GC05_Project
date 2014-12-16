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

/*
Naam: FeedbackAdapter klasse

Werking: Deze klasse zal ervoor zorgen dat alle gegevens van feedback op de juiste plaatsen worden getoond en omgezet zullen worden naar de juiste formaten.
*/
public class FeedbackAdapter extends ArrayAdapter<Vakantie> implements Filterable {

    private Context context;
    private LayoutInflater inflater;
    private List<Feedback> feedbackLijst = null;
    private ArrayList<Feedback> feedbackArrayList;
    private final String MAXIMALE_SCORE = "5";

    public FeedbackAdapter(Context context,
                           List<Feedback> feedbackLijst) {
        super(context, R.layout.listview_item);
        this.context = context;
        if(feedbackLijst == null || feedbackLijst.isEmpty())
        {
            Toast.makeText(context, "Er is nog geen feedback", Toast.LENGTH_LONG).show();
        }
        this.feedbackLijst = feedbackLijst;
        inflater = LayoutInflater.from(context);
        this.feedbackArrayList = new ArrayList<Feedback>();
        this.feedbackArrayList.addAll(feedbackLijst);
    }




    public class ViewHolder {
        TextView tv_naamVakantie;
        TextView tv_feedback;
        TextView tv_score;
        //TextView tv_gebruiker;
    }

    /*
    Naam: getCount
    Werking: deze methode geeft het aantal elementen in de lijst terug
    Return: aantal elementen van de feedback lijst
    */
    @Override
    public int getCount() {
        return feedbackLijst.size();
    }


    /*
    Naam: getItemId
    Werking: Geeft het juiste item terug op basis van de positie
    Return: ID van het feedbackItem, nl. hetzelfde als de position
    */
    @Override
    public long getItemId(int position) {
        return position;
    }

    /*
    Naam: getView
    Werking: Maakt een holder aan voor de view, zodat er minder overhead komt en de view niet steeds herladen moet worden.
     Hier wordt alles ingevuld op de juiste plaats. De juiste gegevens worden opgehaald aan de hand van de positie, de view wordt ingevuld

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
            view = inflater.inflate(R.layout.feedback_list_item, null);
            holder.tv_naamVakantie = (TextView) view.findViewById(R.id.vakantienaamFeedbackOverzicht);
            holder.tv_feedback = (TextView) view.findViewById(R.id.feedbackOverzicht);
            holder.tv_score = (TextView) view.findViewById(R.id.scoreOverzicht);
            //holder.tv_gebruiker = (TextView) view.findViewById(R.id.gebruikerOverzicht);
            view.setTag(holder);
        } else {
            holder = (ViewHolder) view.getTag();
        }
        holder.tv_naamVakantie.setText(feedbackLijst.get(position).getVakantieNaam());
        holder.tv_feedback.setText(feedbackLijst.get(position).getFeedback());
       // holder.tv_gebruiker.setText(feedbackLijst.get(position).getGebruiker());
        holder.tv_score.setText("Score: " + feedbackLijst.get(position).getScore().toString() + "/" + MAXIMALE_SCORE);
        return view;
    }


    /*
    Naam: filter
    Werking: Filtert de lijst van feedback door gebruik te maken van de meegegeven zoekcharacters
    Parameters:
     - charText: String - Het stuk tekst waar de gebruiker op wilt filteren.
    Return: niets. Lijst met feedback wordt auto. aangepast
    */
    public void filter(String charText) {
        charText = charText.toLowerCase(Locale.getDefault());
        feedbackLijst.clear();
        if (charText.length() == 0) {
            feedbackLijst.addAll(feedbackArrayList);
        }
        else
        {
            for (Feedback wp : feedbackArrayList)
            {
                if (wp.getVakantieNaam().toLowerCase(Locale.getDefault()).contains(charText))
                {
                    feedbackLijst.add(wp);
                }
            }
        }
        notifyDataSetChanged();
    }
}
