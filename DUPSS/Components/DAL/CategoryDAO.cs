using Microsoft.Extensions.Configuration;
using Objects;

namespace DAL
{
    public class CategoryDAO
    {
        public List<Category> GetCategories()
        {
            

            var listCategories = new List<Category>();
            try
            {
                using var context = new MyStoreContext();
                listCategories = context.Categories.ToList();
            }
            catch (Exception e)
            {
                throw new Exception(e.Message);
            }
            return listCategories;
        }
    }
}
