using System;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using UoWApi.Configuration;
using UoWApi.Models.Entities;

namespace UoWApi.Controllers
{
    public class ProductController : BaseController
    {
        private readonly IUnitOfWork uow;

        public ProductController(IUnitOfWork uow)
        {
            this.uow = uow;
        }

        [HttpGet("ProductsWithCategory")]
        public async Task<IActionResult> GetProductsWithCategory()
        {
            return Ok(await uow.Product.GetProductsWithCategory());
        }

        [HttpGet]
        public async Task<IActionResult> GetAll()
        {
            return Ok(await uow.Product.All());
        }

        [HttpGet("{id:guid}")]
        public async Task<IActionResult> GetById(Guid id)
        {
            var model = await uow.Product.GetById(id);

            if (model == null)
            {
                return NotFound("Product not found");
            }

            return Ok(model);
        }

        [HttpPost]
        public async Task<IActionResult> Add(Product model)
        {
            if (ModelState.IsValid)
            {
                // Checks whether it is a valid Category
                var categoryModel = await uow.Category.GetById(model.CategoryId);
                if (categoryModel != null)
                {
                    await uow.Product.Add(model);
                    var saved = await uow.CompleteAsync();

                    if (saved > 0)
                    {
                        return CreatedAtAction("GetById", new { model.Id }, model);
                    }
                }
                else
                {
                    return BadRequest("Invalid Category");
                }
            }

            return BadRequest("Something went wrong");
        }

        [HttpDelete("{id:guid}")]
        public async Task<IActionResult> Delete(Guid id)
        {
            var model = await uow.Product.GetById(id);

            if (model == null)
            {
                return NotFound("Product not found");
            }

            await uow.Product.Delete(id);
            return await CustomResponse<Product>(uow);
        }

        [HttpPut()]
        public async Task<IActionResult> Update(Product model)
        {
            if (ModelState.IsValid)
            {
                if (string.IsNullOrEmpty(model.CategoryId.ToString()) || model.CategoryId == Guid.Empty)
                {
                    return BadRequest("Invalid category");
                }

                await uow.Product.Update(model);
            }
            return await CustomResponse<Product>(uow, model);
        }
    }
}
