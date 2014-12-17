using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using Joetz.Models.Domain;
using Parse;
//Repository om gegevens van monitoren uit de database te halen en te bewerken
namespace Joetz.Models.DAL
{
    public class MonitorRepository : IMonitorRepository
    {

        //
        //Naam: GetMonitor
        //
        //Werking: Haalt de monitor op uit de database
        //
        //Parameters:
        // - Het object om op te zoeken
        //
        //Return: de opgezochte monitor
        //
        public Monitor GetMonitor(ParseObject monitorObject)
        {
            Monitor monitor = new Monitor();

            monitor.Id = monitorObject.ObjectId;
            monitor.Email = monitorObject.Get<string>("email");
            monitor.Rijksregisternummer = monitorObject.Get<string>("rijksregisterNr");
           
            monitor.Voornaam = monitorObject.Get<string>("voornaam");
            monitor.Naam = monitorObject.Get<string>("naam");
            monitor.Straat = monitorObject.Get<string>("straat");
            monitor.Nummer = monitorObject.Get<int>("nummer");
            
            monitor.Postcode = monitorObject.Get<int>("postcode");
            monitor.Gemeente = monitorObject.Get<string>("gemeente");
            monitor.Gsm = monitorObject.Get<string>("gsm");
            monitor.Lidnummer = monitorObject.Get<string>("lidnummer");

            return monitor;
        }

        //
        //Naam: FindAll
        //
        //Werking: Haalt alle monitoren op uit de database en vult de objecten 1 voor 1 op
        //
        //
        //Return: de lijst van monitoren
        //
        public async Task<ICollection<Monitor>> FindAll()
        {
            var query = from m in ParseObject.GetQuery("Monitor")
                        orderby m.Get<string>("naam") ascending
                        select m;

            IEnumerable<ParseObject> objects = await query.FindAsync();

            ICollection<Monitor> monitoren = new List<Monitor>();
            Monitor monitor;

            foreach (ParseObject monitorObject in objects)
            {
                monitor = GetMonitor(monitorObject);
                monitoren.Add(monitor);
            }

            return monitoren;
        }

        //
        //Naam: FindBy
        //
        //Werking: Zoekt de monitor op basis van de id
        //
        //Parameters:
        // - id om op te zoeken
        //
        //Return: de gevonden monitor
        //
        public async Task<Monitor> FindBy(string monitorId)
        {
            var query = ParseObject.GetQuery("Monitor").WhereEqualTo("objectId", monitorId);
            ParseObject monitorObject = await query.FirstAsync();

            var monitor = GetMonitor(monitorObject);
            return monitor;
        }

        //
        //Naam: Add
        //
        //Werking: Voegt een monitor toe aan de database
        //
        //Parameters:
        // - De monitor om toe te voegen
        //
        //Return: bool om aan te geven dat het gedaan is
        //
        public async Task<bool> Add(Monitor monitor)
        {
            ParseObject monitorObject = new ParseObject("Monitor");

            monitorObject["email"] = monitor.Email;
            monitorObject["rijksregisterNr"] = monitor.Rijksregisternummer;
            monitorObject["aansluitingsNr"] = monitor.Aansluitingsnummer;
            monitorObject["codeGerechtigde"] = monitor.CodeGerechtigde;
            monitorObject["voornaam"] = monitor.Voornaam;
            monitorObject["naam"] = monitor.Naam;
            monitorObject["straat"] = monitor.Straat;
            monitorObject["nummer"] = monitor.Nummer;
            monitorObject["bus"] = monitor.Bus;
            monitorObject["postcode"] = monitor.Postcode;
            monitorObject["gemeente"] = monitor.Gemeente;
            monitorObject["telefoon"] = monitor.Telefoon;
            monitorObject["gsm"] = monitor.Gsm;
            monitorObject["lidnummer"] = monitor.Lidnummer;
            
            await monitorObject.SaveAsync();

            

            return true;
        }

        //
        //Naam: Delete
        //
        //Werking: Verwijdert de monitor uit de database
        //
        //Parameters:
        // - De monitor om te verwijderen
        //
        //Return: boolean om aan te geven dat het verwijderen gedaan is
        //
        public async Task<bool> Delete(Monitor monitor)
        {
            var query = ParseObject.GetQuery("Monitor").WhereEqualTo("objectId", monitor.Id);
            ParseObject monitorObject = await query.FirstAsync();

            await monitorObject.DeleteAsync();
            return true;
        }
    }
}