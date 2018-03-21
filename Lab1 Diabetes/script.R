#--Read CSV------------------------------------------------------------------------
my_data = read.csv("C:/Users/user/Documents/Msc/Data Science/Files/Diabetes-md.csv")

head(my_data, 5)
class(my_data)
str(my_data)

#--Assign Column Names-------------------------------------------------------------
cnames <- c("Patient_Name", "NI address", "Type", "Age", "Health_Status")
colnames(my_data) <- cnames

head(my_data)
str(my_data)


#--Refactor Type and Health Satus--------------------------------------------------
type_order <- c("Type 1", "Type 2")
factored_type <- factor(my_data$Type, order = TRUE, levels = type_order)
my_data$Type <- factored_type

health_order <- c("Poor", "Improved", "Excellent")
factored_health <- factor(my_data$Health_Status, order = TRUE, levels = health_order)
my_data$Health_Status <- factored_health

str(my_data)


#--Create Patient Name Data Frame-------------------------------------------------
patient_names <- data.frame(my_data[, c("Patient_Name")])

class(patient_names)
str(patient_names)
head(patient_names, 10)


#--Count the Number of Instances of NA--------------------------------------------
sum(is.na(my_data))

nrow(my_data)
nrow(na.omit(my_data))
#--Count the Number of Rows with NA-----------------------------------------------
nrow(my_data) - nrow(na.omit(my_data))


#--Drop Rows with NA--------------------------------------------------------------
my_clean_data <- na.omit(my_data)

head(my_data, 9) # 8th record originally has NA (Clarissa)
head(my_clean_data, 9) # 8th record has been dropped


#--Count the Number of Rows in the Original and Cleaned Data Frames---------------
cat("Original Count ", nrow(my_data))
cat("New Count      ", nrow(my_clean_data))


my_clean_data
