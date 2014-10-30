package com.hogent.ti3g05.ti3_g05_joetzapp.domein;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * Created by Gilles De Vylder on 29/10/2014.
 */
public class Vorming extends Activiteit {
    private List<Date> periodes;
    private int prijs;
    private String criteriaDeelnemers, websiteLocatie, tips, betalingswijze;

    public Vorming(){
        super();
        this.periodes = new ArrayList<Date>();

    }


    public List<Date> getPeriodes() {
        return periodes;
    }

    public void setPeriodes(List<Date> periodes) {
        this.periodes = periodes;
    }

    public int getPrijs() {
        return prijs;
    }

    public void setPrijs(int prijs) {
        this.prijs = prijs;
    }

    public String getCriteriaDeelnemers() {
        return criteriaDeelnemers;
    }

    public void setCriteriaDeelnemers(String criteriaDeelnemers) {
        this.criteriaDeelnemers = criteriaDeelnemers;
    }

    public String getWebsiteLocatie() {
        return websiteLocatie;
    }

    public void setWebsiteLocatie(String websiteLocatie) {
        this.websiteLocatie = websiteLocatie;
    }

    public String getTips() {
        return tips;
    }

    public void setTips(String tips) {
        this.tips = tips;
    }

    public String getBetalingswijze() {
        return betalingswijze;
    }

    public void setBetalingswijze(String betalingswijze) {
        this.betalingswijze = betalingswijze;
    }
}
