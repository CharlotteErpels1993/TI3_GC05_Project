package com.hogent.ti3g05.ti3_g05_joetzapp.SignUpLogin;

import android.app.Activity;
import android.net.Uri;
import android.os.Bundle;
import android.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.TextView;

import com.hogent.ti3g05.ti3_g05_joetzapp.R;
import com.parse.ParseUser;


public class LoginToolBars extends Fragment {
    // TODO: Rename parameter arguments, choose names that match
    // the fragment initialization parameters, e.g. ARG_ITEM_NUMBER
    //private static final String ARG_PARAM1 = "param1";
    //private static final String ARG_PARAM2 = "param2";
    // TODO: Rename and change types of parameters
    //private String mParam1;
    //private String mParam2;
    private Button btnLogin;
    private Button btnLogout;
    private Button btnRegister;
    private TextView txtCurrentUser;


    private OnFragmentInteractionListener mListener;


    // TODO: Rename and change types and number of parameters
    public static LoginToolBars newInstance(String param1, String param2) {
        LoginToolBars fragment = new LoginToolBars();
        /*Bundle args = new Bundle();
        args.putString(ARG_PARAM1, param1);
        args.putString(ARG_PARAM2, param2);
        fragment.setArguments(args);*/
        return fragment;
    }

    public LoginToolBars() {
        // Required empty public constructor
    }

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        //btnLogin = (Button) findViewById(R.id.btn_login);


        /*if (getArguments() != null) {
            mParam1 = getArguments().getString(ARG_PARAM1);
            mParam2 = getArguments().getString(ARG_PARAM2);
        }*/
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        // Inflate the layout for this fragment
        return inflater.inflate(R.layout.fragment_login_tool_bars, container, false);
    }

    // TODO: Rename method, update argument and hook method into UI event
    public void onButtonPressed(Uri uri) {
        if (mListener != null) {
            mListener.onFragmentInteraction(uri);
        }
    }

    @Override
    public void onAttach(Activity activity) {
        super.onAttach(activity);
        try {
            mListener = (OnFragmentInteractionListener) activity;
        } catch (ClassCastException e) {
            throw new ClassCastException(activity.toString()
                    + " must implement OnFragmentInteractionListener");
        }
    }

    @Override
    public void onDetach() {
        super.onDetach();
        mListener = null;
    }

    /**
     * This interface must be implemented by activities that contain this
     * fragment to allow an interaction in this fragment to be communicated
     * to the activity and potentially other fragments contained in that
     * activity.
     * <p/>
     * See the Android Training lesson <a href=
     * "http://developer.android.com/training/basics/fragments/communicating.html"
     * >Communicating with Other Fragments</a> for more information.
     */
    public interface OnFragmentInteractionListener {
        // TODO: Update argument type and name
        public void onFragmentInteraction(Uri uri);
    }

    @Override
    public void onResume(){ //alle code wordt in onResume gestoken, want op dit punt is de fragment zeker al verbonden met de acvtivity.
        super.onResume();

        if (ParseUser.getCurrentUser() == null){
            //nog niet ingelogd


        }
        else{
            //gebruiker is ingelogd


        }
    }

    public void loginButtonWillBecomeVisible(){

    }

    public void logoutButtonWillBecomevisible(){

    }

}
