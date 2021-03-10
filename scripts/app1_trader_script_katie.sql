
/* OPTION 1
approach: only looks at the apps that appear in both stores, since that is client's preference 
downside: possibly filters out a great option that only appear in one store

deliverables: 
1. Develop some general recommendations as to the price range, genre, content rating, 
or anything else for apps that the company should target
2. Develop a Top 10 List of the apps that App Trader should buy next week for its Black Friday debut.
3. Prepare a 5-10 minute presentation for the leadership team of App Trader*/ 

-- the names cte limits the query results to apps that appear in BOTH stores (there are 328)
WITH name AS (SELECT DISTINCT(name)
			FROM play_store_apps
			INNER JOIN app_store_apps
			USING (name)),
-- the psa_calculations cte normalizes the data type for rating and price and 
-- creates the two new columns:
-- the initial cost for App Trader to purchase the app
-- the expected total life span of the app, based on the app rating
-- all for just the play store apps
psa_calculations AS (
	SELECT DISTINCT(name) AS name, 
	genres,
	category,
	content_rating,
	review_count,
	install_count,
	CAST(rating AS FLOAT) AS ps_rating, 
	CAST(replace(price,'$','')AS FLOAT) AS ps_price,
	CASE WHEN CAST(replace(price,'$','')AS FLOAT) <=1 THEN 10000
		ELSE CAST(replace(price,'$','')AS FLOAT)*10000 END AS ps_initial_cost,
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
		WHEN rating = 5 THEN 11 END AS ps_life_span_yr
	FROM play_store_apps),
-- the asa_calculations cte normalizes the data type for rating and price and 
-- creates the two new columns:
-- the initial cost for App Trader to purchase the app
-- the expected total life span of the app, based on the app rating
-- all for just the app store apps
asa_calculations AS (
	SELECT DISTINCT(name) AS name, 
	primary_genre,
	content_rating,
	review_count,
	CAST(rating AS FLOAT) AS as_rating, 
	CAST(price AS FLOAT) AS as_price,
	CASE WHEN CAST(price AS FLOAT) <=1 THEN 10000
		ELSE CAST(price AS FLOAT)*10000 END AS as_initial_cost,
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
		WHEN rating = 5 THEN 11 END AS as_life_span_yr
	FROM app_store_apps)
-- the main query brings the two calculation ctes and LEFT JOINS them to the
-- names cte to limit the results to the 328 apps that appear in both stores
-- also creates a play_store_app profit column, an app_store_app profit column,
-- a marketing cost column and a total profit column
SELECT DISTINCT(name.name),
psa.ps_price,
psa.ps_initial_cost,
--psa.genres,
--psa.category,
--psa.content_rating,
--psa.review_count,
--psa.install_count,
psa.ps_rating,
psa.ps_life_span_yr,
(2500*12*psa.ps_life_span_yr - psa.ps_initial_cost) AS psa_profit,
asa.as_price,
asa.as_initial_cost,
--asa.primary_genre,
--asa.content_rating,
--asa.review_count,
asa.as_rating,
asa.as_life_span_yr,
(2500*12*asa.as_life_span_yr - asa.as_initial_cost) AS asa_profit,
CASE WHEN as_life_span_yr > ps_life_span_yr THEN 1000*12*as_life_span_yr
ELSE 1000*12*ps_life_span_yr END AS marketing_cost,
((2500*12*psa.ps_life_span_yr - psa.ps_initial_cost) + (2500*12*asa.as_life_span_yr - asa.as_initial_cost) - 
CASE WHEN as_life_span_yr > ps_life_span_yr THEN 1000*12*as_life_span_yr ELSE 1000*12*ps_life_span_yr END) AS total_life_span_profit
FROM name
LEFT JOIN psa_calculations AS psa
USING (name)
LEFT JOIN asa_calculations AS asa
USING (name)
ORDER BY ((2500*12*psa.ps_life_span_yr - psa.ps_initial_cost) + (2500*12*asa.as_life_span_yr - asa.as_initial_cost) - 
CASE WHEN as_life_span_yr > ps_life_span_yr THEN 1000*12*as_life_span_yr ELSE 1000*12*ps_life_span_yr END) DESC;
		