package com.hogent.ti3g05.ti3_g05_joetzapp.Services;


import android.app.Activity;
import android.content.Context;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.ViewGroup;
import android.view.inputmethod.InputMethodManager;

public class DismissKeyboardListener implements OnClickListener {

    Context context;

    public DismissKeyboardListener(Context context) {
        this.context = context;
    }

    @Override
    public void onClick(View v) {
        if ( v instanceof ViewGroup) {
            hideSoftKeyboard( this.context );
        }
    }


    public void hideSoftKeyboard(Context context) {
        InputMethodManager imm = (InputMethodManager)context.getSystemService(context.INPUT_METHOD_SERVICE);
        imm.toggleSoftInput(InputMethodManager.HIDE_IMPLICIT_ONLY, 0);
    }
}
