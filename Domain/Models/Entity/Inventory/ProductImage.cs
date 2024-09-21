namespace Pms.Models.Entity.Inventory
{
    public class ProductImage
    {
        public long ProductMediaId { get; set; }  

        public Guid? ProductMediaKey { get; set; }  

        public long ProductId { get; set; }  

        public string ImageUrl { get; set; }  

        public int Position { get; set; }
        public string BodyPartName { get; set; }
    }
}
