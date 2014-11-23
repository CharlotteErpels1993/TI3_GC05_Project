package com.hogent.ti3g05.ti3_g05_joetzapp;

import android.app.DatePickerDialog;
import android.app.Dialog;
import android.os.Bundle;
import android.support.v4.app.DialogFragment;
import android.text.format.Time;
import android.widget.DatePicker;
import android.widget.EditText;
import android.widget.TextView;

import java.util.Calendar;
import java.util.Date;

public /*static*/ class CustomDatePicker extends DialogFragment
        implements DatePickerDialog.OnDateSetListener {

    private int mYear;
    private int mMonth;
    private int mDay;
    private Date date;

    public int getDay(){return mDay;}

    public int getYear(){return mYear;}

    public int getMonth(){return mMonth;}
    @Override
    public Dialog onCreateDialog(Bundle savedInstanceState) {
        // Use the current date as the default date in the picker
        final Calendar c = Calendar.getInstance();
        int year = c.get(Calendar.YEAR);
        int month = c.get(Calendar.MONTH);
        int day = c.get(Calendar.DAY_OF_MONTH);

        // Create a new instance of DatePickerDialog and return it
        return new DatePickerDialog(getActivity(), this, year, month, day);
    }

    public void onDateSet(DatePicker view, int year, int month, int day) {
        // Do something with the date chosen by the user
        mYear=year;
        mMonth=month;
        mDay=day;


        onPopulateSet(year, month + 1, day);

    }
    // set the selected date in the edit text
    private void onPopulateSet(int year, int i, int dayOfMonth) {
        TextView et_setDate;
        TextView datum;
        String maandStr = null;
        TextView dag;
        TextView jaar;
        et_setDate = (TextView) getActivity().findViewById(R.id.DateIns);//register_et_dob:-id name of the edit text
        datum = (TextView) getActivity().findViewById(R.id.maandIns);
        dag = (TextView) getActivity().findViewById(R.id.dagIns);
        jaar = (TextView) getActivity().findViewById(R.id.jaarIns);
        switch (i)
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
        //datum.setText((""+i));
        jaar.setText(""+year);

        dag.setText(""+dayOfMonth);
        System.out.println("enetring on populate Set");

    }


}