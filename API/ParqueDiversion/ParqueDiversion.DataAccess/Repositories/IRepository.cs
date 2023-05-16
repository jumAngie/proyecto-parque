using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ParqueDiversion.DataAccess.Repositories
{
        public   interface IRepository<T, U>
        {
            public U Find(int id);
            public IEnumerable<U> List();
            public RequestStatus Insert(T item);
            public RequestStatus Update(T item);
            public RequestStatus Delete(int id);
        }
}
