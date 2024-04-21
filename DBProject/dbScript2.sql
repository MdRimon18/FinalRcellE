USE [practiceDb]
GO
/****** Object:  Schema [ecom]    Script Date: 4/20/2024 10:49:34 AM ******/
CREATE SCHEMA [ecom]
GO
/****** Object:  Schema [invnt]    Script Date: 4/20/2024 10:49:34 AM ******/
CREATE SCHEMA [invnt]
GO
/****** Object:  Schema [stt]    Script Date: 4/20/2024 10:49:34 AM ******/
CREATE SCHEMA [stt]
GO
/****** Object:  Schema [tst]    Script Date: 4/20/2024 10:49:34 AM ******/
CREATE SCHEMA [tst]
GO
/****** Object:  Table [dbo].[candidates]    Script Date: 4/20/2024 10:49:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[candidates](
	[id] [int] NULL,
	[gender] [varchar](1) NULL,
	[age] [int] NULL,
	[party] [varchar](20) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[results]    Script Date: 4/20/2024 10:49:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[results](
	[constituency_id] [int] NULL,
	[candidate_id] [int] NULL,
	[votes] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[Party_seats_won_function]    Script Date: 4/20/2024 10:49:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--find the number of seat won by each party
--there are many constituencies in a state and many candidates
--who are contesting the election from each constituency
--each candidate belongs to a party
--with the candidate maximum number of votes in given constituency
--wins for the constituency
-- SOLUTION
--select * from Party_seats_won_function()
CREATE function [dbo].[Party_seats_won_function]()
returns table as 
return
with cte as
    (select *
    , rank() over(partition by r.constituency_id order by r.votes desc) as rnk
    from candidates c
    join results r on r.candidate_id = c.id)
select concat(party, ' ', count(1)) as party_seats_won
from cte 
where rnk = 1
group by party 
--order by count(1) desc;

GO
/****** Object:  Table [dbo].[customers]    Script Date: 4/20/2024 10:49:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[customers](
	[id] [int] NULL,
	[first_name] [varchar](50) NULL,
	[last_name] [varchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[campaigns]    Script Date: 4/20/2024 10:49:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[campaigns](
	[id] [int] NULL,
	[customer_id] [int] NULL,
	[name] [varchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[events]    Script Date: 4/20/2024 10:49:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[events](
	[campaign_id] [int] NULL,
	[status] [varchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[MostSuccessNdFaildCampaing]    Script Date: 4/20/2024 10:49:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[MostSuccessNdFaildCampaing](
)
returns table as 
return
with cte as
 (
select e.status,cmp.customer_id,cmp.name,count(1) as total
from events
e left join  campaigns cmp on cmp.id=e.campaign_id
group by e.status,cmp.customer_id,cmp.name
),
cte2 as ( select status,customer_id,STRING_AGG(name,',') as cmpnName,
 RANK() over(partition by status order by sum(total) desc) as rnk,
  sum(total) as total
from cte group by status,customer_id)
select cte2.status,(c.first_name+' '+c.last_name)CusName,
cte2.cmpnName,cte2.total
from cte2   left join customers c on c.id=cte2.customer_id
where rnk=1
--order by status desc

 

GO
/****** Object:  Table [dbo].[__EFMigrationsHistory]    Script Date: 4/20/2024 10:49:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[__EFMigrationsHistory](
	[MigrationId] [nvarchar](150) NOT NULL,
	[ProductVersion] [nvarchar](32) NOT NULL,
 CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY CLUSTERED 
(
	[MigrationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetRoleClaims]    Script Date: 4/20/2024 10:49:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetRoleClaims](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[RoleId] [nvarchar](450) NOT NULL,
	[ClaimType] [nvarchar](max) NULL,
	[ClaimValue] [nvarchar](max) NULL,
 CONSTRAINT [PK_AspNetRoleClaims] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetRoles]    Script Date: 4/20/2024 10:49:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetRoles](
	[Id] [nvarchar](450) NOT NULL,
	[Name] [nvarchar](256) NULL,
	[NormalizedName] [nvarchar](256) NULL,
	[ConcurrencyStamp] [nvarchar](max) NULL,
 CONSTRAINT [PK_AspNetRoles] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetUserClaims]    Script Date: 4/20/2024 10:49:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserClaims](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [nvarchar](450) NOT NULL,
	[ClaimType] [nvarchar](max) NULL,
	[ClaimValue] [nvarchar](max) NULL,
 CONSTRAINT [PK_AspNetUserClaims] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetUserLogins]    Script Date: 4/20/2024 10:49:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserLogins](
	[LoginProvider] [nvarchar](128) NOT NULL,
	[ProviderKey] [nvarchar](128) NOT NULL,
	[ProviderDisplayName] [nvarchar](max) NULL,
	[UserId] [nvarchar](450) NOT NULL,
 CONSTRAINT [PK_AspNetUserLogins] PRIMARY KEY CLUSTERED 
(
	[LoginProvider] ASC,
	[ProviderKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetUserRoles]    Script Date: 4/20/2024 10:49:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserRoles](
	[UserId] [nvarchar](450) NOT NULL,
	[RoleId] [nvarchar](450) NOT NULL,
 CONSTRAINT [PK_AspNetUserRoles] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetUsers]    Script Date: 4/20/2024 10:49:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUsers](
	[Id] [nvarchar](450) NOT NULL,
	[UserName] [nvarchar](256) NULL,
	[NormalizedUserName] [nvarchar](256) NULL,
	[Email] [nvarchar](256) NULL,
	[NormalizedEmail] [nvarchar](256) NULL,
	[EmailConfirmed] [bit] NOT NULL,
	[PasswordHash] [nvarchar](max) NULL,
	[SecurityStamp] [nvarchar](max) NULL,
	[ConcurrencyStamp] [nvarchar](max) NULL,
	[PhoneNumber] [nvarchar](max) NULL,
	[PhoneNumberConfirmed] [bit] NOT NULL,
	[TwoFactorEnabled] [bit] NOT NULL,
	[LockoutEnd] [datetimeoffset](7) NULL,
	[LockoutEnabled] [bit] NOT NULL,
	[AccessFailedCount] [int] NOT NULL,
 CONSTRAINT [PK_AspNetUsers] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetUserTokens]    Script Date: 4/20/2024 10:49:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserTokens](
	[UserId] [nvarchar](450) NOT NULL,
	[LoginProvider] [nvarchar](128) NOT NULL,
	[Name] [nvarchar](128) NOT NULL,
	[Value] [nvarchar](max) NULL,
 CONSTRAINT [PK_AspNetUserTokens] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[LoginProvider] ASC,
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Bonus]    Script Date: 4/20/2024 10:49:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Bonus](
	[WORKER_REF_ID] [int] NULL,
	[BONUS_AMOUNT] [int] NULL,
	[BONUS_DATE] [datetime] NULL,
	[WORKER_ID] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[candidates_tab]    Script Date: 4/20/2024 10:49:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[candidates_tab](
	[id] [int] NULL,
	[first_name] [varchar](50) NULL,
	[last_name] [varchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[loan_data]    Script Date: 4/20/2024 10:49:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[loan_data](
	[particular] [varchar](50) NULL,
	[ld_no] [varchar](20) NULL,
	[loan_date] [date] NULL,
	[loan_amount] [decimal](18, 2) NULL,
	[interest] [decimal](18, 2) NULL,
	[total_amount] [decimal](18, 2) NULL,
	[adjusted_1] [decimal](18, 2) NULL,
	[adjusted_2] [decimal](18, 2) NULL,
	[adjusted_3] [decimal](18, 2) NULL,
	[adjusted_4] [decimal](18, 2) NULL,
	[adjusted_5] [decimal](18, 2) NULL,
	[adjusted_6] [decimal](18, 2) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[loan_data2]    Script Date: 4/20/2024 10:49:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[loan_data2](
	[ld_no] [varchar](20) NULL,
	[loan_date] [date] NULL,
	[loan_amount] [decimal](18, 2) NULL,
	[interest] [decimal](18, 2) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Order]    Script Date: 4/20/2024 10:49:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Order](
	[OrderId] [bigint] IDENTITY(1,1) NOT NULL,
	[OrderKey] [uniqueidentifier] NULL,
	[ProductName] [nvarchar](100) NOT NULL,
	[CategoryId] [bigint] NULL,
	[OrderDate] [datetime] NULL,
	[IsProductRecieve] [bit] NULL,
	[EntryDateTime] [datetime] NULL,
	[EntryBy] [bigint] NULL,
	[Status] [varchar](10) NULL,
 CONSTRAINT [PK_Order] PRIMARY KEY CLUSTERED 
(
	[OrderId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Products]    Script Date: 4/20/2024 10:49:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Products](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[Price] [decimal](18, 2) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[results_tab]    Script Date: 4/20/2024 10:49:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[results_tab](
	[candidate_id] [int] NULL,
	[state] [varchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Students]    Script Date: 4/20/2024 10:49:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Students](
	[StudentID] [int] NOT NULL,
	[FirstName] [nvarchar](50) NOT NULL,
	[LastName] [nvarchar](50) NOT NULL,
	[BirthDate] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[StudentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SupplierInfo]    Script Date: 4/20/2024 10:49:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SupplierInfo](
	[SupplierId] [bigint] IDENTITY(1,1) NOT NULL,
	[SupplierKey] [uniqueidentifier] NULL,
	[BranchId] [bigint] NULL,
	[SupplierName] [nvarchar](100) NOT NULL,
	[CountryId] [bigint] NOT NULL,
	[StateName] [nvarchar](100) NOT NULL,
	[OrgnznName] [nvarchar](200) NOT NULL,
	[SelectTypeId] [bigint] NOT NULL,
	[SupplierAddrsLineONe] [nvarchar](200) NOT NULL,
	[SupplierAddrsLineTwo] [nchar](200) NOT NULL,
	[DeliveryOffDay] [nvarchar](80) NOT NULL,
	[Email] [nvarchar](100) NOT NULL,
	[MobileNo] [nvarchar](100) NOT NULL,
	[ImageLink] [nvarchar](180) NOT NULL,
	[EntryDateTime] [datetime] NULL,
	[EntryBy] [bigint] NULL,
	[LastModifyDate] [datetime] NULL,
	[LastModifyBy] [bigint] NULL,
	[DeletedDate] [datetime] NULL,
	[DeletedBy] [bigint] NULL,
	[Status] [varchar](10) NULL,
 CONSTRAINT [PK_SupplierInfo] PRIMARY KEY CLUSTERED 
(
	[SupplierId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tasks]    Script Date: 4/20/2024 10:49:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tasks](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](200) NULL,
	[IsComplete] [bit] NULL,
 CONSTRAINT [PK_Task] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Title]    Script Date: 4/20/2024 10:49:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Title](
	[WORKER_REF_ID] [int] NULL,
	[WORKER_TITLE] [char](25) NULL,
	[AFFECTED_FROM] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Worker]    Script Date: 4/20/2024 10:49:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Worker](
	[WORKER_ID] [int] NOT NULL,
	[SALARY] [int] NULL,
	[JOINING_DATE] [datetime] NULL,
	[DEPARTMENT] [char](25) NULL,
	[FIRST_NAME] [varchar](100) NULL,
	[LAST_NAME] [varchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[WORKER_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[WorkerClone]    Script Date: 4/20/2024 10:49:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WorkerClone](
	[WORKER_ID] [int] NOT NULL,
	[SALARY] [int] NULL,
	[JOINING_DATE] [datetime] NULL,
	[DEPARTMENT] [char](25) NULL,
	[FIRST_NAME] [varchar](100) NULL,
	[LAST_NAME] [varchar](100) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [invnt].[ProductCategories]    Script Date: 4/20/2024 10:49:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [invnt].[ProductCategories](
	[ProdCtgId] [bigint] IDENTITY(1,1) NOT NULL,
	[ProdCtgKey] [uniqueidentifier] NULL,
	[BranchId] [bigint] NULL,
	[ProdCtgName] [nvarchar](100) NOT NULL,
	[EntryDateTime] [datetime] NOT NULL,
	[EntryBy] [bigint] NOT NULL,
	[LastModifyDate] [datetime] NULL,
	[LastModifyBy] [bigint] NULL,
	[DeletedDate] [datetime] NULL,
	[DeletedBy] [bigint] NULL,
	[Status] [varchar](10) NOT NULL,
 CONSTRAINT [PK_ProductCategories] PRIMARY KEY CLUSTERED 
(
	[ProdCtgId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [invnt].[ProductSubCategories]    Script Date: 4/20/2024 10:49:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [invnt].[ProductSubCategories](
	[ProdSubCtgId] [bigint] IDENTITY(1,1) NOT NULL,
	[ProdSubCtgKey] [uniqueidentifier] NULL,
	[BranchId] [bigint] NOT NULL,
	[ProdCtgId] [bigint] NOT NULL,
	[ProdSubCtgName] [nvarchar](100) NOT NULL,
	[EntryDateTime] [datetime] NOT NULL,
	[EntryBy] [bigint] NOT NULL,
	[LastModifyDate] [datetime] NULL,
	[LastModifyBy] [bigint] NULL,
	[DeletedDate] [datetime] NULL,
	[DeletedBy] [bigint] NULL,
	[Status] [varchar](10) NULL,
 CONSTRAINT [PK_ProductSubCategories] PRIMARY KEY CLUSTERED 
(
	[ProdSubCtgId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [invnt].[Units]    Script Date: 4/20/2024 10:49:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [invnt].[Units](
	[UnitId] [bigint] IDENTITY(1,1) NOT NULL,
	[UnitKey] [uniqueidentifier] NULL,
	[BranchId] [bigint] NOT NULL,
	[UnitName] [nvarchar](100) NOT NULL,
	[EntryDateTime] [datetime] NULL,
	[EntryBy] [bigint] NULL,
	[LastModifyDate] [datetime] NULL,
	[LastModifyBy] [bigint] NULL,
	[DeletedDate] [datetime] NULL,
	[DeletedBy] [bigint] NULL,
	[Status] [varchar](10) NULL,
 CONSTRAINT [PK_Units] PRIMARY KEY CLUSTERED 
(
	[UnitId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [stt].[BusinessTypes]    Script Date: 4/20/2024 10:49:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [stt].[BusinessTypes](
	[BusinessTypeId] [bigint] IDENTITY(1,1) NOT NULL,
	[BusinessTypeKey] [uniqueidentifier] NULL,
	[LanguageId] [int] NOT NULL,
	[BusinessTypeName] [nvarchar](100) NOT NULL,
	[EntryDateTime] [datetime] NOT NULL,
	[EntryBy] [bigint] NOT NULL,
	[LastModifyDate] [datetime] NULL,
	[LastModifyBy] [bigint] NULL,
	[DeletedDate] [datetime] NULL,
	[DeletedBy] [bigint] NULL,
	[Status] [varchar](10) NULL,
 CONSTRAINT [PK_BusinessTypes] PRIMARY KEY CLUSTERED 
(
	[BusinessTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [stt].[Countries]    Script Date: 4/20/2024 10:49:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [stt].[Countries](
	[CountryId] [bigint] IDENTITY(1,1) NOT NULL,
	[CountryKey] [uniqueidentifier] NULL,
	[BranchId] [bigint] NOT NULL,
	[LanguageId] [int] NOT NULL,
	[CountryName] [nvarchar](100) NOT NULL,
	[CntryShortName] [nvarchar](15) NULL,
	[CountryCode] [nvarchar](6) NOT NULL,
	[Capital] [varchar](100) NOT NULL,
	[CurrencyId] [int] NOT NULL,
	[CurrentArea] [decimal](10, 2) NULL,
	[Population] [decimal](10, 2) NULL,
	[EntryDateTime] [datetime] NOT NULL,
	[EntryBy] [bigint] NOT NULL,
	[LastModifyDate] [datetime] NULL,
	[LastModifyBy] [bigint] NULL,
	[DeletedDate] [datetime] NULL,
	[DeletedBy] [bigint] NULL,
	[Status] [varchar](10) NULL,
 CONSTRAINT [PK_Countries] PRIMARY KEY CLUSTERED 
(
	[CountryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [stt].[Currencies]    Script Date: 4/20/2024 10:49:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [stt].[Currencies](
	[CurrencyId] [bigint] IDENTITY(1,1) NOT NULL,
	[CurrencyKey] [uniqueidentifier] NULL,
	[BranchId] [bigint] NOT NULL,
	[LanguageId] [int] NOT NULL,
	[CurrencyName] [nvarchar](100) NOT NULL,
	[CurrencyCode] [varchar](10) NULL,
	[CurrencyShortName] [nvarchar](15) NOT NULL,
	[Symbol] [varchar](12) NOT NULL,
	[ExchangeRate] [decimal](10, 4) NOT NULL,
	[EntryDateTime] [datetime] NOT NULL,
	[EntryBy] [bigint] NOT NULL,
	[LastModifyDate] [datetime] NULL,
	[LastModifyBy] [bigint] NULL,
	[DeletedDate] [datetime] NULL,
	[DeletedBy] [bigint] NULL,
	[Status] [varchar](10) NULL,
 CONSTRAINT [PK_Currencies] PRIMARY KEY CLUSTERED 
(
	[CurrencyId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [stt].[Language]    Script Date: 4/20/2024 10:49:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [stt].[Language](
	[LanguageId] [int] IDENTITY(1,1) NOT NULL,
	[LanguageKey] [uniqueidentifier] NULL,
	[LanguageName] [varchar](50) NOT NULL,
	[EntryDateTime] [datetime] NOT NULL,
	[EntryBy] [bigint] NOT NULL,
	[LastModifyDate] [datetime] NULL,
	[LastModifyBy] [bigint] NULL,
	[DeletedDate] [datetime] NULL,
	[DeletedBy] [bigint] NULL,
	[Status] [varchar](10) NULL,
 CONSTRAINT [PK_Languages] PRIMARY KEY CLUSTERED 
(
	[LanguageId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [stt].[MainDbConfig]    Script Date: 4/20/2024 10:49:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [stt].[MainDbConfig](
	[DbConfigId] [int] IDENTITY(1,1) NOT NULL,
	[CompanyId] [bigint] NULL,
	[BranchId] [bigint] NULL,
	[ServerName] [nvarchar](50) NOT NULL,
	[DatabaseName] [nvarchar](50) NOT NULL,
	[Username] [nvarchar](50) NULL,
	[Password] [nvarchar](50) NULL,
	[TrustedConnection] [bit] NOT NULL,
	[MultipleActiveResultSets] [bit] NOT NULL,
	[Encrypt] [bit] NOT NULL,
	[TrustServerCertificate] [bit] NOT NULL,
 CONSTRAINT [PK_MainDbConfig] PRIMARY KEY CLUSTERED 
(
	[DbConfigId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [stt].[StatusSetting]    Script Date: 4/20/2024 10:49:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [stt].[StatusSetting](
	[StatusSettingId] [bigint] IDENTITY(1,1) NOT NULL,
	[StatusSettingKey] [uniqueidentifier] NULL,
	[BranchId] [bigint] NOT NULL,
	[StatusSettingName] [nvarchar](100) NOT NULL,
	[PageName] [nvarchar](100) NOT NULL,
	[Position] [int] NULL,
	[EntryDateTime] [datetime] NOT NULL,
	[EntryBy] [bigint] NOT NULL,
	[LastModifyDate] [datetime] NULL,
	[LastModifyBy] [bigint] NULL,
	[DeletedDate] [datetime] NULL,
	[DeletedBy] [bigint] NULL,
	[Status] [varchar](10) NULL,
 CONSTRAINT [PK_StatusSettings] PRIMARY KEY CLUSTERED 
(
	[StatusSettingId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[AspNetRoleClaims]  WITH CHECK ADD  CONSTRAINT [FK_AspNetRoleClaims_AspNetRoles_RoleId] FOREIGN KEY([RoleId])
REFERENCES [dbo].[AspNetRoles] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetRoleClaims] CHECK CONSTRAINT [FK_AspNetRoleClaims_AspNetRoles_RoleId]
GO
ALTER TABLE [dbo].[AspNetUserClaims]  WITH CHECK ADD  CONSTRAINT [FK_AspNetUserClaims_AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserClaims] CHECK CONSTRAINT [FK_AspNetUserClaims_AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[AspNetUserLogins]  WITH CHECK ADD  CONSTRAINT [FK_AspNetUserLogins_AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserLogins] CHECK CONSTRAINT [FK_AspNetUserLogins_AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[AspNetUserRoles]  WITH CHECK ADD  CONSTRAINT [FK_AspNetUserRoles_AspNetRoles_RoleId] FOREIGN KEY([RoleId])
REFERENCES [dbo].[AspNetRoles] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserRoles] CHECK CONSTRAINT [FK_AspNetUserRoles_AspNetRoles_RoleId]
GO
ALTER TABLE [dbo].[AspNetUserRoles]  WITH CHECK ADD  CONSTRAINT [FK_AspNetUserRoles_AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserRoles] CHECK CONSTRAINT [FK_AspNetUserRoles_AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[AspNetUserTokens]  WITH CHECK ADD  CONSTRAINT [FK_AspNetUserTokens_AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserTokens] CHECK CONSTRAINT [FK_AspNetUserTokens_AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[Bonus]  WITH CHECK ADD FOREIGN KEY([WORKER_ID])
REFERENCES [dbo].[Worker] ([WORKER_ID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Title]  WITH CHECK ADD FOREIGN KEY([WORKER_REF_ID])
REFERENCES [dbo].[Worker] ([WORKER_ID])
ON DELETE CASCADE
GO
/****** Object:  StoredProcedure [dbo].[AddProduct]    Script Date: 4/20/2024 10:49:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[AddProduct](
@Id  int OUTPUT,
@Name  nvarchar(255) ,
@Price  decimal(18,2) ) AS 
BEGIN         SET NOCOUNT ON        
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED  
INSERT INTO  dbo.Products
VALUES (@Name, @Price ) 
SET  @Id = SCOPE_IDENTITY();   
SELECT @Id  id 
END
GO
/****** Object:  StoredProcedure [dbo].[CreateProduct]    Script Date: 4/20/2024 10:49:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 CREATE PROCEDURE [dbo].[CreateProduct]
    @Name NVARCHAR(255),
    @Price DECIMAL(18, 2)
AS
BEGIN
    INSERT INTO Products (Name, Price)
    VALUES (@Name, @Price);

    SELECT SCOPE_IDENTITY() AS Id; -- Return the newly created product's ID
END;
GO
/****** Object:  StoredProcedure [dbo].[Currency_Get_SP]    Script Date: 4/20/2024 10:49:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

 create PROCEDURE [dbo].[Currency_Get_SP](
 @CurrencyId bigint=null,
 @CurrencyKey nvarchar(40)=null,
 @LanguageId int,
 @CurrencyName nvarchar(100)=null,
 @CurrencyCode varchar=null,
 @CurrencyShortName nvarchar,
 @Symbol varchar,
 @ExchangeRate decimal,
 @BranchId Int=null,
 @page_number INT = 1,
 @page_size INT =10
 )
AS
  BEGIN
      SET nocount ON
      SET TRANSACTION isolation level READ uncommitted

      DECLARE @offset BIGINT
      SET @offset = (@page_number - 1) * @page_size;

      SELECT a.[CurrencyId]
      ,a.[CurrencyKey]
      ,a.[BranchId]
      ,a.[LanguageId]
      ,a.[CurrencyName]
      ,a.[CurrencyCode]
      ,a.[CurrencyShortName]
      ,a.[Symbol]
      ,a.[ExchangeRate]
      ,a.[EntryDateTime]
      ,a.[EntryBy]
      ,a.[LastModifyDate]
      ,a.[LastModifyBy]
      ,a.[DeletedDate]
      ,a.[DeletedBy]
      ,a.[Status]

      FROM   [stt].[Currencies] a
	  WHERE  (@CurrencyId IS NULL OR a.CurrencyId = @CurrencyId) and
	         (@CurrencyKey IS NULL OR a.CurrencyKey = @CurrencyKey) and
			 (@BranchId IS NULL OR a.BranchId = @BranchId) and
			 (@CurrencyCode IS NULL OR a.CurrencyCode = @CurrencyCode) and
			(@CurrencyShortName IS NULL OR a.CurrencyShortName = @CurrencyShortName) and
			(@Symbol IS NULL OR a.Symbol = @Symbol) and
			(@ExchangeRate IS NULL OR a.ExchangeRate= @ExchangeRate) and
		    (@CurrencyName IS NULL OR a.CurrencyName = @CurrencyName)  
			 and a.Status='Active'
      ORDER  BY a.CurrencyId Desc

	 OFFSET @offset ROWS FETCH NEXT @page_size ROWS ONLY;
  END 
  
 -- select * from  [stt].[currencies]
 
GO
/****** Object:  StoredProcedure [dbo].[Currency_Insert_SP]    Script Date: 4/20/2024 10:49:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

 create PROCEDURE [dbo].[Currency_Insert_SP](
  @CurrencyId BIGINT OUTPUT, 
  @CurrencyKey uniqueidentifier=null,
  @BranchId  BIGINT = NULL,
  @CurrencyName NVARCHAR(100),
  @LanguageId int,
  @CurrencyCode varchar=null,
  @CurrencyShortName nvarchar,
  @Symbol varchar,
  @ExchangeRate decimal,
  @EntryDateTime DATETIME,
  @EntryBy BIGINT,
  @LastModifyDate DATETIME = NULL,
  @LastModifyBy BIGINT = NULL,
  @DeletedDate DATETIME = NULL,
  @DeletedBy BIGINT = NULL,
  @Status VARCHAR(10) = 'Active'
) AS BEGIN 
      SET NOCOUNT ON;
      SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

		-- Check if @unitName already exists (case-insensitive, trimmed, and with white spaces replaced)
		IF EXISTS (
			SELECT 1
			FROM [stt].[Currencies]  
			WHERE
			BranchId =@branchId  and
			LOWER(LTRIM(RTRIM(REPLACE([CurrencyName], ' ', '')))) = LOWER(LTRIM(RTRIM(REPLACE(@CurrencyName, ' ', ''))))
		)
		BEGIN
			-- If @unitName already exists, set @unitId to -1
			SET @CurrencyId= -1;
		END
       ELSE
         BEGIN
			-- Insert new record
		INSERT INTO [stt].[Currencies] (	
      [CurrencyKey],
      [BranchId],
      [LanguageId],
      [CurrencyName],
      [CurrencyCode],
      [CurrencyShortName],
      [Symbol],
      [ExchangeRate],
      [EntryDateTime],
      [EntryBy],
      [LastModifyDate],
      [LastModifyBy],
      [DeletedDate],
      [DeletedBy],
      [Status]
	) 
			VALUES (
				NEWID(),  
				@BranchId,
				@LanguageId,
				@CurrencyName,
				@CurrencyCode,
				@CurrencyShortName,
				@Symbol,
				@ExchangeRate,
				@EntryDateTime,
				@EntryBy,
				@LastModifyDate,
				@LastModifyBy,
				@DeletedDate,
				@DeletedBy,
				@Status
			);

			-- Get the unitId of the newly inserted record
			SET @CurrencyId = SCOPE_IDENTITY();
		END

-- Return the @unitId value
SELECT @CurrencyId AS unitId;
END;
GO
/****** Object:  StoredProcedure [dbo].[Currency_Update_SP]    Script Date: 4/20/2024 10:49:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

 
create procedure [dbo].[Currency_Update_SP](
  @CurrencyId BIGINT, 
  @CurrencyKey uniqueidentifier=null,
  @BranchId  BIGINT = NULL,
  @CurrencyName NVARCHAR(100),
  @LanguageId int,
  @CurrencyCode varchar=null,
  @CurrencyShortName nvarchar,
  @Symbol varchar,
  @ExchangeRate decimal,
  @EntryDateTime DATETIME,
  @EntryBy BIGINT,
  @LastModifyDate DATETIME = NULL,
  @LastModifyBy BIGINT = NULL,
  @DeletedDate DATETIME = NULL,
  @DeletedBy BIGINT = NULL,
  @Status VARCHAR(10) =null,
  @success INT OUTPUT
)AS
 BEGIN 
	SET 
	NOCOUNT ON 
	SET 
  TRANSACTION ISOLATION LEVEL READ UNCOMMITTED 
  BEGIN TRY
		UPDATE 
		a WITH(ROWLOCK) 
		SET 
		  [BranchId] = COALESCE(@branchId, [BranchId]),
          [CurrencyName] = COALESCE(@CurrencyName, [CurrencyName]),
		  [BranchId] = COALESCE(@branchId, [BranchId]),
		  [LanguageId] = COALESCE(@LanguageId, [LanguageId]),
		  [CurrencyCode ] = COALESCE(@CurrencyCode , [CurrencyCode]),
		  [CurrencyShortName] = COALESCE(@CurrencyShortName, [CurrencyShortName]),
		  [Symbol] = COALESCE(@Symbol, [Symbol]),
		  [ExchangeRate] = COALESCE(@ExchangeRate, [ExchangeRate]),
          [LastModifyDate] = COALESCE(@lastModifyDate, [LastModifyDate]),
          [LastModifyBy] = COALESCE(@lastModifyBy, [LastModifyBy]),
          [DeletedDate] = COALESCE(@deletedDate, [DeletedDate]),
          [DeletedBy] = COALESCE(@deletedBy, [DeletedBy]),
          [Status] = COALESCE(@status, [Status])
		 FROM 
		  [stt].[CurrencyId] a WITH(ROWLOCK) 
		  WHERE 
		  a.CurrencyId = @CurrencyId 

		  SET @success = 1; -- Set success flag to 1
     END TRY
     BEGIN CATCH
         SET @success = 0; -- Error occurred, set success flag to 0
     END CATCH
  END

 --select *   FROM [stt].[Units]

GO
/****** Object:  StoredProcedure [dbo].[DeleteProduct]    Script Date: 4/20/2024 10:49:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 CREATE PROCEDURE [dbo].[DeleteProduct]
    @Id INT
AS
BEGIN
    DELETE FROM Products
    WHERE Id = @Id;
END;
GO
/****** Object:  StoredProcedure [dbo].[GetProduct]    Script Date: 4/20/2024 10:49:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 CREATE PROCEDURE [dbo].[GetProduct]
    @Id INT
AS
BEGIN
    SELECT * FROM Products WHERE Id = @Id;
END;
GO
/****** Object:  StoredProcedure [dbo].[GetProducts]    Script Date: 4/20/2024 10:49:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 CREATE PROCEDURE [dbo].[GetProducts]
AS
BEGIN
    SELECT * FROM Products;
END;
GO
/****** Object:  StoredProcedure [dbo].[Language_Get_SP]    Script Date: 4/20/2024 10:49:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

 create PROCEDURE [dbo].[Language_Get_SP](
 @LanguageId int=null,
 @LanguageKey nvarchar(40)=null,
 @LanguageName nvarchar(100)=null,
 @BranchId Int=null,
 @page_number INT = 1,
 @page_size INT =10
 )
AS
  BEGIN
      SET nocount ON
      SET TRANSACTION isolation level READ uncommitted

      DECLARE @offset BIGINT
      SET @offset = (@page_number - 1) * @page_size;

      SELECT a.[LanguageId]
      ,a.[LanguageKey]
      
      ,a.[LanguageName]
      ,a.[EntryDateTime]
      ,a.[EntryBy]
      ,a.[LastModifyDate]
      ,a.[LastModifyBy]
      ,a.[DeletedDate]
      ,a.[DeletedBy]
      ,a.[Status]
	  
      FROM   [stt].[Languages] a
	  WHERE  (@LanguageId IS NULL OR a.LanguageId = @LanguageId) and
	         (@LanguageKey IS NULL OR a.LanguageKey = @LanguageKey) and
			
		     (@LanguageName IS NULL OR a.LanguageName = @LanguageName)  
			 and a.Status='Active'
      ORDER  BY a.LanguageId Desc

	 OFFSET @offset ROWS FETCH NEXT @page_size ROWS ONLY;
  END 
  
 -- select * from  [stt].[Units]
 
GO
/****** Object:  StoredProcedure [dbo].[Language_Insert_SP]    Script Date: 4/20/2024 10:49:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

 Create PROCEDURE [dbo].[Language_Insert_SP](
  @LanguageId BIGINT OUTPUT, 
  @LanguageKey uniqueidentifier=null,

  @LanguageName NVARCHAR(100), 
  @EntryDateTime DATETIME,
  @EntryBy BIGINT,
  @LastModifyDate DATETIME = NULL,
  @LastModifyBy BIGINT = NULL,
  @DeletedDate DATETIME = NULL,
  @DeletedBy BIGINT = NULL,
  @Status VARCHAR(10) = 'Active'
) AS BEGIN 
      SET NOCOUNT ON;
      SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

		-- Check if @unitName already exists (case-insensitive, trimmed, and with white spaces replaced)
		IF EXISTS (
			SELECT 1
			FROM [stt].[Languages]  
			WHERE
			
			LOWER(LTRIM(RTRIM(REPLACE([LanguageName], ' ', '')))) = LOWER(LTRIM(RTRIM(REPLACE(@LanguageName, ' ', ''))))
		)
		BEGIN
			-- If @unitName already exists, set @unitId to -1
			SET @LanguageId  = -1;
		END
       ELSE
         BEGIN
			-- Insert new record
			INSERT INTO [stt].[Languages] (
				[LanguageKey],  
			
				[LanguageName],
				[EntryDateTime],
				[EntryBy],
				[LastModifyDate],
				[LastModifyBy],
				[DeletedDate],
				[DeletedBy],
				[Status]
			) 
			VALUES (
				NEWID(),  
			
				@LanguageName,
				@entryDateTime,
				@entryBy,
				@lastModifyDate,
				@lastModifyBy,
				@deletedDate,
				@deletedBy,
				@status
			);

			-- Get the unitId of the newly inserted record
			SET @LanguageId = SCOPE_IDENTITY();
		END

-- Return the @unitId value
SELECT @LanguageId AS unitId;
END;
GO
/****** Object:  StoredProcedure [dbo].[Language_Update_SP]    Script Date: 4/20/2024 10:49:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[Language_Update_SP](
  @LanguageId BIGINT, 
  @LanguageKey uniqueidentifier=null,

  @LanguageName NVARCHAR(100), 
  @EntryDateTimeme DATETIME=Null,
  @EntryBy BIGINT=Null,
  @LastModifyDate DATETIME = NULL,
  @LastModifyBy BIGINT = NULL,
  @DeletedDate DATETIME = NULL,
  @DeletedBy BIGINT = NULL,
  @Status VARCHAR(10) =null,
  @Success INT OUTPUT
)AS
 BEGIN 
	SET 
	NOCOUNT ON 
	SET 
  TRANSACTION ISOLATION LEVEL READ UNCOMMITTED 
  BEGIN TRY
		UPDATE 
		a WITH(ROWLOCK) 
		SET 
		 
          [LanguageName] = COALESCE(@languageName, [LanguageName]),
          [LastModifyDate] = COALESCE(@lastModifyDate, [LastModifyDate]),
          [LastModifyBy] = COALESCE(@lastModifyBy, [LastModifyBy]),
          [DeletedDate] = COALESCE(@deletedDate, [DeletedDate]),
          [DeletedBy] = COALESCE(@deletedBy, [DeletedBy]),
          [Status] = COALESCE(@status, [Status])
		 FROM 
		  [stt].[Languages] a WITH(ROWLOCK) 
		  WHERE 
		  a.LanguageId = @LanguageId

		  SET @success = 1; -- Set success flag to 1
     END TRY
     BEGIN CATCH
         SET @success = 0; -- Error occurred, set success flag to 0
     END CATCH
  END

 --select *   FROM [stt].[Languages]

GO
/****** Object:  StoredProcedure [dbo].[Meeting_Minutes _Details_Save_SP]    Script Date: 4/20/2024 10:49:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Meeting_Minutes _Details_Save_SP](
@meetng_Mnts_Dtls_ID INT,
@fk_Srvc_Id          INT,
@quantity            DECIMAL(10, 0),
@unit                NVARCHAR(50) = NULL)
AS
  BEGIN
      SET nocount ON
      SET TRANSACTION isolation level READ uncommitted

      IF ( @meetng_Mnts_Dtls_ID = 0 )
        BEGIN
            INSERT INTO tst.meeting_minutes_details_tb
            VALUES      (  
                          @fk_Srvc_Id,
                          @quantity,
                          @unit )

            SET @meetng_Mnts_Dtls_ID = Scope_identity();

            SELECT @meetng_Mnts_Dtls_ID meetng_Mnts_Dtls_ID
        END
      ELSE
        BEGIN
            UPDATE a WITH(rowlock)
            SET   
                   a.fk_srvc_id = @fk_Srvc_Id,
                   a.quantity = @quantity,
                   a.unit = @unit
            FROM   tst.meeting_minutes_details_tb a WITH(rowlock)
            WHERE  a.meetng_mnts_dtls_id = @meetng_Mnts_Dtls_ID
        END
  END 
GO
/****** Object:  StoredProcedure [dbo].[pr_tableDetails]    Script Date: 4/20/2024 10:49:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create PROCEDURE [dbo].[pr_tableDetails]
(
 @tableName NVARCHAR(200) 
)
AS
BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	
				SELECT 
			   c.name 'Column Name',			  
			   t.name,
			   t.name +
			   CASE WHEN t.name IN ('char', 'varchar','nchar','nvarchar') THEN '('+

						 CASE WHEN c.max_length=-1 THEN 'MAX'

							  ELSE CONVERT(VARCHAR(4),

										   CASE WHEN t.name IN ('nchar','nvarchar')

										   THEN  c.max_length/2 ELSE c.max_length END )

							  END +')'

					  WHEN t.name IN ('decimal','numeric')

							  THEN '('+ CONVERT(VARCHAR(4),c.precision)+','

									  + CONVERT(VARCHAR(4),c.Scale)+')'

							  ELSE '' END

			   as "DDL name",
			   c.max_length 'Max Length in Bytes',   
			   CASE WHEN c.is_nullable =0 THEN 'not null' ELSE 'null' END AS 'is_nullable',
			   ISNULL(i.is_primary_key, 0) 'Primary Key',
			   c.precision ,
			   c.scale ,
			   (SELECT name AS SchemaTable FROM sys.tables WHERE SCHEMA_NAME(schema_id)+'.'+name =@tableName) AS 'TableName'
			INTO #Temp
			FROM    
			   sys.columns c
			INNER JOIN 
			   sys.types t ON c.user_type_id = t.user_type_id
			LEFT OUTER JOIN 
			   sys.index_columns ic ON ic.object_id = c.object_id AND ic.column_id = c.column_id
			LEFT OUTER JOIN 
			   sys.indexes i ON ic.object_id = i.object_id AND ic.index_id = i.index_id
			WHERE
			   c.object_id = OBJECT_ID(@tableName)


			   Select 
			        
					'"'+ LOWER(LEFT(a.[Column Name],1))+(SUBSTRING(a.[Column Name],2,LEN(a.[Column Name])))+'":0,' AS 'JSON',				
					
					'@'+LOWER(LEFT(a.[Column Name],1))+(SUBSTRING(a.[Column Name],2,LEN(a.[Column Name]))) +'  '+a.[DDL name]+',' AS 'Parametars', 
					'public  '+ CASE WHEN a.name = 'nvarchar' THEN 'string'
					                 WHEN a.name = 'bit' THEN (CASE WHEN a.is_nullable ='null' THEN 'bool?' ELSE 'bool' END) 
									 WHEN a.name = 'int' THEN (CASE WHEN a.is_nullable ='null' THEN 'int?' ELSE 'int' END) 
									 WHEN a.name = 'bigint' THEN (CASE WHEN a.is_nullable ='null' THEN 'long?' ELSE 'long' END) 
									 WHEN a.name = 'varchar' THEN 'string'
									 WHEN a.name = 'uniqueidentifier' THEN 'Guid'
									 WHEN a.name = 'datetime' THEN (CASE WHEN a.is_nullable ='null' THEN 'DateTime?' ELSE 'DateTime' END) 
									 WHEN a.name = 'float' THEN (CASE WHEN a.is_nullable ='null' THEN 'float?' ELSE 'float' END) 
									 WHEN a.name = 'numeric' THEN (CASE WHEN a.is_nullable ='null' THEN 'decimal?' ELSE 'decimal' END) 
					ELSE a.name END +'    '+a.[Column Name] +'  { get; set; }' AS 'Property',
					LOWER(LEFT(a.[TableName],1))+(SUBSTRING(a.[TableName],2,LEN(a.[TableName]))) +'ViewModel.'+a.[Column Name]+'='+
					              CASE WHEN a.name ='bit' THEN '(bool)dr["'+a.[Column Name]+'"];'
								       WHEN a.name ='int' THEN 'Convert.ToInt32(dr["'+a.[Column Name]+'"].ToString());'
									   WHEN a.name ='bigint' THEN 'Convert.ToInt64(dr["'+a.[Column Name]+'"].ToString());'
									   --WHEN a.name ='datetime' THEN (CASE WHEN a.is_nullable ='null' THEN 'if(!string.IsNullOrEmpty(dr["'+a.[Column Name]+'"].ToString()) Convert.ToDateTime(dr["'+a.[Column Name]+'"].ToString());' ELSE 'Convert.ToDateTime(dr["'+a.[Column Name]+'"].ToString());' END) 
									   WHEN a.name ='datetime' THEN 'Convert.ToDateTime(dr["'+a.[Column Name]+'"].ToString());'
					                                          ELSE  'dr["'+a.[Column Name]+'"].ToString();' END AS 'GET',
					'prms[0].Value='+LOWER(LEFT(a.[TableName],1))+(SUBSTRING(a.[TableName],2,LEN(a.[TableName]))) +'ViewModel.'+a.[Column Name]+';' AS 'POST',		
				
				
					'DECLARE  @'+LOWER(LEFT(a.[TableName],1))+(SUBSTRING(a.[TableName],2,LEN(a.[TableName]))) 
					+'  TABLE ('
					+(SElect TOP 1		 
							STUFF  
							(  
								(  
								  SELECT  ', '+ CAST(LOWER(LEFT(g.[Column Name],1))+(SUBSTRING(g.[Column Name],2,LEN(g.[Column Name]))) +'  '+g.[DDL name]   AS VARCHAR(MAX))  
								  FROM #Temp g
								  FOR XMl PATH('')  
								),1,1,''  
							)  
							FROM #Temp t1 )
							--Where t1.[Primary Key]=1)
					+')'
					+'  IF ( @'+LOWER(LEFT(a.[TableName],1))+(SUBSTRING(a.[TableName],2,LEN(a.[TableName])))+'_xml' + ' IS NOT NULL)'+
	                  ' BEGIN' +
					  ' INSERT INTO @'+LOWER(LEFT(a.[TableName],1))+(SUBSTRING(a.[TableName],2,LEN(a.[TableName])))+
					  ' ('+	(SElect TOP 1		 
							STUFF  
							(  
								(  
								  SELECT  +', '+ CAST(LOWER(LEFT(g.[Column Name],1))+(SUBSTRING(g.[Column Name],2,LEN(g.[Column Name])))  AS VARCHAR(MAX))  
								  FROM #Temp g
								  FOR XMl PATH('')  
								),1,1,''  
							)  
							FROM #Temp t1 )
							--Where t1.[Primary Key]=1)
					+' )'
					+' SELECT   '+(SElect TOP 1		 
							STUFF  
							(  
								(  
								  SELECT  ', '+'doc.c.value( ''@'+ CAST(LOWER(LEFT(g.[Column Name],1))+(SUBSTRING(g.[Column Name],2,LEN(g.[Column Name]))) +''' ,' +''' '+g.[DDL name] +''' ) '+ LOWER(LEFT(g.[Column Name],1))+(SUBSTRING(g.[Column Name],2,LEN(g.[Column Name]))) AS VARCHAR(MAX))  
								  FROM #Temp g
								  FOR XMl PATH('')  
								),1,1,''  
							)  
							FROM #Temp t1 )+' ) '
							+' FROM  @'+LOWER(LEFT(a.[TableName],1))+(SUBSTRING(a.[TableName],2,LEN(a.[TableName])))+'_xml.nodes'
							+'(' +'''/'+LOWER(LEFT(a.[TableName],1))+(SUBSTRING(a.[TableName],2,LEN(a.[TableName])))+'/item'')doc(c) END' AS 'XML',

							   'INSERT INTO  '
					+@tableName				
					+' ('
					+ (SElect 	TOP 1	 
							STUFF  
							(  
								(  
								  SELECT  ', '+ CAST((LEFT(g.[Column Name],1))+(SUBSTRING(g.[Column Name],2,LEN(g.[Column Name])))  AS VARCHAR(MAX))  
								  FROM #Temp g
								  FOR XMl PATH('')  
								),1,1,''  
							)  
							FROM #Temp t1 
							Where t1.[Primary Key]=1)
					+' )' AS 'INSERT',
							





					'CREATE procedure [dbo].['+'pr_'+LOWER(LEFT(a.[TableName],1))+(SUBSTRING(a.[TableName],2,LEN(a.[TableName])))+'_set_update]'
					+'('
					+(SElect TOP 1		 
							STUFF  
							(  
								(  
								  SELECT  ', '+'@'+ CAST(LOWER(LEFT(g.[Column Name],1))+(SUBSTRING(g.[Column Name],2,LEN(g.[Column Name]))) +'  '+g.[DDL name] + CASE WHEN g.is_nullable = 'null' THEN ' = null'ELSE ' ' END AS VARCHAR(MAX))  
								  FROM #Temp g
								  FOR XMl PATH('')  
								),1,1,''  
							)  
							FROM #Temp t1 )
							--Where t1.[Primary Key]=1)
					+')'
					+' AS 
					   BEGIN
							SET NOCOUNT ON
							SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED   '
					+'IF '+'(@'+LOWER(LEFT(a.[Column Name],1))+(SUBSTRING(a.[Column Name],2,LEN(a.[Column Name]))) + '= 0)        '
					+'BEGIN  '
                    +'INSERT INTO  '
					+@tableName				
					+'  VALUES ('
					+ (SElect 	TOP 1	 
							STUFF  
							(  
								(  
								  SELECT  ', '+'@'+ CAST(LOWER(LEFT(g.[Column Name],1))+(SUBSTRING(g.[Column Name],2,LEN(g.[Column Name])))  AS VARCHAR(MAX))  
								  FROM #Temp g
								  FOR XMl PATH('')  
								),1,1,''  
							)  
							FROM #Temp t1 
							Where t1.[Primary Key]=1)
					+' )'+
					+'  SET  '
					+ '@'+LOWER(LEFT(a.[Column Name],1))+(SUBSTRING(a.[Column Name],2,LEN(a.[Column Name]))) +' = '+ 'SCOPE_IDENTITY();'
					+ '    '+'SELECT '+'@'+LOWER(LEFT(a.[Column Name],1))+(SUBSTRING(a.[Column Name],2,LEN(a.[Column Name]))) +'  '+ LOWER(LEFT(a.[Column Name],1))+(SUBSTRING(a.[Column Name],2,LEN(a.[Column Name])))
					+'  END'
					+' ELSE  '
					+' 
					   BEGIN  
							'
                    +'UPDATE a  WITH(ROWLOCK) SET  '					
					+ (SElect 		 
							STUFF  
							(  
								(  
								 SELECT  +', '+'a.'+ CAST(g.[Column Name]+'=@'+LOWER(LEFT(g.[Column Name],1))+(SUBSTRING(g.[Column Name],2,LEN(g.[Column Name]))) AS VARCHAR(MAX))  
								  FROM #Temp g
								  FOR XMl PATH('')  
								),1,1,''  
							)  
							FROM #Temp t1 
							Where t1.[Primary Key]=1)
					+'  FROM  '+				
					+@tableName +' a'+' WITH(ROWLOCK) '
					+' WHERE a.'+a.[Column Name] +' = '+ '@'+LOWER(LEFT(a.[Column Name],1))+(SUBSTRING(a.[Column Name],2,LEN(a.[Column Name])))
					+' END  '
					+'  END  '
					AS 'INSERT-UPDATE-PRO',









				
					'CREATE procedure [dbo].['+'pr_'+LOWER(LEFT(a.[TableName],1))+(SUBSTRING(a.[TableName],2,LEN(a.[TableName])))+'_set]'
					+'('
					+(SElect TOP 1		 
							STUFF  
							(  
								(  
								  SELECT  ', '+'@'+ CAST(LOWER(LEFT(g.[Column Name],1))+(SUBSTRING(g.[Column Name],2,LEN(g.[Column Name]))) +'  '+g.[DDL name] + CASE WHEN g.is_nullable = 'null' THEN ' = null'ELSE ' ' END AS VARCHAR(MAX))  
								  FROM #Temp g
								  FOR XMl PATH('')  
								),1,1,''  
							)  
							FROM #Temp t1 )
							--Where t1.[Primary Key]=1)
					+')'
					+' AS 
					   BEGIN
							SET NOCOUNT ON
							SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED   '
                    +'INSERT INTO  '
					+@tableName				
					+'  VALUES ('
					+ (SElect 	TOP 1	 
							STUFF  
							(  
								(  
								  SELECT  ', '+'@'+ CAST(LOWER(LEFT(g.[Column Name],1))+(SUBSTRING(g.[Column Name],2,LEN(g.[Column Name])))  AS VARCHAR(MAX))  
								  FROM #Temp g
								  FOR XMl PATH('')  
								),1,1,''  
							)  
							FROM #Temp t1 
							Where t1.[Primary Key]=1)
					+' )'+
					+'  SET  '
					+ '@'+LOWER(LEFT(a.[Column Name],1))+(SUBSTRING(a.[Column Name],2,LEN(a.[Column Name]))) +' = '+ 'SCOPE_IDENTITY();'
					+ '    '+'SELECT '+'@'+LOWER(LEFT(a.[Column Name],1))+(SUBSTRING(a.[Column Name],2,LEN(a.[Column Name]))) +'  '+ LOWER(LEFT(a.[Column Name],1))+(SUBSTRING(a.[Column Name],2,LEN(a.[Column Name])))
					+'  END'
					AS 'INSERT-PRO',

					'CREATE procedure [dbo].['+'pr_'+LOWER(LEFT(a.[TableName],1))+(SUBSTRING(a.[TableName],2,LEN(a.[TableName])))+'_update]'
					+'('
					+(SElect 	 
							STUFF  
							(  
								(  
								  SELECT  ', '+'@'+ CAST(LOWER(LEFT(g.[Column Name],1))+(SUBSTRING(g.[Column Name],2,LEN(g.[Column Name]))) +'  '+g.[DDL name] +CASE WHEN g.is_nullable = 'null' THEN ' = null'ELSE ' ' END AS VARCHAR(MAX))  
								  FROM #Temp g
								  FOR XMl PATH('')  
								),1,1,''  
							)  
							FROM #Temp t1 
							Where t1.[Primary Key]=1)
					+')'
					+' AS 
					   BEGIN
							SET NOCOUNT ON
							SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED   '
                    +'UPDATE a  WITH(ROWLOCK) SET  '					
					+ (SElect 		 
							STUFF  
							(  
								(  
								 SELECT  +', '+'a.'+ CAST(g.[Column Name]+'=@'+LOWER(LEFT(g.[Column Name],1))+(SUBSTRING(g.[Column Name],2,LEN(g.[Column Name]))) AS VARCHAR(MAX))  
								  FROM #Temp g
								  FOR XMl PATH('')  
								),1,1,''  
							)  
							FROM #Temp t1 
							Where t1.[Primary Key]=1)
					+'  FROM '+				
					+@tableName +' a'+' WITH(ROWLOCK) '
					+' WHERE a.'+a.[Column Name] +' = '+ '@'+LOWER(LEFT(a.[Column Name],1))+(SUBSTRING(a.[Column Name],2,LEN(a.[Column Name])))
					+'  END'
					AS 'UPDATE-PRO'

					,
					'CREATE procedure [dbo].['+'pr_'+LOWER(LEFT(a.[TableName],1))+(SUBSTRING(a.[TableName],2,LEN(a.[TableName])))+'_get]'
					+' AS '
					+' BEGIN '
					+ 'SET NOCOUNT ON
	                   SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED    '
					+'SELECT'
					+(SElect 	 
							STUFF  
							(  
								(  
								 SELECT  +', '+'a.'+ CAST(g.[Column Name] AS VARCHAR(MAX))  
								  FROM #Temp g
								  FOR XMl PATH('')  
								),1,1,''  
							)  
							FROM #Temp t1 
							Where t1.[Primary Key]=1)
					+' FROM '
					+@tableName + ' a '
					+' ORDER BY ' + ' a.' +a.[Column Name]+' ASC '
					+' END '
					AS 'GET-PRO'
					,
						'CREATE procedure [dbo].['+'pr_'+LOWER(LEFT(a.[TableName],1))+(SUBSTRING(a.[TableName],2,LEN(a.[TableName])))+'_get]'
					
					+' ( '
					+'@'+a.[Column Name] +'  '+a.[DDL name]+' =NULL'
					+' ) '
					+' AS '
					+' BEGIN '
					+ 'SET NOCOUNT ON
	                   SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED    '
					+'SELECT'
					+(SElect 	 
							STUFF  
							(  
								(  
								 SELECT  +', '+'a.'+ CAST(g.[Column Name] AS VARCHAR(MAX))  
								  FROM #Temp g
								  FOR XMl PATH('')  
								),1,1,''  
							)  
							FROM #Temp t1 
							Where t1.[Primary Key]=1)
					+' FROM '
					+@tableName + ' a '+
					' WHERE (@'+a.[Column Name]+' IS NULL OR a.'+a.[Column Name]+' = '+'@'+a.[Column Name]+' ) '
					+'AND a.Status =''Active'''
					+' ORDER BY ' + ' a.' +a.[Column Name]+' ASC '
					+' END '
					AS 'GET-AND-GETBY-PRO'
					,
							
					'CREATE procedure [dbo].['+'pr_'+LOWER(LEFT(a.[TableName],1))+(SUBSTRING(a.[TableName],2,LEN(a.[TableName])))+'_paging_wise_data_get]'
					
					+' ( '
					+' @page INT =1, '
					+' @page_size INT =10, '
					+' @searchtext NVARCHAR(500) = NULL '
					+' ) '
					+' AS '
					+' BEGIN '
					+ 'SET NOCOUNT ON
	                   SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED    '
					+'SELECT a.'+a.[Column Name]
					+' INTO #temp1'
					+' FROM '
					+@tableName + ' a '+
					' WHERE (@searchtext  IS NULL OR a.'+a.[Column Name]+' = '+'@searchtext ) '
					+' ORDER BY ' + ' a.' +a.[Column Name]+' ASC '
					+'--Get paging record'
					+' SELECT TOP(@page_size) a.'+a.[Column Name]
					+' INTO #Temp2 '
					+' FROM  '
					+' ( '
					+' SELECT row_id = ROW_NUMBER() OVER (ORDER BY '+a.[Column Name]+ ' DESC),'+a.[Column Name]
					+' FROM #temp1 '
					+' ) a '
					+' WHERE a.row_id > ((@page-1)*@page_size) '
					+' -- GET DATA '
					+' SELECT '
					+(SElect 	 
							STUFF  
							(  
								(  
								 SELECT  +', '+'a.'+ CAST(g.[Column Name] AS VARCHAR(MAX))  
								  FROM #Temp g
								  FOR XMl PATH('')  
								),1,1,''  
							)  
							FROM #Temp t1 
							Where t1.[Primary Key]=1)
					+' from  #Temp2 b '
					+'JOIN '+@tableName +' a ON a.'+a.[Column Name]+' = b.'+a.[Column Name]
					+' --Get total row '
					+' SELECT COUNT(*) AS total_row FROM #temp1 '
					+' END '
					AS 'GET-PAGING-WISE-DATA-GET-PRO'
					,

					'CREATE procedure [dbo].['+'pr_'+LOWER(LEFT(a.[TableName],1))+(SUBSTRING(a.[TableName],2,LEN(a.[TableName])))+'_get_list]'
					+' ( '
					+'  @tt_id tt_int READONLY  '
					+' ) '
					+' AS '
					+' BEGIN '
					+ 'SET NOCOUNT ON
	                   SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED	'
					+' CREATE TABLE  #' + LOWER(LEFT(a.[Column Name],1))+(SUBSTRING(a.[Column Name],2,LEN(a.[Column Name]))) + ' ('+LOWER(LEFT(a.[Column Name],1))+(SUBSTRING(a.[Column Name],2,LEN(a.[Column Name]))) +' INT )'
					+' INSERT INTO '+'#'+ LOWER(LEFT(a.[Column Name],1))+(SUBSTRING(a.[Column Name],2,LEN(a.[Column Name]))) + ' ('+LOWER(LEFT(a.[Column Name],1))+(SUBSTRING(a.[Column Name],2,LEN(a.[Column Name]))) +')'
					+'  SELECT  a.id'
	                 +  ' FROM @tt_id a  '
					+' SELECT '
					+(SElect TOP 1		 
							STUFF  
							(  
								(  
								 SELECT  +', '+'c.'+ CAST(g.[Column Name] AS VARCHAR(MAX))  
								  FROM #Temp g
								  FOR XMl PATH('')  
								),1,1,''  
							)  
							FROM #Temp t1 
							Where t1.[Primary Key]=1)
					+' FROM '
					+@tableName  + ' c '					
					+' JOIN '+
					+' #'+LOWER(LEFT(a.[Column Name],1))+(SUBSTRING(a.[Column Name],2,LEN(a.[Column Name])))+ ' a ' +'  ON '+'c.'+LOWER(LEFT(a.[Column Name],1))+(SUBSTRING(a.[Column Name],2,LEN(a.[Column Name]))) +'  = '+ 'a.'+LOWER(LEFT(a.[Column Name],1))+(SUBSTRING(a.[Column Name],2,LEN(a.[Column Name])))
					+' END '
					AS 'GET-LIST-PRO'

			   from #Temp a

	
END
GO
/****** Object:  StoredProcedure [dbo].[sp_delete_Order]    Script Date: 4/20/2024 10:49:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_delete_Order]
    @order_id INT,
    @Success INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        -- Check if the record exists
        IF EXISTS (SELECT 1 FROM [dbo].[Order] WHERE OrderId = @order_id)
        BEGIN
            -- If the record exists, delete it
            DELETE FROM [dbo].[Order] WHERE OrderId = @order_id;
			select @order_id=1;
            SET @Success = 1; -- Set success flag to 1
        END
        ELSE
        BEGIN
            -- Record not found, set success flag to 0
            SET @Success = 0;
        END
    END TRY
    BEGIN CATCH
         SET @Success = 0; -- Error occurred, set success flag to 0
    END CATCH
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_order]    Script Date: 4/20/2024 10:49:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_insert_order](
  @orderId BIGINT OUTPUT, 
  @orderKey uniqueidentifier=null,
  @productName NVARCHAR(100), 
  @categoryId BIGINT = NULL, 
  @orderDate DATETIME = NULL, 
  @isProductRecieve BIT = NULL,
  @EntryDateTime datetime,
  @EntryBy bigint,
  @Status varchar(10)=null 
) AS BEGIN 
      SET nocount ON
      SET TRANSACTION isolation level READ uncommitted

      INSERT INTO  [dbo].[Order]
      VALUES      (
	                NEWID(),  
                    @productName,
                    @categoryId,
                    @orderDate,
                    @isProductRecieve,
					@EntryDateTime,
					@EntryBy,
					'Active')

      SET @orderId = Scope_identity();
      SELECT @orderId orderId
  END 
GO
/****** Object:  StoredProcedure [dbo].[sp_order_getAll]    Script Date: 4/20/2024 10:49:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
 CREATE PROCEDURE [dbo].[sp_order_getAll](
 @OrderId bigint=null,
 @ProductName nvarchar(100)=null,
 @page INT = 1,
 @page_size INT =10
 )
AS
  BEGIN
      SET nocount ON
      SET TRANSACTION isolation level READ uncommitted

      DECLARE @offset BIGINT
      SET @offset = (@page - 1) * @page_size;

      SELECT a.OrderId,
	  a.OrderKey,
             a.ProductName,
             a.CategoryId,
             a.OrderDate,
             a.IsProductRecieve,
			 a.EntryDateTime,
			 a.EntryBy,
			 a.Status

      FROM   [dbo].[order] a
	  WHERE  (@orderId IS NULL OR a.orderId = @OrderId) and
	         (@ProductName IS NULL OR a.ProductName = @ProductName)
			 and a.Status='Active'
      ORDER  BY a.orderid Desc

	 OFFSET @offset ROWS FETCH NEXT @page_size ROWS ONLY;
  END 
  
 -- select * from  [dbo].[Order]
 
GO
/****** Object:  StoredProcedure [dbo].[sp_order_update]    Script Date: 4/20/2024 10:49:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[sp_order_update](
  @orderId BIGINT=0, 
  @orderKey uniqueidentifier=null,
  @productName NVARCHAR(100), 
  @categoryId BIGINT = NULL, 
  @orderDate DATETIME = NULL, 
  @isProductRecieve BIT = NULL,
  @entryDateTime datetime=null,
  @entryBy bigint=null,
  @status varchar(10)=null,
  @success INT OUTPUT
)AS
 BEGIN 
	SET 
	NOCOUNT ON 
	SET 
  TRANSACTION ISOLATION LEVEL READ UNCOMMITTED 
  BEGIN TRY
		UPDATE 
		a WITH(ROWLOCK) 
		SET 
		  a.ProductName = @productName, 
		  a.CategoryId = @categoryId, 
		  a.OrderDate = @orderDate, 
		  a.IsProductRecieve = @isProductRecieve,
		  a.Status=@status
		 FROM 
		  [dbo].[Order] a WITH(ROWLOCK) 
		  WHERE 
		  a.OrderId = @orderId 
		  SET @success = 1; -- Set success flag to 1
     END TRY
     BEGIN CATCH
         SET @success = 0; -- Error occurred, set success flag to 0
     END CATCH
  END

GO
/****** Object:  StoredProcedure [dbo].[Status_Setting_Get_SP]    Script Date: 4/20/2024 10:49:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

 create PROCEDURE [dbo].[Status_Setting_Get_SP](
 @StatusSettingId bigint=null,
 @StatusSettingKey nvarchar(40)=null,
 @StatusSettingName nvarchar(100),
 @PageName nvarchar(100),
 @Position int=NULL,
 @BranchId Int=null,
 @page_number INT = 1,
 @page_size INT =10
 )
AS
  BEGIN
      SET nocount ON
      SET TRANSACTION isolation level READ uncommitted

      DECLARE @offset BIGINT
      SET @offset = (@page_number - 1) * @page_size;

      SELECT a.[StatusSettingId]
      ,a.[StatusSettingKey]
      ,a.[BranchId]
      ,a.[StatusSettingName]
      ,a.[PageName]
      ,a.[Position]
      ,a.[EntryDateTime]
      ,a.[EntryBy]
      ,a.[LastModifyDate]
      ,a.[LastModifyBy]
      ,a.[DeletedDate]
      ,a.[DeletedBy]
      ,a.[Status]
	  
      FROM   [stt].[StatusSettings]  a
	  WHERE  (@StatusSettingId IS NULL OR a.StatusSettingId = @StatusSettingId) and
	         (@StatusSettingKey IS NULL OR a.StatusSettingKey = @StatusSettingKey) and
			 (@BranchId IS NULL OR a.BranchId = @BranchId) and
		     (@StatusSettingName IS NULL OR a.StatusSettingName = @StatusSettingName)and
			  (@PageName IS NULL OR a.PageName = @PageName) and
			    (@Position IS NULL OR a.Position = @Position)
			  
			 and a.Status='Active'
      ORDER  BY a.StatusSettingId Desc

	 OFFSET @offset ROWS FETCH NEXT @page_size ROWS ONLY;
  END 
  
 -- select * from  [stt].[StatusSettings]
 
GO
/****** Object:  StoredProcedure [dbo].[Status_Setting_Insert_SP]    Script Date: 4/20/2024 10:49:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

 create PROCEDURE [dbo].[Status_Setting_Insert_SP](
    @StatusSettingId BIGINT OUTPUT,
	@StatusSettingKey uniqueidentifier=NULL,
	@BranchId bigint,
	@StatusSettingName nvarchar(100),
	@PageName nvarchar(100),
	@Position int=NULL,
	@EntryDateTime datetime,
	@EntryBy bigint,
	@LastModifyDate datetime =NULL,
	@LastModifyBy bigint =NULL,
	@DeletedDate datetime =NULL,
	@DeletedBy bigint =NULL,
    @status VARCHAR(10) = 'Active'
) AS BEGIN 
      SET NOCOUNT ON;
      SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

		-- Check if @unitName already exists (case-insensitive, trimmed, and with white spaces replaced)
		IF EXISTS (
			SELECT 1
			FROM [stt].[StatusSettings]  
			WHERE
			BranchId=@branchId and
			LOWER(LTRIM(RTRIM(REPLACE([StatusSettingName], ' ', '')))) = LOWER(LTRIM(RTRIM(REPLACE(@StatusSettingName, ' ', ''))))
		)
		BEGIN
			-- If @unitName already exists, set @unitId to -1
			SET @StatusSettingId = -1;
		END
       ELSE
         BEGIN
			-- Insert new record
			INSERT INTO [stt].[StatusSettings] (
				[StatusSettingKey],
                [BranchId],
                [StatusSettingName],
                [PageName],
                [Position],
                [EntryDateTime],
                [EntryBy],
                [LastModifyDate],
                [LastModifyBy],
                [DeletedDate],
                [DeletedBy],
                [Status]
			) 
			VALUES (
				NEWID(),  
				@branchId,
				@StatusSettingName,
				@PageName,
		  	    @Position,
				
				@entryDateTime,
				@entryBy,
				@lastModifyDate,
				@lastModifyBy,
				@deletedDate,
				@deletedBy,
				@status
			);

			-- Get the unitId of the newly inserted record
			SET @StatusSettingId= SCOPE_IDENTITY();
		END

-- Return the @unitId value
SELECT @StatusSettingId AS unitId;
END;
GO
/****** Object:  StoredProcedure [dbo].[Status_Settings_Update_SP]    Script Date: 4/20/2024 10:49:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

 
create procedure [dbo].[Status_Settings_Update_SP](
    @StatusSettingId bigint,
	@StatusSettingKey uniqueidentifier=NULL,
	@BranchId bigint,
	@StatusSettingName nvarchar(100),
	@PageName nvarchar(100),
	@Position int=NULL,
	@EntryDateTime datetime,
	@EntryBy bigint,
	@LastModifyDate datetime =NULL,
	@LastModifyBy bigint =NULL,
	@DeletedDate datetime =NULL,
	@DeletedBy bigint =NULL,
	@Status varchar(10) =NULL,
    @success INT OUTPUT
)AS
 BEGIN 
	SET 
	NOCOUNT ON 
	SET 
  TRANSACTION ISOLATION LEVEL READ UNCOMMITTED 
  BEGIN TRY
		UPDATE 
		a WITH(ROWLOCK) 
		SET 
		  [BranchId] = @BranchId,
          [StatusSettingName] =@StatusSettingName,
		  [PageName ] = @PageName,
		  [Position ] = COALESCE(@Position  , [Position ]),
          [LastModifyDate] = COALESCE(@lastModifyDate, [LastModifyDate]),
          [LastModifyBy] = COALESCE(@lastModifyBy, [LastModifyBy]),
          [DeletedDate] = COALESCE(@deletedDate, [DeletedDate]),
          [DeletedBy] = COALESCE(@deletedBy, [DeletedBy]),
          [Status] = COALESCE(@status, [Status])
		 FROM 
		  [stt].[StatusSettings] a WITH(ROWLOCK) 
		  WHERE 
		  a.StatusSettingId = @StatusSettingId

		  SET @success = 1; -- Set success flag to 1
     END TRY
     BEGIN CATCH
         SET @success = 0; -- Error occurred, set success flag to 0
     END CATCH
  END

 --select *   FROM [stt].[Units]

GO
/****** Object:  StoredProcedure [dbo].[Unit_Get_SP]    Script Date: 4/20/2024 10:49:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

 CREATE PROCEDURE [dbo].[Unit_Get_SP](
 @UnitId bigint=null,
 @UnitKey nvarchar(40)=null,
 @UnitName nvarchar(100)=null,
 @BranchId Int=null,
 @page_number INT = 1,
 @page_size INT =10
 )
AS
  BEGIN
      SET nocount ON
      SET TRANSACTION isolation level READ uncommitted

      DECLARE @offset BIGINT
      SET @offset = (@page_number - 1) * @page_size;

      SELECT a.[UnitId]
      ,a.[UnitKey]
      ,a.[BranchId]
      ,a.[UnitName]
      ,a.[EntryDateTime]
      ,a.[EntryBy]
      ,a.[LastModifyDate]
      ,a.[LastModifyBy]
      ,a.[DeletedDate]
      ,a.[DeletedBy]
      ,a.[Status]
	  
      FROM   [invnt].[Units] a
	  WHERE  (@UnitId IS NULL OR a.UnitId = @UnitId) and
	         (@UnitKey IS NULL OR a.UnitKey = @UnitKey) and
			 (@BranchId IS NULL OR a.BranchId = @BranchId) and
		     (@UnitName IS NULL OR a.UnitName = @UnitName)  
			 and a.Status='Active'
      ORDER  BY a.UnitId Desc

	 OFFSET @offset ROWS FETCH NEXT @page_size ROWS ONLY;
  END 
  
 -- select * from  [invnt].[Units]
 
GO
/****** Object:  StoredProcedure [dbo].[Unit_Insert_SP]    Script Date: 4/20/2024 10:49:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 CREATE PROCEDURE [dbo].[Unit_Insert_SP](
  @unitId BIGINT OUTPUT, 
  @unitKey uniqueidentifier=null,
  @branchId BIGINT = NULL,
  @unitName NVARCHAR(100), 
  @entryDateTime DATETIME,
  @entryBy BIGINT,
  @lastModifyDate DATETIME = NULL,
  @lastModifyBy BIGINT = NULL,
  @deletedDate DATETIME = NULL,
  @deletedBy BIGINT = NULL,
  @status VARCHAR(10) = 'Active'
) AS BEGIN 
      SET NOCOUNT ON;
      SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

		-- Check if @unitName already exists (case-insensitive, trimmed, and with white spaces replaced)
		IF EXISTS (
			SELECT 1
			FROM [invnt].[Units]  
			WHERE
			Status='Active' and
			BranchId=@branchId and
			LOWER(LTRIM(RTRIM(REPLACE([UnitName], ' ', '')))) = LOWER(LTRIM(RTRIM(REPLACE(@unitName, ' ', ''))))
		)
		BEGIN
			-- If @unitName already exists, set @unitId to -1
			SET @unitId = -1;
		END
       ELSE
         BEGIN
			-- Insert new record
			INSERT INTO [invnt].[Units] (
				[UnitKey],  
				[BranchId],
				[UnitName],
				[EntryDateTime],
				[EntryBy],
				[LastModifyDate],
				[LastModifyBy],
				[DeletedDate],
				[DeletedBy],
				[Status]
			) 
			VALUES (
				NEWID(),  
				@branchId,
				@unitName,
				@entryDateTime,
				@entryBy,
				@lastModifyDate,
				@lastModifyBy,
				@deletedDate,
				@deletedBy,
				@status
			);

			-- Get the unitId of the newly inserted record
			SET @unitId = SCOPE_IDENTITY();
		END

-- Return the @unitId value
SELECT @unitId AS unitId;
END;

select * from [invnt]. Units
GO
/****** Object:  StoredProcedure [dbo].[Unit_Update_SP]    Script Date: 4/20/2024 10:49:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
CREATE procedure [dbo].[Unit_Update_SP](
  @unitId BIGINT, 
  @unitKey uniqueidentifier=null,
  @branchId BIGINT = NULL,
  @unitName NVARCHAR(100), 
  @entryDateTime DATETIME=Null,
  @entryBy BIGINT=Null,
  @lastModifyDate DATETIME = NULL,
  @lastModifyBy BIGINT = NULL,
  @deletedDate DATETIME = NULL,
  @deletedBy BIGINT = NULL,
  @status VARCHAR(10) =null,
  @success INT OUTPUT
)AS
 BEGIN 
	SET 
	NOCOUNT ON 
	SET 
  TRANSACTION ISOLATION LEVEL READ UNCOMMITTED 
  BEGIN TRY
		UPDATE 
		a WITH(ROWLOCK) 
		SET 
		  [BranchId] = COALESCE(@branchId, [BranchId]),
          [UnitName] = COALESCE(@unitName, [UnitName]),
          [LastModifyDate] = COALESCE(@lastModifyDate, [LastModifyDate]),
          [LastModifyBy] = COALESCE(@lastModifyBy, [LastModifyBy]),
          [DeletedDate] = COALESCE(@deletedDate, [DeletedDate]),
          [DeletedBy] = COALESCE(@deletedBy, [DeletedBy]),
          [Status] = COALESCE(@status, [Status])
		 FROM 
		  [invnt].[Units] a WITH(ROWLOCK) 
		  WHERE 
		  a.UnitId = @unitId 

		  SET @success = 1; -- Set success flag to 1
     END TRY
     BEGIN CATCH
         SET @success = 0; -- Error occurred, set success flag to 0
     END CATCH
  END

 --select *   FROM [invnt].[Units]

GO
/****** Object:  StoredProcedure [dbo].[UpdateProduct]    Script Date: 4/20/2024 10:49:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 CREATE PROCEDURE [dbo].[UpdateProduct]
    @Id INT,
    @Name NVARCHAR(255),
    @Price DECIMAL(18, 2)
AS
BEGIN
    UPDATE Products
    SET Name = @Name, Price = @Price
    WHERE Id = @Id;
END;
GO
/****** Object:  StoredProcedure [tst].[Meeting_Minutes _Details_Save_SP]    Script Date: 4/20/2024 10:49:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [tst].[Meeting_Minutes _Details_Save_SP](
@meetng_Mnts_Dtls_ID INT,
@fk_Srvc_Id          INT,
@quantity            DECIMAL(10, 0),
@unit                NVARCHAR(50) = NULL)
AS
  BEGIN
      SET nocount ON
      SET TRANSACTION isolation level READ uncommitted

      IF ( @meetng_Mnts_Dtls_ID = 0 )
        BEGIN
            INSERT INTO tst.meeting_minutes_details_tb
            VALUES      (  
                          @fk_Srvc_Id,
                          @quantity,
                          @unit )

            SET @meetng_Mnts_Dtls_ID = Scope_identity();

            SELECT @meetng_Mnts_Dtls_ID meetng_Mnts_Dtls_ID
        END
      ELSE
        BEGIN
            UPDATE a WITH(rowlock)
            SET   
                   a.fk_srvc_id = @fk_Srvc_Id,
                   a.quantity = @quantity,
                   a.unit = @unit
            FROM   tst.meeting_minutes_details_tb a WITH(rowlock)
            WHERE  a.meetng_mnts_dtls_id = @meetng_Mnts_Dtls_ID
        END
  END 
GO
/****** Object:  StoredProcedure [tst].[Meeting_Minutes_Master_Save_SP]    Script Date: 4/20/2024 10:49:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 CREATE PROCEDURE [tst].[Meeting_Minutes_Master_Save_SP](
@meetng_Mnts_Mstr_Id INT,
@is_Corporate_Mettng BIT = NULL,
@fk_Custmr_Id        INT,
@meetng_Agenda       NVARCHAR(max),
@meetng_Dt           DATETIME = NULL,
@time                TIME = NULL,
@metng_Plc           NVARCHAR(250),
@metng_Discssn       NVARCHAR(300),
@attnd_frm_Clnt_Side NVARCHAR(300),
@meetng_Dcssn        NVARCHAR(300),
@attnd_frm_Host_Side NVARCHAR(300),
@status              VARCHAR(50),
@entry_Date_Time     DATETIME)
AS
  BEGIN
      SET nocount ON
      SET TRANSACTION isolation level READ uncommitted

      IF ( @meetng_Mnts_Mstr_Id = 0 )
        BEGIN
            INSERT INTO tst.meeting_minutes_master_tbl
            VALUES      ( 
                          @is_Corporate_Mettng,
                          @fk_Custmr_Id,
                          @meetng_Agenda,
                          @meetng_Dt,
                          @time,
                          @metng_Plc,
                          @metng_Discssn,
                          @attnd_frm_Clnt_Side,
                          @meetng_Dcssn,
                          @attnd_frm_Host_Side,
                          @status,
                          @entry_Date_Time )

            SET @meetng_Mnts_Mstr_Id = Scope_identity();

            SELECT @meetng_Mnts_Mstr_Id meetng_Mnts_Mstr_Id
        END
      ELSE
        BEGIN
            UPDATE a WITH(rowlock)
            SET     
                   a.is_corporate_mettng = @is_Corporate_Mettng,
                   a.fk_custmr_id = @fk_Custmr_Id,
                   a.meetng_agenda = @meetng_Agenda,
                   a.meetng_dt = @meetng_Dt,
                   a.time = @time,
                   a.metng_plc = @metng_Plc,
                   a.metng_discssn = @metng_Discssn,
                   a.attnd_frm_clnt_side = @attnd_frm_Clnt_Side,
                   a.meetng_dcssn = @meetng_Dcssn,
                   a.attnd_frm_host_side = @attnd_frm_Host_Side,
                   a.status = @status,
                   a.entry_date_time = @entry_Date_Time
            FROM   tst.meeting_minutes_master_tbl a WITH(rowlock)
            WHERE  a.meetng_mnts_mstr_id = @meetng_Mnts_Mstr_Id
        END
  END 
GO
