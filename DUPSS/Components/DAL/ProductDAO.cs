using Microsoft.EntityFrameworkCore;
using Objects;

namespace DAL
{
    public class ProductDAO
    {
        private List<Product> listProducts;

        public ProductDAO()
        {
        }

        public List<Product> GetProducts()
        {
            var listProducts = new List<Product>();
            try
            {
                using var db = new MyStoreContext();
                listProducts = db.Products.ToList();
            }
            catch (Exception e) { }
            return listProducts;
        }


        public void SaveProduct(Product p)
        {
            try
            {
                using var context = new MyStoreContext();
                // Server-side validation
                if (string.IsNullOrWhiteSpace(p.ProductName))
                    throw new Exception("Product Name is required.");
                if (p.ProductName.Length > 40)
                    throw new Exception("Product Name cannot exceed 40 characters.");
                if (!p.CategoryId.HasValue)
                    throw new Exception("Category is required.");
                if (p.UnitsInStock.HasValue && p.UnitsInStock < 0)
                    throw new Exception("Units in Stock must be non-negative.");
                if (p.UnitPrice.HasValue && (p.UnitPrice < 0 || p.UnitPrice > 999999.99m))
                    throw new Exception("Unit Price must be non-negative and less than 1,000,000.");
                context.Products.Add(p);
                context.SaveChanges();
            }
            catch (Exception e)
            {
                throw new Exception(e.Message);
            }
        }

        public void UpdateProduct(Product product)
        {
            try
            {
                using var context = new MyStoreContext();

                // Server-side validation
                if (string.IsNullOrWhiteSpace(product.ProductName))
                    throw new Exception("Product Name is required.");
                if (product.ProductName.Length > 40)
                    throw new Exception("Product Name cannot exceed 40 characters.");
                if (!product.CategoryId.HasValue)
                    throw new Exception("Category is required.");
                if (product.UnitsInStock.HasValue && product.UnitsInStock < 0)
                    throw new Exception("Units in Stock must be non-negative.");
                if (product.UnitPrice.HasValue && (product.UnitPrice < 0 || product.UnitPrice > 999999.99m))
                    throw new Exception("Unit Price must be non-negative and less than 1,000,000.");

                context.Entry<Product>(product).State = Microsoft.EntityFrameworkCore.EntityState.Modified;
                context.SaveChanges();
            }
            catch (Exception e)
            {
                throw new Exception(e.Message);
            }
        }

        public void DeleteProduct(Product product)
        {
            try
            {
                using var context = new MyStoreContext();
                var p1 = context.Products.SingleOrDefault(c => c.ProductId == product.ProductId);
                context.Products.Remove(p1);
                context.SaveChanges();
            }
            catch (Exception e)
            {
                throw new Exception(e.Message);
            }
        }

        public Product GetProductById(int id)
        {
            using var db = new MyStoreContext();
            return db.Products.FirstOrDefault(c => c.ProductId.Equals(id));
        }
        
    }
}
