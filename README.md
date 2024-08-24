# CUSTOMERS-SEGMENTATION

##Table of content

-[Project review](#project-review)

-[Data sources](#data-sources)

-[Tools](#tools)

-[DATA CLEANING/PREPARATION](#data-cleaning/preparation)

-[Exploratory Data Analysis ](#exploratory-data-analysis-[eda])

-[Data Analysis](#data-analysis)

-[Results/Findings](#results/findings)

-[Recommendation](#recommendation)

-[Limitation](#limitation)

-[Recommendations](#recommendations)



##PROJECT REVIEW

THIS PROJECT FOCUSES ON ANALYSING SALES BASES ON CUSTOMERS PREFRENCES. IT AIMS AT STOCKS COMMONLY BOUGHT,RARELY BOUGHT
AND STOCKS OFTEN BOUGHT TOGETHER BY CUSTOMERS.

###DATA SOURCES

retail.cvs file. This contain detailed information about the stocks, description, quantities bought, prices and customers details.

###TOOLS

PostgreSQL. Link to download (https://www.postgresql.org/download/)
PostgreSQ- Data analysis

###DATA CLEANING/PREPARATION
The following tasks were performed

1. Data was uploade and inspected
2. Data types were changed accordingly
3. Data analysis was doe

###Exploratory Data Analysis [EDA]

This involves exploring the retail data to answer key questions such as
1. What is the distribution of order values across all customers in the dataset?
2. How many unique products has each customer purchased?
3. Which customers have only made a single purchase from the company?
4. Which products are most commonly purchased together by customers in the dataset?
5. No visualication


###Data Analysis

Some interesting code/features worked with
sql\
```SELECT 
	customerid,
	tockcode,
	description,
	quantity,
	unitprice,
	ROUND(CAST((quantity * unitprice) AS DECIMAL) , 2)  AS ordervalue
FROM retail
```

###Results/Findings

-Most ordervalue ranges between 0 AND 500 whike ordervalue between 501 to 5000 and ordervalue between 50001 to 100000 are low
-Unique products purchased by each customer varries from individual.
-Findins shows that approximately a thousand customers have only made a single purchase from the company.
-Products are most commonly purchased together by customers in the dataset varries also.

###Recommendation

-Products often boughtshould be made available more based on request
-Stock with low request should be probe reason why and improvement strategies needs to be enployed for better sales.
-Customers with high and frequent purchase of goods/stock should enjoy discount anually if possible. This would increase the good customer base. and increase the company's revenue

###Limitation

-For the dataset to be uploaded successfully using the PSQL tool, StockCode, invoicedate and invoiceno were taged as INt as the datatype.
-After a successful upload of the dataset, StockCode, invoicedate and invoiceno datatypeswere altered to varchar datatype.
-Unitprice was rounded up to 2 decimal place
-Ordevalue below 0 was excluded as this would give a negative result.

###References

-Pandas documentation
-youtube

😂

💻

|Headings1|Heading2|
|---------|--------|
|Content|Content2|
|Python|sql|






		


