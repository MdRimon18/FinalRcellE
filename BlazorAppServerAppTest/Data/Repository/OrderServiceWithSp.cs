
using Dapper;
using Pms.Data.DbContex;
using Pms.Pages;
using System.Data;
using Order = BlazorAppServerAppTest.Models.Order;
namespace Pms.Data.Repository
{
    public class OrderServiceWithSp
    {
        private readonly IDbConnection _db;
        private readonly BaseHandaler _handaler;

        public OrderServiceWithSp(DbConnection db)
        {
            _db = db.GetConnection();
            _handaler = new BaseHandaler(db);
        }
        public async Task<IEnumerable<Order>> GetOrders()
        {
            return await _handaler.GetEntities<Order>("sp_order_getAll");
        }
        public async Task<Order> GetOrderById(long id)
        {
            return await _handaler.GetEntityById<Order>(id, "sp_order_get_by_id");
        }
        public async Task<long> AddOrder(Order order)
        {
            long orderId = await _handaler.AddEntity<Order>(order, "@OrderId", "sp_insert_order");
            return orderId;
        }
        public async Task<bool> UpdateOrder(Order order)
        {
            bool isUpdated = await _handaler.UpdateEntity<Order>(order, "sp_order_update");
            return isUpdated;
        }
        public async Task<bool> DeleteOrder(long OrderId)
        {
            bool isDeleted = await _handaler.DeleteEntityById(OrderId, "@order_id", "sp_delete_Order");
            return isDeleted;
        }
        

    }






}
