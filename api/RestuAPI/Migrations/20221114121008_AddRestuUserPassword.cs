using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace RestuAPI.Migrations
{
    /// <inheritdoc />
    public partial class AddRestuUserPassword : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<string>(
                name: "Password",
                table: "RestuUsers",
                type: "nvarchar(max)",
                nullable: false,
                defaultValue: "");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "Password",
                table: "RestuUsers");
        }
    }
}
