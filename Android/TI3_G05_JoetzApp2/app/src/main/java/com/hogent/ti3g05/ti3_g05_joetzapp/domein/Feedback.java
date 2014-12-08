package com.hogent.ti3g05.ti3_g05_joetzapp.domein;

/**
 * Created by Gebruiker on 8/12/2014.
 */
public class Feedback {

    private String feedback;
    private Number score;
    private String vakantieNaam;
    private String vakantieId;
    private String gebruikerId;
    private String gebruiker;
    private Boolean goedgekeurd;

    public void setGoedgekeurd(Boolean goedgekeurd) {
        this.goedgekeurd = goedgekeurd;
    }

    public void setGebruikerId(String gebruikerId) {
        this.gebruikerId = gebruikerId;
    }

    public Boolean getGoedgekeurd() {
        return goedgekeurd;
    }

    public void setGebruiker(String gebruiker) {
        this.gebruiker = gebruiker;
    }

    public String getGebruiker() {
        return gebruiker;
    }

    public String getGebruikerId() {
        return gebruikerId;
    }

    public void setFeedback(String feedback){this.feedback = feedback;}

    public String getFeedback() {
        return feedback;
    }

    public Number getScore() {
        return score;
    }

    public String getVakantieNaam() {
        return vakantieNaam;
    }

    public String getVakantieId() {
        return vakantieId;
    }

    public void setScore(Number score) {
        this.score = score;
    }

    public void setVakantieNaam(String vakantieNaam) {
        this.vakantieNaam = vakantieNaam;
    }

    public void setVakantieId(String vakantieId) {
        this.vakantieId = vakantieId;
    }
}
