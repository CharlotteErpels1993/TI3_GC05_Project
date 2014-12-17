using Joetz.Models.Domain;
using Parse;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Web;
using System.Web.Mvc;

namespace Joetz.Models.DAL
{
    public class AdminRepository : IAdminRepository
    {
        public Admin GetAdmin(ParseObject adminObject)
        {
            Admin admin = new Admin();

            admin.Id = adminObject.ObjectId;
            admin.Email = adminObject.Get<string>("email");

            return admin;
        }

        public async Task<Admin> FindBy(string adminId)
        {
            IEnumerable<ParseUser> adminObject = await ParseUser.Query.WhereEqualTo("objectId", adminId).FindAsync();
            ParseUser adminObj = adminObject.FirstOrDefault();
            var admin = GetAdmin(adminObj);
            return admin;
        }

        public async Task<ICollection<Admin>> FindAll()
        {

            IEnumerable<ParseObject> objects = await (from user in ParseUser.Query
                               where user.Get<string>("soort") == "administrator"
                               select user).FindAsync();


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
            
            ParseUser current = ParseUser.CurrentUser;

            var user = new ParseUser()
            {
                Username = admin.Email,
                Password = admin.Wachtwoord,
                Email = admin.Email
            };

            user["soort"] = "administrator";

            await user.SignUpAsync();
            Parse.ParseUser.LogOut();

            return true;
        }

        public async Task<bool> Delete(Admin admin)
        {
            IEnumerable<ParseUser> adminObject = await ParseUser.Query.WhereEqualTo("objectId", admin.Id).FindAsync();

            ParseObject adminObj = adminObject.FirstOrDefault();
            try
            {
                await adminObj.DeleteAsync();
            }
            catch (ParseException pa)
            {
                adminObj.DeleteAsync();
            }
            
            return true;
        }


    }
}
