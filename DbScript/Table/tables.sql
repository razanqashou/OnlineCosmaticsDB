USE [Online Cosmatics Store]
GO
/****** Object:  Table [dbo].[ingredient]    Script Date: 06/03/2025 3:07:58 PM ******/
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
/****** Object:  Table [dbo].[item]    Script Date: 06/03/2025 3:07:58 PM ******/
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
/****** Object:  Table [dbo].[item_ingredient]    Script Date: 06/03/2025 3:07:58 PM ******/
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
/****** Object:  Table [dbo].[ItemRequest]    Script Date: 06/03/2025 3:07:58 PM ******/
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
/****** Object:  Table [dbo].[LookupType]    Script Date: 06/03/2025 3:07:58 PM ******/
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
/****** Object:  Table [dbo].[LookupValue]    Script Date: 06/03/2025 3:07:58 PM ******/
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
/****** Object:  Table [dbo].[Order]    Script Date: 06/03/2025 3:07:58 PM ******/
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
/****** Object:  Table [dbo].[OrderItem]    Script Date: 06/03/2025 3:07:58 PM ******/
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
/****** Object:  Table [dbo].[person]    Script Date: 06/03/2025 3:07:58 PM ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[phoneNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[wishlist]    Script Date: 06/03/2025 3:07:58 PM ******/
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
