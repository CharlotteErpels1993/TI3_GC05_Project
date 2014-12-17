using System.Collections.Generic;
using System.Threading.Tasks;
using Parse;

namespace Joetz.Models.Domain
{
    //Repository interface
    public interface IVakantieRepository
    {
        Task<Vakantie> FindBy(string vakantieId);
        Task<ICollection<Vakantie>> FindAll();
        Task<bool> Add(Vakantie vakantie);
        Task<bool> Delete(Vakantie vakantie);
        Vakantie GetVakantie(ParseObject vakantieObject);
        Task<bool> Update(Vakantie vakantie);
    }
}
