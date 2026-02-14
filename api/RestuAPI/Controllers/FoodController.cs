using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;
using System.Runtime.CompilerServices;

namespace RestuAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class FoodController : Controller
    {
        private readonly DataContext _context;

        public FoodController(DataContext context)
        {
            _context = context;
        }

        [HttpGet]
        public async Task<ActionResult<List<Food>>> Get()
        {
            return Ok(await _context.Foods.ToListAsync());
        }

        [HttpGet("Type/{type}")]
        public async Task<ActionResult<List<Food>>> GetByType(string type)
        {
            var foods = await _context.Foods.Where(x => x.Type== type).ToListAsync();
            return Ok(foods);
        }
        
        [HttpGet("Name/{name}")]
        public async Task<ActionResult<Food>> GetByName(string name)
        {
            var food = await _context.Foods.Where(x =>x.Name == name).FirstOrDefaultAsync();
            if (food == null)
                return BadRequest("Food not found");
            return Ok(food);
        }
        
        [HttpPost]
        public async Task<ActionResult<List<Food>>> AddFood(Food food)
        {
            _context.Foods.Add(food);
            await _context.SaveChangesAsync();

            return Ok(await _context.Foods.ToListAsync());
        }

        [HttpPut]
        public async Task<ActionResult<List<Food>>> UpdateFood(Food request)
        {
            var dbFood = await _context.Foods.FindAsync(request.Id);
            if (dbFood == null)
                return BadRequest("Food not found.");

            dbFood.Name = request.Name;
            dbFood.Price = request.Price;
            dbFood.Type = request.Type;
            dbFood.Frequency = request.Frequency;
            dbFood.Ingredients = request.Ingredients;
            dbFood.Description = request.Description;

            await _context.SaveChangesAsync();
            return Ok(await _context.Foods.ToListAsync());

        }
        [HttpPut("IncrementByOne/{id}")]
        public async Task<ActionResult<List<Food>>> UpdateById(int id)
        {
            var dbFood = await _context.Foods.FindAsync(id);
            if (dbFood == null)
                return BadRequest("Food not found.");
            dbFood.Frequency += 1;
            
            await _context.SaveChangesAsync();
            return Ok(await _context.Foods.ToListAsync());
        }
        [HttpDelete]
        public async Task<ActionResult<List<Food>>> Delete(string name)
        {
            var dbFood = await _context.Foods.Where(x => x.Name == name).FirstOrDefaultAsync();
            if (dbFood == null)
                return BadRequest("Food not found");

            _context.Foods.Remove(dbFood);
            await _context.SaveChangesAsync();

            return Ok(await _context.Foods.ToListAsync());
        }
    }
}
