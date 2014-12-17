using System.Collections.Generic;
using System.Threading.Tasks;
using Parse;

namespace Joetz.Models.Domain
{
    //Repository interface
    public interface IVormingRepository
    {
        Vorming GetVorming(ParseObject vormingObject);
        Task<Vorming> FindBy(string vormingId);
        Task<ICollection<Vorming>>  FindAll();
        Task<bool> Add(Vorming vorming);
        Task<bool> Delete(Vorming vorming);
        Task<bool> Update(Vorming vorming);
    }
}
