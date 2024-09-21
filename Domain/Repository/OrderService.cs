using BlazorAppServerAppTest.Models;
using Microsoft.EntityFrameworkCore;


namespace Pms.Data.Repository
{
    public class OrderService
    {
         
        private readonly practiceDbContext _db;
        public OrderService(practiceDbContext practiceDbContext)
        {
             
            _db = practiceDbContext;
          
        }  
        public List<Order> GetOrders()//GetAll()
        {
             
            return  _db.Order.ToList();
        }
        public   Order GetOrderById(long orderId)
        {
            return   _db.Order.Find(orderId);
        }
   
        public  string SaveOrder(Order order)
        {
            try
            {
              var saveObject=_db.Order.Add(order);
                 _db.SaveChangesAsync();
                return "Save Successfull";
            }
            catch (Exception e)
            {

                return "Save Failed";
            }
            return "";
        }
        public async Task UpdateOrder(Order order)
        {
            _db.Entry(order).State = EntityState.Modified;
            await _db.SaveChangesAsync();
        }


        public async Task DeleteOrderAsync(long orderId)
        {
            var order = await _db.Order.FindAsync(orderId);
            if (order != null)
            {
                _db.Order.Remove(order);
                await _db.SaveChangesAsync();
            }
        }
    }
}
