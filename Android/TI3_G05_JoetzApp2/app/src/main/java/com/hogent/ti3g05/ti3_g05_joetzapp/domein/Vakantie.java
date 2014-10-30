package com.hogent.ti3g05.ti3_g05_joetzapp.domein;

import android.text.method.DateTimeKeyListener;

import java.util.Date;

/**
 * Created by Gilles De Vylder on 29/10/2014.
 */
public class Vakantie extends Activiteit{
    private Date vertrekDatum, terugkeerDatum;
    //aantalDagenNachten is een berekend veld. Wel/niet erin?
    private String vervoerswijze, formule;
    private double basisprijs, bondMoysonLedenPrijs, sterPrijs;
    private int korting;
    //inbegrepenPrijs ook berekend veld?
    private String doelGroep;
    private int maxAantalDeelnemers;

    public Vakantie(){
        super();

    }

    public Date getVertrekDatum() {
        return vertrekDatum;
    }

    public void setVertrekDatum(Date vertrekDatum) {
        this.vertrekDatum = vertrekDatum;
    }

    public Date getTerugkeerDatum() {
        return terugkeerDatum;
    }

    public void setTerugkeerDatum(Date terugkeerDatum) {
        this.terugkeerDatum = terugkeerDatum;
    }

    public String getVervoerswijze() {
        return vervoerswijze;
    }

    public void setVervoerswijze(String vervoerswijze) {
        this.vervoerswijze = vervoerswijze;
    }

    public String getFormule() {
        return formule;
    }

    public void setFormule(String formule) {
        this.formule = formule;
    }

    public double getBasisprijs() {
        return basisprijs;
    }

    public void setBasisprijs(double basisprijs) {
        this.basisprijs = basisprijs;
    }

    public double getBondMoysonLedenPrijs() {
        return bondMoysonLedenPrijs;
    }

    public void setBondMoysonLedenPrijs(double bondMoysonLedenPrijs) {
        this.bondMoysonLedenPrijs = bondMoysonLedenPrijs;
    }

    public double getSterPrijs() {
        return sterPrijs;
    }

    public void setSterPrijs(double sterPrijs) {
        this.sterPrijs = sterPrijs;
    }

    public int getKorting() {
        return korting;
    }

    public void setKorting(int korting) {
        this.korting = korting;
    }

    public String getDoelGroep() {
        return doelGroep;
    }

    public void setDoelGroep(String doelGroep) {
        this.doelGroep = doelGroep;
    }

    public int getMaxAantalDeelnemers() {
        return maxAantalDeelnemers;
    }

    public void setMaxAantalDeelnemers(int maxAantalDeelnemers) {
        this.maxAantalDeelnemers = maxAantalDeelnemers;
    }
}
