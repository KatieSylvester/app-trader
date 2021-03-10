/* misc app trader calculations and queries */


SELECT *
FROM play_store_apps
LIMIT 200;


SELECT *
FROM play_store_apps
WHERE name ILIKE '%clash of clans%';

SELECT distinct genres
FROM play_store_apps;

SELECT price, CAST(replace(price,'$','')::NUMERIC)
FROM play_store_apps

SELECT
COUNT (*)
FROM app_store_apps;

SELECT
COUNT (*)
FROM play_store_apps;

SELECT name, price, rating, primary_genre
FROM play_store_apps
FULL JOIN app_store_apps
USING (name)
LIMIT 100;

WITH calculations AS (
	SELECT name AS name, 
	rating AS rating, 
	CAST(replace(price,'$','')AS NUMERIC) AS price_num,
	CASE WHEN CAST(replace(price,'$','')AS NUMERIC) <=1 THEN 10000
		ELSE CAST(replace(price,'$','')AS NUMERIC)*10000 END AS initial_cost,
	CASE WHEN rating IS NULL THEN 1
		WHEN rating <.5 THEN 1
		WHEN rating <1 THEN 2
		WHEN rating <1.5 THEN 3
		WHEN rating <2 THEN 4
		WHEN rating <2.5 THEN 5
		WHEN rating <3 THEN 6
		WHEN rating <3.5 THEN 7
		WHEN rating <4 THEN 8
		WHEN rating <4.5 THEN 9
		WHEN rating <5 THEN 10 
		WHEN rating = 5 THEN 11 END AS life_span_yr
	FROM play_store_apps)
SELECT 
	psa.name,  
	psa.price,
	initial_cost,
	psa.rating,
	life_span_yr,
	life_span_yr*12*1500 - initial_cost AS profit 
FROM play_store_apps AS psa
JOIN calculations
USING (name)
ORDER BY profit DESC;

----------

SELECT DISTINCT(name)
FROM (SELECT name
				FROM play_store_apps
			  	UNION
			   	SELECT name
				FROM app_store_apps) AS subquery