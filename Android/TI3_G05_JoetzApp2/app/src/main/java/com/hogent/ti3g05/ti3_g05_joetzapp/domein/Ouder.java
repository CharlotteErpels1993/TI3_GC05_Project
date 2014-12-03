package com.hogent.ti3g05.ti3_g05_joetzapp.domein;

/**
 * Created by Gilles De Vylder on 28/10/2014.
 */
public class Ouder extends Gebruiker { //eventueel link naar deelnemer? Aangezien ouder een deelnemer inschrijft?
    private Number aansluitingsNrTweedeOuder;

    public Number getAansluitingsNrTweedeOuder() {
        return aansluitingsNrTweedeOuder;
    }

    public void setAansluitingsNrTweedeOuder(Number aansluitingsNrTweedeOuder) {
        this.aansluitingsNrTweedeOuder = aansluitingsNrTweedeOuder;
    }

    public Ouder(){
        super();

    }
}
