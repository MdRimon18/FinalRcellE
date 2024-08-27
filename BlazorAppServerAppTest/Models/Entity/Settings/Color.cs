﻿using System.ComponentModel;
using System.ComponentModel.DataAnnotations;

namespace Pms.Models.Entity.Settings
{
    public class Colors
    {
        public long ColorId { get; set; }
        public Guid? ColorKey { get; set; }
        public int LanguageId { get; set; }
        [Required(ErrorMessage = "Color Name is required")]
        [DisplayName("Colors Name")]
        public string ColorIdName { get; set; }
        public DateTime? EntryDateTime { get; set; }
        public long? EntryBy { get; set; }
        public DateTime? LastModifyDate { get; set; }
        public long? LastModifyBy { get; set; }
        public DateTime? DeletedDate { get; set; }
        public long? DeletedBy { get; set; }
        public string Status { get; set; }
        public int total_row { get; set; }
    }
}

