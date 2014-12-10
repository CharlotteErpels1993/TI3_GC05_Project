package com.hogent.ti3g05.ti3_g05_joetzapp;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;

import com.parse.ParseUser;

public class BootReceiver extends BroadcastReceiver
{

    @Override
    public void onReceive(Context context, Intent intent) {
        Intent myIntent = new Intent(context, navBarMainScreen.class);
        myIntent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
        ParseUser.logOut();
        context.startActivity(myIntent);
    }

}