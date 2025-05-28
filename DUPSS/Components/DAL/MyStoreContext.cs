using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;

namespace Objects;

public partial class MyStoreContext : DbContext
{
    public MyStoreContext()
    {
    }

    public MyStoreContext(DbContextOptions<MyStoreContext> options)
        : base(options)
    {
    }

    public virtual DbSet<AccountMember> AccountMembers { get; set; }
    public virtual DbSet<Category> Categories { get; set; }
    public virtual DbSet<Product> Products { get; set; }

    private string GetConnectionString()
    {
        IConfiguration configuration = new ConfigurationBuilder()
            .SetBasePath(Directory.GetCurrentDirectory())
            .AddJsonFile("appsettings.json").Build();
        return configuration["ConnectionStrings:DefaultConnection"];
    }

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
    {
        if (!optionsBuilder.IsConfigured)
        {
            optionsBuilder.UseNpgsql(GetConnectionString());
        }
    }

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<AccountMember>(entity =>
        {
            entity.HasKey(e => e.MemberId);

            entity.ToTable("AccountMember");

            entity.HasIndex(e => e.EmailAddress).IsUnique();

            entity.Property(e => e.MemberId)
                .HasMaxLength(20)
                .HasColumnName("MemberID");
            entity.Property(e => e.EmailAddress)
                .HasMaxLength(100);
            entity.Property(e => e.FullName)
                .HasMaxLength(80);
            entity.Property(e => e.MemberPassword)
                .HasMaxLength(80);
            entity.Property(e => e.MemberRole)
                .HasColumnType("integer");
        });

        modelBuilder.Entity<Category>(entity =>
        {
            entity.HasKey(e => e.CategoryId);

            entity.ToTable("Categories");

            entity.Property(e => e.CategoryId)
                .HasColumnName("CategoryID")
                .HasColumnType("integer")
                .ValueGeneratedOnAdd(); // SERIAL in PostgreSQL
            entity.Property(e => e.CategoryName)
                .HasMaxLength(15);
        });

        modelBuilder.Entity<Product>(entity =>
        {
            entity.HasKey(e => e.ProductId);

            entity.ToTable("Products");

            entity.Property(e => e.ProductId)
                .HasColumnName("ProductID")
                .HasColumnType("integer")
                .ValueGeneratedOnAdd(); // SERIAL in PostgreSQL
            entity.Property(e => e.CategoryId)
                .HasColumnName("CategoryID")
                .HasColumnType("integer");
            entity.Property(e => e.ProductName)
                .HasMaxLength(40);
            entity.Property(e => e.UnitPrice)
                .HasColumnType("numeric(19,4)"); // Matches PostgreSQL NUMERIC
            entity.Property(e => e.UnitsInStock)
                .HasColumnType("smallint");

            entity.HasOne(d => d.Category)
                .WithMany(p => p.Products)
                .HasForeignKey(d => d.CategoryId)
                .OnDelete(DeleteBehavior.Restrict); // Changed to Restrict for PostgreSQL
        });

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}