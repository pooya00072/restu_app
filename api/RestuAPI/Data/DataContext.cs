using Microsoft.EntityFrameworkCore;

namespace RestuAPI.Data
{
    public class DataContext : DbContext
    {
        public DataContext(DbContextOptions<DataContext> options) : base(options) 
        {

        }

        public DbSet<RestuUser> RestuUsers { get; set; }
        public DbSet<Food> Foods { get; set; }
    }
}
