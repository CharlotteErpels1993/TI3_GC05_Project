using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Joetz.Models.Domain
{
    //Administrator klasse
    public class Admin
    {
        //Hat id
       public string Id { get; set; }

       //het email adres is verplicht
        [Display(Name = "Email")]
        [Required(ErrorMessage = "{0} is verplicht")]
        public string Email { get; set; }

        //Het wachtwoord is verplicht, en mag niet langer dan 10 characters zijn
        [Display(Name = "Wachtwoord")]
        [Required(ErrorMessage = "{0} is verplicht")]
        [StringLength(10, ErrorMessage = "{0} is te lang.")]
        public string Wachtwoord { get; set; }

        //Geeft de mogelijkheid om een nieuwe admin aan te maken
        public Admin()
        {
            Id = "";
            Email = "";
            Wachtwoord = "";
        }

    }
}
