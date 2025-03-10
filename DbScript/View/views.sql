USE [Online Cosmatics Store]
GO
/****** Object:  View [dbo].[AvailableItems]    Script Date: 06/03/2025 3:09:00 PM ******/
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
/****** Object:  View [dbo].[CustomerWishlist]    Script Date: 06/03/2025 3:09:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[CustomerWishlist] AS
SELECT  w.quantity, i.itemName , i.cost, i.discount , i.price as [price after discount] FROM wishlist AS w
join item  as i on  w.itemid=i.id
  
GO
/****** Object:  View [dbo].[SalesSummary]    Script Date: 06/03/2025 3:09:00 PM ******/
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
