library(tidyverse)
library(lubridate)

#pulling data from SQL
library(DBI)
con <- dbConnect(odbc::odbc(), driver = "ODBC Driver 17 for SQL Server", 
                 server = "DESKTOP-FH5T65I\\SQLEXPRESS", database = "Google CaseStudyFitBit", Trusted_Connection = "Yes")


#selecting all data from our chosen tables
dailyy_activity <-dbGetQuery(con,"select * from dailyActivity_merged")
hourly_calories <-dbGetQuery(con,"select * from hourlyCalories_merged")
hourly_intensities <-dbGetQuery(con,"select * from hourlyintensities_merged")
hourly_steps<-dbGetQuery(con,"select * from hourlySteps_merged")
daily_sleep <-dbGetQuery(con,"select * from sleepDay_merged")

#previewing data
head(dailyy_activity)
head(hourly_calories)
head(hourly_intensities)
head(hourly_steps)
head(daily_sleep)

#checking structure of columns
glimpse(dailyy_activity)
glimpse(hourly_calories)
glimpse(hourly_intensities)
glimpse(hourly_steps)
glimpse(daily_sleep)

#converting date column into date format
dailyy_activity$ActivityDate <- ymd(dailyy_activity$ActivityDate)
hourly_calories$ActivityHour <- ymd_hms(hourly_calories$ActivityHour)
hourly_intensities$ActivityHour <- ymd_hms(hourly_intensities$ActivityHour)
hourly_steps$ActivityHour <- ymd_hms(hourly_steps$ActivityHour)
daily_sleep$date <- ymd(daily_sleep$date)

#coverting numerical columns from chr to num
dailyy_activity <- dailyy_activity %>% mutate_if(is.character,as.numeric)

summary(dailyy_activity)
summary(hourly_calories)
summary(hourly_intensities)
summary(hourly_steps)
summary(daily_sleep)
