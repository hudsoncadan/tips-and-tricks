using Microsoft.AspNetCore.Mvc;
using System;
using System.Threading.Tasks;
using UoWApi.Configuration;
using UoWApi.Models.Entities;

namespace UoWApi.Controllers
{
    public class CategoryController : BaseController
    {
        private readonly IUnitOfWork uow;

        public CategoryController(IUnitOfWork uow)
        {
            this.uow = uow;
        }

        [HttpGet]
        public async Task<IActionResult> GetAll()
        {
            return Ok(await uow.Category.All());
        }

        [HttpGet("{id:guid}")]
        public async Task<IActionResult> GetById(Guid id)
        {
            var model = await uow.Category.GetById(id);

            if (model == null)
            {
                return NotFound("Category not found");
            }

            return Ok(model);
        }

        [HttpPost]
        public async Task<IActionResult> Add(Category model)
        {
            if (ModelState.IsValid)
            {
                await uow.Category.Add(model);
                var saved = await uow.CompleteAsync();

                if (saved > 0)
                {
                    return CreatedAtAction("GetById", new { model.Id }, model);
                }
            }

            return BadRequest("Something went wrong");
        }

        [HttpDelete("{id:guid}")]
        public async Task<IActionResult> Delete(Guid id)
        {
            var model = await uow.Category.GetById(id);

            if (model == null)
            {
                return NotFound("Category not found");
            }

            await uow.Category.Delete(id);
            return await CustomResponse<Category>(uow);
        }

        [HttpPut()]
        public async Task<IActionResult> Update(Category model)
        {
            await uow.Category.Update(model);
            return await CustomResponse<Category>(uow);
        }
    }
}
