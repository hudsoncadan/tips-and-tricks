using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Threading.Tasks;
using UoWApi.Models.Entities;

namespace UoWApi.Repositories
{
    public interface IGenericRepository<TEntity> where TEntity : Entity
    {
        Task<IEnumerable<TEntity>> All();
        Task<TEntity> GetById(Guid id);
        Task<bool> Add(TEntity entity);
        Task<bool> Delete(Guid id);
        Task<bool> Update(TEntity entity);
        Task<IEnumerable<TEntity>> Find(Expression<Func<TEntity, bool>> predicate); 
    }
}
