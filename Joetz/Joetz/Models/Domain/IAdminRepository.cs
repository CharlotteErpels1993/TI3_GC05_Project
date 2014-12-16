using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Joetz.Models.Domain
{
    public interface IAdminRepository
    {
        Vorming GetVorming(ParseObject vormingObject);
        Task<Vorming> FindBy(string vormingId);
        Task<ICollection<Vorming>> FindAll();
        Task<bool> Add(Vorming vorming);
        Task<bool> Delete(Vorming vorming);
        Task<bool> Update(Vorming vorming);

    }
}
