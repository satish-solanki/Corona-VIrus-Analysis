SELECT * FROM corona_dataset.`corona virus dataset final`;

-- Q1. Write a code to check NULL values
SELECT * from corona_dataset.`corona virus dataset final`
where	Province is null or
		Country is null or	
        Latitude is null or	
        Longitude is null or
        Date is null or 
        Confirmed is null or 
        Deaths is null or
        Recovered is null;
        
-- If NULL values are present, update them with zeros for all columns.

UPDATE corona_dataset.`corona virus dataset final`
SET Province = COALESCE(Province, 0),
    Country = COALESCE(Country, 0),
    Latitude = COALESCE(Latitude, 0),
    Longitude = COALESCE(Longitude, 0),
    Date = COALESCE(Date, 0),
    Confirmed = COALESCE(Confirmed, 0),
    Deaths = COALESCE(Deaths, 0),
    Recovered = COALESCE(Recovered, 0)
where	Province is null or
		Country is null or	
        Latitude is null or	
        Longitude is null or
        Date is null or 
        Confirmed is null or 
        Deaths is null or
        Recovered is null;
        
-- Q3. check total number of rows
 
select count(*) from corona_dataset.`corona virus dataset final`;	

-- Q4. Check what is start_date and end_date

SELECT min(date) as Start_Date, max(date) as End_Date
from corona_dataset.`corona virus dataset final`;

-- Q5. Number of month present in dataset

select extract(month from Date) as month_number , count(*) as month_count 
from corona_dataset.`corona virus dataset final`
group by month_number
order by month_number;

-- Q6. Find monthly average for confirmed, deaths, recovered

select extract(year from Date) as year_num, extract(month from Date) as month_num,
round(avg(Confirmed),2) as confirmed_avg,
round(avg(Deaths),2) as deaths_avg,
round(avg(Recovered),2) as recovered_avg
from corona_dataset.`corona virus dataset final`
group by year_num, month_num
order by year_num, month_num;

-- 	Q7. Find most frequent value for confirmed, deaths, recovered each month
 
 
SELECT YEAR(Date) AS YEAR_ , MONTH(Date) AS MONTH_ ,
MAX(Confirmed) as most_frequent_confirmed,
MAX(Deaths) as most_frequent_deaths,
MAX(Recovered) as most_frequent_recovered 
FROM corona_dataset.`corona virus dataset final`
GROUP BY YEAR_ , MONTH_
ORDER BY YEAR_, MONTH_;

-- Q8. Find minimum values for confirmed, deaths, recovered per year

SELECT YEAR(Date) AS YEAR_, MIN(Confirmed) AS min_confirmed,
MIN(Deaths) AS min_deaths,
MIN(Recovered) AS min_recovered
FROM corona_dataset.`corona virus dataset final`
GROUP BY YEAR_;

-- Q9. Find maximum values of confirmed, deaths, recovered per year

SELECT YEAR(Date) AS YEAR_, MAX(Confirmed) AS max_confirmed,
MAX(Deaths) AS max_deaths,
MAX(Recovered) AS max_recovered
FROM corona_dataset.`corona virus dataset final`
GROUP BY YEAR_;

-- Q10. The total number of case of confirmed, deaths, recovered each month

SELECT YEAR(Date) AS YEAR_, MONTH(Date) AS MONTH_, 
SUM(Confirmed) AS sum_confirmed,
SUM(Deaths) AS sum_deaths,
SUM(Recovered) AS sum_recovered
FROM corona_dataset.`corona virus dataset final`
GROUP BY YEAR_, MONTH_;

-- Q11. Check how corona virus spread out with respect to confirmed case
--      (Eg.: total confirmed cases, their average, variance & STDEV )

SELECT YEAR(Date) AS YEAR_, SUM(Confirmed) AS TOTAL_CONFIRMED, 
AVG(Confirmed) AS AVG_CONFIRMED, 
VARIANCE(Confirmed) AS VARIANCE_CONFIRMED,
stddev(Confirmed) AS STDDEV_CONFIRMED
FROM corona_dataset.`corona virus dataset final`
group by YEAR_
order by YEAR_;

-- Q12. Check how corona virus spread out with respect to death case per month
--      (Eg.: total confirmed cases, their average, variance & STDEV )

SELECT YEAR(Date) AS YEAR_, MONTH(Date) AS MONTH_,  
SUM(Deaths) AS TOTAL_DEATHS, 
AVG(Deaths) AS AVG_DEATHS ,
ROUND(variance(Deaths),2) AS VARIANCE_DEATHS,
ROUND(stddev(Deaths),2) AS STDDEV_DEATHS
FROM corona_dataset.`corona virus dataset final`
group by YEAR_, MONTH_
order by YEAR_, MONTH_;

-- Q13. Check how corona virus spread out with respect to recovered case
--      (Eg.: total confirmed cases, their average, variance & STDEV )


SELECT YEAR(Date) AS YEAR_, MONTH(Date) AS MONTH_,  
SUM(Recovered) AS TOTAL_RECOVERED, 
AVG(Recovered) AS AVG_RECOVERED ,
ROUND(variance(Recovered),2) AS VARIANCE_RECOVERED,
ROUND(stddev(Recovered),2) AS STDDEV_RECOVERED
FROM corona_dataset.`corona virus dataset final`
group by YEAR_, MONTH_
order by YEAR_, MONTH_;

-- Q14. Find Country having highest number of the Confirmed case

SELECT Country, SUM(Confirmed) AS HIGHEST_CONFIRMED
FROM corona_dataset.`corona virus dataset final`
group by Country
ORDER BY  HIGHEST_CONFIRMED DESC
LIMIT 1;

-- Q15. Find Country having lowest number of the death case

WITH RANKING_COUNTRY AS
(SELECT 
	Country, SUM(Deaths) AS LOWEST_DEATHS, 	
    rank()over(ORDER BY SUM(Deaths) ASC) AS RANKING
	FROM corona_dataset.`corona virus dataset final`
	GROUP BY Country)
SELECT Country, LOWEST_DEATHS
FROM RANKING_COUNTRY 
WHERE RANKING = 1;

-- Q16. Find top 5 countries having highest recovered case

SELECT Country, SUM(Recovered) AS TOTAL_RECOVERD_CASES
FROM corona_dataset.`corona virus dataset final`
GROUP BY Country
ORDER BY TOTAL_RECOVERD_CASES DESC
LIMIT 5;