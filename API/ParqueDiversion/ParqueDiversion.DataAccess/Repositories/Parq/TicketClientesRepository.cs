using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using ParqueDiversion.Entities.Entities;

namespace ParqueDiversion.DataAccess.Repositories.Parq
{
    public class TicketClientesRepository : IRepository<tbTicketsCliente, VW_tbTicketClientes>
    {
        public RequestStatus Delete(int id)
        {
            throw new NotImplementedException();
        }

        public VW_tbTicketClientes Find(int id)
        {
            throw new NotImplementedException();
        }

        public RequestStatus Insert(tbTicketsCliente item)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<VW_tbTicketClientes> List()
        {
            throw new NotImplementedException();
        }

        public RequestStatus Update(tbTicketsCliente item)
        {
            throw new NotImplementedException();
        }
    }
}
