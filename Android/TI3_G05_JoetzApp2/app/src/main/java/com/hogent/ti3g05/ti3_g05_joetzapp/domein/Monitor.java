package com.hogent.ti3g05.ti3_g05_joetzapp.domein;

/**
 * Created by Gilles De Vylder on 28/10/2014.
 */
public class Monitor extends Gebruiker {
    private String linkFacebook;
    private String naam, voornaam, email, gemeente, gsm, rijksregNr, straat;
    private int postcode;
    private Number huisnr, codeGerechtigde;
    private int lidNummer;

    private String bus, telefoon;
    private String monitorId;

    private Number aansluitingsNr;
    public Monitor(){
        super();

    }

    public void setMonitorId(String monitorId){this.monitorId = monitorId;}
    public String getMonitorId(){return monitorId;}

    public void setTelefoon(String telefoon){this.telefoon = telefoon;}
    public String getTelefoon(){return telefoon;}

    public void setCodeGerechtigde(Number codeGerechtigde){this.codeGerechtigde=codeGerechtigde;}
    public Number getCodeGerechtigde(){return codeGerechtigde;}

    public void setBus(String bus){this.bus = bus;}
    public String getBus(){return bus;}

    public Number getAansluitingsNr(){return aansluitingsNr;}
    public void setAansluitingsNr(Number aansluitingsNr){this.aansluitingsNr = aansluitingsNr;}

    public Number getHuisnr(){return huisnr;}
    public void setHuisnr(Number huisnr){this.huisnr = huisnr;}

    public String getRijksregNr(){return rijksregNr;}
    public void setRijksregNr(String rijksregNr){this.rijksregNr=rijksregNr;}

    public String getNaam(){return naam;}
    public void setNaam(String naam){this.naam = naam;}

    public String getVoornaam(){return voornaam;}
    public void setVoornaam(String voornaam){this.voornaam=voornaam;}

    public String getEmail(){return email;}
    public void setEmail(String email){this.email=email;}

    public String getGemeente(){return gemeente;}
    public void setGemeente(String gemeente){this.gemeente=gemeente;}

    public String getGsm(){return gsm;}
    public void setGsm(String gsm){this.gsm=gsm;}

    public String getStraat(){return straat;}
    public void setStraat(String straat){this.straat=straat;}

    public int getPostcode(){return postcode;}
    public void setPostcode(int postcode){this.postcode=postcode;}

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
