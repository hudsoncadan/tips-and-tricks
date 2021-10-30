using Microsoft.AspNetCore.Mvc;
using System.Threading.Tasks;
using UoWApi.Configuration;

namespace UoWApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public abstract class BaseController : ControllerBase
    {

        public async Task<IActionResult> CustomResponse<T>(IUnitOfWork uow, T model = default(T))
        {
            if (await uow.CompleteAsync() > 0)
            {
                return Ok(model);
            }
            else
            {
                return BadRequest("Something went wrong");
            }
        }
    }
}
