using Joetz.Models.Domain;
using Parse;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Joetz.Models.DAL
{
    public class AdminRepository : IAdminRepository
    {
        public Vorming GetAdmin(ParseObject adminObject)
        {
            Admin admin = new Admin();

            admin.Id = adminObject.ObjectId;
            admin.Email = adminObject.Get<string>("email");

            return admin;
        }

        public async Task<Vorming> FindBy(string adminId)
        {
            var query = ParseUser.WhereEqualTo("objectId", adminId);
            ParseObject adminObject = await query.FirstAsync();

            var admin = GetAdmin(adminObject);
            return admin;
        }

        public async Task<ICollection<Vorming>> FindAll()
        {
            var query = from u in ParseUser where u.Get<string>("soort").Equals("administrator")
                        orderby u.Get<string>("email") ascending
                        select u;

            IEnumerable<ParseObject> objects = await query.FindAsync();

            ICollection<Admin> admins = new List<Admin>();
            Admin admin;

            foreach (ParseObject adminObject in objects)
            {
                admin = GetAdmin(adminObject);
                admins.Add(admin);
            }

            return admins;
        }

        public async Task<bool> Add(Admin admin)
        {
            ParseObject adminObject = new ParseUser

            adminObject["email"] = admin.Email;
            adminObject["password"] = admin.Wachtwoord;
            adminObject["soort"] = "administrator";

            await adminObject.SaveAsync();

            return true;
        }

        public async Task<bool> Delete(Admin admin)
        {
            var query = ParseUser.WhereEqualTo("objectId", admin.Id);
            ParseObject adminObject = await query.FirstAsync();

            await adminObject.DeleteAsync();
            return true;
        }

        public async Task<bool> Update(Admin admin)
        {
            var query = ParseUser.WhereEqualTo("objectId", admin.Id);
            ParseObject adminObject = await query.FirstAsync();

            adminObject["email"] = admin.Email;
            adminObject["password"] = admin.Wachtwoord;
            
            await adminObject.SaveAsync();

            return true;
        }

    }
}
