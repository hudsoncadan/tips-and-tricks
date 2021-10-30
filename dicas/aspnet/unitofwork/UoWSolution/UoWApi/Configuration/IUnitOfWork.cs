using System.Threading.Tasks;
using UoWApi.Services.Interfaces;

namespace UoWApi.Configuration
{
    public interface IUnitOfWork
    {
        IProductRepository Product { get; }
        ICategoryRepository Category { get; }

        Task<int> CompleteAsync();
        void Dispose();
    }
}
