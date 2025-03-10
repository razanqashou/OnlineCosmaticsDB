USE [master]
GO
/****** Object:  Database [Online Cosmatics Store]    Script Date: 01/03/2025 11:21:24 PM ******/
CREATE DATABASE [Online Cosmatics Store]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Online Cosmatics Store', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS13\MSSQL\DATA\Online Cosmatics Store.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Online Cosmatics Store_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS13\MSSQL\DATA\Online Cosmatics Store_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [Online Cosmatics Store] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Online Cosmatics Store].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Online Cosmatics Store] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Online Cosmatics Store] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Online Cosmatics Store] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Online Cosmatics Store] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Online Cosmatics Store] SET ARITHABORT OFF 
GO
ALTER DATABASE [Online Cosmatics Store] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Online Cosmatics Store] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Online Cosmatics Store] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Online Cosmatics Store] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Online Cosmatics Store] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Online Cosmatics Store] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Online Cosmatics Store] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Online Cosmatics Store] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Online Cosmatics Store] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Online Cosmatics Store] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Online Cosmatics Store] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Online Cosmatics Store] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Online Cosmatics Store] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Online Cosmatics Store] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Online Cosmatics Store] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Online Cosmatics Store] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Online Cosmatics Store] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Online Cosmatics Store] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Online Cosmatics Store] SET  MULTI_USER 
GO
ALTER DATABASE [Online Cosmatics Store] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Online Cosmatics Store] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Online Cosmatics Store] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Online Cosmatics Store] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Online Cosmatics Store] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Online Cosmatics Store] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [Online Cosmatics Store] SET QUERY_STORE = OFF
GO
USE [Online Cosmatics Store]
GO
/****** Object:  Table [dbo].[item]    Script Date: 01/03/2025 11:21:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[item](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[categoryId] [int] NULL,
	[brandId] [int] NULL,
	[itemName] [varchar](30) NOT NULL,
	[cost] [float] NOT NULL,
	[quantity] [float] NOT NULL,
	[image] [varchar](max) NOT NULL,
	[description] [varchar](50) NULL,
	[discount] [float] NULL,
	[discountFlag] [bit] NULL,
	[Rate] [float] NULL,
	[createBy] [varchar](30) NULL,
	[updateBy] [varchar](30) NULL,
	[createDate] [datetime] NULL,
	[updateDate] [datetime] NULL,
	[isActive] [bit] NULL,
	[Price]  AS ([Cost]-[Discount]),
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LookupValue]    Script Date: 01/03/2025 11:21:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LookupValue](
	[Id] [int] NOT NULL,
	[TypeId] [int] NULL,
	[Name] [nchar](10) NOT NULL,
 CONSTRAINT [PK_LookupValue_1] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[AvailableItems]    Script Date: 01/03/2025 11:21:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[AvailableItems] AS
select i.itemName ,i.price,i.discount,(Lv.Name) As CategoryName ,(LB.Name)AS BrandName  from item As i 
Join LookupValue as LV on i.categoryId=Lv.Id 
Join LookupValue as LB on i.brandId=LB.Id 
where i.discountFlag=1
GO
/****** Object:  Table [dbo].[Order]    Script Date: 01/03/2025 11:21:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Order](
	[OrderId] [int] IDENTITY(1,1) NOT NULL,
	[CustomerId] [int] NULL,
	[TotalAmount] [float] NOT NULL,
	[StatusId] [int] NULL,
	[CreateBy] [varchar](30) NULL,
	[UpdateBy] [varchar](30) NULL,
	[CreateDate] [datetime] NULL,
	[UpdateDate] [datetime] NULL,
	[IsActive] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[OrderId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[SalesSummary]    Script Date: 01/03/2025 11:21:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[SalesSummary] AS
SELECT  
    FORMAT(o.CreateDate, 'yyyy-MM') AS SalesMonth,  
    COUNT(o.OrderId) AS TotalOrders,              
    SUM(o.TotalAmount) AS TotalRevenue             
FROM [Order] AS o 
GROUP BY FORMAT(o.CreateDate, 'yyyy-MM')  
GO
/****** Object:  Table [dbo].[wishlist]    Script Date: 01/03/2025 11:21:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[wishlist](
	[wishid] [int] IDENTITY(1,1) NOT NULL,
	[customerid] [int] NOT NULL,
	[itemid] [int] NOT NULL,
	[quantity] [int] NOT NULL,
	[createDate] [datetime] NULL,
	[isActive] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[wishid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[CustomerWishlist]    Script Date: 01/03/2025 11:21:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[CustomerWishlist] AS
SELECT  w.quantity, i.itemName , i.cost, i.discount , i.price as [price after discount] FROM wishlist AS w
join item  as i on  w.itemid=i.id
  
GO
/****** Object:  Table [dbo].[ingredient]    Script Date: 01/03/2025 11:21:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ingredient](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](50) NOT NULL,
	[quantity] [float] NOT NULL,
	[createBy] [varchar](30) NULL,
	[updateBy] [varchar](30) NULL,
	[createDate] [datetime] NULL,
	[updateDate] [datetime] NULL,
	[isActive] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[item_ingredient]    Script Date: 01/03/2025 11:21:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[item_ingredient](
	[itemId] [int] NOT NULL,
	[ingredientId] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[itemId] ASC,
	[ingredientId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ItemRequest]    Script Date: 01/03/2025 11:21:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ItemRequest](
	[ReqId] [int] IDENTITY(1,1) NOT NULL,
	[CustomerId] [int] NULL,
	[QuantityRequested] [int] NOT NULL,
	[ProductName] [varchar](50) NOT NULL,
	[Description] [varchar](255) NULL,
	[CreateBy] [varchar](30) NULL,
	[UpdateBy] [varchar](30) NULL,
	[CreateDate] [datetime] NULL,
	[UpdateDate] [datetime] NULL,
	[IsActive] [bit] NULL,
	[StatusId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ReqId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LookupType]    Script Date: 01/03/2025 11:21:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LookupType](
	[id] [int] NOT NULL,
	[Type] [nchar](10) NULL,
	[CreateBy] [nchar](10) NULL,
	[updateBy] [nchar](10) NULL,
	[createDate] [datetime] NULL,
	[updateDate] [datetime] NULL,
	[isActive] [bit] NULL,
 CONSTRAINT [PK_LookupType_1] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderItem]    Script Date: 01/03/2025 11:21:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderItem](
	[OrderItemId] [int] IDENTITY(1,1) NOT NULL,
	[OrderId] [int] NULL,
	[ItemId] [int] NULL,
	[Quantity] [int] NOT NULL,
	[ItemPrice] [float] NOT NULL,
	[DiscountAmount] [float] NULL,
	[Rate] [float] NULL,
	[CreateBy] [varchar](30) NULL,
	[UpdateBy] [varchar](30) NULL,
	[CreateDate] [datetime] NULL,
	[UpdateDate] [datetime] NULL,
	[IsActive] [bit] NULL,
	[Subtota]  AS ([Quantity]*[ItemPrice]-[DiscountAmount]),
 CONSTRAINT [PK__OrderIte__57ED06818D43C90D] PRIMARY KEY CLUSTERED 
(
	[OrderItemId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[person]    Script Date: 01/03/2025 11:21:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[person](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[firstName] [varchar](30) NOT NULL,
	[lastName] [varchar](30) NOT NULL,
	[ProfileImage] [varchar](max) NULL,
	[email] [varchar](50) NOT NULL,
	[phoneNumber] [varchar](10) NOT NULL,
	[createBy] [varchar](30) NULL,
	[updateBy] [varchar](30) NULL,
	[createDate] [datetime] NULL,
	[updateDate] [datetime] NULL,
	[isActive] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[ingredient] ON 

INSERT [dbo].[ingredient] ([id], [name], [quantity], [createBy], [updateBy], [createDate], [updateDate], [isActive]) VALUES (1, N'Shea Butter', 100, N'admin', N'admin', CAST(N'2025-02-28T02:04:18.133' AS DateTime), CAST(N'2025-02-28T02:04:18.133' AS DateTime), 1)
INSERT [dbo].[ingredient] ([id], [name], [quantity], [createBy], [updateBy], [createDate], [updateDate], [isActive]) VALUES (2, N'Hyaluronic Acid', 50, N'admin', N'admin', CAST(N'2025-02-28T02:04:18.133' AS DateTime), CAST(N'2025-02-28T02:04:18.133' AS DateTime), 1)
INSERT [dbo].[ingredient] ([id], [name], [quantity], [createBy], [updateBy], [createDate], [updateDate], [isActive]) VALUES (3, N'Vitamin C', 75, N'admin', N'admin', CAST(N'2025-02-28T02:04:18.133' AS DateTime), CAST(N'2025-02-28T02:04:18.133' AS DateTime), 1)
INSERT [dbo].[ingredient] ([id], [name], [quantity], [createBy], [updateBy], [createDate], [updateDate], [isActive]) VALUES (4, N'Jojoba Oil', 60, N'admin', N'admin', CAST(N'2025-02-28T02:04:18.133' AS DateTime), CAST(N'2025-02-28T02:04:18.133' AS DateTime), 1)
INSERT [dbo].[ingredient] ([id], [name], [quantity], [createBy], [updateBy], [createDate], [updateDate], [isActive]) VALUES (5, N'Aloe Vera', 80, N'admin', N'admin', CAST(N'2025-02-28T02:04:18.133' AS DateTime), CAST(N'2025-02-28T02:04:18.133' AS DateTime), 1)
INSERT [dbo].[ingredient] ([id], [name], [quantity], [createBy], [updateBy], [createDate], [updateDate], [isActive]) VALUES (6, N'Essential Oils', 90, N'admin', N'admin', CAST(N'2025-02-28T02:04:18.133' AS DateTime), CAST(N'2025-02-28T02:04:18.133' AS DateTime), 1)
INSERT [dbo].[ingredient] ([id], [name], [quantity], [createBy], [updateBy], [createDate], [updateDate], [isActive]) VALUES (7, N'Coconut Oil', 70, N'admin', N'admin', CAST(N'2025-02-28T02:04:18.133' AS DateTime), CAST(N'2025-02-28T02:04:18.133' AS DateTime), 1)
INSERT [dbo].[ingredient] ([id], [name], [quantity], [createBy], [updateBy], [createDate], [updateDate], [isActive]) VALUES (8, N'Glycerin', 85, N'admin', N'admin', CAST(N'2025-02-28T02:04:18.133' AS DateTime), CAST(N'2025-02-28T02:04:18.133' AS DateTime), 1)
INSERT [dbo].[ingredient] ([id], [name], [quantity], [createBy], [updateBy], [createDate], [updateDate], [isActive]) VALUES (9, N'Green Tea Extract', 65, N'admin', N'admin', CAST(N'2025-02-28T02:04:18.133' AS DateTime), CAST(N'2025-02-28T02:04:18.133' AS DateTime), 1)
INSERT [dbo].[ingredient] ([id], [name], [quantity], [createBy], [updateBy], [createDate], [updateDate], [isActive]) VALUES (10, N'Collagen', 55, N'admin', N'admin', CAST(N'2025-02-28T02:04:18.133' AS DateTime), CAST(N'2025-02-28T02:04:18.133' AS DateTime), 1)
INSERT [dbo].[ingredient] ([id], [name], [quantity], [createBy], [updateBy], [createDate], [updateDate], [isActive]) VALUES (11, N'Vitamin E', 10.5, N'admin', N'admin', CAST(N'2025-02-28T23:50:22.567' AS DateTime), CAST(N'2025-02-28T23:50:22.567' AS DateTime), 1)
INSERT [dbo].[ingredient] ([id], [name], [quantity], [createBy], [updateBy], [createDate], [updateDate], [isActive]) VALUES (12, N'Aloe Vera Extract', 15.2, N'admin', N'admin', CAST(N'2025-02-28T23:50:22.567' AS DateTime), CAST(N'2025-02-28T23:50:22.567' AS DateTime), 1)
INSERT [dbo].[ingredient] ([id], [name], [quantity], [createBy], [updateBy], [createDate], [updateDate], [isActive]) VALUES (13, N'Shea Butter', 8.3, N'admin', N'admin', CAST(N'2025-02-28T23:50:22.567' AS DateTime), CAST(N'2025-02-28T23:50:22.567' AS DateTime), 1)
INSERT [dbo].[ingredient] ([id], [name], [quantity], [createBy], [updateBy], [createDate], [updateDate], [isActive]) VALUES (14, N'Coconut Oil', 12, N'admin', N'admin', CAST(N'2025-02-28T23:50:22.567' AS DateTime), CAST(N'2025-02-28T23:50:22.567' AS DateTime), 1)
INSERT [dbo].[ingredient] ([id], [name], [quantity], [createBy], [updateBy], [createDate], [updateDate], [isActive]) VALUES (15, N'Hyaluronic Acid', 5.7, N'admin', N'admin', CAST(N'2025-02-28T23:50:22.567' AS DateTime), CAST(N'2025-02-28T23:50:22.567' AS DateTime), 1)
INSERT [dbo].[ingredient] ([id], [name], [quantity], [createBy], [updateBy], [createDate], [updateDate], [isActive]) VALUES (16, N'Argan Oil', 9.1, N'admin', N'admin', CAST(N'2025-02-28T23:50:22.567' AS DateTime), CAST(N'2025-02-28T23:50:22.567' AS DateTime), 1)
INSERT [dbo].[ingredient] ([id], [name], [quantity], [createBy], [updateBy], [createDate], [updateDate], [isActive]) VALUES (17, N'Rose Extract', 11.6, N'admin', N'admin', CAST(N'2025-02-28T23:50:22.567' AS DateTime), CAST(N'2025-02-28T23:50:22.567' AS DateTime), 1)
INSERT [dbo].[ingredient] ([id], [name], [quantity], [createBy], [updateBy], [createDate], [updateDate], [isActive]) VALUES (18, N'Green Tea Extract', 13.4, N'admin', N'admin', CAST(N'2025-02-28T23:50:22.567' AS DateTime), CAST(N'2025-02-28T23:50:22.567' AS DateTime), 1)
INSERT [dbo].[ingredient] ([id], [name], [quantity], [createBy], [updateBy], [createDate], [updateDate], [isActive]) VALUES (19, N'Charcoal Powder', 6.9, N'admin', N'admin', CAST(N'2025-02-28T23:50:22.567' AS DateTime), CAST(N'2025-02-28T23:50:22.567' AS DateTime), 1)
INSERT [dbo].[ingredient] ([id], [name], [quantity], [createBy], [updateBy], [createDate], [updateDate], [isActive]) VALUES (20, N'Jojoba Oil', 7.5, N'admin', N'admin', CAST(N'2025-02-28T23:50:22.567' AS DateTime), CAST(N'2025-02-28T23:50:22.567' AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[ingredient] OFF
GO
SET IDENTITY_INSERT [dbo].[item] ON 

INSERT [dbo].[item] ([id], [categoryId], [brandId], [itemName], [cost], [quantity], [image], [description], [discount], [discountFlag], [Rate], [createBy], [updateBy], [createDate], [updateDate], [isActive]) VALUES (1, 20001, 30001, N'Lipstick Matte', 5, 26, N'lipstick.jpg', N'Long-lasting matte lipstick', 2, 1, 4.5, N'admin', N'admin', CAST(N'2025-02-28T01:53:39.593' AS DateTime), CAST(N'2025-02-28T01:53:39.593' AS DateTime), 1)
INSERT [dbo].[item] ([id], [categoryId], [brandId], [itemName], [cost], [quantity], [image], [description], [discount], [discountFlag], [Rate], [createBy], [updateBy], [createDate], [updateDate], [isActive]) VALUES (2, 20001, 30002, N'Foundation', 8.5, 37, N'foundation.jpg', N'Full coverage foundation', 3, 1, 4.8, N'admin', N'admin', CAST(N'2025-02-28T01:53:39.593' AS DateTime), CAST(N'2025-02-28T01:53:39.593' AS DateTime), 1)
INSERT [dbo].[item] ([id], [categoryId], [brandId], [itemName], [cost], [quantity], [image], [description], [discount], [discountFlag], [Rate], [createBy], [updateBy], [createDate], [updateDate], [isActive]) VALUES (3, 20001, 30003, N'Eyeliner', 3, 60, N'eyeliner.jpg', N'Waterproof black eyeliner', 1.5, 1, 4.7, N'admin', N'admin', CAST(N'2025-02-28T01:53:39.593' AS DateTime), CAST(N'2025-02-28T01:53:39.593' AS DateTime), 1)
INSERT [dbo].[item] ([id], [categoryId], [brandId], [itemName], [cost], [quantity], [image], [description], [discount], [discountFlag], [Rate], [createBy], [updateBy], [createDate], [updateDate], [isActive]) VALUES (4, 20002, 30001, N'Face Cleanser', 4, 60, N'cleanser.jpg', N'Deep cleansing facial wash', 1, 1, 4.9, N'admin', N'admin', CAST(N'2025-02-28T01:53:39.593' AS DateTime), CAST(N'2025-02-28T01:53:39.593' AS DateTime), 1)
INSERT [dbo].[item] ([id], [categoryId], [brandId], [itemName], [cost], [quantity], [image], [description], [discount], [discountFlag], [Rate], [createBy], [updateBy], [createDate], [updateDate], [isActive]) VALUES (5, 20002, 30002, N'Moisturizer', 6, 50, N'moisturizer.jpg', N'Hydrating face cream', 2.5, 0, 4.6, N'admin', N'admin', CAST(N'2025-02-28T01:53:39.593' AS DateTime), CAST(N'2025-02-28T01:53:39.593' AS DateTime), 1)
INSERT [dbo].[item] ([id], [categoryId], [brandId], [itemName], [cost], [quantity], [image], [description], [discount], [discountFlag], [Rate], [createBy], [updateBy], [createDate], [updateDate], [isActive]) VALUES (6, 20002, 30003, N'Sunscreen SPF50', 5.5, 55, N'sunscreen.jpg', N'Protects skin from UV rays', 2, 1, 4.8, N'admin', N'admin', CAST(N'2025-02-28T01:53:39.593' AS DateTime), CAST(N'2025-02-28T01:53:39.593' AS DateTime), 1)
INSERT [dbo].[item] ([id], [categoryId], [brandId], [itemName], [cost], [quantity], [image], [description], [discount], [discountFlag], [Rate], [createBy], [updateBy], [createDate], [updateDate], [isActive]) VALUES (7, 20003, 30001, N'Floral Perfume', 10, 30, N'floral_perfume.jpg', N'Sweet floral fragrance', 5, 1, NULL, N'admin', N'admin', CAST(N'2025-02-28T01:53:39.593' AS DateTime), CAST(N'2025-02-28T01:53:39.593' AS DateTime), 1)
INSERT [dbo].[item] ([id], [categoryId], [brandId], [itemName], [cost], [quantity], [image], [description], [discount], [discountFlag], [Rate], [createBy], [updateBy], [createDate], [updateDate], [isActive]) VALUES (8, 20003, 30002, N'Woody Perfume', 12, 25, N'woody_perfume.jpg', N'Rich woody scent', 6, 1, NULL, N'admin', N'admin', CAST(N'2025-02-28T01:53:39.593' AS DateTime), CAST(N'2025-02-28T01:53:39.593' AS DateTime), 1)
INSERT [dbo].[item] ([id], [categoryId], [brandId], [itemName], [cost], [quantity], [image], [description], [discount], [discountFlag], [Rate], [createBy], [updateBy], [createDate], [updateDate], [isActive]) VALUES (9, 20003, 30003, N'Citrus Perfume', 9.5, 35, N'citrus_perfume.jpg', N'Fresh citrus aroma', 4, 1, NULL, N'admin', N'admin', CAST(N'2025-02-28T01:53:39.593' AS DateTime), CAST(N'2025-02-28T01:53:39.593' AS DateTime), 1)
INSERT [dbo].[item] ([id], [categoryId], [brandId], [itemName], [cost], [quantity], [image], [description], [discount], [discountFlag], [Rate], [createBy], [updateBy], [createDate], [updateDate], [isActive]) VALUES (10, 20001, 30002, N'Compact Powder', 7, 42, N'powder.jpg', N'Oil-control face powder', 2.5, 1, NULL, N'admin', N'admin', CAST(N'2025-02-28T01:53:39.593' AS DateTime), CAST(N'2025-02-28T01:53:39.593' AS DateTime), 1)
INSERT [dbo].[item] ([id], [categoryId], [brandId], [itemName], [cost], [quantity], [image], [description], [discount], [discountFlag], [Rate], [createBy], [updateBy], [createDate], [updateDate], [isActive]) VALUES (11, 20001, 30002, N'BB Cream', 6.5, 50, N'bb_cream.jpg', N'Lightweight BB cream for daily use', 2, 0, NULL, N'admin', N'admin', CAST(N'2025-02-28T23:44:36.787' AS DateTime), CAST(N'2025-02-28T23:44:36.787' AS DateTime), 1)
INSERT [dbo].[item] ([id], [categoryId], [brandId], [itemName], [cost], [quantity], [image], [description], [discount], [discountFlag], [Rate], [createBy], [updateBy], [createDate], [updateDate], [isActive]) VALUES (12, 20002, 30001, N'Hydrating Serum', 8, 40, N'serum.jpg', N'Intensive hydration for glowing skin', 3, 0, NULL, N'admin', N'admin', CAST(N'2025-02-28T23:44:36.787' AS DateTime), CAST(N'2025-02-28T23:44:36.787' AS DateTime), 1)
INSERT [dbo].[item] ([id], [categoryId], [brandId], [itemName], [cost], [quantity], [image], [description], [discount], [discountFlag], [Rate], [createBy], [updateBy], [createDate], [updateDate], [isActive]) VALUES (13, 20003, 30001, N'Vanilla Perfume', 11, 35, N'vanilla_perfume.jpg', N'Warm vanilla fragrance', 5, 1, NULL, N'admin', N'admin', CAST(N'2025-02-28T23:44:36.787' AS DateTime), CAST(N'2025-02-28T23:44:36.787' AS DateTime), 1)
INSERT [dbo].[item] ([id], [categoryId], [brandId], [itemName], [cost], [quantity], [image], [description], [discount], [discountFlag], [Rate], [createBy], [updateBy], [createDate], [updateDate], [isActive]) VALUES (14, 20001, 30002, N'Blush Palette', 5, 55, N'blush_palette.jpg', N'Diverse shades for perfect cheeks', 1.5, 1, NULL, N'admin', N'admin', CAST(N'2025-02-28T23:44:36.787' AS DateTime), CAST(N'2025-02-28T23:44:36.787' AS DateTime), 1)
INSERT [dbo].[item] ([id], [categoryId], [brandId], [itemName], [cost], [quantity], [image], [description], [discount], [discountFlag], [Rate], [createBy], [updateBy], [createDate], [updateDate], [isActive]) VALUES (15, 20002, 30003, N'Face Mask', 3, 65, N'face_mask.jpg', N'Revitalizing face mask with natural extracts', 0, 0, NULL, N'admin', N'admin', CAST(N'2025-02-28T23:44:36.787' AS DateTime), CAST(N'2025-02-28T23:44:36.787' AS DateTime), 1)
INSERT [dbo].[item] ([id], [categoryId], [brandId], [itemName], [cost], [quantity], [image], [description], [discount], [discountFlag], [Rate], [createBy], [updateBy], [createDate], [updateDate], [isActive]) VALUES (16, 20003, 30003, N'Rose Perfume', 10, 30, N'rose_perfume.jpg', N'Elegant rose-scented perfume', 4, 1, NULL, N'admin', N'admin', CAST(N'2025-02-28T23:44:36.787' AS DateTime), CAST(N'2025-02-28T23:44:36.787' AS DateTime), 1)
INSERT [dbo].[item] ([id], [categoryId], [brandId], [itemName], [cost], [quantity], [image], [description], [discount], [discountFlag], [Rate], [createBy], [updateBy], [createDate], [updateDate], [isActive]) VALUES (17, 20001, 30002, N'Concealer', 6, 50, N'concealer.jpg', N'Full coverage concealer', 2, 1, NULL, N'admin', N'admin', CAST(N'2025-02-28T23:44:36.787' AS DateTime), CAST(N'2025-02-28T23:44:36.787' AS DateTime), 1)
INSERT [dbo].[item] ([id], [categoryId], [brandId], [itemName], [cost], [quantity], [image], [description], [discount], [discountFlag], [Rate], [createBy], [updateBy], [createDate], [updateDate], [isActive]) VALUES (18, 20002, 30001, N'Exfoliating Scrub', 7, 45, N'scrub.jpg', N'Deep cleansing exfoliating scrub', 2.5, 1, NULL, N'admin', N'admin', CAST(N'2025-02-28T23:44:36.787' AS DateTime), CAST(N'2025-02-28T23:44:36.787' AS DateTime), 1)
INSERT [dbo].[item] ([id], [categoryId], [brandId], [itemName], [cost], [quantity], [image], [description], [discount], [discountFlag], [Rate], [createBy], [updateBy], [createDate], [updateDate], [isActive]) VALUES (19, 20003, 30003, N'Coconut Perfume', 9, 40, N'coconut_perfume.jpg', N'Refreshing coconut aroma', 6, 1, NULL, N'admin', N'admin', CAST(N'2025-02-28T23:44:36.787' AS DateTime), CAST(N'2025-02-28T23:44:36.787' AS DateTime), 1)
INSERT [dbo].[item] ([id], [categoryId], [brandId], [itemName], [cost], [quantity], [image], [description], [discount], [discountFlag], [Rate], [createBy], [updateBy], [createDate], [updateDate], [isActive]) VALUES (20, 20001, 30001, N'Eyeshadow Palette', 10, 35, N'eyeshadow_palette.jpg', N'Vibrant colors for stunning looks', 10, 1, NULL, N'admin', N'admin', CAST(N'2025-02-28T23:44:36.787' AS DateTime), CAST(N'2025-02-28T23:44:36.787' AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[item] OFF
GO
INSERT [dbo].[item_ingredient] ([itemId], [ingredientId]) VALUES (1, 1)
INSERT [dbo].[item_ingredient] ([itemId], [ingredientId]) VALUES (1, 6)
INSERT [dbo].[item_ingredient] ([itemId], [ingredientId]) VALUES (2, 3)
INSERT [dbo].[item_ingredient] ([itemId], [ingredientId]) VALUES (2, 8)
INSERT [dbo].[item_ingredient] ([itemId], [ingredientId]) VALUES (3, 7)
INSERT [dbo].[item_ingredient] ([itemId], [ingredientId]) VALUES (4, 5)
INSERT [dbo].[item_ingredient] ([itemId], [ingredientId]) VALUES (5, 2)
INSERT [dbo].[item_ingredient] ([itemId], [ingredientId]) VALUES (5, 9)
INSERT [dbo].[item_ingredient] ([itemId], [ingredientId]) VALUES (6, 10)
INSERT [dbo].[item_ingredient] ([itemId], [ingredientId]) VALUES (7, 4)
INSERT [dbo].[item_ingredient] ([itemId], [ingredientId]) VALUES (8, 6)
INSERT [dbo].[item_ingredient] ([itemId], [ingredientId]) VALUES (9, 7)
INSERT [dbo].[item_ingredient] ([itemId], [ingredientId]) VALUES (10, 8)
INSERT [dbo].[item_ingredient] ([itemId], [ingredientId]) VALUES (11, 1)
INSERT [dbo].[item_ingredient] ([itemId], [ingredientId]) VALUES (11, 2)
INSERT [dbo].[item_ingredient] ([itemId], [ingredientId]) VALUES (12, 3)
INSERT [dbo].[item_ingredient] ([itemId], [ingredientId]) VALUES (12, 5)
INSERT [dbo].[item_ingredient] ([itemId], [ingredientId]) VALUES (13, 6)
INSERT [dbo].[item_ingredient] ([itemId], [ingredientId]) VALUES (13, 7)
INSERT [dbo].[item_ingredient] ([itemId], [ingredientId]) VALUES (14, 2)
INSERT [dbo].[item_ingredient] ([itemId], [ingredientId]) VALUES (14, 8)
INSERT [dbo].[item_ingredient] ([itemId], [ingredientId]) VALUES (15, 9)
INSERT [dbo].[item_ingredient] ([itemId], [ingredientId]) VALUES (16, 7)
INSERT [dbo].[item_ingredient] ([itemId], [ingredientId]) VALUES (17, 3)
INSERT [dbo].[item_ingredient] ([itemId], [ingredientId]) VALUES (18, 10)
INSERT [dbo].[item_ingredient] ([itemId], [ingredientId]) VALUES (19, 4)
INSERT [dbo].[item_ingredient] ([itemId], [ingredientId]) VALUES (20, 8)
GO
SET IDENTITY_INSERT [dbo].[ItemRequest] ON 

INSERT [dbo].[ItemRequest] ([ReqId], [CustomerId], [QuantityRequested], [ProductName], [Description], [CreateBy], [UpdateBy], [CreateDate], [UpdateDate], [IsActive], [StatusId]) VALUES (1, 2, 1, N'Lipstick Matte', N'Long-lasting matte lipstick', N'admin', N'admin', CAST(N'2025-02-28T02:17:57.917' AS DateTime), CAST(N'2025-02-28T02:17:57.917' AS DateTime), 1, 10003)
INSERT [dbo].[ItemRequest] ([ReqId], [CustomerId], [QuantityRequested], [ProductName], [Description], [CreateBy], [UpdateBy], [CreateDate], [UpdateDate], [IsActive], [StatusId]) VALUES (2, 3, 2, N'Foundation', N'Full coverage foundation', N'admin', N'admin', CAST(N'2025-02-28T02:17:57.917' AS DateTime), CAST(N'2025-02-28T02:17:57.917' AS DateTime), 1, 10002)
INSERT [dbo].[ItemRequest] ([ReqId], [CustomerId], [QuantityRequested], [ProductName], [Description], [CreateBy], [UpdateBy], [CreateDate], [UpdateDate], [IsActive], [StatusId]) VALUES (3, 4, 3, N'Eyeliner', N'Waterproof black eyeliner', N'admin', N'admin', CAST(N'2025-02-28T02:17:57.917' AS DateTime), CAST(N'2025-02-28T02:17:57.917' AS DateTime), 1, 10003)
INSERT [dbo].[ItemRequest] ([ReqId], [CustomerId], [QuantityRequested], [ProductName], [Description], [CreateBy], [UpdateBy], [CreateDate], [UpdateDate], [IsActive], [StatusId]) VALUES (4, 5, 1, N'Face Cleanser', N'Deep cleansing facial wash', N'admin', N'admin', CAST(N'2025-02-28T02:17:57.917' AS DateTime), CAST(N'2025-02-28T02:17:57.917' AS DateTime), 1, 10001)
INSERT [dbo].[ItemRequest] ([ReqId], [CustomerId], [QuantityRequested], [ProductName], [Description], [CreateBy], [UpdateBy], [CreateDate], [UpdateDate], [IsActive], [StatusId]) VALUES (5, 6, 4, N'Moisturizer', N'Hydrating face cream', N'admin', N'admin', CAST(N'2025-02-28T02:17:57.917' AS DateTime), CAST(N'2025-02-28T02:17:57.917' AS DateTime), 1, 10002)
INSERT [dbo].[ItemRequest] ([ReqId], [CustomerId], [QuantityRequested], [ProductName], [Description], [CreateBy], [UpdateBy], [CreateDate], [UpdateDate], [IsActive], [StatusId]) VALUES (6, 7, 2, N'Sunscreen SPF50', N'Protects skin from UV rays', N'admin', N'admin', CAST(N'2025-02-28T02:17:57.917' AS DateTime), CAST(N'2025-02-28T02:17:57.917' AS DateTime), 1, 10001)
INSERT [dbo].[ItemRequest] ([ReqId], [CustomerId], [QuantityRequested], [ProductName], [Description], [CreateBy], [UpdateBy], [CreateDate], [UpdateDate], [IsActive], [StatusId]) VALUES (7, 8, 1, N'Floral Perfume', N'Sweet floral fragrance', N'admin', N'admin', CAST(N'2025-02-28T02:17:57.917' AS DateTime), CAST(N'2025-02-28T02:17:57.917' AS DateTime), 1, 10003)
INSERT [dbo].[ItemRequest] ([ReqId], [CustomerId], [QuantityRequested], [ProductName], [Description], [CreateBy], [UpdateBy], [CreateDate], [UpdateDate], [IsActive], [StatusId]) VALUES (8, 9, 3, N'Woody Perfume', N'Rich woody scent', N'admin', N'admin', CAST(N'2025-02-28T02:17:57.917' AS DateTime), CAST(N'2025-02-28T02:17:57.917' AS DateTime), 1, 10002)
INSERT [dbo].[ItemRequest] ([ReqId], [CustomerId], [QuantityRequested], [ProductName], [Description], [CreateBy], [UpdateBy], [CreateDate], [UpdateDate], [IsActive], [StatusId]) VALUES (9, 10, 1, N'Citrus Perfume', N'Fresh citrus aroma', N'admin', N'admin', CAST(N'2025-02-28T02:17:57.917' AS DateTime), CAST(N'2025-02-28T02:17:57.917' AS DateTime), 1, 10001)
INSERT [dbo].[ItemRequest] ([ReqId], [CustomerId], [QuantityRequested], [ProductName], [Description], [CreateBy], [UpdateBy], [CreateDate], [UpdateDate], [IsActive], [StatusId]) VALUES (10, 11, 2, N'Compact Powder', N'Oil-control face powder', N'admin', N'admin', CAST(N'2025-02-28T02:17:57.917' AS DateTime), CAST(N'2025-02-28T02:17:57.917' AS DateTime), 1, 10002)
SET IDENTITY_INSERT [dbo].[ItemRequest] OFF
GO
INSERT [dbo].[LookupType] ([id], [Type], [CreateBy], [updateBy], [createDate], [updateDate], [isActive]) VALUES (10, N'status    ', NULL, NULL, CAST(N'2025-02-27T22:27:33.147' AS DateTime), NULL, 1)
INSERT [dbo].[LookupType] ([id], [Type], [CreateBy], [updateBy], [createDate], [updateDate], [isActive]) VALUES (20, N'category  ', NULL, NULL, CAST(N'2025-02-27T22:27:43.923' AS DateTime), NULL, 1)
INSERT [dbo].[LookupType] ([id], [Type], [CreateBy], [updateBy], [createDate], [updateDate], [isActive]) VALUES (30, N'brand     ', NULL, NULL, CAST(N'2025-02-27T22:27:53.197' AS DateTime), NULL, 1)
GO
INSERT [dbo].[LookupValue] ([Id], [TypeId], [Name]) VALUES (10001, 10, N'Pending   ')
INSERT [dbo].[LookupValue] ([Id], [TypeId], [Name]) VALUES (10002, 10, N'Approved  ')
INSERT [dbo].[LookupValue] ([Id], [TypeId], [Name]) VALUES (10003, 10, N'Rejected  ')
INSERT [dbo].[LookupValue] ([Id], [TypeId], [Name]) VALUES (20001, 20, N'makeup    ')
INSERT [dbo].[LookupValue] ([Id], [TypeId], [Name]) VALUES (20002, 20, N'skinCare  ')
INSERT [dbo].[LookupValue] ([Id], [TypeId], [Name]) VALUES (20003, 20, N'perfums   ')
INSERT [dbo].[LookupValue] ([Id], [TypeId], [Name]) VALUES (30001, 30, N'BrandA    ')
INSERT [dbo].[LookupValue] ([Id], [TypeId], [Name]) VALUES (30002, 30, N'BrandB    ')
INSERT [dbo].[LookupValue] ([Id], [TypeId], [Name]) VALUES (30003, 30, N'BrandC    ')
GO
SET IDENTITY_INSERT [dbo].[Order] ON 

INSERT [dbo].[Order] ([OrderId], [CustomerId], [TotalAmount], [StatusId], [CreateBy], [UpdateBy], [CreateDate], [UpdateDate], [IsActive]) VALUES (1, 2, 203.95999999999998, 10001, N'admin', N'admin', CAST(N'2025-02-28T02:25:38.823' AS DateTime), CAST(N'2025-02-28T02:25:38.823' AS DateTime), 1)
INSERT [dbo].[Order] ([OrderId], [CustomerId], [TotalAmount], [StatusId], [CreateBy], [UpdateBy], [CreateDate], [UpdateDate], [IsActive]) VALUES (2, 3, 37.46, 10002, N'admin', N'admin', CAST(N'2025-02-28T02:25:38.823' AS DateTime), CAST(N'2025-02-28T02:25:38.823' AS DateTime), 1)
INSERT [dbo].[Order] ([OrderId], [CustomerId], [TotalAmount], [StatusId], [CreateBy], [UpdateBy], [CreateDate], [UpdateDate], [IsActive]) VALUES (3, 4, 29.48, 10003, N'admin', N'admin', CAST(N'2025-02-28T02:25:38.823' AS DateTime), CAST(N'2025-02-28T02:25:38.823' AS DateTime), 1)
INSERT [dbo].[Order] ([OrderId], [CustomerId], [TotalAmount], [StatusId], [CreateBy], [UpdateBy], [CreateDate], [UpdateDate], [IsActive]) VALUES (4, 5, 79.460000000000008, 10001, N'admin', N'admin', CAST(N'2025-02-28T02:25:38.823' AS DateTime), CAST(N'2025-02-28T02:25:38.823' AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[Order] OFF
GO
SET IDENTITY_INSERT [dbo].[OrderItem] ON 

INSERT [dbo].[OrderItem] ([OrderItemId], [OrderId], [ItemId], [Quantity], [ItemPrice], [DiscountAmount], [Rate], [CreateBy], [UpdateBy], [CreateDate], [UpdateDate], [IsActive]) VALUES (1, 1, 1, 7, 12.99, 2, 4.5, N'admin', N'admin', CAST(N'2025-02-28T02:25:38.827' AS DateTime), CAST(N'2025-02-28T02:25:38.827' AS DateTime), 1)
INSERT [dbo].[OrderItem] ([OrderItemId], [OrderId], [ItemId], [Quantity], [ItemPrice], [DiscountAmount], [Rate], [CreateBy], [UpdateBy], [CreateDate], [UpdateDate], [IsActive]) VALUES (2, 1, 2, 1, 19.99, 1, 4.8, N'admin', N'admin', CAST(N'2025-02-28T02:25:38.827' AS DateTime), CAST(N'2025-02-28T02:25:38.827' AS DateTime), 1)
INSERT [dbo].[OrderItem] ([OrderItemId], [OrderId], [ItemId], [Quantity], [ItemPrice], [DiscountAmount], [Rate], [CreateBy], [UpdateBy], [CreateDate], [UpdateDate], [IsActive]) VALUES (3, 2, 3, 3, 9.99, 3, 4.7, N'admin', N'admin', CAST(N'2025-02-28T02:25:38.827' AS DateTime), CAST(N'2025-02-28T02:25:38.827' AS DateTime), 1)
INSERT [dbo].[OrderItem] ([OrderItemId], [OrderId], [ItemId], [Quantity], [ItemPrice], [DiscountAmount], [Rate], [CreateBy], [UpdateBy], [CreateDate], [UpdateDate], [IsActive]) VALUES (4, 2, 4, 1, 10.99, 1.5, 4.9, N'admin', N'admin', CAST(N'2025-02-28T02:25:38.827' AS DateTime), CAST(N'2025-02-28T02:25:38.827' AS DateTime), 1)
INSERT [dbo].[OrderItem] ([OrderItemId], [OrderId], [ItemId], [Quantity], [ItemPrice], [DiscountAmount], [Rate], [CreateBy], [UpdateBy], [CreateDate], [UpdateDate], [IsActive]) VALUES (5, 3, 5, 2, 15.99, 2.5, 4.6, N'admin', N'admin', CAST(N'2025-02-28T02:25:38.827' AS DateTime), CAST(N'2025-02-28T02:25:38.827' AS DateTime), 1)
INSERT [dbo].[OrderItem] ([OrderItemId], [OrderId], [ItemId], [Quantity], [ItemPrice], [DiscountAmount], [Rate], [CreateBy], [UpdateBy], [CreateDate], [UpdateDate], [IsActive]) VALUES (6, 4, 6, 4, 13.99, 4, 4.8, N'admin', N'admin', CAST(N'2025-02-28T02:25:38.827' AS DateTime), CAST(N'2025-02-28T02:25:38.827' AS DateTime), 1)
INSERT [dbo].[OrderItem] ([OrderItemId], [OrderId], [ItemId], [Quantity], [ItemPrice], [DiscountAmount], [Rate], [CreateBy], [UpdateBy], [CreateDate], [UpdateDate], [IsActive]) VALUES (8, 1, 10, 2, 4.5, NULL, NULL, NULL, NULL, CAST(N'2025-03-01T21:26:53.470' AS DateTime), NULL, 1)
INSERT [dbo].[OrderItem] ([OrderItemId], [OrderId], [ItemId], [Quantity], [ItemPrice], [DiscountAmount], [Rate], [CreateBy], [UpdateBy], [CreateDate], [UpdateDate], [IsActive]) VALUES (9, 1, 1, 7, 3, 2, NULL, NULL, NULL, CAST(N'2025-03-01T21:44:17.227' AS DateTime), NULL, 1)
INSERT [dbo].[OrderItem] ([OrderItemId], [OrderId], [ItemId], [Quantity], [ItemPrice], [DiscountAmount], [Rate], [CreateBy], [UpdateBy], [CreateDate], [UpdateDate], [IsActive]) VALUES (12, 4, 4, 5, 3, 1, NULL, NULL, NULL, CAST(N'2025-03-01T22:33:03.133' AS DateTime), NULL, 1)
INSERT [dbo].[OrderItem] ([OrderItemId], [OrderId], [ItemId], [Quantity], [ItemPrice], [DiscountAmount], [Rate], [CreateBy], [UpdateBy], [CreateDate], [UpdateDate], [IsActive]) VALUES (13, 4, 2, 3, 5.5, 3, NULL, NULL, NULL, CAST(N'2025-03-01T22:34:06.143' AS DateTime), NULL, 1)
SET IDENTITY_INSERT [dbo].[OrderItem] OFF
GO
SET IDENTITY_INSERT [dbo].[person] ON 

INSERT [dbo].[person] ([id], [firstName], [lastName], [ProfileImage], [email], [phoneNumber], [createBy], [updateBy], [createDate], [updateDate], [isActive]) VALUES (2, N'Sarah', N'Johnson', N'profile1.jpg', N'sarah.johnson@email.com', N'0791234567', N'admin', N'admin', CAST(N'2025-02-28T01:29:31.160' AS DateTime), CAST(N'2025-02-28T01:29:31.160' AS DateTime), 1)
INSERT [dbo].[person] ([id], [firstName], [lastName], [ProfileImage], [email], [phoneNumber], [createBy], [updateBy], [createDate], [updateDate], [isActive]) VALUES (3, N'Emily', N'Smith', N'profile2.jpg', N'emily.smith@email.com', N'0782345678', N'admin', N'admin', CAST(N'2025-02-28T01:29:31.160' AS DateTime), CAST(N'2025-02-28T01:29:31.160' AS DateTime), 1)
INSERT [dbo].[person] ([id], [firstName], [lastName], [ProfileImage], [email], [phoneNumber], [createBy], [updateBy], [createDate], [updateDate], [isActive]) VALUES (4, N'Olivia', N'Brown', N'profile3.jpg', N'olivia.brown@email.com', N'0773456789', N'admin', N'admin', CAST(N'2025-02-28T01:29:31.160' AS DateTime), CAST(N'2025-02-28T01:29:31.160' AS DateTime), 1)
INSERT [dbo].[person] ([id], [firstName], [lastName], [ProfileImage], [email], [phoneNumber], [createBy], [updateBy], [createDate], [updateDate], [isActive]) VALUES (5, N'Liam', N'Williams', N'profile4.jpg', N'liam.williams@email.com', N'0794567890', N'admin', N'admin', CAST(N'2025-02-28T01:29:31.160' AS DateTime), CAST(N'2025-02-28T01:29:31.160' AS DateTime), 1)
INSERT [dbo].[person] ([id], [firstName], [lastName], [ProfileImage], [email], [phoneNumber], [createBy], [updateBy], [createDate], [updateDate], [isActive]) VALUES (6, N'James', N'Jones', N'profile5.jpg', N'james.jones@email.com', N'0785678901', N'admin', N'admin', CAST(N'2025-02-28T01:29:31.160' AS DateTime), CAST(N'2025-02-28T01:29:31.160' AS DateTime), 1)
INSERT [dbo].[person] ([id], [firstName], [lastName], [ProfileImage], [email], [phoneNumber], [createBy], [updateBy], [createDate], [updateDate], [isActive]) VALUES (7, N'Sophia', N'Garcia', N'profile6.jpg', N'sophia.garcia@email.com', N'0776789012', N'admin', N'admin', CAST(N'2025-02-28T01:29:31.160' AS DateTime), CAST(N'2025-02-28T01:29:31.160' AS DateTime), 1)
INSERT [dbo].[person] ([id], [firstName], [lastName], [ProfileImage], [email], [phoneNumber], [createBy], [updateBy], [createDate], [updateDate], [isActive]) VALUES (8, N'Charlotte', N'Martinez', N'profile7.jpg', N'charlotte.martinez@email.com', N'0797890123', N'admin', N'admin', CAST(N'2025-02-28T01:29:31.160' AS DateTime), CAST(N'2025-02-28T01:29:31.160' AS DateTime), 1)
INSERT [dbo].[person] ([id], [firstName], [lastName], [ProfileImage], [email], [phoneNumber], [createBy], [updateBy], [createDate], [updateDate], [isActive]) VALUES (9, N'Amelia', N'Hernandez', N'profile8.jpg', N'amelia.hernandez@email.com', N'0788901234', N'admin', N'admin', CAST(N'2025-02-28T01:29:31.160' AS DateTime), CAST(N'2025-02-28T01:29:31.160' AS DateTime), 1)
INSERT [dbo].[person] ([id], [firstName], [lastName], [ProfileImage], [email], [phoneNumber], [createBy], [updateBy], [createDate], [updateDate], [isActive]) VALUES (10, N'Mason', N'Lopez', N'profile9.jpg', N'mason.lopez@email.com', N'0779012345', N'admin', N'admin', CAST(N'2025-02-28T01:29:31.160' AS DateTime), CAST(N'2025-02-28T01:29:31.160' AS DateTime), 1)
INSERT [dbo].[person] ([id], [firstName], [lastName], [ProfileImage], [email], [phoneNumber], [createBy], [updateBy], [createDate], [updateDate], [isActive]) VALUES (11, N'Ethan', N'Wilson', N'profile10.jpg', N'ethan.wilson@email.com', N'0790123456', N'admin', N'admin', CAST(N'2025-02-28T01:29:31.160' AS DateTime), CAST(N'2025-02-28T01:29:31.160' AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[person] OFF
GO
SET IDENTITY_INSERT [dbo].[wishlist] ON 

INSERT [dbo].[wishlist] ([wishid], [customerid], [itemid], [quantity], [createDate], [isActive]) VALUES (1, 2, 1, 2, CAST(N'2025-02-28T02:31:52.170' AS DateTime), 1)
INSERT [dbo].[wishlist] ([wishid], [customerid], [itemid], [quantity], [createDate], [isActive]) VALUES (2, 3, 2, 1, CAST(N'2025-02-28T02:31:52.170' AS DateTime), 1)
INSERT [dbo].[wishlist] ([wishid], [customerid], [itemid], [quantity], [createDate], [isActive]) VALUES (3, 4, 3, 3, CAST(N'2025-02-28T02:31:52.170' AS DateTime), 1)
INSERT [dbo].[wishlist] ([wishid], [customerid], [itemid], [quantity], [createDate], [isActive]) VALUES (4, 5, 4, 1, CAST(N'2025-02-28T02:31:52.170' AS DateTime), 1)
INSERT [dbo].[wishlist] ([wishid], [customerid], [itemid], [quantity], [createDate], [isActive]) VALUES (5, 6, 5, 2, CAST(N'2025-02-28T02:31:52.170' AS DateTime), 1)
INSERT [dbo].[wishlist] ([wishid], [customerid], [itemid], [quantity], [createDate], [isActive]) VALUES (6, 7, 6, 1, CAST(N'2025-02-28T02:31:52.170' AS DateTime), 1)
INSERT [dbo].[wishlist] ([wishid], [customerid], [itemid], [quantity], [createDate], [isActive]) VALUES (7, 8, 7, 2, CAST(N'2025-02-28T02:31:52.170' AS DateTime), 1)
INSERT [dbo].[wishlist] ([wishid], [customerid], [itemid], [quantity], [createDate], [isActive]) VALUES (8, 9, 8, 1, CAST(N'2025-02-28T02:31:52.170' AS DateTime), 1)
INSERT [dbo].[wishlist] ([wishid], [customerid], [itemid], [quantity], [createDate], [isActive]) VALUES (9, 10, 9, 2, CAST(N'2025-02-28T02:31:52.170' AS DateTime), 1)
INSERT [dbo].[wishlist] ([wishid], [customerid], [itemid], [quantity], [createDate], [isActive]) VALUES (10, 11, 10, 1, CAST(N'2025-02-28T02:31:52.170' AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[wishlist] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__person__4849DA01D99A4D1B]    Script Date: 01/03/2025 11:21:24 PM ******/
ALTER TABLE [dbo].[person] ADD UNIQUE NONCLUSTERED 
(
	[phoneNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__person__AB6E6164CFD5A461]    Script Date: 01/03/2025 11:21:24 PM ******/
ALTER TABLE [dbo].[person] ADD UNIQUE NONCLUSTERED 
(
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ingredient] ADD  DEFAULT (getdate()) FOR [createDate]
GO
ALTER TABLE [dbo].[ingredient] ADD  DEFAULT ((1)) FOR [isActive]
GO
ALTER TABLE [dbo].[item] ADD  DEFAULT ((0)) FOR [discountFlag]
GO
ALTER TABLE [dbo].[item] ADD  DEFAULT (getdate()) FOR [createDate]
GO
ALTER TABLE [dbo].[item] ADD  DEFAULT ((1)) FOR [isActive]
GO
ALTER TABLE [dbo].[ItemRequest] ADD  DEFAULT (getdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[ItemRequest] ADD  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[LookupType] ADD  CONSTRAINT [DC]  DEFAULT (getdate()) FOR [createDate]
GO
ALTER TABLE [dbo].[LookupType] ADD  CONSTRAINT [DCa]  DEFAULT ((1)) FOR [isActive]
GO
ALTER TABLE [dbo].[Order] ADD  DEFAULT (getdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[Order] ADD  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[OrderItem] ADD  CONSTRAINT [DF__OrderItem__Creat__5DCAEF64]  DEFAULT (getdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[OrderItem] ADD  CONSTRAINT [DF__OrderItem__IsAct__5EBF139D]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[person] ADD  DEFAULT (getdate()) FOR [createDate]
GO
ALTER TABLE [dbo].[person] ADD  DEFAULT ((1)) FOR [isActive]
GO
ALTER TABLE [dbo].[wishlist] ADD  DEFAULT (getdate()) FOR [createDate]
GO
ALTER TABLE [dbo].[wishlist] ADD  DEFAULT ((1)) FOR [isActive]
GO
ALTER TABLE [dbo].[item_ingredient]  WITH CHECK ADD FOREIGN KEY([ingredientId])
REFERENCES [dbo].[ingredient] ([id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[item_ingredient]  WITH CHECK ADD FOREIGN KEY([itemId])
REFERENCES [dbo].[item] ([id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ItemRequest]  WITH CHECK ADD  CONSTRAINT [FK__ItemReque__Custo__656C112C] FOREIGN KEY([CustomerId])
REFERENCES [dbo].[person] ([id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ItemRequest] CHECK CONSTRAINT [FK__ItemReque__Custo__656C112C]
GO
ALTER TABLE [dbo].[ItemRequest]  WITH CHECK ADD  CONSTRAINT [FK_ItemRequest_Status] FOREIGN KEY([StatusId])
REFERENCES [dbo].[LookupValue] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ItemRequest] CHECK CONSTRAINT [FK_ItemRequest_Status]
GO
ALTER TABLE [dbo].[LookupValue]  WITH CHECK ADD  CONSTRAINT [FK_LookupValue_LookupType1] FOREIGN KEY([TypeId])
REFERENCES [dbo].[LookupType] ([id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[LookupValue] CHECK CONSTRAINT [FK_LookupValue_LookupType1]
GO
ALTER TABLE [dbo].[Order]  WITH CHECK ADD  CONSTRAINT [FK_Order_Customer] FOREIGN KEY([CustomerId])
REFERENCES [dbo].[person] ([id])
GO
ALTER TABLE [dbo].[Order] CHECK CONSTRAINT [FK_Order_Customer]
GO
ALTER TABLE [dbo].[OrderItem]  WITH CHECK ADD  CONSTRAINT [FK__OrderItem__ItemI__60A75C0F] FOREIGN KEY([ItemId])
REFERENCES [dbo].[item] ([id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[OrderItem] CHECK CONSTRAINT [FK__OrderItem__ItemI__60A75C0F]
GO
ALTER TABLE [dbo].[OrderItem]  WITH CHECK ADD  CONSTRAINT [FK__OrderItem__Order__5FB337D6] FOREIGN KEY([OrderId])
REFERENCES [dbo].[Order] ([OrderId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[OrderItem] CHECK CONSTRAINT [FK__OrderItem__Order__5FB337D6]
GO
ALTER TABLE [dbo].[wishlist]  WITH CHECK ADD  CONSTRAINT [FK__wishlist__custom__534D60F1] FOREIGN KEY([customerid])
REFERENCES [dbo].[person] ([id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[wishlist] CHECK CONSTRAINT [FK__wishlist__custom__534D60F1]
GO
ALTER TABLE [dbo].[wishlist]  WITH CHECK ADD FOREIGN KEY([itemid])
REFERENCES [dbo].[item] ([id])
GO
ALTER TABLE [dbo].[item]  WITH CHECK ADD CHECK  (([Rate]>=(0) AND [Rate]<=(5)))
GO
ALTER TABLE [dbo].[OrderItem]  WITH CHECK ADD  CONSTRAINT [CK__OrderItem__Rate__5CD6CB2B] CHECK  (([Rate]>=(0) AND [Rate]<=(5)))
GO
ALTER TABLE [dbo].[OrderItem] CHECK CONSTRAINT [CK__OrderItem__Rate__5CD6CB2B]
GO
ALTER TABLE [dbo].[person]  WITH CHECK ADD CHECK  (([email] like '%_@__%.__%'))
GO
ALTER TABLE [dbo].[person]  WITH CHECK ADD  CONSTRAINT [CK_phoneNumber] CHECK  ((([phoneNumber] like '079%' OR [phoneNumber] like '078%' OR [phoneNumber] like '077%') AND len([phoneNumber])=(10)))
GO
ALTER TABLE [dbo].[person] CHECK CONSTRAINT [CK_phoneNumber]
GO
/****** Object:  StoredProcedure [dbo].[AddItemToOrder]    Script Date: 01/03/2025 11:21:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AddItemToOrder]
    @CustomerId INT,
    @ItemId INT,
    @Quantity INT
AS
BEGIN
    
    INSERT INTO OrderItem (OrderId, ItemId, Quantity, ItemPrice, DiscountAmount)
    SELECT o.OrderId, i.ID, @Quantity, i.Price, i.Discount
    FROM [Order] o, Item i
    WHERE o.CustomerId = @CustomerId 
          AND o.StatusId = 10001 
          AND i.ID = @ItemId;

    UPDATE Item
    SET Quantity = Quantity - @Quantity
    WHERE ID = @ItemId;

    
      UPDATE o
        SET TotalAmount = (
            SELECT SUM(oi.Quantity * oi.ItemPrice - oi.DiscountAmount) 
            FROM OrderItem oi
            WHERE oi.OrderId = o.OrderId
        )
        FROM [Order] o
        WHERE o.CustomerId = @CustomerId AND o.StatusId = 10001;
END;
GO
/****** Object:  StoredProcedure [dbo].[GenerateSalesReport]    Script Date: 01/03/2025 11:21:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GenerateSalesReport]
    @StartDate DATE,
    @EndDate DATE
AS
BEGIN
   
    SELECT
        i.itemName,
        SUM(oi.Quantity) AS TotalQuantitySold,
        SUM(oi.Quantity * oi.ItemPrice) AS TotalRevenue,
        AVG(oi.Rate) AS AverageRating
    FROM OrderItem oi
    JOIN [Order] o ON oi.OrderId = o.OrderId
    JOIN Item i ON oi.ItemId = i.id
    WHERE o.CreateDate BETWEEN @StartDate AND @EndDate
    AND o.StatusId = 10001 
    GROUP BY i.itemName
    ORDER BY TotalRevenue DESC;
	END;


GO
/****** Object:  StoredProcedure [dbo].[ManageDiscounts]    Script Date: 01/03/2025 11:21:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[ManageDiscounts]
    @ItemId INT = NULL,  
    @CategoryId INT = NULL,  
    @DiscountAmount DECIMAL(10,2) =null,
	@DISCOUNTFlag bit
AS
BEGIN
    
    UPDATE Item
    SET Discount = @DiscountAmount
	,discountFlag=@DISCOUNTFlag
    WHERE id = @ItemId;

   
    UPDATE Item
    SET Discount = @DiscountAmount
	,discountFlag=@DISCOUNTFlag
    WHERE CategoryId = @CategoryId;
END;
GO
/****** Object:  StoredProcedure [dbo].[ProcessItemRequest]    Script Date: 01/03/2025 11:21:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ProcessItemRequest]
    @RequestId INT,              
    @AdminApproval BIT          
AS
BEGIN

    UPDATE ItemRequest
    SET StatusId = (SELECT Id FROM LookupValue WHERE Name = 'Approved' AND Id = 10002)
    WHERE reqid = @RequestId AND @AdminApproval = 1;

    UPDATE ItemRequest
    SET StatusId = (SELECT Id FROM LookupValue WHERE Name = 'Rejected' AND Id = 10003)
    WHERE reqid = @RequestId AND @AdminApproval = 0;

   
    UPDATE Item
    SET Quantity = Quantity + (SELECT QuantityRequested FROM ItemRequest WHERE reqid = @RequestId)
    WHERE itemName = (SELECT ProductName FROM ItemRequest WHERE reqid = @RequestId) 
    AND @AdminApproval = 1;
END;
GO
USE [master]
GO
ALTER DATABASE [Online Cosmatics Store] SET  READ_WRITE 
GO
