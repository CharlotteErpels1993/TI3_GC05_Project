package com.hogent.ti3g05.ti3_g05_joetzapp.domein;

import java.util.Date;

/**
 * Created by Gilles De Vylder on 29/10/2014.
 */
public class InschrijvingVorming {
    private int inschrijvingVormingID;
    private String monitor, vorming;
    private Date beginDatum, eindDatum; //kan een vorming over meerdere data spannen?

    public InschrijvingVorming(){

    }

    public int getInschrijvingVormingID() {
        return inschrijvingVormingID;
    }

    public void setInschrijvingVormingID(int inschrijvingVormingID) {
        this.inschrijvingVormingID = inschrijvingVormingID;
    }

    public void setMonitor(String monitor){this.monitor = monitor;}
    public String getMonitor(){return monitor;}

    public void setVorming(String vorming){this.vorming = vorming;}
    public String getVorming(){return vorming;}

    public Date getBeginDatum() {
        return beginDatum;
    }

    public void setBeginDatum(Date beginDatum) {
        this.beginDatum = beginDatum;
    }

    public Date getEindDatum() {
        return eindDatum;
    }

    public void setEindDatum(Date eindDatum) {
        this.eindDatum = eindDatum;
    }
}
