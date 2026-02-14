using Microsoft.AspNetCore.Mvc;
using Microsoft.IdentityModel.Tokens;
using System.Runtime.CompilerServices;

namespace RestuAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class RestuUserController : Controller
    {

        private readonly DataContext _context;

        public RestuUserController(DataContext context)
        {
            _context = context;
        }

        [HttpGet]
        public async Task<ActionResult<List<RestuUser>>> Get()
        {
            return Ok(await _context.RestuUsers.ToListAsync());
        }

        [HttpGet("{email}")]
        public async Task<ActionResult<RestuUser>> Get(string email)
        {
            var user = await _context.RestuUsers.Where(x => x.Email == email).FirstOrDefaultAsync();
            if (user == null)
                return BadRequest("User not found.");
            return Ok(user);
        }

        [HttpPost]
        public async Task<ActionResult<List<RestuUser>>> AddUser(RestuUser user)
        {
            _context.RestuUsers.Add(user);
            await _context.SaveChangesAsync();

            return Ok(await _context.RestuUsers.ToListAsync());
        }

        [HttpPut]
        public async Task<ActionResult<List<RestuUser>>> UpdateUser(RestuUser request)
        {
            var dbUser = await _context.RestuUsers.FindAsync(request.Id);
            if (dbUser == null)
                return BadRequest("User not found.");

            dbUser.Address = request.Address;
            dbUser.Email = request.Email;
            dbUser.Fname = request.Fname;
            dbUser.Lname = request.Lname;
            dbUser.Phone = request.Phone;
            dbUser.Password = request.Password;

            await _context.SaveChangesAsync();
            return Ok(await _context.RestuUsers.ToListAsync());
        }

        [HttpDelete]
        public async Task<ActionResult<List<RestuUser>>> Delete(string email)
        {
            var dbUser = await _context.RestuUsers.Where(x => x.Email == email).FirstOrDefaultAsync();
            if (dbUser == null)
                return BadRequest("User not found.");

            _context.RestuUsers.Remove(dbUser);
            await _context.SaveChangesAsync();

            return Ok(await _context.RestuUsers.ToListAsync());
        }
    }
}
