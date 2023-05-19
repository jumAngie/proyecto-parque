using System;
using ParqueDiversion.Entities.Entities;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ParqueDiversion.DataAccess.Repositories.Parq
{
    public class RegionesRepository : IRepository<tbRegiones, VW_tbRegiones>
    {
        public RequestStatus Delete(int id)
        {
            throw new NotImplementedException();
        }

        public VW_tbRegiones Find(int id)
        {
            throw new NotImplementedException();
        }

        public RequestStatus Insert(tbRegiones item)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<VW_tbRegiones> List()
        {
            throw new NotImplementedException();
        }

        public RequestStatus Update(tbRegiones item)
        {
            throw new NotImplementedException();
        }
    }
}
