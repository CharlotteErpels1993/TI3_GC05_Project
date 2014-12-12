package com.hogent.ti3g05.ti3_g05_joetzapp.domein;


public class Gebruiker {
    private long userId;
    private String email;
    private String wachtwoord;

    private String voornaam, naam;
    private Number huisnr;
    private String rijksregNr;
    private String bus, straat, gemeente;
    private int postcode;
    private String telefoonnr, gsmnr;
    private Number aansluitingsNr;
    private Number codeGerechtigde;

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

    public Number getHuisnr(){return huisnr;}
    public void setHuisnr(Number huisnr){this.huisnr = huisnr;}

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

    public Number getCodeGerechtigde() {
        return codeGerechtigde;
    }

    public void setCodeGerechtigde(Number codeGerechtigde) {
        this.codeGerechtigde = codeGerechtigde;
    }

    public Number getAansluitingsNr(){return aansluitingsNr;}
    public void setAansluitingsNr(Number aansluitingsNr){this.aansluitingsNr = aansluitingsNr;}

    public String getRijksregNr() {
        return rijksregNr;
    }

    public void setRijksregNr(String rijksregisternummer) {
        this.rijksregNr = rijksregisternummer;
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

    public static boolean isDitEenGeldigRijksregisternummer(String objRijksregisternummer){
        String eerste9cijfers, laatste2;
        eerste9cijfers = objRijksregisternummer.substring(0, 9);
        laatste2 = objRijksregisternummer.substring(9, 11);
        int restNaDeling = Integer.parseInt(eerste9cijfers) % 97;
        int controleGetal = 97 - restNaDeling;
        return controleGetal == Integer.parseInt(laatste2);
    }


}
