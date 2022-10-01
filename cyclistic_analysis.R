#This file contains all of the aggregations, calculations, and plots that informed my analysis, dashboard, conclusions, and recommendations

#count of trips per month, grouped by member type

monthly_ride_count <- trips_cleaned_v5 %>% 
  group_by(month, member_type) %>% 
    summarize(ride_count = n()) %>% 
      arrange(desc(ride_count))

#plot for monthly ride count(Note: I think using position = "dodge" on this graph makes it easier to distinguish
#the different months, but the side-by-side view makes it easier to see the differences between the two groups)

ggplot(data = trips_cleaned_v5) + 
  geom_bar(mapping = aes(x = month, fill = member_type), position = "dodge") +
    scale_y_continuous(labels = scales::comma) +
      theme(axis.text.x = element_text(angle = 45)) +
        labs(title = "Monthly ride count by member category", x = "month", y = "ride count")

#count of trips by day of week, grouped by member type 

weekly_ride_count <- trips_cleaned_v5 %>% 
  group_by(day, member_type) %>% 
    summarize(ride_count = n()) %>% 
      arrange(desc(ride_count))

#plot for weekly ride count

ggplot(data = trips_cleaned_v5) + 
  geom_bar(mapping = aes(x = day, fill = member_type), position = "dodge") +
    scale_y_continuous(labels = scales::comma) +
      theme(axis.text.x = element_text(angle = 45)) +
         labs(title = "Weekly ride count by member category", x = "day of week", y = "ride count")

#average trip duration by month, grouped by member category

avg_trip_by_month <- trips_cleaned_v5 %>% 
  group_by(month, member_type) %>% 
    summarize(avg_trip_duration = mean(trip_duration_min))

#plot for average trip duration by month

ggplot(data = avg_trip_by_month) + 
  geom_bar(mapping = aes(x = month, y = avg_trip_duration, fill = member_type), stat = "identity") +
    scale_y_continuous(labels = scales::comma) +
      theme(axis.text.x = element_text(angle = 45)) +
        labs(title = "Average monthly trip duration", x = "month", y = "average trip duration")

#average trip duration by day of week, grouped by member category

avg_trip_by_day <- trips_cleaned_v5 %>% 
  group_by(day, member_type) %>% 
    summarize(avg_day_trip = mean(trip_duration_min)) %>% 
      arrange(desc(avg_day_trip))

#plot for average trip duration by day of week

ggplot(data = avg_trip_by_day) + 
  geom_bar(mapping = aes(x = day, y = avg_day_trip, fill = member_type), stat = "identity") +
    scale_y_continuous(labels = scales::comma) +
      theme(axis.text.x = element_text(angle = 45)) +
        labs(title = "Average trip duration by day", x = "day of week", y = "average trip duration")

#plot to visualize which bicycle type is preferred for each member category

ggplot(data = trips_cleaned_v5) + 
  geom_bar(mapping = aes(x = bicycle_type, fill = member_type)) +
    scale_y_continuous(labels = scales::comma) +
      labs(title = "Preferred bicycle type", x = "type of bicycle", y = "number of trips") 

#most frequently used start station by member type

start_station_groupings <- trips_cleaned_v5 %>% 
  group_by(start_station, member_type) %>% 
    summarize(ride_count = n()) %>% 
      arrange(desc(ride_count))

#top 5 start stations by member type 

popular_start_points <- start_station_groupings %>% 
  arrange(desc(ride_count)) %>% 
    group_by(member_type) %>% 
      slice(1:5)

#plot for trip start hour

start_hr_table <- trips_cleaned_v5 %>% 
  group_by(start_hr, member_type) %>% 
    summarize(ride_count = n()) %>% 
      arrange(desc(ride_count))

ggplot(data = start_hr_table)+
  geom_point(mapping = aes(x= start_hr, y = ride_count, color = member_type))+
    scale_y_continuous(labels = scales::comma) +
      labs(title = "Ride counts by starting hour", x = "trip starting hour", y = "ride count")
