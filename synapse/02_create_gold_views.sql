--create view calendar
---------------
CREATE VIEW gold.calnedar
AS
SELECT * from 
OPENROWSET
(
    BULK 'https://awstorage29.blob.core.windows.net/silver/AdventureWorks_Calendar/',
    FORMAT='PARQUET'
) as q1

--create view customer

CREATE VIEW gold.customer
AS
SELECT * from 
OPENROWSET
(
    BULK 'https://awstorage29.blob.core.windows.net/silver/AdventureWorks_Customer/',
    FORMAT='PARQUET'
) as q2

--create view productsubcat

CREATE VIEW gold.productsubcat
AS
SELECT * from 
OPENROWSET
(
    BULK 'https://awstorage29.blob.core.windows.net/silver/AdventureWorks_Product_Subcategories/',
    FORMAT='PARQUET'
) as q3

--create view products

CREATE VIEW gold.products
AS
SELECT * from 
OPENROWSET
(
    BULK 'https://awstorage29.blob.core.windows.net/silver/AdventureWorks_Products/',
    FORMAT='PARQUET'
) as q4

--create view returns
CREATE VIEW gold.ret
AS
SELECT * from 
OPENROWSET
(
    BULK 'https://awstorage29.blob.core.windows.net/silver/AdventureWorks_Returns/',
    FORMAT='PARQUET'
) as q5

--create view Sales
CREATE VIEW gold.Sales
AS
SELECT * from 
OPENROWSET
(
    BULK 'https://awstorage29.blob.core.windows.net/silver/AdventureWorks_Sales/',
    FORMAT='PARQUET'
) as q6

--create view AdventureWorks_Subcategory
CREATE VIEW gold.Subcategory
AS
SELECT * from 
OPENROWSET
(
    BULK 'https://awstorage29.blob.core.windows.net/silver/AdventureWorks_Subcategory/',
    FORMAT='PARQUET'
) as q7

--create view Territories

CREATE VIEW gold.Territories
AS
SELECT * from 
OPENROWSET
(
    BULK 'https://awstorage29.blob.core.windows.net/silver/AdventureWorks_Territories/',
    FORMAT='PARQUET'
) as q8
