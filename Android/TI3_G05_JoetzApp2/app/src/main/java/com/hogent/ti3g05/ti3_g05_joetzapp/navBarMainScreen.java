package com.hogent.ti3g05.ti3_g05_joetzapp;

import android.annotation.SuppressLint;
import android.app.Activity;
import android.app.Fragment;
import android.app.FragmentManager;
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
import com.parse.ParseUser;

//Maakt de navigatiebar aan, is tevens ook de mainactivity, alle andere activiteiten zullen als fragment hierin worden ingesteld
public class navBarMainScreen extends Activity {

    private Fragment fragment;

    private boolean doubleBackToExitPressedOnce = false;

    private DrawerLayout mDrawerLayout;

    // De navigatiebar
    private ListView mDrawerList;

    // geeft de aanwezigheid aan van de navigatiebar in de actionbar
    private ActionBarDrawerToggle mDrawerToggle;

    private String mTitle = "";

    private String[] menuItems;

    Boolean isInternetPresent = false;
    ConnectionDetector cd;

    private FrameLayout fragLayout;


    @SuppressLint("NewApi")
    @Override
    //Maakt de navbar aan en toont het juiste fragment
    protected void onCreate(Bundle savedInstanceState) {

        //Om naar de juiste fragmenten te gaan worden deze meegegeven als parameter aan de intent
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
            if(frag.toLowerCase().startsWith("vakantie"))
            {
                fragment = new Vakantie_overzicht();

                mTitle = "Vakanties";
            }
            else if(frag.toLowerCase().startsWith("vorming"))
            {
                fragment = new Vormingen_Overzicht_Fragment();

                mTitle = "Vormingen";
            }
            else if (frag.toLowerCase().startsWith("profiel"))
            {
                fragment = new ProfielenOverzicht_fragment();
                mTitle = "Monitoren";

            }
            else if(frag.toLowerCase().startsWith("favoriet"))
            {
                fragment = new FavorieteVakanties();

                mTitle = "Favoriete vakanties";
            }
            else if(frag.toLowerCase().startsWith("feedback"))
            {
                fragment = new feedback_overzicht();
                mTitle = "Joetz funfactor";
            }
        }
        else
        {
            fragment = new Vakantie_overzicht();
        }

        fragLayout = (FrameLayout) findViewById(R.id.content_frame);

        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_navigationbar);


        cd = new ConnectionDetector(getApplicationContext());


        //Vervang in de content_frame het fragment
        FragmentManager fragmentManager = getFragmentManager();
        fragmentManager.beginTransaction().replace(R.id.content_frame, fragment).commit();



        mDrawerLayout = (DrawerLayout) findViewById(R.id.drawer_layout);

        mDrawerList = (ListView) findViewById(R.id.drawer_list);
        getActionBar().setDisplayHomeAsUpEnabled(true);
        getActionBar().setHomeButtonEnabled(true);

        // Getting reference to the ActionBarDrawerToggle
        mDrawerToggle = new ActionBarDrawerToggle(this, mDrawerLayout,
                R.drawable.menu, R.string.drawer_open,
                R.string.drawer_close) {

            //Als de navbar gesloten wordt
            public void onDrawerClosed(View view) {
                getActionBar().setTitle(mTitle);
                invalidateOptionsMenu();

            }

            //Als de navbar geopend wordt
            public void onDrawerOpened(View drawerView) {
                getActionBar().setTitle("");
                invalidateOptionsMenu();
            }

        };

        //Drawertoggle linken aan de navbar
        mDrawerLayout.setDrawerListener(mDrawerToggle);

        ArrayAdapter<String> adapter = null;

        //Toon de juiste gegevens in de navbar op basis van de gebruiker
        if (ParseUser.getCurrentUser() != null)
        {
            adapter = new ArrayAdapter<String>(getBaseContext(),
                    R.layout.activity_drawer_layout_item, getResources().getStringArray(R.array.itemsIngelogged));

        } else
        {
            adapter = new ArrayAdapter<String>(getBaseContext(),
                    R.layout.activity_drawer_layout_item, getResources().getStringArray(R.array.items));
        }

        //Adatper meegeven aan de narvbar
        mDrawerList.setAdapter(adapter);

        getActionBar().setHomeButtonEnabled(true);

        getActionBar().setDisplayHomeAsUpEnabled(true);

        // Als een item aangeklikt wordt op de navbar zal deze functie worden aangeroepen en die toont dan de juiste gegevens door een andere functie aan te roepen
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

                //Het geselecteerde item
                mTitle = menuItems[position];

                //Fragment object aanmaken
                WebViewFragment rFragment = new WebViewFragment();

                // De geselecteerde info doorgeven aan het fragment
                Bundle data = new Bundle();
                data.putInt("position", position);
                getUrl(position);

                rFragment.setArguments(data);

                FragmentManager fragmentManager = getFragmentManager();

                    fragmentManager.beginTransaction().replace(R.id.content_frame, rFragment).commit();

                // Navbar sluiten
                final Animation fadeInAnimation = AnimationUtils.loadAnimation(navBarMainScreen.this, R.anim.fadein);

                mDrawerLayout.startAnimation(fadeInAnimation);
                mDrawerLayout.closeDrawer(mDrawerList);


            }
        });
    }

    //Het juiste fragment of de juiste handelingen uitvoeren bij selectie van een item
    protected void getUrl(int position) {
        isInternetPresent = cd.isConnectingToInternet();

        switch (position) {

            //VakantieOverzicht, toegankelijk voor iedereen
            case 0:

                Intent intent = new Intent(navBarMainScreen.this, navBarMainScreen.class);

                fragment = new Vakantie_overzicht();

                intent.putExtra("frag", fragment.toString());
                startActivity(intent);
                break;
            //FeedbackOverzicht, toegankelijj voor iedereen
            case 1:
                Intent intent9 = new Intent(navBarMainScreen.this, navBarMainScreen.class);
                fragment = new feedback_overzicht();

                intent9.putExtra("frag", fragment.toString());
                startActivity(intent9);

                break;
            //ProfielenOverzicht, Toegankelijk voor monitoren en administrator
            case 2:

                if(ParseUser.getCurrentUser()!=null && ParseUser.getCurrentUser().get("soort").toString().toLowerCase().equals("monitor"))
                {
                    Intent intent1 = new Intent(navBarMainScreen.this, navBarMainScreen.class);
                    fragment = new ProfielenOverzicht_fragment();

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

                    startActivity(intent1);
                }

                break;

            //VormingOverzicht, toegankelijk voor monitoren en administrator
            case 3:
                if(ParseUser.getCurrentUser() == null ) {
                    Toast.makeText(this, "U hebt niet de juiste bevoegdheid om dit te bekijken.", Toast.LENGTH_SHORT).show();
                    Intent intent1 = new Intent(navBarMainScreen.this, navBarMainScreen.class
                    );

                    intent1.putExtra("herladen", "nee");

                    intent1.putExtra("frag", fragment.toString());
                    startActivity(intent1); }
                else{
                    if (ParseUser.getCurrentUser() != null && !ParseUser.getCurrentUser().get("soort").toString().toLowerCase().equals("ouder"))

                    {
                        Intent intent3 = new Intent(navBarMainScreen.this, navBarMainScreen.class);
                        fragment = new Vormingen_Overzicht_Fragment();
                        intent3.putExtra("frag", fragment.toString());

                        startActivity(intent3);
                        break;

                    } else {
                        Toast.makeText(this, "U hebt niet de juiste bevoegdheid om dit te bekijken.", Toast.LENGTH_SHORT).show();
                        Intent intent1 = new Intent(navBarMainScreen.this, navBarMainScreen.class
                        );

                        intent1.putExtra("herladen", "nee");

                        intent1.putExtra("frag", fragment.toString());
                        startActivity(intent1);
                    }
                }

                break;
            //IndienenVoorkeurVakantie, enkel toegankelijk voor monitoren
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

                            startActivity(intent1);
                        }
                    } else {
                        Intent intent1 = new Intent(navBarMainScreen.this, navBarMainScreen.class
                        );
                        Toast.makeText(this, "U hebt niet de juiste bevoegdheid om dit te bekijken.", Toast.LENGTH_SHORT).show();

                    intent1.putExtra("herladen", "nee");

                    intent1.putExtra("frag", fragment.toString());
                        startActivity(intent1);
                    }
                break;
            //Stuurt de gebruiker naar registreren indien de gebruiker niet ingelogged is
            //Stuurt de gebruiker, (monitor en ouder) door naar favorietenOverzicht indien ingelogged
            case 5:

                if(ParseUser.getCurrentUser() == null)
                {
                    Intent intent5 = new Intent(navBarMainScreen.this, SignUp_deel1.class
                    );
                    startActivity(intent5);
                }
                else if(!ParseUser.getCurrentUser().get("soort").toString().toLowerCase().equals("administrator"))
                {

                    Intent intent7 = new Intent(navBarMainScreen.this, navBarMainScreen.class);
                    fragment = new FavorieteVakanties();

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

                    startActivity(intent1);
                }
                break;
            //Stuurt de gebruiker naar login als deze niet ingelogged is
            //Indien de gebruiker ingelogged is wordt deze doorgestuurd naar uitloggen
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
            //Stuurt de gebruiker door naar het scherm met meer info over joetz
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



  /*  protected void refreshFragment(int position)
    {
        if(fragment != null)
        {
           /* FragmentManager fragmentManager = getFragmentManager();
            fragmentManager.beginTransaction().replace(R.id.content_frame, fragment).commit();
*//*
            mDrawerList.setItemChecked(position, true);
            mDrawerList.setSelection(position);
            //setTitle("vakanties");*/
       /*     mDrawerLayout.closeDrawer(mDrawerList);

        } else
        {
            Log.e("Error", "Error in het maken van fragment");
        }
    }*/



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

        //Herlaad de lijst op basis van het fragment
        if (id == R.id.menu_loadVak) {
            isInternetPresent = cd.isConnectingToInternet();

            if (isInternetPresent) {
                // Internet Connection is Present
                // make HTTP requests

                if(fragment.toString().toLowerCase().startsWith("activiteit"))
                {
                    fragment = new Vakantie_overzicht();
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
                    fragment = new feedback_overzicht();
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
            Intent intentFeedback = new Intent(navBarMainScreen.this, feedbac_geven_vakantie_kiezen.class);
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

        //Geeft ng fout, toont steeds message bij teruggaan
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
