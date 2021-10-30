using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using UoWApi.Models.Entities;
using UoWApi.Repositories;

namespace UoWApi.Services.Interfaces
{
    public interface IProductRepository : IGenericRepository<Product>
    {
        Task<IEnumerable<Product>> GetProductsWithCategory();
    }    
}
