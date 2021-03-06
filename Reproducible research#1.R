#Reproducible Research

#Loading and preprocessing the data

#Read csv file
activity <- read.csv("activity.csv", header=TRUE)
#Explore file
str(activity)
head(activity)

#What is mean total number of steps taken per day?

#1. Make a histogram of the total number of steps taken each day
#fist calculate sum of steps
steps <- tapply(activity$steps, activity$date, sum)
#create histrogram
hist(steps)
#2. Calculate and report the mean and median total number of steps taken per day
mean(steps, na.rm=T)
median(steps, na.rm=T)

#What is the average daily activity pattern?

# 1. Make a time series plot (i.e. type = "l") of the 5-minute interval (x-axis) and the average number of steps taken, averaged across all days (y-axis)
steps2 <- tapply(activity$steps, activity$interval, mean, na.rm=T)
plot(steps2, type="l")
# 2.Which 5-minute interval, on average across all the days in the dataset, contains the maximum number of steps?
which.max(steps2)

#Imputing missing values

#Note that there are a number of days/intervals where there are missing values (coded as NA). The presence of missing days may introduce bias into some calculations or summaries of the data.

# 1. Calculate and report the total number of missing values in the dataset (i.e. the total number of rows with NAs)
sum(is.na(activity$steps))
sum(is.na(activity$date))
sum(is.na(activity$interval))
# 2. Devise a strategy for filling in all of the missing values in the dataset. The strategy does not need to be sophisticated. For example, you could use the mean/median for that day, or the mean for that 5-minute interval, etc.
sapply(steps,function(x) ifelse(is.na(x)==T, mean(x,na.rm =T),x))
# 3. Create a new dataset that is equal to the original dataset but with the missing data filled in.
step3 <- sapply(steps,function(x) ifelse(is.na(x)==T, mean(x,na.rm =T),x))
#4. Make a histogram of the total number of steps taken each day and Calculate and report the mean and median total number of steps taken per day. Do these values differ from the estimates from the first part of the assignment? What is the impact of imputing missing data on the estimates of the total daily number of steps?
hist(step3)
mean(step3, na.rm=T)
median(step3, na.rm=T)

# Are there differences in activity patterns between weekdays and weekends?

#For this part the weekdays() function may be of some help here. Use the dataset with the filled-in missing values for this part.

# 1. Create a new factor variable in the dataset with two levels -- "weekday" and "weekend" indicating whether a given date is a weekday or weekend day.
week <- function(date) {
  if (weekdays(as.Date(date)) %in% c("Saturday", "Sunday")) {
    "weekend"
  } else {
    "weekday"
  }
}
week.type <- as.factor(sapply(activity$date, week))
table(week.type)
# 2. Make a panel plot containing a time series plot (i.e. type = "l") of the 5-minute interval (x-axis) and the average number of steps taken, averaged across all weekday days or weekend days (y-axis). 

