using System;
using System.ComponentModel.DataAnnotations;

namespace Joetz.Models.Domain
{
    //Monitor klasse
    public class Monitor
    {
        //De monitor id
        public string Id { get; set; }

        //Het emailadres is verplicht
        [Display(Name = "E-mail")]
        [Required(ErrorMessage = "{0} is verplicht")]
        [DataType(DataType.EmailAddress)]
        public string Email { get; set; }

        //Het rijksregisternummer is verplicht, en mag niet langer dan 11 characters zijn
        [Display(Name = "Rijksregisternummer")]
        [Required(ErrorMessage = "{0} is verplicht")]
        [StringLength(11, ErrorMessage = "{0} is te lang.")]
        public string Rijksregisternummer { get; set; }

        //Het aansluitingsnummer is verplicht, en mag niet langer dan 10 characters zijn
        [Display(Name = "Aansluitingsnummer")]
        [Required(ErrorMessage = "{0} is verplicht")]
        [StringLength(10, ErrorMessage = "{0} is te lang.")]
        public int Aansluitingsnummer { get; set; }

        //Het codegerechtigdenummer is verplicht, en mag niet langer dan 6 characters zijn
        [Display(Name = "Code van de gerechtigde")]
        [Required(ErrorMessage = "{0} is verplicht")]
        [StringLength(6, ErrorMessage = "{0} is te lang.")]
        public int CodeGerechtigde { get; set; }

        //De voornaam is verplicht, en mag niet langer dan 50 characters zijn
        [Display(Name = "Voornaam")]
        [Required(ErrorMessage = "{0} is verplicht")]
        [StringLength(50, ErrorMessage = "{0} is te lang.")]
        public string Voornaam { get; set; }

        //De achternaam is verplicht, en mag niet langer dan 50 characters zijn
        [Display(Name = "Naam")]
        [Required(ErrorMessage = "{0} is verplicht")]
        [StringLength(50, ErrorMessage = "{0} is te lang.")]
        public string Naam { get; set; }

        //De straat is verplicht, en mag niet langer dan 50 characters zijn
        [Display(Name = "Straat")]
        [Required(ErrorMessage = "{0} is verplicht")]
        [StringLength(50, ErrorMessage = "{0} is te lang.")]
        public string Straat { get; set; }

        //Het huisnummer is verplicht, en moet positief zijn
        [Display(Name = "Huisnummer")]
        [Required(ErrorMessage = "{0} is verplicht")]
        [Range(1, Int32.MaxValue, ErrorMessage = "Huisnummer mag niet negatief zijn")]
        public int Nummer { get; set; }

        //De bus is optioneel
        [Display(Name = "Bus")]
        public string Bus { get; set; }

        //De postcode is verplicht, en moet tussen 1000 en 9992 liggen
        [Display(Name = "Postcode")]
        [Required(ErrorMessage = "{0} is verplicht")]
        [Range(1000, 9992, ErrorMessage = "Postcode moet tussen 1000 en 9992 liggen (grenzen inbegrepen)")]
        public int Postcode { get; set; }

        //De gemeente is verplicht, en mag niet langer dan 50 characters zijn
        [Display(Name = "Gemeente")]
        [Required(ErrorMessage = "{0} is verplicht")]
        [StringLength(50, ErrorMessage = "{0} is te lang.")]
        public string Gemeente { get; set; }

        //Het telefoonnummer is optioneel
        [Display(Name = "Telefoon")]
        [DataType(DataType.PhoneNumber)]
        public string Telefoon { get; set; }

        //Het gsmnummer is verplicht
        [Display(Name = "Gsm-nummer")]
        [Required(ErrorMessage = "{0} is verplicht")]
        [DataType(DataType.PhoneNumber)]
        public string Gsm { get; set; }

        //Het lidnummer is verplicht, en mag niet langer dan 5 characters zijn
        [Display(Name = "Lidnummer")]
        [Required(ErrorMessage = "{0} is verplicht")]
        [StringLength(5, ErrorMessage = "{0} is te lang.")]
        public string Lidnummer { get; set; }

        //Geeft de mogelijkheid om een nieuwe monitor aan te maken
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