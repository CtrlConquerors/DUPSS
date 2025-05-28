using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace Objects
{
    public partial class Product
    {
        public Product(int id, string name, int catId, short unitInStock, decimal price)
        {
            this.ProductId = id;
            this.ProductName = name;
            this.CategoryId = catId;
            this.UnitsInStock = unitInStock;
            this.UnitPrice = price;
        }

        public Product() { }
        public int ProductId { get; set; }

        [Required(ErrorMessage = "Product Name is required.")]
        [StringLength(40, ErrorMessage = "Product Name cannot exceed 40 characters.")]
        public string ProductName { get; set; }

        [Required(ErrorMessage = "Category is required.")]
        public int? CategoryId { get; set; }

        [Required(ErrorMessage = "Units In Stock is required.")]
        [Range(0, short.MaxValue, ErrorMessage = "Units in Stock must be non-negative.")]
        public short? UnitsInStock { get; set; }

        [Required(ErrorMessage = "Unit Price is required.")]
        [Range(0, 999999.99, ErrorMessage = "Unit Price must be non-negative and less than 1,000,000.")]
        public decimal? UnitPrice { get; set; }
        public virtual Category Category { get; set; }
    }
}
