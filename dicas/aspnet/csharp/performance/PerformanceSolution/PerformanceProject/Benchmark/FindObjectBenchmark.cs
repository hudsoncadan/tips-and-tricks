using BenchmarkDotNet.Attributes;
using System.Collections.Generic;
using System.Linq;

namespace PerformanceProject
{
    /// <summary>
    /// The main goal is to find an instance by its property in a list of User objects
    /// </summary>
    [ShortRunJob]
    [RankColumn]
    public class FindObjectBenchmark
    {
        private List<UserModel> listUserModel;
        private IEnumerable<UserModel> listUserModelEnumerable;

        private string targetUser = "Ana";

        [Params(50)]
        public int listSize;

        [GlobalSetup]
        public void Setup()
        {
            listUserModelEnumerable = Helper.GenerateRandomUserList(listSize);
            listUserModel = listUserModelEnumerable.ToList();
        }

        #region Traditional loop comparing List x IEnumerable

        [Benchmark]
        public void For_List()
        {
            var result = new List<UserModel>();

            for (int i = 0; i < listUserModel.Count; i++)
            {
                if (listUserModel[i].Name == targetUser)
                {
                    result.Add(listUserModel[i]);
                }
            }
        }

        [Benchmark]
        public void For_IEnumerable()
        {
            var result = new List<UserModel>();

            for (int i = 0; i < listUserModelEnumerable.Count(); i++)
            {
                if (listUserModelEnumerable.ElementAt(i).Name == targetUser)
                {
                    result.Add(listUserModelEnumerable.ElementAt(i));
                }
            }
        }

        #endregion

        #region Foreach loop comparing List x IEnumerable

        [Benchmark]
        public void Foreach_List()
        {
            var result = new List<UserModel>();

            foreach (var userModel in listUserModel)
            {
                if (userModel.Name == targetUser)
                {
                    result.Add(userModel);
                }
            }
        }

        [Benchmark]
        public void Foreach_IEnumerable()
        {
            var result = new List<UserModel>();

            foreach (var userModel in listUserModelEnumerable)
            {
                if (userModel.Name == targetUser)
                {
                    result.Add(userModel);
                }
            }
        }

        #endregion

        #region Using LINQ to compare List x IEnumerable

        [Benchmark]
        public void FindAll_List()
        {
            List<UserModel> result = listUserModel.FindAll(model => model.Name == targetUser);
        }

        [Benchmark]
        public void Where_List()
        {
            IEnumerable<UserModel> result = listUserModel.Where(model => model.Name == targetUser);
        }

        [Benchmark]
        public void Where_IEnumerable()
        {
            IEnumerable<UserModel> result = listUserModelEnumerable.Where(model => model.Name == targetUser);
        }

        [Benchmark]
        public void Where_List_ToList()
        {
            List<UserModel> result = listUserModel.Where(model => model.Name == targetUser).ToList();
        }

        [Benchmark]
        public void Where_IEnumerable_ToList()
        {
            List<UserModel> result = listUserModelEnumerable.Where(model => model.Name == targetUser).ToList();
        }

        #endregion
    }
}
