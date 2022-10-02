 # Google Data Analytics Professional Certificate Capstone Project
 ## Cyclistic Bike-share Case Study

I completed this case study for the Google Data Analytics Professional Certificate capstone project. To organize the project, I followed the six phases of the data analysis process, which are outlined below. 

This repository contains the R code I wrote throughout the cleaning, exploration, and analysis process. My main takeaways from the data are presented in a Tableau dashboard, which you can access here: https://public.tableau.com/app/profile/sarah.turner4702/viz/CyclisticBikeShareCaseStudy_16647420931620/WeeklyTrends

### Ask
Cyclistic, a bike share company in Chicago, wants to increase its number of annual memberships. The marketing team seeks to understand how casual riders and riders with annual memberships use Cyclistic bikes differently. These insights will enable the team to devise a new marketing strategy to convert casual riders to annual members, as the company’s finance analysts have determined that annual members are more profitable than casual riders. Cyclistic customers who purchase a single ride pass or full-day pass are categorized as casual riders, and customers who purchase an annual pass are annual members. 

Business task: Determine how annual members and casual riders use Cyclistic bikes differently. Use these insights to devise a marketing strategy to convert casual riders into annual members. 

### Prepare
I selected trip data from January 2021 through December 2021 for the analysis. I chose this time period to analyze trends and patterns over a complete calendar year. There are separate csv files for each month, each with several hundred thousand rows of data. Due to the size of the files, I chose to do all of the cleaning and analysis in R. 

### Process
I cleaned, organized, and transformed the data to prepare it for analysis in RStudio. This process included the following steps: 
* loaded the csv files for each month and then compiled them all into one dataframe 
* removed duplicate rows based on the ride_id field 
* renamed fields to better reflect the data they contained
* changed the data type for the started_at and ended_at fields from character to date-time 
* removed all incomplete records
* trimmed extra white space in character fields
* investigated formatting in fields to locate and remove errors in the data 
* identified and removed outlying values for trip durations (i.e. trips that were longer than 24 hours or shorter than 2 minutes were dropped from the data frame)
* added fields for trip duration, month, day of week, and start time to the data frame

### Analyze
I completed the following calculations and aggregations in R to analyze the data for trends and patterns, keeping an eye out for differences between the two rider categories
* average, maximum, and minimum trip durations by rider category
* count of trips by month and day of week for each rider category
* identified the top 5 start stations for each rider category 
* preferred bicycle types for each rider category
* count of trips grouped by the hour the trip started and by rider category

I used ggplot2 to create a graph of each aggregation or calculation. This visual helped me more easily notice trends, patterns, and differences between the two rider categories. 

Through the analysis process, I realized that the data had some limitations:
* The starting and ending latitude and longitude was provided; however, there were many riders that appeared to make a "round trip," starting and ending at the same station. I attempted to calculate the trip distance in addition to the trip duration, however, this was not possible due to limitation described above. 
* There was no information provided about the rider, such as age, or a unique identifier for the specific rider (there was just a unique ride id for each trip). This additional detail may have revealed other relationships between age group and ride patterns, or it may have shown if the same casual riders were logging a lot of trips.

### Share 
I created a Tableau dashboard to summarize the key differences between casual riders and annual members. View this dashboard here: https://public.tableau.com/app/profile/sarah.turner4702/viz/CyclisticBikeSharecasestudy/Locationrideduration_1

### Act
Based on my analysis, these are my top three recommendations for Cyclistic: 
* The data shows that casual riders log the most trips on the weekends. Based on this information, I recommend Cyclistic consider creating membership categories for weekends only. The weekends-only category would be a type of annual membership that includes trips only on weekends. Since weekends-only members may also occassionally want to rent a bike during a weekday, Cyclistic can offer a discounted rate for weekday trips to make this membership option even more attractive. 
* Casual riders log the most trips during the summer months of June, July, and August. Offering discounted rates for annual memberships or other incentives during June through August may reach a wider range of casual riders and convince them to purchase an annual membership. Alternatively, Cyclistic may consider creating a "summer months" membership category to cater to the casual riders who make the most use of Cyclistic bicycles during the summer. 
* Casual riders consistently log longer trips than annual members. Assuming that a trip that is longer in duration is also likely to be longer in distance (this would need to be verified with additional data), Cyclistic can create a fun "distance challenge" for casual members to participate in, inviting people to log miles ridden on Cyclistic bikes over a certain period of time. Cyclistic can create "prizes" for participants, such as discounts on the first year of an annual membership. 

Finally, if Cyclistic is able to obtain an email address or phone number from casual riders when they purchase a single-ride or all-day pass, they should consider surveying casual riders to gather more information about how and why they use Cyclistic bikes. The survey results will likely provide additional insight into how Cyclistic can tailor their membership options to attract more annual members. 

<b>Note:</b> Cyclistic is a fictional company. 



