using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Parse;

namespace Joetz.Models.Domain
{
    public interface IVakantieRepository
    {
        Vakantie FindBy(string vakantieId);
        Task<IList<Vakantie>> FindAll();
        void Add(Vakantie vakantie);
        void Delete(Vakantie vakantie);
        Vakantie GetVakantie(ParseObject vakantieObject);
    }
}
