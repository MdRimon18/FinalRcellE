﻿// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
#nullable disable
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace BlazorAppServerAppTest.Models;

[Keyless]
public partial class results
{
    public int? constituency_id { get; set; }

    public int? candidate_id { get; set; }

    public int? votes { get; set; }
}