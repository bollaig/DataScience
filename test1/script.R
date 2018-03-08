# ASSIGNMENT
x <- 2
y <- 5
x
y
x <- 5
class(x)

#VECTORS
v <- c(10, 150, 30, 40, 55.6)
v
class(v)
v2 <- v + 2
v
v2

#MATRICES
r <- 3
c <- 2
m1 <- matrix(c(1, 2, 3, 4, 5, 6,7, 8, 9, 10, 11, 12), 3, 4, FALSE)
m2 <- matrix(c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12), 3, 4, TRUE)
m1
m2
m1[r, c]
m2[r, c]
m1[r,]
m2[r,]
m1[, c]
m2[, c]

#LISTS
a <- c(1, 2, 3)
a
x <- 2
x
b <- c('a', 'b', 'c')
c <- c(TRUE, FALSE, TRUE)
a
b
c
l <- list(a, b, c)
l
l[2]
l[1][1]
l[[1]][1]
l[[2]][2]
l[c(2, 3)]

install.packages("swirl")
library(swirl)
install_course_zip("C:/Users/user/Documents/Msc/swirl_courses-master.zip", multi = TRUE, which_course = "R Programming")
#install_course_zip("C:/Users/user/swirl_courses-master.zip", multi = TRUE, which_course = "R Programming")
swirl()

