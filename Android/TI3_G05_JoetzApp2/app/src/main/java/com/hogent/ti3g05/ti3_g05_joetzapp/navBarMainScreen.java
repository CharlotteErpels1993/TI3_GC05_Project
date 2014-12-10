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
import android.view.animation.Animation;
import android.view.animation.AnimationUtils;
import android.webkit.WebViewFragment;
import android.widget.AdapterView;
import android.widget.AdapterView.OnItemClickListener;
import android.widget.ArrayAdapter;
import android.widget.FrameLayout;
import android.widget.ListView;
import android.widget.Toast;

import com.hogent.ti3g05.ti3_g05_joetzapp.Services.ConnectionDetector;
import com.hogent.ti3g05.ti3_g05_joetzapp.SignUpLogin.Login;
import com.hogent.ti3g05.ti3_g05_joetzapp.SignUpLogin.SignUp_deel1;
import com.hogent.ti3g05.ti3_g05_joetzapp.domein.Feedback;
import com.parse.ParseUser;


public class navBarMainScreen extends Activity {

    private Fragment fragment;

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

    private FrameLayout fragLayout;


    @SuppressLint("NewApi")
    @Override
    protected void onCreate(Bundle savedInstanceState) {

        Bundle extra = getIntent().getExtras();
        if(extra != null)
        {
            String frag = "";
            if(getIntent().getStringExtra("frag")!=null)
            {
                frag = getIntent().getStringExtra("frag");
            }
            if(getIntent().getStringExtra("naarfrag")!= null)
            {
                frag = getIntent().getStringExtra("naarfrag");
            }
            if(frag.toLowerCase().startsWith("activiteit"))
            {
                fragment = new activiteit_overzicht();
            }
            else if(frag.toLowerCase().startsWith("vorming"))
            {
                fragment = new Vormingen_Overzicht_Fragment();
            }
            else if (frag.toLowerCase().startsWith("profiel"))
            {
                fragment = new ProfielenOverzicht_fragment();
            }
            else if(frag.toLowerCase().startsWith("favoriet"))
            {
                fragment = new FavorieteVakanties();
            }
            else if(frag.toLowerCase().startsWith("feedback"))
            {
                fragment = new feedbackOverzicht();
            }
        }
        else
        {
            fragment = new activiteit_overzicht();
        }

        fragLayout = (FrameLayout) findViewById(R.id.content_frame);

        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_navigationbar);


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
                R.drawable.menu, R.string.drawer_open,
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

        //ArrayAdapter<String> adapter = new ArrayAdapter<String>(getBaseContext(),
                //R.layout.activity_drawer_layout_item, getResources().getStringArray(R.array.items));
        ArrayAdapter<String> adapter = null;

        if (ParseUser.getCurrentUser() != null)
        {
            adapter = new ArrayAdapter<String>(getBaseContext(),
                    R.layout.activity_drawer_layout_item, getResources().getStringArray(R.array.itemsIngelogged));

        } else
        {
            adapter = new ArrayAdapter<String>(getBaseContext(),
                    R.layout.activity_drawer_layout_item, getResources().getStringArray(R.array.items));
        }

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

                if (ParseUser.getCurrentUser() != null)
                {

                    menuItems = getResources().getStringArray(R.array.itemsIngelogged);

                } else
                {

                    menuItems = getResources().getStringArray(R.array.items);
                }
                // Getting an array of rivers

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
                    fragmentManager.beginTransaction().replace(R.id.content_frame, rFragment).commit();

                    // Adding a fragment to the fragment transaction
                    //ft.replace();

                    // Committing the transaction
                   // ft.commit();


                // Closing the drawer
                final Animation fadeInAnimation = AnimationUtils.loadAnimation(navBarMainScreen.this, R.anim.fadein);

                //fragLayout.startAnimation(fadeInAnimation);
                mDrawerLayout.startAnimation(fadeInAnimation);
                mDrawerLayout.closeDrawer(mDrawerList);


            }
        });
    }

    protected void getUrl(int position) {
        isInternetPresent = cd.isConnectingToInternet();

        switch (position) {

            case 0:

                Intent intent = new Intent(navBarMainScreen.this, navBarMainScreen.class);

                fragment = new activiteit_overzicht();
               // refreshFragment(position);

                intent.putExtra("frag", fragment.toString());
                startActivity(intent);
                break;

            case 1:
                Intent intent9 = new Intent(navBarMainScreen.this, navBarMainScreen.class);
                fragment = new feedbackOverzicht();

                //refreshFragment(position);

                intent9.putExtra("frag", fragment.toString());
                startActivity(intent9);

                break;

            case 2:

                if(ParseUser.getCurrentUser()!=null && ParseUser.getCurrentUser().get("soort").toString().toLowerCase().equals("monitor"))
                {
                    Intent intent1 = new Intent(navBarMainScreen.this, navBarMainScreen.class);
                    fragment = new ProfielenOverzicht_fragment();
                    //refreshFragment(position);

                    intent1.putExtra("frag", fragment.toString());
                    startActivity(intent1);

                    break;

                }
                else
                {
                    Toast.makeText(this,"U hebt niet de juiste bevoegdheid om dit te bekijken.", Toast.LENGTH_SHORT).show();
                    Intent intent1 = new Intent(navBarMainScreen.this, navBarMainScreen.class
                    );
                    intent1.putExtra("herladen", "nee");

                    intent1.putExtra("frag", fragment.toString());
                   // refreshFragment(position);
                    startActivity(intent1);
                }

                break;


            case 3:
                if(ParseUser.getCurrentUser() == null ) {
                    Toast.makeText(this, "U hebt niet de juiste bevoegdheid om dit te bekijken.", Toast.LENGTH_SHORT).show();
                    Intent intent1 = new Intent(navBarMainScreen.this, navBarMainScreen.class
                    );

                    intent1.putExtra("herladen", "nee");

                    intent1.putExtra("frag", fragment.toString());
                    //refreshFragment(position);
                    startActivity(intent1); }
                else{
                    if (ParseUser.getCurrentUser() != null && !ParseUser.getCurrentUser().get("soort").toString().toLowerCase().equals("ouder"))

                    {
                        Intent intent3 = new Intent(navBarMainScreen.this, navBarMainScreen.class);
                        fragment = new Vormingen_Overzicht_Fragment();

                        refreshFragment(position);

                        intent3.putExtra("frag", fragment.toString());

                        startActivity(intent3);
                        break;

                    } else {
                        Toast.makeText(this, "U hebt niet de juiste bevoegdheid om dit te bekijken.", Toast.LENGTH_SHORT).show();
                        Intent intent1 = new Intent(navBarMainScreen.this, navBarMainScreen.class
                        );

                        intent1.putExtra("herladen", "nee");

                        intent1.putExtra("frag", fragment.toString());
                       // refreshFragment(position);
                        startActivity(intent1);
                    }
                }
                refreshFragment(position);

                break;

            case 4:
                if (isInternetPresent) {

                        if (ParseUser.getCurrentUser() != null && ParseUser.getCurrentUser().get("soort").toString().toLowerCase().equals("monitor")) {
                            Intent intent2 = new Intent(navBarMainScreen.this, IndienenVoorkeurVakantie.class
                            );
                            startActivity(intent2);
                        } else {
                            Toast.makeText(this, "U hebt niet de juiste bevoegdheid om dit te bekijken.", Toast.LENGTH_SHORT).show();
                            Intent intent1 = new Intent(navBarMainScreen.this, navBarMainScreen.class
                            );

                            intent1.putExtra("herladen", "nee");

                            intent1.putExtra("frag", fragment.toString());
                            //refreshFragment(position);
                            startActivity(intent1);
                        }
                    } else {
                        Intent intent1 = new Intent(navBarMainScreen.this, navBarMainScreen.class
                        );
                        Toast.makeText(this, "U hebt niet de juiste bevoegdheid om dit te bekijken.", Toast.LENGTH_SHORT).show();

                    intent1.putExtra("herladen", "nee");

                    intent1.putExtra("frag", fragment.toString());
                       // refreshFragment(position);
                        startActivity(intent1);
                    }
                break;

            case 5:

                if(ParseUser.getCurrentUser() == null)
                {
                    Intent intent5 = new Intent(navBarMainScreen.this, SignUp_deel1.class
                    );
                    startActivity(intent5);
                }
                else if(ParseUser.getCurrentUser().get("soort").toString().toLowerCase().equals("ouder"))
                {

                    Intent intent7 = new Intent(navBarMainScreen.this, navBarMainScreen.class);
                    fragment = new FavorieteVakanties();

                   // refreshFragment(position);

                    intent7.putExtra("frag", fragment.toString());
                    startActivity(intent7);
                    break;
                } else
                {
                    Toast.makeText(this, "U hebt niet de juiste bevoegdheid om dit te bekijken", Toast.LENGTH_SHORT).show();
                    Intent intent1 = new Intent(navBarMainScreen.this, navBarMainScreen.class
                    );

                    intent1.putExtra("herladen", "nee");

                    intent1.putExtra("frag", fragment.toString());
                   // refreshFragment(position);
                    startActivity(intent1);
                }
                break;

            case 6:

                Intent intent4;
                if(ParseUser.getCurrentUser() != null)
                {
                    intent4 = new Intent(navBarMainScreen.this, Loguit.class
                    );
                }
                else
                {
                    intent4 = new Intent(navBarMainScreen.this, Login.class
                    );
                }

                startActivity(intent4);

                break;

            case 7:

                Intent intent3 = new Intent(navBarMainScreen.this, about.class
                );
                startActivity(intent3);

                break;



          /*  case 7:
                if(ParseUser.getCurrentUser()!= null)
                {
                    if(ParseUser.getCurrentUser().get("soort").toString().toLowerCase().equals("administrator"))
                    {
                        Intent intent8 = new Intent(navBarMainScreen.this, LidnummerToevoegen.class
                        );
                        startActivity(intent8);
                    }
                    else
                    {
                        Intent intent7 = new Intent(navBarMainScreen.this, navBarMainScreen.class);
                        fragment = new activiteit_overzicht();

                        refreshFragment(position);

                        intent7.putExtra("frag", fragment.toString());
                        startActivity(intent7);
                    }
                } else
                {
                    Intent intent9 = new Intent(navBarMainScreen.this, navBarMainScreen.class);
                    fragment = new activiteit_overzicht();

                    refreshFragment(position);

                    intent9.putExtra("frag", fragment.toString());
                    startActivity(intent9);
                }

                break;
*/

            default:
                break;
        }


    }



    protected void refreshFragment(int position)
    {
        if(fragment != null)
        {
           /* FragmentManager fragmentManager = getFragmentManager();
            fragmentManager.beginTransaction().replace(R.id.content_frame, fragment).commit();
*//*
            mDrawerList.setItemChecked(position, true);
            mDrawerList.setSelection(position);
            //setTitle("vakanties");*/
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

        if (id == R.id.menu_loadVak) {
            isInternetPresent = cd.isConnectingToInternet();

            if (isInternetPresent) {
                // Internet Connection is Present
                // make HTTP requests

                if(fragment.toString().toLowerCase().startsWith("activiteit"))
                {
                    fragment = new activiteit_overzicht();
                }
                else if(fragment.toString().toLowerCase().startsWith("vorming"))
                {
                    fragment = new Vormingen_Overzicht_Fragment();
                }
                else if (fragment.toString().toLowerCase().startsWith("profiel"))
                {
                    fragment = new ProfielenOverzicht_fragment();
                }
                else if(fragment.toString().toLowerCase().startsWith("favoriet"))
                {
                    fragment = new FavorieteVakanties();
                }
                else if(fragment.toString().toLowerCase().startsWith("feedback"))
                {
                    fragment = new feedbackOverzicht();
                }

                FragmentManager fragmentManager = getFragmentManager();
                fragmentManager.beginTransaction().replace(R.id.content_frame, fragment).commit();

                setTitle(fragment.getId());
                final Animation fadeInAnimation = AnimationUtils.loadAnimation(this, R.anim.fadein);

                mDrawerLayout.startAnimation(fadeInAnimation);
                mDrawerLayout.closeDrawer(mDrawerList);

            } else {
                // Internet connection is not present
                // Ask user to connect to Internet
                Toast.makeText(navBarMainScreen.this, getString(R.string.error_no_internet), Toast.LENGTH_SHORT).show();
            }
        } else if(id == R.id.menu_voegFeedbackToe)
        {
            Intent intentFeedback = new Intent(navBarMainScreen.this, feedback_geven.class);
            startActivity(intentFeedback);
        }
        return super.onOptionsItemSelected(item);
    }

    @Override
    public boolean onPrepareOptionsMenu(Menu menu) {
        boolean drawerOpen = mDrawerLayout.isDrawerOpen(mDrawerList);

        return super.onPrepareOptionsMenu(menu);
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        getMenuInflater().inflate(R.menu.menu_inschrijven_vakantie_part1, menu);
        if(fragment != null && fragment.toString().toLowerCase().startsWith("feedback")&&ParseUser.getCurrentUser()!=null)
        {
            MenuItem item = menu.findItem(R.id.menu_voegFeedbackToe);
            item.setVisible(true);
        }
        else{
            MenuItem item = menu.findItem(R.id.menu_voegFeedbackToe);
            item.setVisible(false);
        }

        return true;
    }



    @Override
    public void onBackPressed() {
        if (doubleBackToExitPressedOnce) {
            super.onBackPressed();
            ParseUser.logOut();
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

   /* @Override
    protected void onDestroy() {
        super.onDestroy();
        ParseUser.logOut();
    }*/

    /*public void onStart(){
        super.onStart();
        if(ParseUser.getCurrentUser()!=null)
            ParseUser.logOut();
    }*/
}
