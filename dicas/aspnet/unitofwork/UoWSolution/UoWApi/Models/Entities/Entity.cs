using System;
using System.ComponentModel.DataAnnotations;

namespace UoWApi.Models.Entities
{
    public abstract class Entity
    {
        public Entity()
        {
            Id = Guid.NewGuid();
        }

        [Required(ErrorMessage = "ID is required")]
        public Guid Id { get; set; }
    }
}
