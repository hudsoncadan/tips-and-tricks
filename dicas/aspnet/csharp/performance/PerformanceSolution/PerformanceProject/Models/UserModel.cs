using System;

namespace PerformanceProject
{
    public class UserModel
    {
        public UserModel()
        {
        }

        public UserModel(string name, int experienceYears)
        {
            Id = Guid.NewGuid();
            Name = name;
            ExperienceYears = experienceYears;
        }

        public Guid Id { get; set; }
        public string Name { get; set; }
        public int ExperienceYears { get; set; }
    }
}
