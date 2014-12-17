package com.hogent.ti3g05.ti3_g05_joetzapp;

import android.app.DatePickerDialog;
import android.app.Dialog;
import android.os.Bundle;
import android.support.v4.app.DialogFragment;
import android.text.format.Time;
import android.widget.DatePicker;
import android.widget.TextView;

import java.util.Calendar;
import java.util.Date;

/*Naam: CustomDatePicker

    Werking: Geeft een dialoog weer om een datum te kiezen
    */
public class CustomDatePicker extends DialogFragment
        implements DatePickerDialog.OnDateSetListener {

    private int mYear;
    private int mMonth;
    private int mDay;
    private int maxYear;
    private int maxMonth, maxDay;


    @Override
    public Dialog onCreateDialog(Bundle savedInstanceState) {
        // Default datum geselecteerd is de huidige datum
        final Calendar c = Calendar.getInstance();

        Time today = new Time(Time.getCurrentTimezone());
        Date now = new Date();
        today.setToNow();

        int year = c.get(Calendar.YEAR);
        int month = c.get(Calendar.MONTH);
        int day = c.get(Calendar.DAY_OF_MONTH);

        maxYear = c.get(Calendar.YEAR);
        maxMonth = c.get(Calendar.MONTH);
        maxDay = c.get(Calendar.DAY_OF_MONTH);
        Date maxDate = new Date(maxYear, maxMonth, maxDay);
        DatePickerDialog dialog = new DatePickerDialog(getActivity(), this, year, month, day);
        dialog.getDatePicker().setMaxDate(now.getTime());
        return dialog;
    }

    /*Naam: onDateSet
    Werking: Haalt de datum op die de gebruiker heeft geselecteerd
    Parameters:
     - year, month & day: int - geselecteerde waarden van gebruiker
    */
    public void onDateSet(DatePicker view, int year, int month, int day) {
        mYear=year;
        mMonth=month;
        mDay=day;

        onPopulateSet(year, month + 1, day);

    }

    /*Naam: fetchLocalObjects
    Werking: Laat de geselecteerde datum zien in een textview
    Parameters:
     - year, objMonth & dayOfMonth: int - geselcteerd jaar, maand en dag
    */
    private void onPopulateSet(int year, int objMonth, int dayOfMonth) {
        TextView et_setDate;
        TextView datum;
        String maandStr = null;
        TextView dag;
        TextView jaar;
        et_setDate = (TextView) getActivity().findViewById(R.id.DateIns);//register_et_dob:-id name of the edit text
        datum = (TextView) getActivity().findViewById(R.id.maandIns);
        dag = (TextView) getActivity().findViewById(R.id.dagIns);
        jaar = (TextView) getActivity().findViewById(R.id.jaarIns);
        switch (objMonth)
        {
            case 1: maandStr = "Jan"; break;
            case 2: maandStr = "Feb"; break;
            case 3: maandStr = "Mar"; break;
            case 4: maandStr = "Apr"; break;
            case 5: maandStr = "May"; break;
            case 6: maandStr = "Jun"; break;
            case 7: maandStr = "Jul"; break;
            case 8: maandStr = "Aug"; break;
            case 9: maandStr = "Sep"; break;
            case 10: maandStr = "Oct"; break;
            case 11: maandStr = "Nov"; break;
            case 12: maandStr = "Dec"; break;
        }
        int dagGe = dayOfMonth+1;
        et_setDate.setText(maandStr + " " + dayOfMonth + ", " + year);
        datum.setText(maandStr + " " + dagGe + ", " + year);
        jaar.setText(""+year);

        dag.setText(""+dayOfMonth);
        System.out.println("entering on populate Set");

    }


}