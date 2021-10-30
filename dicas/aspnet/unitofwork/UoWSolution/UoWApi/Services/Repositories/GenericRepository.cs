using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Threading.Tasks;
using UoWApi.Models.Entities;

namespace UoWApi.Repositories
{
    public abstract class GenericRepository<TEntity> : IGenericRepository<TEntity> where TEntity : Entity
    {
        protected DbContext context;
        internal DbSet<TEntity> dbSet;
        protected readonly ILogger _logger;

        public GenericRepository(
            DbContext context, 
            ILogger looger
            )
        {
            this.context = context;
            this.dbSet = context.Set<TEntity>();
            _logger = looger;
        }

        public virtual async Task<IEnumerable<TEntity>> All()
        {
            try
            {
                return await dbSet.ToListAsync();
            }
            catch (Exception ex)
            {
                return new List<TEntity>();
            }
        }

        public virtual async Task<TEntity> GetById(Guid id)
        {
            return await dbSet.FindAsync(id);
        }

        public virtual async Task<bool> Add(TEntity entity)
        {
            await dbSet.AddAsync(entity);
            return true;
        }

        public virtual async Task<bool> Delete(Guid id)
        {
            try
            {
                var exist = await dbSet.Where(x => x.Id == id)
                                        .FirstOrDefaultAsync();

                if (exist == null) return false;

                dbSet.Remove(exist);

                return true;
            }
            catch (Exception ex)
            {
                return false;
            }
        }

        public virtual async Task<bool> Update(TEntity entity)
        {
            if (entity == null)
            {
                return false;
            }

            var existingId = entity.GetType().GetProperty("Id").GetValue(entity);
            var existingModel = await dbSet.FindAsync(existingId);

            if (existingModel == null)
            {
                return false;
            }

            context.Entry(existingModel).State = EntityState.Detached;
            dbSet.Update(entity);
            dbSet.Attach(entity);
            context.Entry(entity).State = EntityState.Modified;

            return true;
        }

        public virtual async Task<IEnumerable<TEntity>> Find(Expression<Func<TEntity, bool>> predicate)
        {
            return await dbSet.Where(predicate).ToListAsync();
        }
    }
}
