using BlazorAppServerAppTest.Models;
using Dapper;
using Pms.Data.DbContex;
using System.Data;

namespace Pms.Data.Repository
{
    public class OrderServiceWithSp
    {
        private readonly IDbConnection _db;

        public OrderServiceWithSp(DbConnection db)
        {
            _db = db.GetConnection();
        }
            public async Task<IEnumerable<Order>> GetOrders()
            {
                return await _db.QueryAsync<Order>("sp_order_getAll", 
                    commandType: CommandType.StoredProcedure);
            }

        public async Task<Order> GetOrderById(long id)
        {
            return await _db.QueryFirstOrDefaultAsync<Order>("sp_order_get_by_id",
                new { OrderId = id }, commandType: CommandType.StoredProcedure)!
                ?? throw new InvalidOperationException($"Order with ID {id} not found.");
        }


        public async Task<int> AddOrder(Order order)
            {
                var parameters = new DynamicParameters();

            parameters.Add("@productName", order.ProductName);
            parameters.Add("@categoryId", order.CategoryId);
            parameters.Add("@orderDate", order.OrderDate);
            parameters.Add("@isProductRecieve", order.IsProductRecieve);
            parameters.Add("@orderId", dbType: DbType.Int64, 
                  
                direction: ParameterDirection.Output);

                await _db.ExecuteAsync("sp_insert_order", parameters, 
                    commandType: CommandType.StoredProcedure);

                return parameters.Get<int>("@orderId");
            }

            public async Task<bool> UpdateOrder(Order order)
            {
                var parameters = new DynamicParameters();
              
                parameters.Add("@orderId", order.OrderId);
                parameters.Add("@productName", order.ProductName);
                parameters.Add("@categoryId", order.CategoryId);
                parameters.Add("@orderDate", order.OrderDate);
                parameters.Add("@isProductRecieve", order.IsProductRecieve);

            int affectedRows = await _db.ExecuteAsync("sp_order_update", 
                    parameters, commandType: CommandType.StoredProcedure);
                return affectedRows > 0;
            }

        public async Task<bool> DeleteOrder(long id)
        {


            int affectedRows = await _db.ExecuteAsync("sp_delete_Order",
                new { order_id = id },
                commandType: CommandType.StoredProcedure);
            return affectedRows > 0;
        }
    }






}
