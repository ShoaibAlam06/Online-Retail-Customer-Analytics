WITH Deduped AS (
	SELECT *,
	ROW_NUMBER() OVER (
	PARTITION BY Invoice, StockCode, Description, Quantity, InvoiceDate, Price, Customer_ID, Country
	ORDER BY (SELECT NULL)
	) AS RowNum
	FROM dbo.RetailCombined
)
SELECT Invoice, StockCode, Description, Quantity, InvoiceDate, Price, Customer_ID, Country, SourceSheet
INTO dbo.RetailCleaned
FROM Deduped
Where RowNum = 1;

SELECT * FROM dbo.RetailCleaned;