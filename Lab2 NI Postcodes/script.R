
#--Read CSV------------------------------------------------------------------------
my_data = read.csv("C:/Users/user/Documents/Msc/Data Science/Files/NIPostcodes.csv")


# Show the structure and first 10 rows of the dataframe containing all of the NIPostcode data.
str(my_data)
head(my_data, 10)

# Show the total number and mean missing values of the NIPostcode data.
missing_vals <- sum(is.na(my_data))
missing_vals

nrow(my_data)
nrow(na.omit(my_data))

# Remove or replace missing entries with a suitable identifier. Decide whether it is best to remove missing data or to recode it.


# Add a suitable title to each attribute of the data.
cols <- c("Organisation_Name", "Sub-building_Name", "Building_Name", "Number", "Primary_Thorfare", "Alt_Thorfare", "Secondary_Thorfare", "Locality", "Townland", "Town", "County", "Postcode", "x-coordinates", "y-coordinates", "Primary_Key")
colnames(my_data) <- cols
head(my_data, 10)
str(my_data)

# Modify the County attribute to a categorising factor.
attach(my_data)
counties <- c("Antrim", "Armagh", "Derry", "Down", "Fermanagh", "Tyrone" )
categorised_county <- factor(County, levels = counties)
County <- categorised_county
str(my_data)


# Align all attributes and relevant data.


# Move the primary key identifier to the start of the dataset.


# Create a new dataset called Limavady_data. Store within it only information that has locality, townland and town containing the name “Limavady”. Store this information in an external csv file called Limavady.
limavady_data <- data.frame(my_data[Town == "LIMAVADY",])
head(limavady_data, 10)

# Save the modified dataset in a csv file called CleanNIPostcodeData.












