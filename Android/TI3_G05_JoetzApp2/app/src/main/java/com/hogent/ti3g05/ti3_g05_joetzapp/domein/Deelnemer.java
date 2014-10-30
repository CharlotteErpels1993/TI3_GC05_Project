package com.hogent.ti3g05.ti3_g05_joetzapp.domein;

import java.util.Date;

/**
 * Created by Gilles De Vylder on 29/10/2014.
 */
public class Deelnemer { //link naar ouder? Of ligt dat niet vast?

    private double rijksregisternummer;
    private String naam, voornaam;
    private Date geboorteDatum;
    private String straat;
    private int huisnummer;
    private String postbus, gemeente;
    private int postcode;

    public Deelnemer(){

    }

    public double getRijksregisternummer() {
        return rijksregisternummer;
    }

    public void setRijksregisternummer(double rijksregisternummer) {
        this.rijksregisternummer = rijksregisternummer;
    }

    public String getNaam() {
        return naam;
    }

    public void setNaam(String naam) {
        this.naam = naam;
    }

    public String getVoornaam() {
        return voornaam;
    }

    public void setVoornaam(String voornaam) {
        this.voornaam = voornaam;
    }

    public Date getGeboorteDatum() {
        return geboorteDatum;
    }

    public void setGeboorteDatum(Date geboorteDatum) {
        this.geboorteDatum = geboorteDatum;
    }

    public String getStraat() {
        return straat;
    }

    public void setStraat(String straat) {
        this.straat = straat;
    }

    public int getHuisnummer() {
        return huisnummer;
    }

    public void setHuisnummer(int huisnummer) {
        this.huisnummer = huisnummer;
    }

    public String getPostbus() {
        return postbus;
    }

    public void setPostbus(String postbus) {
        this.postbus = postbus;
    }

    public String getGemeente() {
        return gemeente;
    }

    public void setGemeente(String gemeente) {
        this.gemeente = gemeente;
    }

    public int getPostcode() {
        return postcode;
    }

    public void setPostcode(int postcode) {
        this.postcode = postcode;
    }
}
