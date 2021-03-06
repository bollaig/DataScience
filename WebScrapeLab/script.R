# Example of a detailed web scrape from IMDB.com
install.packages("rvest")

library(rvest)

# Specifying url of website to be scrapped
url <- 'https://www.imdb.com/search/title?release_date=2017-01-01.2017-12-31'

# Reading the HTML code from the website
web_page <- read_html(url)
# Quick look at the contents of web_page
head(web_page)
str(web_page)


# Using CSS selectors to scrap the �rankings� section - IMDB site is 
# examined for this information first

rank_data_html <- html_nodes(web_page, '#main > div > div > div.lister-list > div:nth-child(n) > div.lister-item-content > h3 > span.lister-item-index.unbold.text-primary')

head(rank_data_html, 10)
# should have 250 records
length(rank_data_html)


# Converting the ranking data from HTML to text
rank_data <- html_text(rank_data_html)

# Let's have a look at the rankings data
head(rank_data, 10)

# Data-Preprocessing: Converting rankings from string to numeric
rank_data <- as.numeric(rank_data)

# Let's have another look at the rankings data
head(rank_data, 10)



# Scrape the title section using the HTML data
# copied from "Copy selector"
title_data_html <- html_nodes(web_page, '#main > div > div > div.lister-list > div:nth-child(n) > div.lister-item-content > h3 > a')

# Converting the title section data to text
title_data <- html_text(title_data_html)

# Let's have a look at the title
head(title_data, 10)


# Scrape the description section
description_data_html <- html_nodes(web_page, '#main > div > div > div.lister-list > div:nth-child(n) > div.lister-item-content > p:nth-child(4)')
description_data <- html_text(description_data_html)
# Examine the description data
head(description_data, 10)
# Converting the description data to text
description_data <- html_text(description_data_html)


> head(description_data, 10)

# Tidy the decription data to remove the "\n" control character
# using gsub() function. Replaces all matches of a string
# with a string vector of same length
description_data <- gsub("\n", "", description_data)
head(description_data, 10)


# Alternatively we can scrape all of the text from the description section
# and then use gsub to remove unneeded portions of text

# Delete all text with punctuation included
# See http://www.endmemo.com/program/R/gsub.php for details
description_data <- gsub("[[:punct:]]", "", description_data)

# Delete all text with "Votes"
description_data <- gsub("Votes", "", description_data)

# Delete all text with "201*"
description_data <- gsub("201.*", "", description_data)

# Delete all text with "Gross"
description_data <- gsub("Gross", "", description_data)

# Delete all text with a number in it - eg PG12A
description_data <- gsub(".*[0-9]", "", description_data)

description_data <- gsub(".* min ", "", description_data)

description_data <- description_data[description_data == ""] <- NA


# Using CSS selectors to scrape the Movie runtime section
runtime_data_html <- html_nodes(web_page, '#main > div > div > div.lister-list > div:nth-child(n) > div.lister-item-content > p:nth-child(2) > span.runtime')

# Converting the runtime data to text
runtime_data <- html_text(runtime_data_html)

# Let's have a look at the runtime
head(runtime_data, 10)
title_data
runtime_data

# "min" text inside running time values are going to be a problem
# Remove it using gsub function. And convert it using the as.numeric convertor
runtime_data <- gsub(" min", "", runtime_data)
runtime_data <- as.numeric(runtime_data)

#Let's have another look at the runtime data
head(runtime_data, 10)



# Using CSS selectors to scrape the Movie genre section
genre_data_html <- html_nodes(web_page, '#main > div > div > div.lister-list > div:nth-child(n) > div.lister-item-content > p:nth-child(2) > span.genre')

# Converting the genre data to text
genre_data <- html_text(genre_data_html)

# Let's have a look at the genre data
head(genre_data, 10)

# We need to tidy the genre data to remove "\n" control character
# and to remove additional spaces after each ",� Do this using gsub() function
genre_data <- gsub("\n", "", genre_data)

# Data-Preprocessing: removing excess spaces found at the end of the genre data
genre_data <- gsub(" ", "", genre_data)

head(genre_data, 10)


# Using CSS selectors to scrape the Movie genre section
genre_data_html <- html_nodes(web_page, '#main > div > div > div.lister-list > div:nth-child(n) > div.lister-item-content > p:nth-child(2) > span.genre')

# Converting the genre data to text
genre_data <- html_text(genre_data_html)

# Let's have a look at the genre data
head(genre_data, 10)

# We need to tidy the genre data to remove "\n" control character
# and to remove additional spaces after each ",� Do this using gsub() function
genre_data <- gsub("\n", "", genre_data)

# Data-Preprocessing: removing excess spaces found at the end of the genre data
genre_data <- gsub(" ", "", genre_data)


head(genre_data, 10)


# There are multiple genres for each film.
# We only need to have the first genre so we can use gsub() and a wildcard to remove
# all text after the first comma
genre_data <- gsub(",.*", "", genre_data)

# Now let's examine the genre_data
head(genre_data, 10)

# Scraping the IMDB rating section
rating_data_html <- html_nodes(web_page, '#main > div > div > div.lister-list > div:nth-child(n) > div.lister-item-content > div > div.inline-block.ratings-imdb-rating > strong')

# Converting the ratings data to text
rating_data <- html_text(rating_data_html)

# Data-Preprocessing: converting ratings to numerical values
rating_data <- as.numeric(rating_data)

# Let's have another look at the ratings data
head(rating_data, 10)
length(rating_data)

# Scraping the directors section
directors_data_html <- html_nodes(web_page, '#main > div > div > div.lister-list > div:nth-child(n) > div.lister-item-content > p:nth-child(5)')

#Converting the directors data to text
directors_data <- html_text(directors_data_html)

#Let's have a look at the directors data
head(directors_data, 10)

#Data-Preprocessing: converting directors data into factors
directors_data <- as.factor(directors_data)
# Check the length of the directors data
length(directors_data)


# Scraping the actors section
actors_data_html <- html_nodes(web_page, '#main > div > div > div.lister-list > div:nth-child(n) > div.lister-item-content > p:nth-child(5) > a:nth-child(3)')

# Converting the gross actors data to text
actors_data <- html_text(actors_data_html)

# Let's have a look at the actors data
head(actors_data, 10)

# Data-Preprocessing: convert the actors data into factors
actors_data <- as.factor(actors_data)
length(actors_data)

# Scrape the metascore section
metascore_data_html <- html_nodes(web_page, '#main > div > div > div.lister-list > div:nth-child(n) > div.lister-item-content > div > div.inline-block.ratings-metascore > span')

#Converting the data to text
metascore_data <- html_text(metascore_data_html)

#Let's have a look at the metascore 
head(metascore_data, 10)
# Problem with the metascore data length
length(metascore_data)

# Data-Preprocessing: removing extra space in metascore data
metascore_data <- gsub(" ", "", metascore_data)
head(metascore_data, 100)


# Data should contain 250 values (50 movies)
length(metascore_data)
summary(metascore_data)

# Through analysis, this data is missing
missing_data <- c(1, 4, 6, 10, 16, 17, 23, 25, 29, 33, 37, 43, 47, 49, 50, 52, 57:59, 64:66, 73, 74, 77, 78, 83, 85, 87, 89:91, 94, 95, 97, 100, 103, 105112, 113, 115, 117, 118, 120:122, 130, 136:138, 141, 147, 149, 152, 158:160, 162, 164:166, 169, 170, 173, 178, 183, 184, 189, 193, 197:199, 205:207, 209:212, 220:222, 225, 227, 228, 231, 233, 235, 240, 241, 247, 249)

length(missing_data)

metascore_data <- replace_missing_data(metascore_data, missing_data)
head(metascore_data, 10)
str(metascore_data)


# Scrape the gross revenue section
gross_data_html <- html_nodes(web_page, '#main > div > div > div.lister-list > div:nth-child(n) > div.lister-item-content > p.sort-num_votes-visible > span:nth-child(5)')

#Converting the gross revenue data to text
gross_data <- html_text(gross_data_html)

#Let's have a look at the gross data
head(gross_data, 10)
length(gross_data)

# Data-Preprocessing: removing 'M' sign
gross_data <- gsub("M", "", gross_data)
head(gross_data, 10)

# Data-Preprocessing: removing '$' sign with substring
gross_data <- substring(gross_data, 2, 7)

#Let's check the length of gross data
# Should be 50 - lots of data missing
length(gross_data)
summary(gross_data)

# Data-Preprocessing: converting gross to numerical
gross_data <- as.numeric(gross_data)


# Now lets combine all of the vectors into a data frame
length(rank_data)
length(title_data)
length(description_data)
length(genre_data)
length(runtime_data)
runtime_data[50] <- 0

movies <- data.frame(rank = rank_data, Title = title_data, Desc = description_data, Genre = genre_data, Runtime = runtime_data)
head(movies, 60)
length(description_data)
summary(movies)
str(movies)
movies
