package com.hogent.ti3g05.ti3_g05_joetzapp.domein;

import android.media.Image;
import android.text.method.DateTimeKeyListener;

import com.parse.ParseFile;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.NavigableMap;

public class Vakantie extends Activiteit{
    private Date vertrekDatum, terugkeerDatum;
    private String aantalDagenNachten;
    private String vervoerswijze, formule;
    private Number basisprijs, bondMoysonLedenPrijs, sterPrijs1Ouder, sterPrijs2Ouder;
    private int korting;
    private String inbegrepenInPrijs;
    private String doelGroep;
    private Number maxAantalDeelnemers;
    private String naamVakantie;
    private String foto1 ;
    private String foto2;
    private String foto3;
    private String prijsStr;
    private String periode;
    private String vakantieID;
    private String locatie;
    private String korteBeschrijving;
    private String vertrekDatumString, terugDatumString;


    private HashMap<String, ArrayList<String>> fotos;

    public Vakantie(){
        super();

    }

    public void setVertrekDatumString(String vertrekDatumString){this.vertrekDatumString = vertrekDatumString;}
    public String getVertrekDatumString(){return vertrekDatumString;}

    public void setTerugDatumString(String terugDatumString){this.terugDatumString = terugDatumString;}
    public String getTerugDatumString(){return terugDatumString;}

    public void setLocatie(String locatie){this.locatie = locatie;}
    public String getLocatie() {return locatie;}

    public void setKorteBeschrijving(String korteBeschrijving){this.korteBeschrijving = korteBeschrijving;}
    public String getKorteBeschrijving(){return korteBeschrijving;}
    /*public String toString(){
        Calendar cal = Calendar.getInstance();
        cal.setTime(getVertrekDatum());
        String objvertrekDatum = cal.get(Calendar.DAY_OF_MONTH) + "/" + cal.get(Calendar.MONTH) + "/" + cal.get(Calendar.YEAR);
        cal.setTime(getTerugkeerDatum());
        String objterugkeerDatum = cal.get(Calendar.DAY_OF_MONTH) + "/" + cal.get(Calendar.MONTH) + "/" + cal.get(Calendar.YEAR);
        return getNaamVakantie() + " - " + getLocatie() + "\n" +
                objvertrekDatum +
                " - " + objterugkeerDatum;
    }*/

    public HashMap<String, ArrayList<String>> getFotos(){return fotos;}
    public void setFotos(HashMap<String,ArrayList< String>> fotos){this.fotos = fotos;}


    public String getVakantieID(){return vakantieID;}
    public void setVakantieID(String vakantieID){this.vakantieID=vakantieID;}

    public String getPeriode() {return periode;}
    public void setPeriode(String periode){this.periode=periode;}
    public String getNaamVakantie() {return naamVakantie;}

    public void setNaamVakantie(String naamVakantie) { this.naamVakantie = naamVakantie;}

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
    public void setPrijsStr(String prijs){this.prijsStr = prijs;}
    public String getPrijsStr(){return prijsStr;}

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

    public Number getBasisprijs() {
        return basisprijs;
    }

    public void setBasisprijs(Number basisprijs) {
        this.basisprijs = basisprijs;
    }

    public Number getBondMoysonLedenPrijs() {
        return bondMoysonLedenPrijs;
    }

    public void setBondMoysonLedenPrijs(Number bondMoysonLedenPrijs) {
        this.bondMoysonLedenPrijs = bondMoysonLedenPrijs;
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

    public Number getMaxAantalDeelnemers() {
        return maxAantalDeelnemers;
    }

    public String getFoto1(){   return foto1; }

    public void setFoto1(String fto) {this.foto1=fto;}

    public String getFoto2(){   return foto2; }

    public void setFoto2(String fto) {this.foto2=fto;}

    public String getFoto3(){   return foto3; }

    public void setFoto3(String fto) {this.foto3=fto;}

    public void setMaxAantalDeelnemers(Number maxAantalDeelnemers) {
        this.maxAantalDeelnemers = maxAantalDeelnemers;
    }

    public String getAantalDagenNachten() {
        return aantalDagenNachten;
    }

    public void setAantalDagenNachten(String aantalDagenNachten) {
        this.aantalDagenNachten = aantalDagenNachten;
    }

    public String getInbegrepenInPrijs() {
        return inbegrepenInPrijs;
    }

    public void setInbegrepenInPrijs(String inbegrepenInPrijs) {
        this.inbegrepenInPrijs = inbegrepenInPrijs;
    }

    public Number getSterPrijs1Ouder() {
        return sterPrijs1Ouder;
    }

    public void setSterPrijs1Ouder(Number sterPrijs1Ouder) {
        this.sterPrijs1Ouder = sterPrijs1Ouder;
    }

    public Number getSterPrijs2Ouder() {
        return sterPrijs2Ouder;
    }

    public void setSterPrijs2Ouder(Number sterPrijs2Ouder) {
        this.sterPrijs2Ouder = sterPrijs2Ouder;
    }
}
