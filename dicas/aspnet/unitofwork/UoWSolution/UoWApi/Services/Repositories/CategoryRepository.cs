using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using UoWApi.Models.Entities;
using UoWApi.Repositories;
using UoWApi.Services.Interfaces;

namespace UoWApi.Services.Repositories
{
    public class CategoryRepository : GenericRepository<Category>, ICategoryRepository
    {
        public CategoryRepository(DbContext context, ILogger looger) : base(context, looger)
        {
        }
    }
}
