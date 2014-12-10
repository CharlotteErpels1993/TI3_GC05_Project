package com.hogent.ti3g05.ti3_g05_joetzapp.domein;

import java.util.ArrayList;
import java.util.List;


public class Vorming extends Activiteit {
    private List<String> periodes;
    private Number prijs;

    private String criteriaDeelnemers, websiteLocatie, tips, betalingswijze;
    private String inbegrepenInPrijs;

    public Vorming(){
        super();
        this.periodes = new ArrayList<String>();

    }

    public String getInbegrepenInPrijs() {
        return inbegrepenInPrijs;
    }

    public void setInbegrepenInPrijs(String inbegrepenInPrijs) {
        this.inbegrepenInPrijs = inbegrepenInPrijs;
    }

    public List<String> getPeriodes() {
        return periodes;
    }

    public void setPeriodes(List<String> periodes) {
        this.periodes = periodes;
    }

    public Number getPrijs() {
        return prijs;
    }

    public void setPrijs(Number prijs) {
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

    public void setPeriodes(String string) {
        String[] perdiodesStr = string.split(",");
        for(int i = 0; i<perdiodesStr.length;i++)
        {
            periodes.add(perdiodesStr[i]);

        }

    }
}
