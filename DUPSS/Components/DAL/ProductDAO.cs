using Microsoft.EntityFrameworkCore;
using Objects;

namespace DAL
{
    public class ProductDAO
    {
        private readonly MyStoreContext _context;

        public ProductDAO(MyStoreContext context)
        {
            _context = context;
        }

        public List<Product> GetProducts()
        {
            var listProducts = new List<Product>();
            try
            {
                listProducts = _context.Products.ToList();
            }
            catch (Exception e) { }
            return listProducts;
        }


        public void SaveProduct(Product p)
        {
            try
            {
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
                _context.Products.Add(p);
                _context.SaveChanges();
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

                var tracked = _context.Products.SingleOrDefault(p => p.ProductId == product.ProductId);
                if (tracked != null)
                {
                    tracked.ProductName = product.ProductName;
                    tracked.CategoryId = product.CategoryId;
                    tracked.UnitsInStock = product.UnitsInStock;
                    tracked.UnitPrice = product.UnitPrice;

                    _context.SaveChanges();
                }
                else
                {
                    throw new Exception("Product not found.");
                }
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
                var p1 = _context.Products.SingleOrDefault(c => c.ProductId == product.ProductId);
                _context.Products.Remove(p1);
                _context.SaveChanges();
            }
            catch (Exception e)
            {
                throw new Exception(e.Message);
            }
        }

        public Product GetProductById(int id)
        {
            return _context.Products.FirstOrDefault(c => c.ProductId.Equals(id));
        }
        
    }
}
