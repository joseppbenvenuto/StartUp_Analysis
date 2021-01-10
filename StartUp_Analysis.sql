# ------------------------------------------------------------------------------------------------------------------------------------------------------------------
# Analysis Description
# ------------------------------------------------------------------------------------------------------------------------------------------------------------------

# The analysis seeks to explore specific questions on data regarding start-up companies.

# ------------------------------------------------------------------------------------------------------------------------------------------------------------------
# Create Coal database
CREATE DATABASE StartUp;

# Use Coal database
USE StartUp;

# ------------------------------------------------------------------------------------------------------------------------------------------------------------------
# Instructions
# ------------------------------------------------------------------------------------------------------------------------------------------------------------------

# For ease of use and accurate calculations, all queries should be executed consecutively. 

# ------------------------------------------------------------------------------------------------------------------------------------------------------------------
# Overview Data Cleaning
# ------------------------------------------------------------------------------------------------------------------------------------------------------------------
# View overview Single-View
SELECT * 
FROM overview;

# There are 0 null values
SELECT COUNT(*)
FROM overview
WHERE ID IS NULL OR Name IS NULL OR Industry IS NULL OR Description IS NULL OR `Year Founded` IS NULL OR Employees IS NULL OR State IS NULL OR City IS NULL;

# Create new overview table excluding unknown columns
CALL spChooseCol('overview','overview1','1,2,3,4,5,6,7,8,9');

# View new overview1 table
SELECT *
FROM overview1;

# ------------------------------------------------------------------------------------------------------------------------------------------------------------------
# Financials Data Cleaning
# ------------------------------------------------------------------------------------------------------------------------------------------------------------------
# View financials Single-View
SELECT * 
FROM financials;

# There are 0 null values
SELECT COUNT(*)
FROM financials
WHERE ID IS NULL OR Name IS NULL OR `2015 Revenue` IS NULL OR `2015 Expenses` IS NULL OR `2015 Profit` IS NULL OR `2015 Growth %` IS NULL OR 
`2014 Revenue` IS NULL OR `2014 Expenses` IS NULL OR `2014 Profit` IS NULL OR `2014 Growth %` IS NULL;

# Create new financial table excluding unknown columns and reformating text to int
CREATE TABLE financials1 AS
SELECT ID, Name,
CAST(REPLACE(REPLACE(`2015 Revenue`, ',', ''), '$','') AS SIGNED) AS `2015 Revenue`, 
CAST(REPLACE(REPLACE(`2015 Expenses`, ',', ''), '$','') AS SIGNED) AS `2015 Expenses`, 
CAST(REPLACE(REPLACE(`2015 Profit`, ',', ''), '$','') AS SIGNED) AS `2015 Profit`, 
CAST(REPLACE(`2015 Growth %`, '%', '') AS SIGNED) AS `2015 Growth %`,
CAST(REPLACE(REPLACE(`2014 Profit`, ',', ''), '$','') AS SIGNED) AS `2014 Profit`
FROM financials;

# View new financials1 table
SELECT * 
FROM financials1;

# ------------------------------------------------------------------------------------------------------------------------------------------------------------------
# 1) Which are the top 10 industries basis Revenue? 
# ------------------------------------------------------------------------------------------------------------------------------------------------------------------
# Top 10 industries basis average revenue per company 
SELECT ov.Industry, ROUND(AVG(fin.`2015 Revenue`)/1000000,0) AS 'Average 2015 Revenue M'
FROM overview1 AS ov JOIN financials1 AS fin
ON ov.ID = fin.ID
GROUP BY ov.Industry
ORDER BY AVG(fin.`2015 Revenue`) DESC
LIMIT 10;

# Media  - $10M
# Retail - $10M
# Security - $10M
# Government Services - $9M
# Environmental Services - $9M
# Logistics & Transportation - $9M
# Engineering - $9M
# Real Estate - $9M
# IT Services - $9M
# Consumer Products & Services - $9M

# Top 10 industries basis total revenue
SELECT ov.Industry, ROUND(SUM(fin.`2015 Revenue`)/1000000,0) AS 'Total 2015 Revenue M'
FROM overview1 AS ov JOIN financials1 AS fin
ON ov.ID = fin.ID
GROUP BY ov.Industry
ORDER BY SUM(fin.`2015 Revenue`) DESC
LIMIT 10;

# IT Services - $1,345M
# Software - $775M
# Health - $774M
# Business Products & Services - $596M
# Advertising & Marketing - $594M
# Government Services - $472M
# Financial Services - $468M
# Retail - $463M
# Construction - $437M
# Consumer Products & Services - $412M

# ------------------------------------------------------------------------------------------------------------------------------------------------------------------
# 2) Which company had the maximum change in profit from 2014 to 2015?
# ------------------------------------------------------------------------------------------------------------------------------------------------------------------
# Foxwml has the greatest profit change to the upside from 2014 - 2015
SELECT Name, `2015 Profit`, `2014 Profit`, ((`2015 Profit` - `2014 Profit`) / `2014 Profit`) * 100 AS '2015-2014 Profit Growth%'
FROM financials1
WHERE `2015 Profit` >= 0
ORDER BY ((`2015 Profit` - `2014 Profit`) / `2014 Profit`) DESC
LIMIT 1;

# Foxwml - 4,120% 

# Grippingstirring has the greatest change to the downside from 2014 - 2015
SELECT Name, `2015 Profit`, `2014 Profit`, ((`2015 Profit` - `2014 Profit`) / `2014 Profit`) * 100 AS '2015-2014 Profit Growth%'
FROM financials1
WHERE `2015 Profit` < 0
ORDER BY ((`2015 Profit` - `2014 Profit`) / `2014 Profit`) DESC
LIMIT 1;

# 'Grippingstirring - 10,629%

# ------------------------------------------------------------------------------------------------------------------------------------------------------------------
# 3) Identify the companies that fulfill these 3 criterias (Consider 2015 numbers)
#
#	 	a) They should be among the top 100 in terms of revenue
#	 	b) They should be among the top 100 in terms of expenses
#	 	c) They should be among the top 100 in terms of growth percentage
#
# ------------------------------------------------------------------------------------------------------------------------------------------------------------------
# Create table with top 100 companies with the largest revenue
CREATE TABLE top_rev AS
SELECT ID, Name, `2015 Revenue`
FROM financials1
ORDER BY `2015 Revenue` DESC
LIMIT 100;

# Create table with top 100 companies with the lowest expenses
CREATE TABLE top_exp AS
SELECT ID, Name, `2015 Expenses`
FROM financials1
ORDER BY `2015 Expenses` ASC
LIMIT 100;

# Create table with top 100 companies with the largest Growth
CREATE TABLE top_growth AS
SELECT ID, Name, `2015 Growth %`
FROM financials1
ORDER BY `2015 Growth %` DESC
LIMIT 100;

# Hot-Electrics and Shadefronted are companies among the top 100 in terms of revenue, 
# the top 100 in terms of least expenses, and the top 100 in terms of growth percentage
SELECT rev.ID, rev.Name, rev.`2015 Revenue`, exp.`2015 Expenses`, growth.`2015 Growth %`
FROM top_rev AS rev JOIN top_exp AS exp 
ON rev.ID = exp.ID
JOIN top_growth AS growth 
ON exp.ID = growth.ID
LIMIT 100;

# Hot-Electrics - 2015 Rev: $12,214M, 2015 Exp: $1,412M, 2015 Growth: 595%
# Shadefronted - 2015 Rev: $12,242M, 2015 Exp: $1,382M, 2015 Growth: 537%

# Drop tables
DROP TABLE IF EXISTS Overview1;
DROP TABLE IF EXISTS financials1;
DROP TABLE IF EXISTS top_exp;
DROP TABLE IF EXISTS top_growth;
DROP TABLE IF EXISTS top_rev;


