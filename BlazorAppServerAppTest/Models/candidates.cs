﻿// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
#nullable disable
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace BlazorAppServerAppTest.Models;

[Keyless]
public partial class candidates
{
    public int? id { get; set; }

    [StringLength(1)]
    [Unicode(false)]
    public string gender { get; set; }

    public int? age { get; set; }

    [StringLength(20)]
    [Unicode(false)]
    public string party { get; set; }
}