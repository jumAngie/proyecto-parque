using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using ParqueDiversion.Entities.Entities;

namespace ParqueDiversion.DataAccess.Repositories.Parq
{
    class AtraccionesRepository : IRepository<tbAtracciones, VW_tbAtracciones>
    {
        public RequestStatus Delete(int id)
        {
            throw new NotImplementedException();
        }

        public VW_tbAtracciones Find(int id)
        {
            throw new NotImplementedException();
        }

        public RequestStatus Insert(tbAtracciones item)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<VW_tbAtracciones> List()
        {
            throw new NotImplementedException();
        }

        public RequestStatus Update(tbAtracciones item)
        {
            throw new NotImplementedException();
        }
    }
}
