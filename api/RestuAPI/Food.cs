namespace RestuAPI
{
    public class Food
    {
        public int Id { get; set; }
        public string Name { get; set; } = string.Empty;
        public float Price { get; set; } = 0;
        public string Type { get; set; } = string.Empty;
        public string Ingredients { get; set; } = string.Empty;
        public string Description { get; set; } = string.Empty;
        public int Frequency { get; set; } = 0;
    }
}
