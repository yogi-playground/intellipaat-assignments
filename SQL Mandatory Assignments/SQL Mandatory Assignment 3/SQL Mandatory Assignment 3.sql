
/**SQL Mandatory Assignment 3**/
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
      ,[RatingStatus]
  FROM dbo.Jomato;
/**1. Create a stored procedure to display the restaurant name, type, and cuisine where 
the table booking is not zero**/
CREATE PROCEDURE DisplayRestaurantsWithTableBooking
AS
BEGIN
    SELECT RestaurantName, RestaurantType, CuisinesType
    FROM dbo.Jomato
    WHERE TableBooking <> 0;
END;
/**Validate results*/
EXEC DisplayRestaurantsWithTableBooking;

/**2. Create a transaction and update the cuisine type 'Cafe' to 'Cafeteria'.
Check the result and rollback if necessary:**/
BEGIN TRANSACTION;
-- Check the value before Change
SELECT * FROM Jomato Where CuisinesType = 'Cafe';

UPDATE Jomato
SET CuisinesType = 'Cafeteria'
WHERE CuisinesType = 'Cafe';

-- Check the result and it should show zero as all changed to Cafeteria from Cafe
SELECT * FROM Jomato Where CuisinesType = 'Cafe';

-- Check the result for Cafeteria
SELECT * FROM Jomato Where CuisinesType = 'Cafeteria';

-- Rollback Changes Cafeteria to Cafe back
   ROLLBACK TRANSACTION;
-- Check the result for Cafe
SELECT * FROM Jomato Where CuisinesType = 'Cafe';
/**3. Generate a row number column and find the top 5 areas 
with the highest rating of restaurants:**/
SELECT TOP 5
    ROW_NUMBER() OVER (ORDER BY Rating DESC) AS RowNum,
    Area,
    Rating
FROM Jomato
ORDER BY Rating DESC;

/**4. Use the while loop to display numbers from 1 to 50:**/
DECLARE @counter INT = 1;

WHILE @counter <= 50
BEGIN
    PRINT @counter;
    SET @counter = @counter + 1;
END;

/**5. Create a Top rating view to store the top 5 highest ratings of restaurants**/
CREATE VIEW TopRatingRestaurant AS
SELECT TOP 5
    RestaurantName,
    Rating
FROM Jomato
ORDER BY Rating DESC;

/** Review results of view**/
Select * from TopRatingRestaurant;

/**6. Write a trigger that sends an email notification to the restaurant 
owner whenever a new record is inserted:**/
/**How to set up email server and account as we need this to send email https://www.youtube.com/watch?v=yE643hEOir8**/
CREATE TRIGGER SendEmailOnInsert
ON Jomato
AFTER INSERT
AS
BEGIN
    DECLARE @RestaurantName VARCHAR(255);
    DECLARE @Email VARCHAR(255);
    
    SELECT @RestaurantName = RestaurantName, @Email = 'yogi@gmail.com'
    FROM inserted;

    -- code to send email using sql standard funcation sp_send_dbmail 
       EXEC msdb.dbo.sp_send_dbmail @recipients = @Email, @subject = 'New Record Inserted', 	   @body = 'A new record has been inserted for your restaurant';

END;

