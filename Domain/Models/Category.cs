﻿// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
#nullable disable
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace BlazorAppServerAppTest.Models;

public partial class Category
{
    [Key]//primary key
    public long CategoryId { get; set; }

    [Required]
    [StringLength(100)]
    public string CategoryName { get; set; }
} 