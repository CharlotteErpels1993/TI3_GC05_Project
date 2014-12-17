using Parse;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Web;
using System.Web.Mvc;

namespace Joetz.Models.Domain
{
    //Repository interface
    public interface IAdminRepository
    {
        Admin GetAdmin(ParseObject adminObject);
        Task<Admin> FindBy(string adminId);
        Task<ICollection<Admin>> FindAll();
        Task<bool> Add(Admin admin);
        Task<bool> Delete(Admin admin);

    }
}
