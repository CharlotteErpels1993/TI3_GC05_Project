namespace Joetz.Models.Domain
{
    public class Activiteit
    {
        public string Id { get; set; }
        public string Titel { get; set; }
        public string Locatie { get; set; }
        public string KorteBeschrijving { get; set; }

        public Activiteit(string id)
        {
            Id = id;
            Titel = "";
            Locatie = "";
            KorteBeschrijving = "";
        }
    }
}