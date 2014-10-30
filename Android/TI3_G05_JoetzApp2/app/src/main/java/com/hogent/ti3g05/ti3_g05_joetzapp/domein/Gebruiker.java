package com.hogent.ti3g05.ti3_g05_joetzapp.domein;

/**
 * Created by Gebruiker on 26/10/2014.
 */
public class Gebruiker { //abstract?
    private long userId;
    private String email;
    private String wachtwoord;

    private String voornaam, naam;
    private int huisnummer;
    private String bus, straat, gemeente;
    private int postcode;
    private String telefoonnr, gsmnr;

    public long getUserId() {
        return userId;
    }

    public void setUserId(long userId) {
        this.userId = userId;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getWachtwoord() {
        return wachtwoord;
    }

    public void setWachtwoord(String wachtwoord) {
        this.wachtwoord = wachtwoord;
    }

    public String getVoornaam() {
        return voornaam;
    }

    public void setVoornaam(String voornaam) {
        this.voornaam = voornaam;
    }

    public String getNaam() {
        return naam;
    }

    public void setNaam(String naam) {
        this.naam = naam;
    }

    public int getHuisnummer() {
        return huisnummer;
    }

    public void setHuisnummer(int huisnummer) {
        this.huisnummer = huisnummer;
    }

    public String getStraat() {
        return straat;
    }

    public void setStraat(String straat) {
        this.straat = straat;
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

    public String getBus() {
        return bus;
    }

    public void setBus(String bus) {
        this.bus = bus;
    }

    public Gebruiker(){

    }

    public Gebruiker(long userId, String email, String wachtwoord) {
        setUserId(userId);
        setEmail(email);
        setWachtwoord(wachtwoord);

    }



}
