﻿// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
#nullable disable
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace BlazorAppServerAppTest.Models;

[Keyless]
public partial class WorkerClone
{
    public int WORKER_ID { get; set; }

    public int? SALARY { get; set; }

    [Column(TypeName = "datetime")]
    public DateTime? JOINING_DATE { get; set; }

    [StringLength(25)]
    [Unicode(false)]
    public string DEPARTMENT { get; set; }

    [StringLength(100)]
    [Unicode(false)]
    public string FIRST_NAME { get; set; }

    [StringLength(100)]
    [Unicode(false)]
    public string LAST_NAME { get; set; }
}