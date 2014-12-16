using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Joetz.Models.Domain
{
    public class Admin
    {
       public string Id { get; set; }

        [Display(Name = "Email")]
        [Required(ErrorMessage = "{0} is verplicht")]
        public string Email { get; set; }

        [Display(Name = "Locatie")]
        [Required(ErrorMessage = "{0} is verplicht")]
        [StringLength(10, ErrorMessage = "{0} is te lang.")]
        [DataType(DataType.MultilineText)]
        public string Wachtwoord { get; set; }

        [Display(Name = "Beschrijving")]
        [Required(10, ErrorMessage = "{0} is verplicht")]
        public string BevestigWachtwoord { get; set; }

        public Activiteit()
        {
            Id = "";
            Email = "";
            Wachtwoord = "";
            BevestigWachtwoord = "";
        }

    }
}
