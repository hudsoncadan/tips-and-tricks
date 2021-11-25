using System;
using System.Collections.Generic;
using System.Linq;

namespace PerformanceProject
{
    public static class Helper
    {
        static string[] nomes = { "Helena", "Ana", "Hudson", "Alice", "Douglas", "Vanessa", "Marcos", "Kris", "Theo", "Miguel", "Arthur", "Heitor" };
		
        public static IEnumerable<int> GenerateRandomNumbersList(int size)
        {
            return Enumerable.Range(1, size);
        }

        public static IEnumerable<UserModel> GenerateRandomUserList(int size)
        {
            Random random = new Random();
            List<UserModel> list = new List<UserModel>();

            for (int i = 0; i < size; i++)
            {
                int index = random.Next(nomes.Length);
                string randomName = nomes[index];
                int experienceYears = random.Next(15);

                list.Add(new UserModel(randomName, experienceYears));
            }

            return list;
        }
    }
}
