using BenchmarkDotNet.Running;

namespace PerformanceProject
{
    class Program
    {
        static void Main(string[] args)
        {
            // Comparing traditional loop, foreach and LINQ to sum the numbers of a Generic.List x IEnumerable
            // Which one is the fastest?
            BenchmarkRunner.Run<IterateSumBenchmark>();

            // Comparing traditional loop, foreach and LINQ to get the average of UserModel's age in a Generic.List x IEnumerable 
            // Which one is the fastest?
            BenchmarkRunner.Run<IterateAverageBenchmark>();

            // Comparing traditional loop, foreach and LINQ to find an instance in a Generic.List x IEnumerable 
            // Which one is the fastest?
            BenchmarkRunner.Run<FindObjectBenchmark>();
        }
    }
}
