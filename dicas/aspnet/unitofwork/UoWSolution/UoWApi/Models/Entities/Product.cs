using System;
using System.ComponentModel.DataAnnotations;

namespace UoWApi.Models.Entities
{
    public class Product : Entity
    {
        public string Description { get; set; }

        [Required(ErrorMessage ="Category ID is required")]
        public Guid CategoryId { get; set; }

        // Navigation Property
        public Category Category { get; set; }
    }
}
