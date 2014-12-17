using Joetz.Models.Domain;
using Parse;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Web;
using System.Web.Mvc;
//Repository om gegevens van administratoren uit de database te halen en te bewerken
namespace Joetz.Models.DAL
{
    public class AdminRepository : IAdminRepository
    {
        //
        //Naam: GetAdmin
        //
        //Werking: Haalt de gebruiker op uit de database
        //
        //Parameters:
        // - Het object om op te zoeken
        //
        //Return: de opgezochte administrator
        //
        public Admin GetAdmin(ParseObject adminObject)
        {
            Admin admin = new Admin();

            admin.Id = adminObject.ObjectId;
            admin.Email = adminObject.Get<string>("email");

            return admin;
        }

        //
        //Naam: FindBy
        //
        //Werking: Zoekt een administrator op basis van de id
        //
        //Parameters:
        // - id om op te zoeken
        //
        //Return: de gevonden administrator
        //
        public async Task<Admin> FindBy(string adminId)
        {
            IEnumerable<ParseUser> adminObject = await ParseUser.Query.WhereEqualTo("objectId", adminId).FindAsync();
            ParseUser adminObj = adminObject.FirstOrDefault();
            var admin = GetAdmin(adminObj);
            return admin;
        }

        //
        //Naam: FindAll
        //
        //Werking: Haalt alle admins op uit de database en vult de objecten 1 voor 1 op
        //
        //
        //Return: de lijst van administrators
        //
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

        //
        //Naam: Add
        //
        //Werking: Voegt een administrator toe aan de database
        //
        //Parameters:
        // - De administrator om toe te voegen
        //
        //Return: bool om aan te geven dat het gedaan is
        //
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

        //
        //Naam: Delete
        //
        //Werking: Verwijdert de administrator uit de database, kan enkel door de gebruiker zelf
        //
        //Parameters:
        // - De administrator om te verwijderen
        //
        //Return: boolean om aan te geven dat het verwijderen gedaan is
        //
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
