using ParqueDiversion.Entities.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ParqueDiversion.DataAccess.Repositories.Parq
{
    public class CargoRepository : IRepository<tbCargos, VW_tbCargos>
    {
        public RequestStatus Delete(int id)
        {
            throw new NotImplementedException();
        }

        public VW_tbCargos Find(int id)
        {
            throw new NotImplementedException();
        }

        public RequestStatus Insert(tbCargos item)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<VW_tbCargos> List()
        {
            throw new NotImplementedException();
        }

        public RequestStatus Update(tbCargos item)
        {
            throw new NotImplementedException();
        }
    }
}
