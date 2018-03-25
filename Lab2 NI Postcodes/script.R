
#--Read CSV------------------------------------------------------------------------
my_data = read.csv("C:/Users/user/Documents/Msc/Data Science/Files/NIPostcodes.csv")
my_backup <- my_data
#my_data <- my_backup

# Show the structure and first 10 rows of the dataframe containing all of the NIPostcode data.
str(my_data)
head(my_data, 10)

# Show the total number and mean missing values of the NIPostcode data.
my_data[my_data == ""] <- NA # replace blanks with NA
head(my_data, 10)
missing_vals <- sum(is.na(my_data))
missing_vals


rowSum <- rowSums(is.na(my_data))
class(rowSum)
str(rowSum)
mean(rowSum)
sum(rowSum)

mean(rowSums(is.na(my_data)))  # mean(vector of NA counts per row)


nrow(my_data)
nrow(na.omit(my_data))

# Add a suitable title to each attribute of the data.
cols <- c("Organisation_Name", "Sub-building_Name", "Building_Name", "Number", "Primary_Thorfare", "Alt_Thorfare", "Secondary_Thorfare", "Locality", "Townland", "Town", "County", "Postcode", "x-coordinates", "y-coordinates", "Primary_Key")
colnames(my_data) <- cols
head(my_data, 10)
str(my_data)

head(my_data$County, 10)
class(County)
#head(my_data[ ,12],10)
# Remove or replace missing entries with a suitable identifier. Decide whether it is best to remove missing data or to recode it.

attach(my_data)
nrow(my_data)  # count before
my_data <- my_data[!is.na(Postcode), ]  # drop if Postcode = NA
nrow(my_data)  # count after
head(my_data, 10)


# Modify the County attribute to a categorising factor.
my_data <- my_backup2
attach(my_data)

head(my_data$County, 10)

counties <- c("Antrim", "Derry", "Armagh", "Down", "Fermanagh", "Tyrone" )
categorised_county <- factor(County, levels = counties)
County <- categorised_county
my_backup2 <- my_data
head(my_data$County, 10)

# Align all attributes and relevant data.

str(my_data)

my_data <- my_data[c(15, 1:14)]

str(my_data)

# Move the primary key identifier to the start of the dataset.


# Create a new dataset called Limavady_data. Store within it only information that has locality, townland and town containing the name “Limavady”. Store this information in an external csv file called Limavady.

attach(my_data)


library(stringr)

limavady_data <- my_data[grep("limavady", ignore.case = TRUE, my_data$Townland),] # match the pattern of limavady in townland first

limavady_data <- limavady_data[grep("limavady", ignore.case = TRUE, limavady_data$Locality),] # match the pattern of limavady in locality from the first subset

limavady_data <- subset(limavady_data, Town == "LIMAVADY") # further refine by town and locality

head(limavady_data[, c(9, 10, 11)],10)
nrow(limavady_data)





#Save the contents of my_lotto_data to a csv
write.csv(limavady_data, file = "C:/Users/user/Documents/Msc/Data Science/Files/limavady.csv", quote = FALSE, na = " ", row.names = FALSE)


# Save the modified dataset in a csv file called CleanNIPostcodeData.

write.csv(my_data, file = "C:/Users/user/Documents/Msc/Data Science/Files/CleanNIPostcodeData.csv", quote = FALSE, na = " ", row.names = FALSE)







