using System.Collections.Generic;
using System.Threading.Tasks;
using Parse;

namespace Joetz.Models.Domain
{
    public interface IMonitorRepository
    {
        Task<Monitor> FindBy(string monitorId);
        Task<ICollection<Monitor>> FindAll();
        Task<bool> Add(Monitor monitor);
        Task<bool> Delete(Monitor monitor);
        Monitor GetMonitor(ParseObject monitorObject);
    }
}
