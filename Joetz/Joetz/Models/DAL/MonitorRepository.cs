using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using Joetz.Models.Domain;
using Parse;

namespace Joetz.Models.DAL
{
    public class MonitorRepository : IMonitorRepository
    {
        public Monitor GetMonitor(ParseObject monitorObject)
        {
            Monitor monitor = new Monitor();

            monitor.Id = monitorObject.ObjectId;
            monitor.Email = monitorObject.Get<string>("Email");
            monitor.Rijksregisternummer = monitorObject.Get<string>("rijksregisterNr");
            monitor.Aansluitingsnummer = monitorObject.Get<int>("aansluitingsNr");
            monitor.CodeGerechtigde = monitorObject.Get<int>("codeGerechtigde");
            monitor.Voornaam = monitorObject.Get<string>("voornaam");
            monitor.Naam = monitorObject.Get<string>("naam");
            monitor.Straat = monitorObject.Get<string>("straat");
            monitor.Nummer = monitorObject.Get<int>("nummer");
            monitor.Bus = monitorObject.Get<string>("bus");
            monitor.Postcode = monitorObject.Get<int>("postcode");
            monitor.Gemeente = monitorObject.Get<string>("gemeente");
            monitor.Telefoon = monitorObject.Get<string>("telefoon");
            monitor.Gsm = monitorObject.Get<string>("gsm");
            monitor.Lidnummer = monitorObject.Get<string>("lidnummer");

            return monitor;
        }

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

        public async Task<Monitor> FindBy(string monitorId)
        {
            var query = ParseObject.GetQuery("Monitor").WhereEqualTo("objectId", monitorId);
            ParseObject monitorObject = await query.FirstAsync();

            var monitor = GetMonitor(monitorObject);
            return monitor;
        }

        public async void Add(Monitor monitor)
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
        }

        public async void Delete(Monitor monitor)
        {
            var query = ParseObject.GetQuery("Monitor").WhereEqualTo("objectId", monitor.Id);
            ParseObject monitorObject = await query.FirstAsync();

            await monitorObject.DeleteAsync();
        }

        public void Update(Monitor monitor)
        {
            throw new NotImplementedException();
        }
    }
}