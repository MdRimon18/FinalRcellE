using System.Data;
using Dapper;
using Pms.Data.DbContex;

namespace Pms.Data.Repository
{
    public class BaseHandaler
    {
        private readonly IDbConnection _db;

        public BaseHandaler(DbConnection db)
        {
            _db = db.GetConnection();
        }
        public async Task<IEnumerable<T>> GetEntities<T>(string storedProcedureName)
        {
            try
            {
                return await _db.QueryAsync<T>(storedProcedureName, commandType: CommandType.StoredProcedure);
            }
            catch (Exception ex)
            {
                // Handle the exception (e.g., log the error)
                Console.WriteLine($"An error occurred while fetching entities: {ex.Message}");
                return Enumerable.Empty<T>();
            }
        }
        public async Task<T> GetEntityById<T>(long id, string storedProcedureName)
        {
            try
            {
                return await _db.QueryFirstOrDefaultAsync<T>(
                    storedProcedureName,
                    new { OrderId = id },
                    commandType: CommandType.StoredProcedure
                ) ?? throw new InvalidOperationException($"{typeof(T).Name} with ID {id} not found.");
            }
            catch (Exception ex)
            {
                Console.WriteLine($"An error occurred while fetching {typeof(T).Name} with ID {id}: {ex.Message}");
                // Return a default instance of T or null, depending on your requirement
                return default;
            }
        }

        public async Task<long> AddEntity<T>(T entity, string outputParameterName, string storedProcedureName)
        {
            try
            {
                var parameters = new DynamicParameters();

                var properties = typeof(T).GetProperties();
                foreach (var property in properties)
                {
                    parameters.Add($"@{property.Name}", property.GetValue(entity));
                }

                parameters.Add(outputParameterName, dbType: DbType.Int64, direction: ParameterDirection.Output);

                await _db.ExecuteAsync(storedProcedureName, parameters, commandType: CommandType.StoredProcedure);

                return parameters.Get<long>(outputParameterName);
            }
            catch (Exception ex)
            {
                // Handle the exception (e.g., log the error)
                Console.WriteLine($"An error occurred while adding entity: {ex.Message}");
                return 0;
            }
        }
        public async Task<bool> UpdateEntity<T>(T entity, string storedProcedureName)
        {
            try
            {
                var parameters = new DynamicParameters();

                var properties = typeof(T).GetProperties();
                foreach (var property in properties)
                {
                    parameters.Add($"@{property.Name}", property.GetValue(entity));
                }
                parameters.Add("@success", dbType: DbType.Int32, direction: ParameterDirection.Output);
               
                await _db.ExecuteAsync(storedProcedureName, parameters,
                              commandType: CommandType.StoredProcedure);

                int success = parameters.Get<int>("@success");
                return success > 0;
            }
            catch (Exception ex)
            {
                // Handle the exception (e.g., log the error)
                Console.WriteLine($"An error occurred while updating entity: {ex.Message}");
                return false;
            }
        }

        public async Task<bool> DeleteEntityById<TId>(TId id, string idParameterName, string storedProcedureName)
        {
            try
            {
                var parameters = new DynamicParameters();
                parameters.Add(idParameterName, id, DbType.Int32, ParameterDirection.Input);
                parameters.Add("@Success", dbType: DbType.Int32, direction: ParameterDirection.Output);

                await _db.ExecuteAsync(
                    storedProcedureName,
                    parameters,
                    commandType: CommandType.StoredProcedure
                );

                int success = parameters.Get<int>("@Success");
                return success > 0;
            }
            catch (Exception ex)
            {
                // Handle the exception (e.g., log the error)
                Console.WriteLine($"An error occurred while deleting entity: {ex.Message}");
                return false;
            }
        }



    }
}
