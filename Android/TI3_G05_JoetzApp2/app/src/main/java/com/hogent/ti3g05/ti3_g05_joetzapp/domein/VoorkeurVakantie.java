package com.hogent.ti3g05.ti3_g05_joetzapp.domein;

import java.util.Date;

/**
 * Created by Gilles De Vylder on 29/10/2014.
 */
public class VoorkeurVakantie {
    private int voorkeurID;
    private Date datum;

    public VoorkeurVakantie(){

    }

    public int getVoorkeurID() {
        return voorkeurID;
    }

    public void setVoorkeurID(int voorkeurID) {
        this.voorkeurID = voorkeurID;
    }

    public Date getDatum() {
        return datum;
    }

    public void setDatum(Date datum) {
        this.datum = datum;
    }
}
