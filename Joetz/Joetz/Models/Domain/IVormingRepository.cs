using System.Collections.Generic;
using Parse;

namespace Joetz.Models.Domain
{
    public interface IVormingRepository
    {
        Vorming GetVorming(ParseObject vormingObject);
        Vorming FindBy(string vormingId);
        IList<Vorming> FindAll();
        void Add(Vorming vorming);
        void Delete(Vorming vorming);
    }
}
