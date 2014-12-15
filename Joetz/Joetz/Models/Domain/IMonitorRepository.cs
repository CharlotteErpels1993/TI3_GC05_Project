using System.Collections.Generic;
using System.Threading.Tasks;
using Parse;

namespace Joetz.Models.Domain
{
    public interface IMonitorRepository
    {
        Task<Monitor> FindBy(string monitorId);
        Task<ICollection<Monitor>> FindAll();
        void Add(Monitor monitor);
        void Delete(Monitor monitor);
        Monitor GetMonitor(ParseObject monitorObject);
        void Update(Monitor monitor);
    }
}
