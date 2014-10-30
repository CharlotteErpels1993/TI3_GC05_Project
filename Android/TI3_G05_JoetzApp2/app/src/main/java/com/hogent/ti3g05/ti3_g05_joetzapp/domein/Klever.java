package com.hogent.ti3g05.ti3_g05_joetzapp.domein;

/**
 * Created by Gilles De Vylder on 29/10/2014.
 */
public class Klever {
    private String aansluitingsnummer, codeGerechtigde;
    private double rijksregisternummer;
    private String aansluitingsnummerTweedeOuder;

    public Klever(){

    }


    public String getAansluitingsnummer() {
        return aansluitingsnummer;
    }

    public void setAansluitingsnummer(String aansluitingsnummer) {
        this.aansluitingsnummer = aansluitingsnummer;
    }

    public String getCodeGerechtigde() {
        return codeGerechtigde;
    }

    public void setCodeGerechtigde(String codeGerechtigde) {
        this.codeGerechtigde = codeGerechtigde;
    }

    public double getRijksregisternummer() {
        return rijksregisternummer;
    }

    public void setRijksregisternummer(double rijksregisternummer) {
        this.rijksregisternummer = rijksregisternummer;
    }

    public String getAansluitingsnummerTweedeOuder() {
        return aansluitingsnummerTweedeOuder;
    }

    public void setAansluitingsnummerTweedeOuder(String aansluitingsnummerTweedeOuder) {
        this.aansluitingsnummerTweedeOuder = aansluitingsnummerTweedeOuder;
    }
}
