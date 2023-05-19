using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using ParqueDiversion.Entities.Entities;

namespace ParqueDiversion.DataAccess.Repositories.Parq
{
    public class TicketRepository : IRepository<tbTickets, VW_tbTickets>
    {
        public RequestStatus Delete(int id)
        {
            throw new NotImplementedException();
        }

        public VW_tbTickets Find(int id)
        {
            throw new NotImplementedException();
        }

        public RequestStatus Insert(tbTickets item)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<VW_tbTickets> List()
        {
            throw new NotImplementedException();
        }

        public RequestStatus Update(tbTickets item)
        {
            throw new NotImplementedException();
        }
    }
}
