package com.hogent.ti3g05.ti3_g05_joetzapp.domein;

public class Monitor extends Gebruiker {
    private String linkFacebook;
    private int lidNummer;

    private String monitorId;

    public Monitor(){
        super();

    }

    public void setMonitorId(String monitorId){this.monitorId = monitorId;}
    public String getMonitorId(){return monitorId;}

    public String getLinkFacebook() {
        return linkFacebook;
    }

    public void setLinkFacebook(String linkFacebook) {
        this.linkFacebook = linkFacebook;
    }

    public int getLidNummer() {
        return lidNummer;
    }

    public void setLidNummer(int lidNummer) {
        this.lidNummer = lidNummer;
    }
}
