using Microsoft.EntityFrameworkCore;

namespace DUPSS.Object;

public class AppDbContext : DbContext
{
    public DbSet<Role> Roles { get; set; }
    public DbSet<User> Users { get; set; }
    public DbSet<Appointment> Appointments { get; set; }
    public DbSet<Campaign> Campaigns { get; set; }
    public DbSet<CourseTopic> CourseTopics { get; set; }
    public DbSet<Course> Courses { get; set; }
    public DbSet<CourseEnroll> CourseEnrollments { get; set; }
    public DbSet<Assessment> Assessments { get; set; }
    public DbSet<AssessmentResult> AssessmentResults { get; set; }
    public DbSet<Blog> Blogs { get; set; }

    public AppDbContext(DbContextOptions<AppDbContext> options) : base(options) { }

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        // Role -> Users (one-to-many)
        modelBuilder.Entity<User>()
            .HasOne(u => u.Role)
            .WithMany(r => r.Users)
            .HasForeignKey(u => u.RoleId);

        // Users -> Appointments (member and consultant, one-to-many)
        modelBuilder.Entity<Appointment>()
            .HasOne(a => a.Member)
            .WithMany(u => u.MemberAppointments)
            .HasForeignKey(a => a.MemberId);
        modelBuilder.Entity<Appointment>()
            .HasOne(a => a.Consultant)
            .WithMany(u => u.ConsultantAppointments)
            .HasForeignKey(a => a.ConsultantId);

        // Users -> Campaigns (one-to-many)
        modelBuilder.Entity<Campaign>()
            .HasOne(c => c.Staff)
            .WithMany(u => u.Campaigns)
            .HasForeignKey(c => c.StaffId);

        // CourseTopic -> Courses (one-to-many)
        modelBuilder.Entity<Course>()
            .HasOne(c => c.Topic)
            .WithMany(t => t.Courses)
            .HasForeignKey(c => c.TopicId);

        // Users -> Courses (one-to-many)
        modelBuilder.Entity<Course>()
            .HasOne(c => c.Staff)
            .WithMany(u => u.Courses)
            .HasForeignKey(c => c.StaffId);

        // Users -> CourseEnroll (one-to-many)
        modelBuilder.Entity<CourseEnroll>()
            .HasOne(ce => ce.Member)
            .WithMany(u => u.Enrollments)
            .HasForeignKey(ce => ce.MemberId);

        // Course -> CourseEnroll (one-to-many)
        modelBuilder.Entity<CourseEnroll>()
            .HasOne(ce => ce.Course)
            .WithMany(c => c.Enrollments)
            .HasForeignKey(ce => ce.CourseId);

        // Assessment -> AssessmentResult (one-to-many)
        modelBuilder.Entity<AssessmentResult>()
            .HasOne(ar => ar.Assessment)
            .WithMany(a => a.Results)
            .HasForeignKey(ar => ar.AssessmentId);

        // Users -> AssessmentResult (one-to-many)
        modelBuilder.Entity<AssessmentResult>()
            .HasOne(ar => ar.Member)
            .WithMany(u => u.AssessmentResults)
            .HasForeignKey(ar => ar.MemberId);

        // Users -> Blogs (one-to-many)
        modelBuilder.Entity<Blog>()
            .HasOne(b => b.Staff)
            .WithMany(u => u.Blogs)
            .HasForeignKey(b => b.StaffId);

        // Configure indexes (optional, as schema already defines them)
        modelBuilder.Entity<User>().HasIndex(u => u.RoleId);
        modelBuilder.Entity<Appointment>().HasIndex(a => a.MemberId);
        modelBuilder.Entity<Appointment>().HasIndex(a => a.ConsultantId);
        modelBuilder.Entity<Campaign>().HasIndex(c => c.StaffId);
        modelBuilder.Entity<Course>().HasIndex(c => c.TopicId);
        modelBuilder.Entity<Course>().HasIndex(c => c.StaffId);
        modelBuilder.Entity<CourseEnroll>().HasIndex(ce => ce.MemberId);
        modelBuilder.Entity<CourseEnroll>().HasIndex(ce => ce.CourseId);
        modelBuilder.Entity<AssessmentResult>().HasIndex(ar => ar.AssessmentId);
        modelBuilder.Entity<AssessmentResult>().HasIndex(ar => ar.MemberId);
        modelBuilder.Entity<Blog>().HasIndex(b => b.StaffId);
    }
}
