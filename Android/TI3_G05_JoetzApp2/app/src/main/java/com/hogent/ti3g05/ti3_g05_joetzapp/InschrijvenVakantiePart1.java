package com.hogent.ti3g05.ti3_g05_joetzapp;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.support.v4.app.DialogFragment;
import android.support.v4.app.FragmentActivity;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.Button;


public class InschrijvenVakantiePart1 extends FragmentActivity {

    private Button btnVolgende;
    //!!!!!!!!!!!!!!!!!!!!!!!
    //voor date picker:
    //http://developer.android.com/guide/topics/ui/controls/pickers.html#DatePicker

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_inschrijven_vakantie_part1);
        btnVolgende = (Button)findViewById(R.id.btnNaarDeel2Vak);

        btnVolgende.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Intent intent = new Intent(InschrijvenVakantiePart1.this, InschrijvenVakantiePart2.class);
                startActivity(intent);

                overridePendingTransition(R.anim.right_in, R.anim.left_out);
            }
        });

    }


    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.back, menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        int id = item.getItemId();
        if (id == R.id.backMenu) {
            Intent intent1 = new Intent(this, navBarMainScreen.class);
            startActivity(intent1);

            overridePendingTransition(R.anim.left_in, R.anim.right_out);
        }

        return super.onOptionsItemSelected(item);
    }

    public void showDatePickerDialog(View v) {
        DialogFragment newFragment = new CustomDatePicker();
        newFragment.show(getSupportFragmentManager(), "datePicker");
    }
}
