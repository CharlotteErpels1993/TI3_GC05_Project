package com.hogent.ti3g05.ti3_g05_joetzapp;

import android.app.Application;

import com.parse.Parse;
import com.parse.ParseObject;

public class MyParseApplication extends Application {
    @Override
    public void onCreate() {
        super.onCreate();

         Parse.initialize(this, "G7iR0ji0Kc1fc2PUwhXi9Gj8HmaqK52Qmhk2ffHy", "gJJgkWD5UxMA80iqZkaUHTy8pc9UwJfdv3alDk9Q");

        //Parse.enableLocalDatastore(this);
        ParseObject testObject = new ParseObject("TestObject");
        testObject.put("foo", "bar");
        testObject.saveInBackground();
    }


}
