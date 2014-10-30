package com.hogent.ti3g05.ti3_g05_joetzapp.domein;

/**
 * Created by Gilles De Vylder on 29/10/2014.
 */
public class ContactPersoonInNood {
    private int contactPersoonInNoodID;
    private String naam, voornaam, telefoonnr, gsmnr;

    public ContactPersoonInNood(){

    }

    public int getContactPersoonInNoodID() {
        return contactPersoonInNoodID;
    }

    public void setContactPersoonInNoodID(int contactPersoonInNoodID) {
        this.contactPersoonInNoodID = contactPersoonInNoodID;
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

    public String getTelefoonnr() {
        return telefoonnr;
    }

    public void setTelefoonnr(String telefoonnr) {
        this.telefoonnr = telefoonnr;
    }

    public String getGsmnr() {
        return gsmnr;
    }

    public void setGsmnr(String gsmnr) {
        this.gsmnr = gsmnr;
    }
}
