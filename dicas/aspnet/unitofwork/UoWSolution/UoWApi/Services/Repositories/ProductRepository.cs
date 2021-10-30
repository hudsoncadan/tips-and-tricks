using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using System.Collections.Generic;
using System.Threading.Tasks;
using UoWApi.Models.Entities;
using UoWApi.Repositories;
using UoWApi.Services.Interfaces;

namespace UoWApi.Services.Repositories
{
    public class ProductRepository : GenericRepository<Product>, IProductRepository
    {
        public ProductRepository(DbContext context, ILogger logger) : base(context, logger)
        {
        }

        #region Custom Code

        public async Task<IEnumerable<Product>> GetProductsWithCategory()
        {
            return await dbSet.Include(x => x.Category).ToListAsync();
        }

        #endregion
    }
}
