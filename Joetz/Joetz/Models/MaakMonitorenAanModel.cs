using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace Joetz.Models
{
    public class MaakMonitorenAanModel
    {
        [Required]
        [Display(Name = "File")]
        public String fileNaam { get; set; }
           
    }
}