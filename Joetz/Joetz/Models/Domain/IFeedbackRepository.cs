using Parse;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Web;
using System.Web.Mvc;

namespace Joetz.Models.Domain
{
    public interface IFeedbackRepository
    {
        Task<Feedback> FindBy(string feedbackId);
        Task<ICollection<Feedback>> FindAll();
        void Delete(Feedback vakantie);
        Feedback GetFeedback(ParseObject feedbackObject);
        void Update(Feedback feedback);
    }
}
