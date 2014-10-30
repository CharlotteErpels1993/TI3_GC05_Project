package com.hogent.ti3g05.ti3_g05_joetzapp.domein;

/**
 * Created by Gilles De Vylder on 29/10/2014.
 */
public class InschrijvingVakantie {
    private int inschrijvingVakantieID;
    private String extraInformatie;

    public InschrijvingVakantie(){

    }


    public int getInschrijvingVakantieID() {
        return inschrijvingVakantieID;
    }

    public void setInschrijvingVakantieID(int inschrijvingVakantieID) {
        this.inschrijvingVakantieID = inschrijvingVakantieID;
    }

    public String getExtraInformatie() {
        return extraInformatie;
    }

    public void setExtraInformatie(String extraInformatie) {
        this.extraInformatie = extraInformatie;
    }
}
