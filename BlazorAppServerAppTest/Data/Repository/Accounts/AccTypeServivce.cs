using Dapper;
using System.Data;
using Pms.Data.DbContex;
using Pms.Models.Entity.Settings;
namespace Pms.Data.Repository.Accounts
{
    public class AccTypeServivce
    {
        private readonly IDbConnection _db;


        public AccTypeServivce(DbConnection db)
        {
            _db = db.GetDbConnection();

        }
        public async Task<IEnumerable<AccType>> Get(int? LanguageId)
        {
            try
            {
                var parameters = new DynamicParameters();

                parameters.Add("@LanguageId", LanguageId);


                return await _db.QueryAsync<AccType>("AccountType_Get_SP", parameters, commandType: CommandType.StoredProcedure);

            }
            catch (Exception ex)
            {

                return Enumerable.Empty<AccType>();
            }
        }
    }


}
