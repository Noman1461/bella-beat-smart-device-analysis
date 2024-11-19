weekday_steps <- dailyy_activity%>%
  group_by(week_day) %>%
  summarize(TotalSteps=mean(TotalSteps)) 
view(weekday_steps)

#visualizing weekday_steps for better understanding
ggplot(weekday_steps,aes(x=reorder(week_day, TotalSteps),y=TotalSteps)) +
  geom_bar(stat="identity",fill="blue") +
  labs(title= "Total Steps by Weekday",x="Weekday",y="Total Steps") +
  theme(axis.text.x=element_text(angle=45,hjust=1))


#first agregating each users average total steps per day 
avg_user_steps <- dailyy_activity %>%
  group_by(Id)%>%
  summarise(Average_daily_steps =mean(TotalSteps))

activitylevel_count <-avg_user_steps %>%
  group_by(Acctivitylevel) %>%
  summarize(number_of_users=n())
view(activitylevel_count)

avg_user_steps$Acctivitylevel[avg_user_steps$Average_daily_steps <5000] <- "Sedentary" 
avg_user_steps$Acctivitylevel[avg_user_steps$Average_daily_steps >=5000 & avg_user_steps$Average_daily_steps < 7499] <- " Low Active "
avg_user_steps$Acctivitylevel[avg_user_steps$Average_daily_steps >=7500 & avg_user_steps$Average_daily_steps < 9999] <- " Somewhat Active "
avg_user_steps$Acctivitylevel[avg_user_steps$Average_daily_steps >= 10000 & avg_user_steps$Average_daily_steps < 12499] <- " Active "
avg_user_steps$Acctivitylevel[avg_user_steps$Average_daily_steps >=12500] <- " Highly Active "
view(avg_user_steps)


ggplot(data=dailyy_activity ,aes(x=TotalSteps,y=Calories)) + 
  geom_point()+geom_smooth() +
  labs(title="Total Steps vs Calories Burned")

#creating Total_Active_Minutes column from VeryActive,FairlyActive and LightlyActive mins 
dailyy_activity$Total_Active_Minutes <- dailyy_activity$VeryActiveMinutes+dailyy_activity$FairlyActiveMinutes+dailyy_activity$LightlyActiveMinutes

#visualization
ggplot(data=dailyy_activity,aes(x=TotalActiveMinutes,y=Calories))+ 
  geom_point()+
  labs(title="Total Active Minutes per Calories burned")

ggplot(data=dailyy_activity,aes(x=SedentaryMinutes,y=Calories))+ 
  geom_point()+
  labs(title="Sedentary Minutes per Calories burned")

#split datetime column into date and time
hourly_calories <- hourly_calories %>%
  separate(ActivityHour,into = c("date","time"),sep=" ")

hourly_calories <- hourly_calories %>% 
  group_by(time) %>% 
  drop_na() %>%
  summarise(avg_calories_burned=mean(Calories))

ggplot(data=hourly_calories,aes(x=time,y=avg_calories_burned)) + 
  geom_histogram(stat="identity",fill="blue") +
  labs(title="Average Calories Burned per Time")+
  theme(axis.text.x=element_text(angle=90))