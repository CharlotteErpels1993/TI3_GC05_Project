using System.Linq;

namespace Joetz.Models.Domain
{
    public interface IVakantieRepository
    {
        Vakantie FindBy(string vakantieId);
        IQueryable<Vakantie> FindAll();
        void Add(Vakantie vakantie);
        void Delete(Vakantie vakantie);
        void SaveChanges();
    }
}
