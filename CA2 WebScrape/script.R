#install.packages("rvest") 
library(rvest)


# Specify the url of the citypopulation website
url <- 'https://www.citypopulation.de/php/ireland.php'


# Read the HTML code from the website
web_page <- read_html(url)


#Extract html from website
area_data_html   <- html_nodes(web_page, '#tl > tbody > tr:nth-child(n) > td.rname')
status_data_html <- html_nodes(web_page, '#tl > tbody > tr:nth-child(n) > td.rstatus')
p1991_data_html  <- html_nodes(web_page, '#tl > tbody > tr:nth-child(n) > td.rpop.prio6')
p1996_data_html  <- html_nodes(web_page, '#tl > tbody > tr:nth-child(n) > td.rpop.prio5')
p2002_data_html  <- html_nodes(web_page, '#tl > tbody > tr:nth-child(n) > td.rpop.prio4')
p2006_data_html  <- html_nodes(web_page, '#tl > tbody > tr:nth-child(n) > td.rpop.prio3')
p2011_data_html  <- html_nodes(web_page, '#tl > tbody > tr:nth-child(n) > td.rpop.prio2')
p2016_data_html  <- html_nodes(web_page, '#tl > tbody > tr:nth-child(n) > td.rpop.prio1')


#Extract text from html
area_data   <- html_text(area_data_html)
status_data <- html_text(status_data_html)
p1991_data  <- html_text(p1991_data_html)
p1996_data  <- html_text(p1996_data_html)
p2002_data  <- html_text(p2002_data_html)
p2006_data  <- html_text(p2006_data_html)
p2011_data  <- html_text(p2011_data_html)
p2016_data  <- html_text(p2016_data_html)


#Remove the thousands separator
p1991_data <- gsub(',', '', p1991_data)
p1996_data <- gsub(',', '', p1996_data)
p2002_data <- gsub(',', '', p2002_data)
p2006_data <- gsub(',', '', p2006_data)
p2011_data <- gsub(',', '', p2011_data)
p2016_data <- gsub(',', '', p2016_data)


#Convert to integers
p1991_data <- as.numeric(p1991_data)
p1996_data <- as.numeric(p1996_data)
p2002_data <- as.numeric(p2002_data)
p2006_data <- as.numeric(p2006_data)
p2011_data <- as.numeric(p2011_data)
p2016_data <- as.numeric(p2016_data)


#Load a data frame
pop_stats <- data.frame(area = area_data, status = status_data, p1991  = p1991_data,
                                                                p1996  = p1996_data,
                                                                p2002  = p2002_data,
                                                                p2006  = p2006_data,
                                                                p2011  = p2011_data,
                                                                p2016  = p2016_data)
head(pop_stats)


#Display data frame information
summary(pop_stats)
str(pop_stats)
pop_stats


#Generate totals
p1991_total <- sum(pop_stats$p1991)
p1996_total <- sum(pop_stats$p1996)
p2002_total <- sum(pop_stats$p2002)
p2006_total <- sum(pop_stats$p2006)
p2011_total <- sum(pop_stats$p2011)
p2016_total <- sum(pop_stats$p2016)


#Show population trend
xaxis <- c('1991', '1996', '2002', '2006', '2011', '2016')
totals <- c(p1991_total, p1996_total, p2002_total, p2006_total, p2011_total, p2016_total)

plot(totals, type = 'b', xlab = 'Census Year', ylab = 'Population', xaxt = "n")
axis(1, at = 1:6, labels = xaxis)
