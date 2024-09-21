using System.Data;
using Dapper;
using Pms.Domain.DbContex;
namespace Pms.Data.Repository;
using Order = BlazorAppServerAppTest.Models.Order;
// use this class where more concurrent action occured like invoice,ecommerce pages
public class OrderServiceWithSpV2
{
    private readonly IDbConnection _db;
     

    public OrderServiceWithSpV2(DbConnection db)
    {
        _db = db.GetDbConnection();
         
    }
    public async Task<IEnumerable<Order>> GetOrders()
    {
        try
        {
            return await _db.QueryAsync<Order>("sp_order_getAll",
                commandType: CommandType.StoredProcedure);
        }
        catch (Exception ex)
        {
            // Handle the exception (e.g., log the error)
            Console.WriteLine($"An error occurred while fetching orders: {ex.Message}");
            return Enumerable.Empty<Order>();
        }
    }

    public async Task<Order> GetOrderById(long id)
    {
        try
        {
            return await _db.QueryFirstOrDefaultAsync<Order>(
                "sp_order_get_by_id",
                new { OrderId = id },
                commandType: CommandType.StoredProcedure
            ) ?? throw new InvalidOperationException($"Order with ID {id} not found.");
        }
        catch (Exception ex)
        {
            Console.WriteLine($"An error occurred while fetching order with ID {id}: {ex.Message}");
            // Return a new Order instance or null, depending on your requirement
            return new Order(); // You may need to adjust this based on your Order class constructor
        }
    }


    public async Task<long> AddOrder(Order order)
    {
        try
        {
            var parameters = new DynamicParameters();

            parameters.Add("@productName", order.ProductName);
            parameters.Add("@categoryId", order.CategoryId);
            parameters.Add("@orderDate", order.OrderDate);
            parameters.Add("@isProductRecieve", order.IsProductRecieve);
            parameters.Add("@orderId", dbType: DbType.Int64, direction: ParameterDirection.Output);

            await _db.ExecuteAsync("sp_insert_order", parameters, commandType: CommandType.StoredProcedure);



            return parameters.Get<long>("@orderId");
        }
        catch (Exception ex)
        {
            // Handle the exception (e.g., log the error)
            Console.WriteLine($"An error occurred while adding order: {ex.Message}");
            return 0;
        }
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
        var parameters = new DynamicParameters();
        parameters.Add("@order_id", id, DbType.Int32, ParameterDirection.Input);
        parameters.Add("@Success", dbType: DbType.Int32, direction: ParameterDirection.Output);

        await _db.ExecuteAsync(
            "sp_delete_Order",
            parameters,
            commandType: CommandType.StoredProcedure
        );
        long sccss = parameters.Get<long>("@Success");
        return sccss > 0;
    }
}
