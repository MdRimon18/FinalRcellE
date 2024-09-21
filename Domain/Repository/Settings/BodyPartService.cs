
using Dapper;
 
using Pms.Domain.DbContex;
using Pms.Helper;
using Pms.Models.Entity.Settings;
using System.Data;
using System.Data.Common;
using DbConnection = Pms.Domain.DbContex.DbConnection;

namespace Pms.Data.Repository.Inventory
{
    public class BodyPartService
    {
        private readonly IDbConnection _db;


        public BodyPartService(DbConnection db)
        {
            _db = db.GetDbConnection();

        }
        // Method to get all BodyParts
        public async Task<IEnumerable<BodyPart>> GetBodyPartsAsync()
        {
            var sql = "SELECT BodyPartName FROM BodyParts"; // Adjust table name as needed
            return await _db.QueryAsync<BodyPart>(sql);
        }

    }
}
