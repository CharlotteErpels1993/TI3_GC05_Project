using System;
using System.ComponentModel.DataAnnotations;
using System.Dynamic;
using NetOffice;

namespace Joetz.Models.Domain
{
    public class Monitor
    {
        public string Id { get; set; }

        [Display(Name = "E-mail")]
        [Required(ErrorMessage = "{0} is verplicht")]
        [DataType(DataType.EmailAddress)]
        public string Email { get; set; }

        [Display(Name = "Rijksregisternummer")]
        [Required(ErrorMessage = "{0} is verplicht")]
        [StringLength(11, ErrorMessage = "{0} is te lang.")]
        public string Rijksregisternummer { get; set; }

        [Display(Name = "Aansluitingsnummer")]
        [Required(ErrorMessage = "{0} is verplicht")]
        [StringLength(10, ErrorMessage = "{0} is te lang.")]
        //[Range(0, , ErrorMessage = "Maximum leeftijd mag niet negatief zijn")]
        public int Aansluitingsnummer { get; set; }

        [Display(Name = "Code van de gerechtigde")]
        [Required(ErrorMessage = "{0} is verplicht")]
        [StringLength(6, ErrorMessage = "{0} is te lang.")]
        //[Range(0, , ErrorMessage = "Maximum leeftijd mag niet negatief zijn")]
        public int CodeGerechtigde { get; set; }

        [Display(Name = "Voornaam")]
        [Required(ErrorMessage = "{0} is verplicht")]
        [StringLength(50, ErrorMessage = "{0} is te lang.")]
        public string Voornaam { get; set; }

        [Display(Name = "Naam")]
        [Required(ErrorMessage = "{0} is verplicht")]
        [StringLength(50, ErrorMessage = "{0} is te lang.")]
        public string Naam { get; set; }

        [Display(Name = "Straat")]
        [Required(ErrorMessage = "{0} is verplicht")]
        [StringLength(50, ErrorMessage = "{0} is te lang.")]
        public string Straat { get; set; }

        [Display(Name = "Huisnummer")]
        [Required(ErrorMessage = "{0} is verplicht")]
        [Range(1, Int32.MaxValue, ErrorMessage = "Huisnummer mag niet negatief zijn")]
        public int Nummer { get; set; }

        [Display(Name = "Bus")]
        public string Bus { get; set; }

        [Display(Name = "Postcode")]
        [Required(ErrorMessage = "{0} is verplicht")]
        [Range(1000, 9992, ErrorMessage = "Postcode moet tussen 1000 en 9992 liggen (grenzen inbegrepen)")]
        public int Postcode { get; set; }

        [Display(Name = "Gemeente")]
        [Required(ErrorMessage = "{0} is verplicht")]
        [StringLength(50, ErrorMessage = "{0} is te lang.")]
        public string Gemeente { get; set; }

        [Display(Name = "Telefoon")]
        [DataType(DataType.PhoneNumber)]
        public string Telefoon { get; set; }

        [Display(Name = "Gsm-nummer")]
        [Required(ErrorMessage = "{0} is verplicht")]
        //[StringLength(50, ErrorMessage = "{0} is te lang.")]
        [DataType(DataType.PhoneNumber)]
        public string Gsm { get; set; }

        [Display(Name = "Lidnummer")]
        [Required(ErrorMessage = "{0} is verplicht")]
        [StringLength(5, ErrorMessage = "{0} is te lang.")]
        public string Lidnummer { get; set; }

        public Monitor()
        {
            Id = "";
            Email = "";
            Rijksregisternummer = "";
            Aansluitingsnummer = 0;
            CodeGerechtigde = 0;
            Voornaam = "";
            Naam = "";
            Straat = "";
            Nummer = 0;
            Bus = "";
            Postcode = 0;
            Gemeente = "";
            Telefoon = "";
            Gsm = "";
            Lidnummer = "";
        }
    }
}