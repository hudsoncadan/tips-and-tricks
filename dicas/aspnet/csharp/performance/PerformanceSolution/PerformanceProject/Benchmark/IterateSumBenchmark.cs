using BenchmarkDotNet.Attributes;
using System.Collections.Generic;
using System.Linq;

namespace PerformanceProject
{
    /// <summary>
    /// The main goal is to sum all of numbers in a list
    /// </summary>
    [ShortRunJob]
    [RankColumn]
    public class IterateSumBenchmark
    {
        private List<int> listInt;
        private IEnumerable<int> listIntEnumerable;

        [Params(50)]
        public int listSize;

        [GlobalSetup]
        public void Setup()
        {
            listIntEnumerable = Helper.GenerateRandomNumbersList(listSize);
            listInt = listIntEnumerable.ToList();
        }

        #region Traditional loop comparing List x IEnumerable

        /// <summary>
        /// Traditional loop with Generic.List
        /// </summary>
        [Benchmark]
        public void For_List()
        {
            var sum = 0;
            for (int i = 0; i < listInt.Count; i++)
            {
                sum += listInt[i];
            }
        }

        /// <summary>
        /// Traditional loop with IEnumerable
        /// </summary>
        [Benchmark]
        public void For_IEnumerable()
        {
            var sum = 0;
            for (int i = 0; i < listIntEnumerable.Count(); i++)
            {
                sum += listIntEnumerable.ElementAt(i);
            }
        }

        #endregion

        #region Foreach loop comparing List x IEnumerable

        /// <summary>
        /// Use of foreach with Generic.List to sum all numbers
        /// </summary>
        [Benchmark]
        public void Foreach_List()
        {
            var sum = 0;
            foreach (var number in listInt)
            {
                sum += number;
            }
        }

        /// <summary>
        /// Use of foreach with IEnumerable to sum all numbers
        /// </summary>
        [Benchmark]
        public void Foreach_IEnumerable()
        {
            var sum = 0;
            foreach (var number in listIntEnumerable)
            {
                sum += number;
            }
        }

        #endregion

        #region Using LINQ to sum() the numbers comparing List x IEnumerable

        /// <summary>
        /// Use of LINQ with Generic.List to sum all numbers
        /// </summary>
        [Benchmark]
        public void Linq_Sum_List()
        {
            var sum = listInt.Sum();
        }

        /// <summary>
        /// Use of LINQ with IEnumerable to sum all numbers
        /// </summary>
        [Benchmark]
        public void Linq_Sum_IEnumerable()
        {
            var sum = listIntEnumerable.Sum();
        }

        #endregion
    }
}
