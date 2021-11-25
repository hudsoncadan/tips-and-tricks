using BenchmarkDotNet.Attributes;
using System.Collections.Generic;
using System.Linq;

namespace PerformanceProject
{
    /// <summary>
    /// The main goal is to get the average of the ExperienceYears property in a list of User objects
    /// </summary>
    [ShortRunJob]
    [RankColumn]
    public class IterateAverageBenchmark
    {
        private List<UserModel> listUserModel;
        private IEnumerable<UserModel> listUserModelEnumerable;

        [Params(50)]
        public int listSize;

        [GlobalSetup]
        public void Setup()
        {
            listUserModelEnumerable = Helper.GenerateRandomUserList(listSize);
            listUserModel = listUserModelEnumerable.ToList();
        }

        #region Traditional loop comparing List x IEnumerable

        /// <summary>
        /// Traditional loop with Generic.List
        /// </summary>
        [Benchmark]
        public void For_List()
        {
            var average = 0;
            for (int i = 0; i < listUserModel.Count; i++)
            {
                average += listUserModel[i].ExperienceYears;
            }
            average = average / listUserModel.Count;
        }

        /// <summary>
        /// Traditional loop with IEnumerable
        /// </summary>
        [Benchmark]
        public void For_IEnumerable()
        {
            var average = 0;
            for (int i = 0; i < listUserModelEnumerable.Count(); i++)
            {
                average += listUserModelEnumerable.ElementAt(i).ExperienceYears;
            }
            average = average / listUserModelEnumerable.Count();
        }

        #endregion

        #region Foreach loop comparing List x IEnumerable

        /// <summary>
        /// Use of foreach with Generic.List to sum all numbers
        /// </summary>
        [Benchmark]
        public void Foreach_List()
        {
            var average = 0;
            foreach (var userModel in listUserModel)
            {
                average += userModel.ExperienceYears;
            }
            average = average / listUserModel.Count;
        }

        /// <summary>
        /// Use of foreach with IEnumerable to sum all numbers
        /// </summary>
        [Benchmark]
        public void Foreach_IEnumerable()
        {
            var average = 0;
            foreach (var userModel in listUserModelEnumerable)
            {
                average += userModel.ExperienceYears;
            }
            average = average / listUserModelEnumerable.Count();
        }

        #endregion

        #region Using LINQ to get the average of the ExperienceYears comparing List x IEnumerable

        /// <summary>
        /// Use of LINQ with Generic.List to sum all numbers
        /// </summary>
        [Benchmark]
        public void Linq_Sum_List()
        {
            var average = listUserModel.Average(userModel => userModel.ExperienceYears);
        }

        /// <summary>
        /// Use of LINQ with IEnumerable to sum all numbers
        /// </summary>
        [Benchmark]
        public void Linq_Sum_IEnumerable()
        {
            var average = listUserModelEnumerable.Average(userModel => userModel.ExperienceYears);
        }

        #endregion
    }
}
