package com.hogent.ti3g05.ti3_g05_joetzapp;

import android.app.Application;
import com.parse.Parse;
import com.parse.ParseObject;
import com.parse.ParseUser;

public class MyParseApplication extends Application {
    @Override
    public void onCreate() {
        super.onCreate();
        Parse.initialize(this, "a3jgklEb2rHZYcgqDezLfqSP6i1C2u4eVV8R03YS", "3ZguW3kx5J6PuieccT7ypJ5ZvYhwX08ESKL8cDNX");

        if(ParseUser.getCurrentUser()!= null)
        {
            ParseUser.logOut();
        }
        //Parse.enableLocalDatastore(this);

        //ParseObject testObject = new ParseObject("TestObject");
        //testObject.put("foo", "bar");
        //testObject.saveInBackground();
    }


}
