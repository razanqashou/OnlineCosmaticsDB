USE [Online Cosmatics Store]
GO
/****** Object:  StoredProcedure [dbo].[AddItemToOrder]    Script Date: 06/03/2025 3:09:37 PM ******/
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
/****** Object:  StoredProcedure [dbo].[GenerateSalesReport]    Script Date: 06/03/2025 3:09:37 PM ******/
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
/****** Object:  StoredProcedure [dbo].[ManageDiscounts]    Script Date: 06/03/2025 3:09:37 PM ******/
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
/****** Object:  StoredProcedure [dbo].[ProcessItemRequest]    Script Date: 06/03/2025 3:09:37 PM ******/
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
