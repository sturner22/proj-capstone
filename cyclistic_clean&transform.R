#set my working directory so I can import the files

setwd("C:\\Users\\st041\\OneDrive\\Datasets\\case_studies\\cyclistic\\2021_data")

#load libraries

library(tidyverse)
library(lubridate)
library(janitor)

#import all of the data

jan_2021 <- read.csv("jan_2021.csv", na.strings = c("", "NA")) 
feb_2021 <- read.csv("feb_2021.csv", na.strings = c("", "NA"))
march_2021 <- read.csv("march_2021.csv", na.strings = c("", "NA"))
april_2021 <- read.csv("april_2021.csv", na.strings = c("", "NA"))
may_2021 <- read.csv("may_2021.csv", na.strings = c("", "NA"))
june_2021 <- read.csv("june_2021.csv", na.strings = c("", "NA"))
july_2021 <- read.csv("july_2021.csv", na.strings = c("", "NA"))
aug_2021 <- read.csv("aug_2021.csv", na.strings = c("", "NA"))
sep_2021 <- read.csv("sep_2021.csv", na.strings = c("", "NA"))
oct_2021 <- read.csv("oct_2021.csv", na.strings = c("", "NA"))
nov_2021 <- read.csv("nov_2021.csv", na.strings = c("", "NA"))
dec_2021 <- read.csv("dec_2021.csv", na.strings = c("", "NA"))

#consolidate all files into one dataframe

trips_2021 <- rbind(jan_2021, feb_2021, march_2021, april_2021, may_2021, june_2021,
  july_2021, aug_2021, sep_2021, oct_2021, nov_2021, dec_2021)

#remove incomplete records from the data set

trips_2021_v2 <- na.omit(trips_2021)

#convert data type for started_at and ended_at from character to date-time: 

trips_2021_v3 <- trips_2021_v2 %>% 
  mutate(ride_start = mdy_hm(started_at), 
    ride_end = mdy_hm(ended_at))

#add new field for month 

trips_2021_v4 <- trips_2021_v3 %>% 
  mutate(month = strftime(ride_start, "%m"))

#add a new field for day of week

trips_2021_v5 <- trips_2021_v4 %>% 
  mutate(weekday = strftime(ride_start, "%A"))

#add a new field for trip duration

trips_2021_v6 <- trips_2021_v5 %>% 
  mutate(ride_duration = ride_end - ride_start)

#convert data type in ride_duration to integer so I can use it in calculations

trips_2021_v7 <- trips_2021_v6 %>% 
  mutate(trip_duration = as.integer(ride_duration))

#ride_duration was returned in seconds, convert to minutes

trips_2021_v8 <- trips_2021_v7 %>% 
  mutate(trip_duration_min = trip_duration/60)

#to remove outliers in trip duration, drop rows with trip_duration_min < 2 or > 1440 (24 hours)

trips_2021_v9 <- trips_2021_v8 %>% 
  filter(trip_duration_min >=2, trip_duration_min <= 1440)

#checking to ensure this calculated correctly: 

test_1 <- trips_2021_v9 %>% 
  filter(trip_duration_min < 2, trip_duration_min > 1440)

#filter out duplicate rows based on ride_id

trips_2021_v10 <- trips_2021_v9 %>% 
  distinct(ride_id, .keep_all = TRUE)

#trim extra space in start station and end station fields

trips_2021_v11 <- trips_2021_v10 %>% 
  mutate(start_station = str_squish(start_station_name),
         end_station = str_squish(end_station_name))

#time to clean up the data frame and drop fields no longer needed

trips_cleaned <- trips_2021_v11 %>% 
  select(ride_id, bicycle_type, member_type, ride_start, ride_end, start_station, start_station_id, 
    end_station, end_station_id, trip_duration_min, month, weekday, start_lat, start_lng, end_lat, end_lng) 

#drop records that indicate the trip was actually for maintenance purposes

trips_cleaned_v2 <- trips_cleaned %>% 
  filter(end_station_id != "Hubbard Bike-checking (LBS-WH-TEST)")


#I want the month spelled out instead of being represented by a number. First I'm going to change the name of the data 
#frame to make it easier to read and write this next set of code

trips_cleaned_v2.1 <- trips_cleaned_v2 %>% 
  mutate(trip_month = as.integer(month))

v3 <- trips_cleaned_v2.1

v3$ride_month <- ifelse(v3$trip_month == 1, "Jan",
                   ifelse(v3$trip_month == 2, "Feb",
                     ifelse(v3$trip_month == 3, "March",
                       ifelse(v3$trip_month == 4, "April",
                        ifelse(v3$trip_month == 5, "May",
                          ifelse(v3$trip_month == 6, "June",
                            ifelse(v3$trip_month == 7, "July",
                              ifelse(v3$trip_month == 8, "Aug",
                                ifelse(v3$trip_month == 9, "Sep",
                                  ifelse(v3$trip_month == 10, "Oct",
                                    ifelse(v3$trip_month == 12, "Nov", "Dec")))))))))))


#change factor levels so months and weekdays appear in order on plots

v3$month <- factor(v3$ride_month, levels = c("Jan", "Feb", "March", "April", "May",
  "June", "July", "Aug", "Sep", "Oct", "Nov", "Dec"))

v3$day <- factor(v3$weekday, level = c("Monday", "Tuesday", "Wednesday", "Thursday", 
  "Friday", "Saturday", "Sunday"))

#new data frame to remove fields no longer needed

trips_cleaned_v4 <- v3 %>% 
  select(everything(), -ride_month, -weekday)

#adding a field for the trip start hour to be used in analysis

trips_cleaned_v5 <- trips_cleaned_v4 %>% 
  mutate(start_hr = hour(ride_start))

#trips_cleaned_v5 is the data frame I will use to start calculations, aggregations, and plots to look for trends



