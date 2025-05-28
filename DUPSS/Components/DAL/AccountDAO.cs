using Objects;

namespace DAL
{
    public class AccountDAO
    {
        private readonly MyStoreContext _context;

        public AccountDAO(MyStoreContext context)
        {
            _context = context;
        }

        public AccountMember GetAccountById(string accountID)
        {
            return _context.AccountMembers.FirstOrDefault(x => x.MemberId.Equals(accountID));
        }
    }
}
