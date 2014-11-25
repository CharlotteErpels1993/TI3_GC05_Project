package com.hogent.ti3g05.ti3_g05_joetzapp;

import android.annotation.SuppressLint;
import android.app.Activity;
import android.app.Fragment;
import android.app.FragmentManager;
import android.app.FragmentTransaction;
import android.content.Intent;
import android.os.Bundle;
import android.os.Handler;
import android.support.v4.app.ActionBarDrawerToggle;
import android.support.v4.widget.DrawerLayout;
import android.util.Log;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.webkit.WebViewFragment;
import android.widget.AdapterView;
import android.widget.AdapterView.OnItemClickListener;
import android.widget.ArrayAdapter;
import android.widget.ListView;
import android.widget.Toast;

import com.hogent.ti3g05.ti3_g05_joetzapp.Services.ConnectionDetector;
import com.hogent.ti3g05.ti3_g05_joetzapp.SignUpLogin.Login;
import com.hogent.ti3g05.ti3_g05_joetzapp.SignUpLogin.SignUp_deel1;
import com.parse.ParseUser;


public class navBarMainScreen extends Activity {

    private Fragment fragment = new activiteit_overzicht();

    private boolean doubleBackToExitPressedOnce = false;
    // Within which the entire activity is enclosed
    private DrawerLayout mDrawerLayout;

    // ListView represents Navigation Drawer
    private ListView mDrawerList;

    // ActionBarDrawerToggle indicates the presence of Navigation Drawer in the action bar
    private ActionBarDrawerToggle mDrawerToggle;

    // Title of the action bar
    private String mTitle = "";

    private String[] menuItems;

    // flag for Internet connection status
    Boolean isInternetPresent = false;
    // Connection detector class
    ConnectionDetector cd;


    @SuppressLint("NewApi")
    @Override
    protected void onCreate(Bundle savedInstanceState) {


        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_navigationbar);


        getActionBar().setTitle("");
        cd = new ConnectionDetector(getApplicationContext());

        FragmentManager fragmentManager = getFragmentManager();
        fragmentManager.beginTransaction().replace(R.id.content_frame, fragment).commit();


        // Getting reference to the DrawerLayout
        mDrawerLayout = (DrawerLayout) findViewById(R.id.drawer_layout);

        mDrawerList = (ListView) findViewById(R.id.drawer_list);
        getActionBar().setDisplayHomeAsUpEnabled(true);
        getActionBar().setHomeButtonEnabled(true);

        // Getting reference to the ActionBarDrawerToggle
        mDrawerToggle = new ActionBarDrawerToggle(this, mDrawerLayout,
                R.drawable.ic_drawer, R.string.drawer_open,
                R.string.drawer_close) {

            /** Called when drawer is closed */
            public void onDrawerClosed(View view) {
                getActionBar().setTitle(mTitle);
                invalidateOptionsMenu();

            }

            /** Called when a drawer is opened */
            public void onDrawerOpened(View drawerView) {
                getActionBar().setTitle("");
                invalidateOptionsMenu();
            }

        };

        // Setting DrawerToggle on DrawerLayout
        mDrawerLayout.setDrawerListener(mDrawerToggle);

        // Creating an ArrayAdapter to add items to the listview mDrawerList
        ArrayAdapter<String> adapter = new ArrayAdapter<String>(getBaseContext(),
                R.layout.activity_drawer_layout_item, getResources().getStringArray(R.array.items));

        // Setting the adapter on mDrawerList
        mDrawerList.setAdapter(adapter);

        // Enabling Home button
        getActionBar().setHomeButtonEnabled(true);

        // Enabling Up navigation
        getActionBar().setDisplayHomeAsUpEnabled(true);

        // Setting item click listener for the listview mDrawerList
        mDrawerList.setOnItemClickListener(new OnItemClickListener() {

            @Override
            public void onItemClick(AdapterView<?> parent, View view,
                                    int position, long id) {

                // Getting an array of rivers
                menuItems = getResources().getStringArray(R.array.items);

                // Currently selected river
                mTitle = menuItems[position];

                // Creating a fragment object
                WebViewFragment rFragment = new WebViewFragment();

                // Passing selected item information to fragment
                Bundle data = new Bundle();
                data.putInt("position", position);
                getUrl(position);
                rFragment.setArguments(data);


                // Getting reference to the FragmentManager
                FragmentManager fragmentManager = getFragmentManager();

                // Creating a fragment transaction
                FragmentTransaction ft = fragmentManager.beginTransaction();

                // Adding a fragment to the fragment transaction
                ft.replace(R.id.content_frame, rFragment);

                // Committing the transaction
                ft.commit();

                // Closing the drawer
                mDrawerLayout.closeDrawer(mDrawerList);

            }
        });
    }

    protected void getUrl(int position) {
        isInternetPresent = cd.isConnectingToInternet();

        switch (position) {


            case 0:

                if(ParseUser.getCurrentUser()!=null)
                {
                    Intent intent1 = new Intent(navBarMainScreen.this, ProfielenOverzicht.class
                    );
                    startActivity(intent1);
                }
                else
                {
                    Toast.makeText(this,"U hebt niet de juiste bevoegdheid om dit te bekijken.", Toast.LENGTH_SHORT).show();
                }

                break;


            case 1:
                if(ParseUser.getCurrentUser() == null ) {
                    Toast.makeText(this, "U hebt niet de juiste bevoegdheid om dit te bekijken.", Toast.LENGTH_SHORT).show();
                    Intent intent1 = new Intent(navBarMainScreen.this, navBarMainScreen.class
                    );
                    startActivity(intent1); }
                else{
                    if (ParseUser.getCurrentUser().get("soort").toString().toLowerCase().equals("monitor"))

                    {
                        Intent intent2 = new Intent(navBarMainScreen.this, Vormingen_Overzicht.class
                        );
                        startActivity(intent2);
                    } else {
                        Toast.makeText(this, "U hebt niet de juiste bevoegdheid om dit te bekijken.", Toast.LENGTH_SHORT).show();
                        Intent intent1 = new Intent(navBarMainScreen.this, navBarMainScreen.class
                        );
                        startActivity(intent1);
                    }
                }

                break;

            case 2:
                if (isInternetPresent) {
                    if (ParseUser.getCurrentUser() != null) {
                        if (ParseUser.getCurrentUser().get("soort").toString().toLowerCase().equals("monitor")) {
                            Intent intent2 = new Intent(navBarMainScreen.this, IndienenVoorkeurVakantie.class
                            );
                            startActivity(intent2);
                        } else {
                            Toast.makeText(this, "U hebt niet de juiste bevoegdheid om dit te bekijken.", Toast.LENGTH_SHORT).show();
                            Intent intent1 = new Intent(navBarMainScreen.this, navBarMainScreen.class
                            );
                            startActivity(intent1);
                        }
                    } else {
                        Intent intent1 = new Intent(navBarMainScreen.this, navBarMainScreen.class
                        );
                        startActivity(intent1);
                    }
                } else
                {
                    Toast.makeText(this, "Kan geen verbinding maken met de server. Controleer uw internetconnectie.", Toast.LENGTH_SHORT).show();
                    Intent intent1 = new Intent(navBarMainScreen.this, navBarMainScreen.class
                    );
                    startActivity(intent1);
                }
                break;
            case 3:

                Intent intent3 = new Intent(navBarMainScreen.this, about.class
                );
                startActivity(intent3);

                break;

            default:
                break;
        }
        if(fragment != null)
        {
            FragmentManager fragmentManager = getFragmentManager();
            fragmentManager.beginTransaction().replace(R.id.content_frame, fragment).commit();

            mDrawerList.setItemChecked(position, true);
            mDrawerList.setSelection(position);
            setTitle(menuItems[position]);
            mDrawerLayout.closeDrawer(mDrawerList);

        } else
        {
            Log.e("Error", "Error in het maken van fragment");
        }
    }

    @Override
    protected void onPostCreate(Bundle savedInstanceState) {
        super.onPostCreate(savedInstanceState);
        mDrawerToggle.syncState();
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        if (mDrawerToggle.onOptionsItemSelected(item)) {
            return true;
        }

        int id = item.getItemId();
        if (id == R.id.inloggen) {
            Intent intent1 = new Intent(this, Login.class);
            startActivity(intent1);
        }
        if(id == R.id.regisreren){
            Intent intent1 = new Intent(this, SignUp_deel1.class);
            startActivity(intent1);
        }
        if(id == R.id.uitloggen){

            Intent intent1 = new Intent(this, Loguit.class);
            startActivity(intent1);
        }

        return super.onOptionsItemSelected(item);
    }

    @Override
    public boolean onPrepareOptionsMenu(Menu menu) {
        boolean drawerOpen = mDrawerLayout.isDrawerOpen(mDrawerList);

        menu.findItem(R.id.inloggen).setVisible(!drawerOpen);

        if (ParseUser.getCurrentUser() == null){
            //gebruiker is niet ingelogd
            menu.findItem(R.id.inloggen).setVisible(true);
            menu.findItem(R.id.regisreren).setVisible(true);
            menu.findItem(R.id.uitloggen).setVisible(false);
        }
        else{
            //gebruiker is ingelogd.
            menu.findItem(R.id.inloggen).setVisible(false);
            menu.findItem(R.id.regisreren).setVisible(false);
            menu.findItem(R.id.uitloggen).setVisible(true);
        }

        return super.onPrepareOptionsMenu(menu);
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        getMenuInflater().inflate(R.menu.main_screen, menu);

        if (ParseUser.getCurrentUser() == null){
            //gebruiker is niet ingelogd
            menu.findItem(R.id.inloggen).setVisible(true);
            menu.findItem(R.id.regisreren).setVisible(true);
            menu.findItem(R.id.uitloggen).setVisible(false);
        }
        else{
            //gebruiker is ingelogd.
            menu.findItem(R.id.inloggen).setVisible(false);
            menu.findItem(R.id.regisreren).setVisible(false);
            menu.findItem(R.id.uitloggen).setVisible(true);
        }

        return true;
    }

    @Override
    public void onBackPressed() {
        if (doubleBackToExitPressedOnce) {
            super.onBackPressed();
            return;
        }

        this.doubleBackToExitPressedOnce = true;
        Toast.makeText(this,"Ben je zeker dat je de app wil sluiten?",Toast.LENGTH_SHORT).show();

        new Handler().postDelayed(new Runnable() {

            @Override
            public void run() {
                doubleBackToExitPressedOnce=false;
            }
        }, 2000);
    }


}
