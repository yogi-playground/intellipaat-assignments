/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [OrderId]
      ,[RestaurantName]
      ,[RestaurantType]
      ,[Rating]
      ,[No_of_Rating]
      ,[AverageCost]
      ,[OnlineOrder]
      ,[TableBooking]
      ,[CuisinesType]
      ,[Area]
      ,[LocalAddress]
      ,[Delivery_time]
  FROM dbo.Jomato where RestaurantName='Quick Bites' ;
/**Create a user-defined functions to stuff the Chicken into ‘Quick Bites’. Eg: ‘Quick Chicken Bites’.**/
CREATE FUNCTION dbo.UpdateQuickBitesNames(@restaurantName varchar(255))
RETURNS varchar(255)
AS
BEGIN
  DECLARE @updatedName varchar(255);

  IF @restaurantName = 'Quick Bites'
  BEGIN
    SET @updatedName = 'Quick Chicken Bites';
  END
  ELSE
  BEGIN
    SET @updatedName = @restaurantName;
  END

  RETURN @updatedName;
END;
/**Update  value of RestaurantName if value is Quick Bites insert Chicken and make it Quick Chicken Bites**/UPDATE dbo.Jomato
SET RestaurantName = dbo.UpdateQuickBitesNames(RestaurantName);

/**Use the function to display the restaurant name and cuisine type which has the maximum number of rating**/
SELECT  TOP (1) RestaurantName,        CuisinesType, No_of_Rating
FROM  dbo.Jomato Order by No_of_Rating Desc;


/**3. Create a Rating Status column to display the rating as ‘Excellent’ if it has more the 4 start rating, 
‘Good’ if it has above 3.5 and below 5 star rating, ‘Average’ if it is above 3 and 
below 3.5 and ‘Bad’ if it is below 3 star rating.**/
ALTER TABLE dbo.Jomato ADD RatingStatus NVARCHAR(50) ;

CREATE OR Alter TRIGGER trg_SetRatingStatus
ON dbo.Jomato
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;
	 -- get the last id value of the record inserted or updated
    DECLARE @id INT
    SELECT @id = OrderId  FROM INSERTED
    UPDATE dbo.Jomato
    SET RatingStatus = 
        CASE 
            WHEN Rating >= 4 THEN 'Excellent' 
            WHEN Rating >= 3.5 AND Rating < 4 THEN 'Good' 
            WHEN Rating >= 3 AND Rating < 3.5 THEN 'Average' 
            ELSE 'Bad' 
         END
    
    WHERE OrderId = @id;
END;
/**Review Values before update**/
SELECT TOP (1000) *  FROM dbo.Jomato;
/**Update existing record**/
UPDATE dbo.Jomato
    SET RatingStatus = 
        CASE 
            WHEN Rating >= 4 THEN 'Excellent' 
            WHEN Rating >= 3.5 AND Rating < 4 THEN 'Good' 
            WHEN Rating >= 3 AND Rating < 3.5 THEN 'Average' 
            ELSE 'Bad' 
         END;
/**Review Values after update**/
SELECT  RatingStatus,Count(*)  FROM dbo.Jomato Group By RatingStatus;

/**4. Find the Ceil, floor and absolute values of the rating column and 
display the current date and separately display the year, month_name and day. **/
-- Ceil, floor, and absolute values of the Rating column
SELECT     
    CEILING(Rating) AS CeilRating,
    FLOOR(Rating) AS FloorRating,
    ABS(Rating) AS AbsoluteRating
FROM 
    dbo.Jomato;

-- Display the current date, year, month name, and day
SELECT 
    GETDATE() AS CurrentDateTime,
    YEAR(GETDATE()) AS CurrentYear,
    DATENAME(MONTH, GETDATE()) AS CurrentMonthName,
    DAY(GETDATE()) AS CurrentDay;

/**5. Display the restaurant type and total average cost using rollup.**/
SELECT 
    ISNULL(RestaurantType, 'Total') AS RestaurantType,
    SUM(AverageCost) AS TotalAverageCost
FROM 
    dbo.Jomato
GROUP BY 
    RestaurantType WITH ROLLUP;



