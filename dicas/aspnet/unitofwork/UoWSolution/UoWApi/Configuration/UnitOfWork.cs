using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using System;
using System.Threading.Tasks;
using UoWApi.Data;
using UoWApi.Services.Interfaces;
using UoWApi.Services.Repositories;

namespace UoWApi.Configuration
{
    public class UnitOfWork : IUnitOfWork, IDisposable
    {
        private readonly DbContext _context;
        private readonly ILogger _logger;

        public IProductRepository Product { get; private set; }
        
        public ICategoryRepository Category { get; private set; }

        public UnitOfWork(AppDbContext context, ILoggerFactory logger)
        {
            _context = context;
            _logger = logger.CreateLogger("logs");

            Product = new ProductRepository(context, _logger);
            Category = new CategoryRepository(context, _logger);
        }

        public async Task<int> CompleteAsync()
        {
            return await _context.SaveChangesAsync();
        }

        public void Dispose()
        {
            _context.Dispose();
        }
    }
}
