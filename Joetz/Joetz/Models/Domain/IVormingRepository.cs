using System.Collections.Generic;
using System.Threading.Tasks;
using Parse;

namespace Joetz.Models.Domain
{
    public interface IVormingRepository
    {
        Vorming GetVorming(ParseObject vormingObject);
        Task<Vorming> FindBy(string vormingId);
        Task<ICollection<Vorming>>  FindAll();
        void Add(Vorming vorming);
        void Delete(Vorming vorming);
    }
}
