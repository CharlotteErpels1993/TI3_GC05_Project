﻿using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using Joetz.Models.Domain;
using Parse;
//Repository om gegevens van vakanties uit de database te halen en te bewerken
namespace Joetz.Models.DAL
{
    public class VakantieRepository: IVakantieRepository
    {
        //
        //Naam: GetVakantie
        //
        //Werking: Haalt de vakantie op uit de database
        //
        //Parameters:
        // - Het object om op te zoeken
        //
        //Return: de opgezochte vakantie
        //
        public Vakantie GetVakantie(ParseObject vakantieObject)
        {
            Vakantie vakantie = new Vakantie();

            vakantie.Id = vakantieObject.ObjectId;
            vakantie.Titel = vakantieObject.Get<string>("titel");
            vakantie.Locatie = vakantieObject.Get<string>("locatie");
            vakantie.KorteBeschrijving = vakantieObject.Get<string>("korteBeschrijving");
            vakantie.AantalDagenNachten = vakantieObject.Get<string>("aantalDagenNachten");
            vakantie.Link = vakantieObject.Get<string>("link");
            vakantie.BasisPrijs = vakantieObject.Get<Double>("basisPrijs");
            vakantie.BondMoysonLedenPrijs = vakantieObject.Get<Double>("bondMoysonLedenPrijs");
            vakantie.Formule = vakantieObject.Get<string>("formule");
            vakantie.InbegrepenPrijs = vakantieObject.Get<string>("inbegrepenPrijs");
            vakantie.MaxAantalDeelnemers = vakantieObject.Get<int>("maxAantalDeelnemers");
            vakantie.MinLeeftijd = vakantieObject.Get<int>("minLeeftijd");
            vakantie.MaxLeeftijd = vakantieObject.Get<int>("maxLeeftijd");
            vakantie.SterPrijs1Ouder = vakantieObject.Get<Double>("sterPrijs1ouder");
            vakantie.SterPrijs2Ouders = vakantieObject.Get<Double>("sterPrijs2ouders");
            vakantie.TerugkeerDatum = vakantieObject.Get<DateTime>("terugkeerdatum");
            vakantie.VertrekDatum = vakantieObject.Get<DateTime>("vertrekdatum");
            vakantie.Vervoerwijze = vakantieObject.Get<string>("vervoerwijze");

            return vakantie;

        }
        //
        //Naam: FindAll
        //
        //Werking: Haalt alle vakanties op uit de database en vult de objecten 1 voor 1 op
        //
        //
        //Return: de lijst van vakanties
        //
        public async Task<ICollection<Vakantie>> FindAll()
        {
            var query = from v in ParseObject.GetQuery("Vakantie")
                        orderby v.Get<string>("titel") ascending
                        select v;

            IEnumerable<ParseObject> objects = await query.FindAsync();

            ICollection<Vakantie> vakanties = new List<Vakantie>();
            Vakantie vakantie;

            foreach (ParseObject vakantieObject in objects)
            {
                vakantie = GetVakantie(vakantieObject);
                vakanties.Add(vakantie);
            }

            return vakanties;
        }
        //
        //Naam: FindBy
        //
        //Werking: Zoekt de vakantie op basis van de id
        //
        //Parameters:
        // - id om op te zoeken
        //
        //Return: de gevonden vakantie
        //
        public async Task<Vakantie> FindBy(string vakantieId)
        {
            var query = ParseObject.GetQuery("Vakantie").WhereEqualTo("objectId", vakantieId);
            ParseObject vakantieObject = await query.FirstAsync();

            var vakantie = GetVakantie(vakantieObject);
            return vakantie;
        }

        //
        //Naam: Add
        //
        //Werking: Voegt een vakantie toe aan de database
        //
        //Parameters:
        // - De vakantie om toe te voegen
        //
        //Return: bool om aan te geven dat het gedaan is
        //
        public async Task<bool> Add(Vakantie vakantie)
        {
            ParseObject vakantieObject = new ParseObject("Vakantie");

            vakantieObject["titel"] = vakantie.Titel;
            vakantieObject["locatie"] = vakantie.Locatie;
            vakantieObject["korteBeschrijving"] = vakantie.KorteBeschrijving;
            vakantieObject["aantalDagenNachten"] = vakantie.AantalDagenNachten;
            vakantieObject["basisPrijs"] = vakantie.BasisPrijs;
            vakantieObject["bondMoysonLedenPrijs"] = vakantie.BondMoysonLedenPrijs;
            vakantieObject["formule"] = vakantie.Formule;
            vakantieObject["link"] = vakantie.Link;
            vakantieObject["inbegrepenPrijs"] = vakantie.InbegrepenPrijs;
            vakantieObject["maxAantalDeelnemers"] = vakantie.MaxAantalDeelnemers;
            vakantieObject["minLeeftijd"] = vakantie.MinLeeftijd;
            vakantieObject["maxLeeftijd"] = vakantie.MaxLeeftijd;
            vakantieObject["sterPrijs1ouder"] = vakantie.SterPrijs1Ouder;
            vakantieObject["sterPrijs2ouders"] = vakantie.SterPrijs2Ouders;
            vakantieObject["terugkeerdatum"] = vakantie.TerugkeerDatum;
            vakantieObject["vertrekdatum"] = vakantie.VertrekDatum;
            vakantieObject["vervoerwijze"] = vakantie.Vervoerwijze;

            await vakantieObject.SaveAsync();

            return true;
        }
        //
        //Naam: Delete
        //
        //Werking: Verwijdert de vakantie uit de database
        //
        //Parameters:
        // - De vakantie om te verwijderen
        //
        //Return: boolean om aan te geven dat het verwijderen gedaan is
        //
        public async Task<bool> Delete(Vakantie vakantie)
        {
            var query = ParseObject.GetQuery("Vakantie").WhereEqualTo("objectId", vakantie.Id);
            ParseObject vakantieObject = await query.FirstAsync();

            await vakantieObject.DeleteAsync();

            return true;
        }

        //
        //Naam: Update
        //
        //Werking: Verandert de vakantie in de database
        //
        //Parameters:
        // - De vakantie om te aan te passen
        //
        //Return: boolean om aan te geven dat het aanpassen gedaan is
        //
        public async Task<bool> Update(Vakantie vakantie)
        {
            var query = ParseObject.GetQuery("Vakantie").WhereEqualTo("objectId", vakantie.Id);
            ParseObject vakantieObject = await query.FirstAsync();

            vakantieObject["titel"] = vakantie.Titel;
            vakantieObject["locatie"] = vakantie.Locatie;
            vakantieObject["korteBeschrijving"] = vakantie.KorteBeschrijving;
            vakantieObject["aantalDagenNachten"] = vakantie.AantalDagenNachten;
            vakantieObject["basisPrijs"] = vakantie.BasisPrijs;
            vakantieObject["bondMoysonLedenPrijs"] = vakantie.BondMoysonLedenPrijs;
            vakantieObject["formule"] = vakantie.Formule;
            vakantieObject["link"] = vakantie.Link;
            vakantieObject["inbegrepenPrijs"] = vakantie.InbegrepenPrijs;
            vakantieObject["maxAantalDeelnemers"] = vakantie.MaxAantalDeelnemers;
            vakantieObject["minLeeftijd"] = vakantie.MinLeeftijd;
            vakantieObject["maxLeeftijd"] = vakantie.MaxLeeftijd;
            vakantieObject["sterPrijs1ouder"] = vakantie.SterPrijs1Ouder;
            vakantieObject["sterPrijs2ouders"] = vakantie.SterPrijs2Ouders;
            vakantieObject["terugkeerdatum"] = vakantie.TerugkeerDatum;
            vakantieObject["vertrekdatum"] = vakantie.VertrekDatum;
            vakantieObject["vervoerwijze"] = vakantie.Vervoerwijze;

            await vakantieObject.SaveAsync();

            return true;
        }
    }
}