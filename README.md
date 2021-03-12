## App Trader

![first page of powerpoint](../main/images/App_Trader_front_page.jpg)
<br>
<br>
Note: This was a group project at Nashville Software School.  However, the analysis, scripts, visualizations and PowerPoint presentation within the repository were all created by me.
<br>
<br>

## Table of Contents
* [General Information](#general-information)
* [Technologies](#technologies)
* [Files in this Repository](#files)
* [Analysis](#analysis)
<br>

## <a name="general-information"></a>General Information
Our team has been hired by a mock company called App Trader to help them explore and gain insights from apps that are made available through the Apple App Store and Android Play Store. Unfortunately, the data for app store is located in a separate table with no referential integrity.

App Trader is a broker that purchases the rights to apps from developers in order to market the apps and offer in-app purchase. App developers retain **all** money from users purchasing the app, and they retain _half_ of the money made from in-app purchases. App Trader will be solely responsible for marketing apps they purchase rights to.  
<br>

<u>Assumptions</u>
a. App Trader will purchase apps for 10,000 times the price of the app for each app store. For apps that are priced from free up to $1.00, the purchase price is $10,000.  
b. Apps earn $5000 per month on average from each app store from in-app advertising and in-app purchases _regardless_ of the price of the app.  
c. App Trader will spend an average of $1000 per month to market an app _regardless_ of the price of the app. If App Trader owns rights to the app in both stores, it can market the app for both stores for a single cost of $1000 per month.  
d. For every half point that an app gains in rating, its projected lifespan increases by one year, in other words, an app with a rating of 0 can be expected to be in use for 1 year, an app with a rating of 1.0 can be expected to last 3 years, and an app with a rating of 4.0 can be expected to last 9 years. Ratings should be rounded to the nearest 0.5 to evaluate an app's likely longevity.  
e. App Trader would prefer to work with apps that are available in both the App Store and the Play Store since they can market both for the same $1000 per month. 
<br>

## <a name="technologies"></a>Technologies
Project is created with:
* SQL (Postgres) for all analysis
* Excel for data visualizations
* Power Point for final client presentation
<br>

## <a name="files"></a>Files in this Repository
* All SQL scripts are in the scripts folder.  
* The exported csv files are in the folder named csv_files_for_visualizations.  
* The final PowerPoint presentation is the PDF named App_Trader_ksylvester. 
<br>

## Analysis
The entire analysis was completed in SQL utilizing two 2 disparate data sets:  Apple app store data and Android Play Store data.  The app stores had a different rating, genre category and age recommendation for each app which required reconciling before conducting an analysis.

My first step in the analysis was to narrow down the list to only apps that were present in both app stores. Then I determined the profitabiliy for each app based on the provided metrics and sorted from most profitable to least, which required some complex calculations and lengthy SQL code.  To ensure that I was truly finding the most profitable apps, regardless of which store(s) they were present in, I conducted a second analysis to determine profitability of all apps. These calculations were even more complex and again required lengthly SQL code.  I found that the most profitable apps matched the results from the first, narrowed down list, which confirmed the hypothesis that the most profitable apps were present in both app stores. 

I found the top 7 most profitable apps based on profitability alone, but the apps that had rankings from 8 to 50+ all had the same profitability. This meant there would be some subjectivity in selecting the last three recommendations for App Trader.  Since the profitability calculations are based on the total lifespan of an app, it would be wise of App Trader to buy apps that are earlier in their product life cycle to maximize their profits.  Since there was no clearcut metric in place for where each app was in its product life cycle, I utilized the download count and found three apps that had a lower download count than the others with the same calculated profitability.  This completed the Top 10 recommendation list for App Trader.  

I also further explored the data to make more general observations such as average app profitability based on app price point, content rating, and genre.

Once the SQL analysis was complete, I exported csv files into Excel for data visualizations and prepared a polished presentation in PowerPoint.

