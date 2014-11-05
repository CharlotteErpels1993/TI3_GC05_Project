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
import android.widget.BaseAdapter;
import android.widget.TextView;

import com.hogent.ti3g05.ti3_g05_joetzapp.R;
import com.hogent.ti3g05.ti3_g05_joetzapp.activiteit_detail;
import com.hogent.ti3g05.ti3_g05_joetzapp.domein.Vakantie;

public class ListViewAdapter extends BaseAdapter {

    Context context;
    LayoutInflater inflater;
    //ImageLoader imageLoader;
    private List<Vakantie> vakanties = null;
    private ArrayList<Vakantie> arraylist;

    public ListViewAdapter(Context context,
                           List<Vakantie> vakanties) {
        this.context = context;
        this.vakanties = vakanties;
        inflater = LayoutInflater.from(context);
        this.arraylist = new ArrayList<Vakantie>();
        this.arraylist.addAll(vakanties);
        //imageLoader = new ImageLoader(context);
    }

    public class ViewHolder {
        TextView naamVakantie;
        TextView locatie;
        TextView vertrekdatum;
        TextView terugdatum;
       // ImageView flag;
    }

    @Override
    public int getCount() {
        return vakanties.size();
    }

    @Override
    public Object getItem(int position) {
        return vakanties.get(position);
    }

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
           // holder.flag = (ImageView) view.findViewById(R.id.flag);
            view.setTag(holder);
        } else {
            holder = (ViewHolder) view.getTag();
        }
        holder.naamVakantie.setText(vakanties.get(position).getNaamVakantie());
        holder.locatie.setText(vakanties.get(position).getLocatie());
        holder.vertrekdatum.setText((CharSequence) vakanties.get(position).getVertrekDatum());
        holder.terugdatum.setText((CharSequence) vakanties.get(position).getTerugkeerDatum());
       // imageLoader.DisplayImage(vakanties.get(position).getFlag(),
              //  holder.flag);
        view.setOnClickListener(new OnClickListener() {

            @Override
            public void onClick(View arg0) {
                Intent intent = new Intent(context, activiteit_detail.class);
                intent.putExtra("naam",
                        (vakanties.get(position).getNaamVakantie()));
                intent.putExtra("locatie",
                        (vakanties.get(position).getLocatie()));
                intent.putExtra("vertrekdatum",
                        (vakanties.get(position).getVertrekDatum()));
                intent.putExtra("terugdatum",
                        (vakanties.get(position).getTerugkeerDatum()));
                context.startActivity(intent);
            }
        });
        return view;
    }

   /* public void filter(String text) {
        text =text.toLowerCase(Locale.getDefault());
        vakanties.clear();
        if(text.length()==0)
        {
            vakanties.addAll(arraylist);
        } else {
            for(Vakantie v: arraylist) {
                if(v.getLocatie().toLowerCase(Locale.getDefault()).contains(text)) {
                    vakanties.add(v);
                }
            }
        }
        notifyDataSetChanged();
    }*/

}