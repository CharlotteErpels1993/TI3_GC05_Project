using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Parse;

namespace Joetz.Models.Domain
{
    public interface IVakantieRepository
    {
        Task<Vakantie> FindBy(string vakantieId);
        Task<ICollection<Vakantie>> FindAll();
        void Add(Vakantie vakantie);
        void Delete(Vakantie vakantie);
        Vakantie GetVakantie(ParseObject vakantieObject);
        void Update(Vakantie vakantie);
    }
}
