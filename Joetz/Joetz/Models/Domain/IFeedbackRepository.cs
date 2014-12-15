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
        Task<bool> Delete(Feedback vakantie);
        Task<Feedback> GetFeedback(ParseObject feedbackObject);
        Task<Boolean> Update(Feedback feedback);
    }
}
