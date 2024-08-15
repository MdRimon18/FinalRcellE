using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;


namespace Pms.Models.Entity.Settings    

{
    public class Products
    {
        public long ProductId { get; set; }
        public Guid? ProductKey { get; set; }
        public long ProdCtgId { get; set; }
        public long? ProdSubCtgId { get; set; }
        [Required(ErrorMessage = "Unit Type is Required")]
        public long UnitId { get; set; }
        public decimal FinalPrice { get; set; }
        public decimal? PreviousPrice { get; set; }
        public long CurrencyId { get; set; }
        public string TagWord { get; set; }
        [Required(ErrorMessage = "Product Name is Required")]
        [StringLength(100, ErrorMessage = "Product Name cannot exceed 100 characters")]
        public string ProdName { get; set; }
        public string ManufacturarName { get; set; }
        public string SerialNmbrOrUPC { get; set; }
        public string Sku { get; set; }

        [Required(ErrorMessage = "Opening Quantity is Required")]
        public int OpeningQnty { get; set; } = 0;
        public int? AlertQnty { get; set; } = 0;
        [Required(ErrorMessage = "Buying Price is Required")]
        public decimal BuyingPrice { get; set; } = 0;
        [Required(ErrorMessage = "Selling Price is Required")]
        public decimal SellingPrice { get; set; } = 0;
        public decimal? VatPercent { get; set; }
        public decimal? VatAmount { get; set; }
        public decimal? DiscountPercentg { get; set; }
        public decimal? DiscountAmount { get; set; }
        public string BarCode { get; set; }
        public int? SupplirLinkId { get; set; }
        public string ImportedForm { get; set; }
        public int? ImportStatusId { get; set; }
        public DateTime? GivenEntryDate { get; set; }
        public int? WarrentYear { get; set; }
        public string WarrentyPolicy { get; set; }
        public int? ColorId { get; set; }
        public int? SizeId { get; set; }
       
        public int? ShippingById { get; set; }
        public int? ShippingDays { get; set; }
        public string ShippingDetails { get; set; }
        public int? OriginCountryId { get; set; }
        public int? Rating { get; set; }
        public int? ProdStatusId { get; set; }
        public string Remarks { get; set; }
        public string ProdDescription { get; set; }
        public DateTime? ReleaseDate { get; set; }
        public long BranchId { get; set; }  
        public int StockQuantity { get; set; }
        public decimal? ItemWeight { get; set; }
        public long? WarehouseId { get; set; }
        public string RackNumber { get; set; }
        public string BatchNumber { get; set; }
        public long? PolicyId { get; set; }
        public DateTime? EntryDateTime { get; set; }
        public long? EntryBy { get; set; }
        public DateTime? LastModifyDate { get; set; }
        public long? LastModifyBy { get; set; }
        public DateTime? DeletedDate { get; set; }
        public long? DeletedBy { get; set; }
        public string ProdStatus { get; set; }
        public string ProdCtgName { get; set; }
        public string UnitName {  get; set; }
        [NotMapped]
        public int total_row { get; set; } = 0;
    }
}
