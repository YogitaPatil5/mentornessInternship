-- CREATE THE DATABASE
CREATE DATABASE CoronaVirusAnalysis;
GO

-- USE THE NEWLY CREATED DATABASE
USE CoronaVirusAnalysis; 
GO

SELECT COUNT(*) FROM CoronaData

-- To avoid any errors, check missing value / null value 
-- Q1. Write a code to check NULL values
SELECT * FROM CoronaData
WHERE	Province IS NULL
	OR	CountryRegion IS NULL
	OR	Latitude IS NULL 
	OR	Longitude IS NULL 
	OR	Date IS NULL 
	OR	Confirmed IS NULL 
	OR	Deaths IS NULL 
	OR	Recovered IS NULL;

--Q2. If NULL values are present, update them with zeros for all columns. 

UPDATE CoronaData
SET

	Province = COALESCE(Province, 'Not Available'),
	CountryRegion = COALESCE(CountryRegion, 'Not Available'),
	Latitude = COALESCE(Latitude, 0.0),
	Longitude = COALESCE(Longitude, 0.0),
	Confirmed = COALESCE(Confirmed, 0),
	Deaths = COALESCE(Deaths, 0),
	Recovered = COALESCE(Recovered, 0);

-- Q3. check total number of rows

SELECT COUNT(*) AS Total_No_Of_Rows
FROM CoronaData

-- Q4. Check what is start_date and end_date

SELECT MIN(Date) AS Start_Date, MAX(Date) AS End_Date 
FROM CoronaData;


-- Q5. Number of month present in dataset

SELECT 
	COUNT(DATEPART(MONTH, Date)) AS Total_Number_of_Months
FROM CoronaData

SELECT 
	COUNT(DISTINCT DATEPART(MONTH, Date)) AS Number_of_Months
FROM CoronaData

--
DELETE FROM CoronaData
WHERE Date IS NULL;


-- Q6. Find monthly average for confirmed, deaths, recovered

SELECT DATEPART(YEAR, Date) AS Year, DATEPART(MONTH, Date) AS Month, 
       AVG(Confirmed) AS Avg_Confirmed, 
       AVG(Deaths) AS Avg_Deaths, 
       AVG(Recovered) AS Avg_Recovered
FROM CoronaData
GROUP BY DATEPART(YEAR, Date), DATEPART(MONTH, Date)
ORDER BY DATEPART(YEAR, Date), DATEPART(MONTH, Date);



-- Q7. Find most frequent value for confirmed, deaths, recovered each month 

SELECT 
    YEAR(Date) AS Year,
    MONTH(Date) AS Month,
    MAX(Confirmed) AS Confirmed_Most_frq,
    MAX(Deaths) AS Deaths_Most_frq,
    MAX(Recovered) AS Recovered_Most_frq
FROM CoronaData
GROUP BY YEAR(Date), MONTH(Date)
ORDER BY Year, Month;


-- Q8. Find minimum values for confirmed, deaths, recovered per year

SELECT 
    YEAR(Date) AS Year,
    MIN(Confirmed) AS Confirmed_Min,
    MIN(Deaths) AS Deaths_Min,
    MIN(Recovered) AS Recovered_Min
FROM CoronaData
GROUP BY YEAR(Date)
ORDER BY Year;

-- Q9. Find maximum values of confirmed, deaths, recovered per year

SELECT DATEPART(YEAR, Date) AS Year, 
       MAX(Confirmed) AS Max_Confirmed, 
       MAX(Deaths) AS Max_Deaths, 
       MAX(Recovered) AS Max_Recovered
FROM CoronaData
GROUP BY DATEPART(YEAR, Date)
ORDER BY Year;


-- Q10. The total number of case of confirmed, deaths, recovered each month

SELECT DATEPART(YEAR, Date) AS Year, DATEPART(MONTH, Date) AS Month, 
       SUM(Confirmed) AS Total_Confirmed, 
       SUM(Deaths) AS Total_Deaths, 
       SUM(Recovered) AS Total_Recovered
FROM CoronaData
GROUP BY DATEPART(YEAR, Date), DATEPART(MONTH, Date)
ORDER BY DATEPART(YEAR, Date), DATEPART(MONTH, Date);


-- Q11. Check how corona virus spread out with respect to confirmed case
--      (Eg.: total confirmed cases, their average, variance & STDEV )

SELECT ROUND(SUM(Confirmed), 2) AS Total_Confirmed,
       ROUND(AVG(Confirmed), 2) AS Avg_Confirmed,
       ROUND(VAR(Confirmed), 2) AS Var_Confirmed,
       ROUND(STDEV(Confirmed), 2) AS Stdev_Confirmed
FROM CoronaData;


SELECT 
    YEAR(Date) AS Year,
    MONTH(Date) AS Per_Month,
    ROUND(SUM(Confirmed), 2) AS Total_Confirmed,
    ROUND(AVG(Confirmed), 2) AS AVG_Confirmed,
    ROUND(VAR(Confirmed), 2) AS Var_Confirmed,
    ROUND(STDEV(Confirmed), 2) AS Std_Confirmed
FROM CoronaData
GROUP BY YEAR(Date), MONTH(Date)
ORDER BY YEAR(Date), MONTH(Date);


-- Q12. Check how corona virus spread out with respect to death case per month
--      (Eg.: total confirmed cases, their average, variance & STDEV )

SELECT 
    DATEPART(YEAR, Date) AS Year, 
    DATEPART(MONTH, Date) AS Month, 
    ROUND(SUM(Deaths), 2) AS Total_Deaths, 
    ROUND(AVG(Deaths), 2) AS Avg_Deaths, 
    ROUND(VAR(Deaths), 2) AS Var_Deaths, 
    ROUND(STDEV(Deaths), 2) AS Stdev_Deaths
FROM CoronaData
GROUP BY DATEPART(YEAR, Date), DATEPART(MONTH, Date)
ORDER BY Year, Month;

-- Q13. Check how corona virus spread out with respect to recovered case
--      (Eg.: total confirmed cases, their average, variance & STDEV )
SELECT 
    ROUND(SUM(Recovered), 2) AS Total_Recovered,
    ROUND(AVG(Recovered), 2) AS Avg_Recovered,
    ROUND(VAR(Recovered), 2) AS Var_Recovered,
    ROUND(STDEV(Recovered), 2) AS Stdev_Recovered
FROM CoronaData;


SELECT 
    YEAR(Date) AS Year,
    MONTH(Date) AS Per_Month,
    ROUND(SUM(Recovered), 2) AS Total_Recovered,
    ROUND(AVG(Recovered), 2) AS AVG_Recovered,
    ROUND(VAR(Recovered), 2) AS Var_Recovered,
    ROUND(STDEV(Recovered), 2) AS Std_Recovered
FROM CoronaData
GROUP BY YEAR(Date), MONTH(Date)
ORDER BY YEAR(Date), MONTH(Date);


-- Q14. Find Country having highest number of the Confirmed case

SELECT TOP 1 [CountryRegion], SUM(Confirmed) AS Total_Confirmed
FROM CoronaData
GROUP BY [CountryRegion]
ORDER BY Total_Confirmed DESC;


-- Q15. Find Country having lowest number of the death case

SELECT TOP 1 [CountryRegion], SUM(Deaths) AS Total_Deaths
FROM CoronaData
GROUP BY [CountryRegion]
ORDER BY Total_Deaths ASC;


SELECT TOP 4 [CountryRegion], SUM(Deaths) AS Total_Deaths
FROM CoronaData
GROUP BY [CountryRegion]
ORDER BY Total_Deaths ASC;

-- Q16. Find top 5 countries having highest recovered case

SELECT TOP 5 [CountryRegion], SUM(Recovered) AS Total_Recovered
FROM CoronaData
GROUP BY [CountryRegion]
ORDER BY Total_Recovered DESC;
