namespace Pms.Helper
{
	public static class UserInfo
	{
		public static long UserId { get; set; } = 1;


	}
	public static class CompanyInfo
	{
        public static long BranchId { get; set; } = 1;
        public static long CompanyId { get; set; } = 1;
		public static int LanguageId { get; set; } = 1;
        public static int CurrencyId { get; set; } = 1;
    }
    public static class GlobalPageConfig
    {
        public static int PageNumber { get; set; } = 1;
        public static int PageSize { get; set; } = 1000;

    }
}
