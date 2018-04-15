
#a) Amalgamate multiple .csv Files ####################################################################################

ReadFiles <- function(folder) {
    fullpath <- paste(folder, '/', folder, '-northern-ireland-street.csv', sep = '')
    new_data <- read.csv(fullpath)
    print(paste(folder, nrow(new_data)))

    return(new_data)
}


folders <- list.files(path = '.',)
folders

i <- 0
for (x in folders) {
    new_data <- ReadFiles(x)
    if (i == 0){
        AllNICrimeData <- new_data
    }
    else {
        AllNICrimeData <- rbind(AllNICrimeData, new_data)
    }
    i = i + 1
}

print(paste('Total Number of Rows ', nrow(AllNICrimeData)))
head(AllNICrimeData)
str(AllNICrimeData)
write.csv(AllNICrimeData, file = '2017-12/AllNICrimeData.csv', quote = FALSE, na = " ", row.names = FALSE)


#b) Remove a number of attributes #################################################################################

AllNICrimeData.bkup.b <- AllNICrimeData
#AllNICrimeData <- AllNICrimeData.bkup.b

#Remove CrimeID(1), Reported by(3) , Falls within(4), LSOA code(8), LSOA name(9), last outcome(11) and context(12).
drop_cols <- c(1, 3, 4, 8, 9, 11, 12)

AllNICrimeData <- subset(AllNICrimeData, select = -drop_cols)
str(AllNICrimeData)
head(AllNICrimeData)


#(c) Factorise the Crime.type attribute ###########################################################################

AllNICrimeData.bkup.c <- AllNICrimeData
#AllNICrimeData <- AllNICrimeData.bkup.c


#d) Remove 'On or near' & Flag Missing Values #####################################################################

attach(AllNICrimeData) # not woring for some reason

AllNICrimeData$Location <- sub('on or near ', '', AllNICrimeData$Location, ignore.case = TRUE)
AllNICrimeData$Location[AllNICrimeData$Location == ''] <- NA

str(AllNICrimeData)
head(AllNICrimeData)


#e) Lookup Postcode ###############################################################################################

GetMostCommon <- function(matches, unique_matches) { # get the mode of the matches vector
    # For each unique match, count (tabulate) the occurrences in the non-unique list and select the most frequent (max)
    result <- as.character(unique_matches[which.max(tabulate(match(matches, unique_matches)))])

    return (result)
}


FindAPoscode <- function(location, postcodes) {
    matches <- postcodes$Postcode[postcodes$Primary_Thorfare == location]  # find all matches for the location in the pastcodes dataframe
    unique_matches <- unique(matches)  # build a vector of unique results

    if (length(unique_matches) > 1) {  # only get the mode if there's more than one unique postcode
        result <- as.character(GetMostCommon(matches, unique_matches))
    } 
    else {
        if (length(unique_matches) == 1) {  # only one postcode found
            result <- as.character(unique_matches[1]) 
        }
        else { # no postcodes found for location
            result <- 'Not Found'
        }
    }

    return (result) 
}


postcodes <- read.csv('2017-12/CleanNIPostcodeData.csv') # load the cleaned postcode dataset
postcode_lookups <- vector(length = 0)  # pre-define for efficiency

for (x in 1:nrow(AllNICrimeData)) { # loop through all rows
    search_for <- toupper(AllNICrimeData$Location[x])  # take each location one by one
    
    if (is.na(search_for) == FALSE & x < 10000) {  # exclude NA locations from lookup
        if (x%%100 == 0) {
            print(paste('progress if   ', x))  # this indicates that something is happening, whatever it might be!
        }
        answer <- as.character(find_a_postcode(search_for, postcodes))
        postcode_lookups <- c(postcode_lookups, answer)  # append new result to existing ones
    }
    else {
        if (x %% 1000 == 0) {
            print(paste('progress else   ', x))
        }
        postcode_lookups <- c(postcode_lookups, NA)  # this ensures postcode_lookups has an element for each location row (ie. rows will sync)
    }
}

postcodes_df <- data.frame(postcode_lookups) # create data frame from results vector

str(postcodes_df)
head(postcodes_df, 10)
write.csv(postcodes_df, file = '2017-12/postcodes_df.csv', quote = FALSE, na = " ", row.names = FALSE)




#f) Append postcode ###############################################################################################
AllNICrimeData.bkup.e <- AllNICrimeData

AllNICrimeData <- cbind(AllNICrimeData, postcodes_df)  # apend new column to the right of the existing attributes

head(AllNICrimeData, 10)
tail(AllNICrimeData, 10)
str(AllNICrimeData)



#g) Approximate Location ###############################################################################################

TidyLocation <- function(lat, lon, precision) {
    # Use the adjsted coordinates to find a similar location, ignore NA locations
    # Adjust the coordinates for the good rows in the same manner as was done for the search terms, otherwise they'd never match
    similar <- as.character(AllNICrimeData$Location[which(!is.na(AllNICrimeData$Location) &
                                                  (trunc(AllNICrimeData$Latitude * 10 ^ precision) / (10 ^ precision)) == lat & #  drop the lsd
                                                   (trunc(AllNICrimeData$Longitude * 10 ^ precision) / (10 ^ precision)) == lon)])

    return (similar)
}


for (i in 1:10000) {                            # limit to the first 10,000
    if (is.na(AllNICrimeData$Location[i])){     # only interested in missing values
        lon <- AllNICrimeData$Longitude[i]      # initial search coordinates are the originals
        lat <- AllNICrimeData$Latitude[i]

        precision <- 6                          # after each unsuccessful test the precision will be reduced by 1 (least significant digit (lsd) removed)
        found <- FALSE

        while (!isTRUE(found) & precision > 1) {  # keep going until a match is found or the precision is so poor the result is meaningless                                                   
            similar <- TidyLocation(lat, lon, precision)  # search for matches
            if (length(similar) > 0) {  # if at least one was found
                found <- TRUE  # stop the loop
                AllNICrimeData$Location[i] <- similar[1]  # use the first match found to value the new location
            }
            else {
                precision <- precision - 1                       # reduce the precision for the next pass
                lon <- (trunc(lon*10^precision))/(10^precision)  # drop the lsd (e.g. 123.4567 * 10^3 = 123456.7, trunc = 123456, 123456 / 10^3 = 123.456)
                lat <- (trunc(lat*10^precision))/(10^precision)
            }
        }
    }
}


head(AllNICrimeData, 10)
str(AllNICrimeData)

#i) Write csv ####################################################################################################

write.csv(postcodes_df, file = '2017-12/FinalNICrimeData.csv', quote = FALSE, na = " ", row.names = FALSE)


#j) (More) Places to avoid in Strabane #############################################################################

strabane_data <- with(AllNICrimeData, AllNICrimeData[grepl('bt82', postcode_lookups, ignore.case = TRUE) |
                                                     grepl('place', Location, ignore.case = TRUE),])
head(strabane_data, 10)
str(strabane_data)

