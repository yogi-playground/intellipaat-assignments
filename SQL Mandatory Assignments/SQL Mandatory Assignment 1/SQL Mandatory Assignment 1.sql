/**1.Insert a new record in the Orders table:**/
INSERT INTO Orders (OrderId, CustomerId, SalesmanId, Orderdate, Amount)
VALUES (5004, 2345, 101, '2022-01-20', 700);

-- Primary key constraint for SalesmanId in Salesman table
SELECT * FROM Salesman WHERE SalesmanId IS NULL;
ALTER TABLE Salesman ALTER COLUMN SalesmanId INT NOT NULL;
ALTER TABLE Salesman ADD PRIMARY KEY (SalesmanId);

-- Default constraint for City column in Salesman table
ALTER TABLE Salesman ADD CONSTRAINT df_City DEFAULT 'Texas' FOR City;

/**-- Add Foreign key constraint for SalesmanId column in Customer table**/
ALTER TABLE Customer
ADD CONSTRAINT FK_Customer_SalesmanId FOREIGN KEY (SalesmanId) REFERENCES Salesman(SalesmanId);


/**-- Add not null constraint in CustomerName column for the Customer table**/
ALTER TABLE Customer
ALTER COLUMN CustomerName VARCHAR(255) NOT NULL;

/**3. Fetch the data where the Customer’s name is ending with either ‘N’ also get the
purchase amount value greater than 500.**/
SELECT *
FROM Customer
WHERE CustomerName LIKE '%N' AND PurchaseAmount > 500;

/**4. Using SET operators, retrieve the first result with unique SalesmanId values from two
tables, and the other result containing SalesmanId without duplicates from two tables.**/
-- Retrieve unique SalesmanId values from two tables
SELECT SalesmanId FROM Salesman
UNION
SELECT SalesmanId FROM Customer;

-- Retrieve SalesmanId values without duplicates from two tables
SELECT SalesmanId FROM Salesman
UNION ALL
SELECT SalesmanId FROM Customer;


/**5. Display the below columns which has the matching data.
Orderdate, Salesman Name, Customer Name, Commission, and City which has the
range of Purchase Amount between 1500 to 3000**/
SELECT Orders.Orderdate, Salesman.Name AS SalesmanName, Customer.CustomerName, Salesman.Commission, Salesman.City
FROM Orders
INNER JOIN Salesman ON Orders.SalesmanId = Salesman.SalesmanId
INNER JOIN Customer ON Orders.CustomerId = Customer.CustomerId
WHERE PurchaseAmount BETWEEN 1500 AND 3000;

/**6. Using right join fetch all the results from Salesman and Orders table.**/
SELECT *
FROM Salesman
RIGHT JOIN Orders ON Salesman.SalesmanId = Orders.SalesmanId;
