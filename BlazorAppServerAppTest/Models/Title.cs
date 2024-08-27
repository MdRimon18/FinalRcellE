﻿// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
#nullable disable
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace BlazorAppServerAppTest.Models;

[Keyless]
public partial class Title
{
    public int? WORKER_REF_ID { get; set; }

    [StringLength(25)]
    [Unicode(false)]
    public string WORKER_TITLE { get; set; }

    [Column(TypeName = "datetime")]
    public DateTime? AFFECTED_FROM { get; set; }

    [ForeignKey("WORKER_REF_ID")]
    public virtual Worker WORKER_REF { get; set; }
}