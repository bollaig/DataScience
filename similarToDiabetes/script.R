colnames <- c("Date", "Country", "Gender", "Age", "Q1", "Q2", "Q3", "Q4", "Q5")
date_col <- c("2018-15-10", "2018-01-11", "2018-21-10", "2018-28-10", "2018-01-05")
country_col <- c("US", "US", "IRL", "IRL", "IRL")
gender_col <- c("M", "F", "F", "M", "F")
age_col <- c(32, 45, 25, 39, 99)
q1_col <- c(5, 3, 3, 3, 2)
q2_col <- c(4, 5, 5, 3, 2)
q3_col <- c(5, 2, 5, 4, 1)
q4_col <- c(5, 5, 5, NA, 2)
q5_col <- c(5, 5, 2, NA, 1)

my_data <- data.frame(date_col, country_col, gender_col, age_col, q1_col, q2_col, q3_col, q4_col, q5_col)
colnames(my_data) <- colnames
my_data$Age[my_data$Age == 99] <- NA
my_data
head(my_data)
str(my_data)

#Create a new column called AgeCat and categorise
my_data$AgeCat[my_data$Age >= 45] <- "Elder"
my_data$AgeCat[my_data$Age >= 26 & my_data$Age <= 44] <- "Middle Aged"
my_data$AgeCat[my_data$Age <= 25] <- "Young"
my_data$AgeCat[is.na(my_data$Age)] <- "Elder"
#Show contents of my_data data frame
my_data

#Factor AgeCat
AgeCat <- factor(my_data$AgeCat, order = TRUE, levels = c("Young", "Middle Aged", "Elder"))
AgeCat
my_data$AgeCat <- AgeCat

summary_col <- q1_col + q2_col + q3_col + q4_col + q5_col
summary_col
my_data <- data.frame(my_data, summary_col)
my_data

cat("date format")
date_format <- "%b %d %y"
today <- Sys.Date()
today
output_date <- format(today, format = date_format)
output_date

#Diff between dates
startdate <- as.Date("2004-02-13")
enddate <- as.Date("2018-01-22")
days <- enddate - startdate
days


?difftime
today <- Sys.Date()
DOB <- as.Date("1979-11-02")
diff_dates <- difftime(today, DOB, units = "weeks")
diff_dates
difftime(today, DOB, units = "hours")
difftime(today, DOB, units = "days")

my_data
new_data <- my_data[order(my_data$Age),]
new_data

attach(my_data)
str(Age)
str(Gender)
new_data <- my_data[order(Gender, Age),]
new_data

new_data

new_data_CC <- complete.cases(new_data)
new_data_CC

new_data_NCC <- !complete.cases(new_data)
new_data_NCC

new_data_omitNA <- na.omit(new_data)
new_data_omitNA

new_data_NA <- !na.omit(new_data)
new_data_NA

cat("sdfdf")
complete_data <- new_data[complete.cases(new_data), ]
complete_data

?mean()

mean(complete_data$Age)

new_data

new_data[new_data$Gender == "M", ]

females <- new_data[new_data$Gender == "F", ]
females

startdate <- "2018-02-05"
enddate <- "2018-20-10"

daterange <- new_data[new_data$Date > startdate & new_data$Date < enddate]
daterange

new_data

my_data

attach(my_data)
new_data <- subset(my_data, Gender == "M" & Age < 35, select = c(Gender: Q4))
new_data


