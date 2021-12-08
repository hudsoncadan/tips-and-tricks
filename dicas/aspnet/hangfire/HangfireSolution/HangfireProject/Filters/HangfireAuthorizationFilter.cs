using Hangfire.Annotations;
using Hangfire.Dashboard;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace HangfireProject.Filters
{
    public class HangfireAuthorizationFilter : IDashboardAuthorizationFilter
    {
        public bool Authorize([NotNull] DashboardContext context)
        {
            //var httpContext = context.GetHttpContext();
            //return httpContext.User.Identity.IsAuthenticated;

            // Allow all authenticated users to see the Dashboard (potentially dangerous)
            return true;
        }
    }
}
