using Dapper;
using Pms.Domain.DbContex;
using Pms.Helper;
using Pms.Models.Entity.Settings;

using System.Data;

namespace Pms.Data.Repository.Inventory
{
    public class UserService
    {
        private readonly IDbConnection _db;


        public UserService(DbConnection db)
        {
            _db = db.GetDbConnection();

        }
        public async Task<IEnumerable<User>> Get(long? UserId, string? UserKey, string? UserName, string? UserPhoneNo, string? UserPassword, string UserDesignation,string UserImgLink, int? PageNumber, int? PageSize)
        {
            try
            {
                var parameters = new DynamicParameters();

                parameters.Add("@UserId", UserId);
                parameters.Add("@UserKey", UserKey);
                parameters.Add("@UserName", UserName);
                parameters.Add("@UserPhoneNo", UserPhoneNo);
                parameters.Add("@UserPassword", UserPassword);
                parameters.Add("@UserDesignation", UserDesignation);
                parameters.Add("@UserImgLink", UserImgLink);
                parameters.Add("@PageNumber", PageNumber);
                parameters.Add("@PageSize", PageSize);

                return await _db.QueryAsync<User>("Users_Get_SP", parameters, commandType: CommandType.StoredProcedure);

            }
            catch (Exception ex)
            {

                return Enumerable.Empty<User>();
            }
        }

        public async Task<User> GetById(long UserId)

        {
            var user = await (Get(UserId, null,null,null, null, null, null, 1, 1));
            return user.FirstOrDefault();
        }

        public async Task<User> GetByKey(string UserKey)

        {
            var user = await (Get(null, UserKey, null,null,null,null, null, 1, 1));
            return user.FirstOrDefault();
        }


        public async Task<long> SaveOrUpdate(User user)
        {
            try
            {
                var parameters = new DynamicParameters();

                parameters.Add("@UserId", user.UserId);
                parameters.Add("@UserKey", user.UserKey);
                parameters.Add("@UserName", user.UserName);
                parameters.Add("@UserPhoneNo", user.UserPhoneNo);
                parameters.Add("@UserPassword", user.UserPassword);
                parameters.Add("@UserDesignation", user.UserDesignation);
                parameters.Add("@UserImgLink", user.UserImgLink);
                parameters.Add("@EntryDateTime", user.EntryDateTime);
                parameters.Add("@EntryBy", user.EntryBy);
                parameters.Add("@LastModifyDate", user.LastModifyDate);
                parameters.Add("@LastModifyBy", user.LastModifyBy);
                parameters.Add("@DeletedDate", user.DeletedDate);
                parameters.Add("@DeletedBy", user.DeletedBy);
                parameters.Add("@Status", user.Status);
                parameters.Add("@SuccessOrFailId", dbType: DbType.Int32, direction: ParameterDirection.Output);
                await _db.ExecuteAsync("User_InsertOrUpdate_SP", parameters, commandType: CommandType.StoredProcedure);

                return (long)parameters.Get<int>("@SuccessOrFailId");
            }
            catch (Exception ex)
            {
                // Handle the exception (e.g., log the error)
                Console.WriteLine($"An error occurred while adding order: {ex.Message}");
                return 0;
            }
        }

        public async Task<bool> Delete(long UserId)
        {
            var user = await (Get(UserId, null, null,null,null, null, null, 1, 1));
            var deleteObj = user.FirstOrDefault();
            long DeletedSatatus = 0;
            if (deleteObj != null)
            {
                deleteObj.DeletedDate = DateTimeHelper.CurrentDateTime();
                deleteObj.Status = "Deleted";
                DeletedSatatus = await SaveOrUpdate(deleteObj);
            }

            return DeletedSatatus > 0;
        }
    }
}
