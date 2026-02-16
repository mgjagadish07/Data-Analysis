
-- Q1 List the country wise restaurants
select z.restaurantName, c.Country
from zomata z
join countrycode c 
ON z.countrycode = c.countrycode;

#Q2 Build a Calendar Table using the Column Datekey Add all the below Columns in the Calendar Table using the Formulas.

CREATE TABLE calendar AS SELECT DISTINCT 
Datekey_Opening AS Date,year(Datekey_Opening) as Year,month(Datekey_Opening) as monthnumber,monthname(Datekey_Opening) as monnth_name,concat('Q',quarter(Datekey_Opening)) as Quarter,
DATE_FORMAT(Datekey_Opening, '%Y-%b') AS YearMonth, WEEKDAY(Datekey_Opening) + 1 AS WeekdayNo, DAYNAME(Datekey_Opening) AS WeekdayName,
CASE WHEN MONTH(Datekey_Opening) >= 4 THEN MONTH(Datekey_Opening) - 3 ELSE MONTH(Datekey_Opening) + 9 END AS FinancialMonth, 
CASE WHEN MONTH(Datekey_Opening) BETWEEN 4 AND 6 THEN 'FQ1' WHEN MONTH(Datekey_Opening) BETWEEN 7 AND 9 THEN 'FQ2'
WHEN MONTH(Datekey_Opening) BETWEEN 10 AND 12 THEN 'FQ3' ELSE 'FQ4' END AS FinancialQuarter FROM zomata;
select  * from calendar;

#Q3 Find the Numbers of Resturants based on City and Country.
SELECT z.city,c.country,COUNT(z.restaurantname) AS number_of_restaurants
FROM zomata z JOIN countrycode c ON z.countrycode = c.countrycode
GROUP BY z.city,c.country ORDER BY number_of_restaurants desc;


#Q4.Numbers of Resturants opening based on Year , Quarter , Month
select year(datekey_opening) as year,concat("Q",quarter(datekey_opening))as quarter,
monthname(datekey_opening) as month_name,count(RestaurantID) as total_restaurent_count from zomata 
group by YEAR(datekey_opening),CONCAT('Q', QUARTER(datekey_opening)),
MONTH(datekey_opening),MONTHNAME(datekey_opening) order by year,quarter,month_name,total_restaurent_count;
   
   
#Q5 Count of Resturants based on Average Ratings

SELECT 
CASE 
WHEN Rating BETWEEN 0 AND 1 THEN '0–1 Poor'
WHEN Rating BETWEEN 1.1 AND 2 THEN '1–2 Below Avg'
WHEN Rating BETWEEN 2.1 AND 3 THEN '2–3 Average'
WHEN Rating BETWEEN 3.1 AND 4 THEN '3–4 Good'
WHEN Rating BETWEEN 4.1 AND 5 THEN '4–5 Excellent'
ELSE 'No Rating'
END AS Rating_Bucket,
COUNT(RestaurantID) AS Restaurant_Count
FROM zomata
GROUP BY Rating_Bucket
ORDER BY Rating_Bucket;

-- Q6 Create buckets based on Average Price of reasonable size and find out how many resturants falls in each buckets --  
select *from zomata;
select 
case
when Average_Cost_for_two between 0 and 500 then "0-500"
when Average_Cost_for_two between 501 and 1000 then "501-1000"
when Average_Cost_for_two between 1001 and 1500 then "1001-1500"
else '2000+' 
END AS Price_Bucket,
    COUNT(RestaurantID) AS Restaurant_Count
FROM zomata
GROUP BY Price_Bucket
ORDER BY Price_Bucket;


#Q7 7.Percentage of Resturants based on "Has_Table_booking"
SELECT Has_Table_booking,COUNT(*) AS Restaurant_Count,
ROUND(100 * COUNT(*) / (SELECT COUNT(*) FROM zomata), 2) AS Percentage
FROM zomata
GROUP BY Has_Table_booking;

#Q8 percantage of restaurents based on "has_online_delivery"

select has_online_delivery,count(*) as restaurent_count,round(100*count(*)/(select count(*) from zomata), 2) as percentage
from zomata 
group by has_online_delivery;

#Q9
#A Restaurants by Cuisine
SELECT Cuisines, COUNT(RestaurantID) AS Restaurant_Count
FROM zomata
GROUP BY Cuisines
ORDER BY Restaurant_Count DESC;


#B Restaurants by City

SELECT City, COUNT(RestaurantID) AS Restaurant_Count
FROM zomata
GROUP BY City
ORDER BY Restaurant_Count DESC;


#C Restaurants by Rating

SELECT Rating, COUNT(RestaurantID) AS Restaurant_Count
FROM zomata
GROUP BY Rating
ORDER BY Rating DESC;
