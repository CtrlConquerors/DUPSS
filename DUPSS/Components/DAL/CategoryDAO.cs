using Microsoft.Extensions.Configuration;
using Objects;

namespace DAL
{
    public class CategoryDAO
    {

        private readonly MyStoreContext _context;

        public CategoryDAO(MyStoreContext context)
        {
            _context = context;
        }
        public List<Category> GetCategories()
        {

            var listCategories = new List<Category>();
            try
            {
                listCategories = _context.Categories.ToList();
            }
            catch (Exception e)
            {
                throw new Exception(e.Message);
            }
            return listCategories;
        }
    }
}
