
# Read CSV
location <- "C:/Users/user/Documents/Msc/Data Science/Files/Lotto/Lotto/2017.csv"
folder <- "C:/Users/user/Documents/Msc/Data Science/Files/Lotto/Lotto"

my_data = read.csv(location)
str(my_data)
head(my_data)

csv_file_list <- list.files(path = folder, pattern = "*.csv")
csv_file_list
class(csv_file_list)

Combine_Results <- function(filelist) {
    filelist

    for (file in filelist) {
        cat("looping-------------------------------looping")
        filename <- paste(folder, "/", file, sep = "")
        cat("fname ", filename)
        lotto_data_temp <- read.csv(filename, header = TRUE, stringsAsFactors = FALSE)
        lotto_data <- rbind(lotto_data, lotto_data_temp[2:9])
       
    }

    return(lotto_data)
}

lotto_data <- Combine_Results(csv_file_list)
lotto_data