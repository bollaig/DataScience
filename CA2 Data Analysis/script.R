install.packages("pwr")

library(pwr)
power_changes <- pwr.p.test(h = ES.h(p1 = .75, p2 = .5),
                            sig.level = .05, power = .8,
                            alternative = "greater")
plot(power_changes)
power_changes

#reduce sig level to 0.1 to ensure we didn't cause a type 1 error  
power_changes <- pwr.p.test(h = ES.h(p1 = .75, p2 = .5),
                            sig.level = .01, power = .8,
                            alternative = "greater")
plot(power_changes)
power_changes


#use n=40 and omit power to determine the power  
power_changes <- pwr.p.test(h = ES.h(p1 = .75, p2 = .5),
                            sig.level = .01, n = 40,
                            alternative = "greater")
plot(power_changes)
power_changes





#Omitting the alternative para defaults to a two-sided test (two sample proportion test)
power_changes <- pwr.p.test(h = ES.h(p1 = .75, p2 = .5),
                            sig.level = .01, n = 40)
plot(power_changes)
power_changes

#What if the loaded coin was suspected to be 65%
power_changes <- pwr.p.test(h = ES.h(p1 = .65, p2 = .5),
                            sig.level = .05, power = .8,
                            alternative = "greater")
plot(power_changes)
power_changes

#show effect size for different tests depending on size
effect_size <- cohen.ES(test = "r", size = "medium")
effect_size

effect_size <- cohen.ES(test = c("r"), size = c("medium"))
effect_size

#based on the cohen.ES results, get the values of the r test
pwr.r.test(r = effect_size$effect.size, power = .8, sig.level = .05)


#Use multiple effect.sizes in a single test
effect.sizes <- c(0.2, 0.5, 0.8)
power_changes <- pwr.p.test(h = effect.sizes, n = 20,
                            sig.level = .05,
                            alternative = "greater")
#plot(power_changes) can't plot three
power_changes

#H0: uF = uM 
#H1: uF < uM

power_changes <- pwr.2p.test(h = ES.h(p1 = .50, p2 = .55),
                            sig.level = .05, power = .8,
                            alternative = "less")
power_changes
#########################################################################
#########################################################################
#########################################################################

#--Read CSV------------------------------------------------------------------------
ReadFile <- function(infile, delim, df_name) {

   df_name = read.csv(infile, sep = delim)

}

fname = "C:/Users/user/Documents/Msc/Data Science/CA/CA1/age_group_gender__population.tsv"
age_group_gender = read.csv(fname, sep = "\t", header = FALSE)
        

head(age_group_gender)
str(age_group_gender)
nrow(age_group_gender)
ncol(age_group_gender)

cols <- c("Id", "Type", "Area", "Age", "Sex", "Count")
colnames(age_group_gender) <- cols

head(age_group_gender$what,1000)


fname = "C:/Users/user/Documents/Msc/Data Science/CA/CA1/gender_industry__persons_at_wo.tsv"
work = read.csv(fname, sep = "\t", header = FALSE)

cols <- c("Id", "Type", "Area", "Sex", "Sector", "Count", "Text")
colnames(work) <- cols

head(work)
nrow(work)
ncol(work)

fname = "C:/Users/user/Documents/Msc/Data Science/CA/CA1/internet__households.tsv"
net_households = read.csv(fname, sep = "\t", header = FALSE)
#ReadFile("C:/Users/user/Documents/Msc/Data Science/CA/CA1/internet__households.tsv", "\t", "net_households")

cols <- c("Id", "Type", "Area", "Connection_type", "Count", "Text")
colnames(net_households) <- cols

net_households <- lapply(net_households$Area, gsub, pattern = "", replacement = "u", fixed = TRUE)

head(net_households)
nrow(net_households)
ncol(net_households)



age_group_gender
work
net_households

locations <- c("Donegal", "South Dublin", "Dublin City", "Fingal")


#extract relevant age/gender data
age_data <- age_group_gender[age_group_gender$Area %in% locations, ]
head(age_data)
nrow(age_data)


#extract relevant work data
work_data <- work[work$Area %in% locations,]
head(work_data)
nrow(work_data)
unique(work_data$Sector)

#extract relevant net data
net_data <- net_households[net_households$Area %in% locations,]
head(net_data)
nrow(net_data)
unique(net_data$Connection_type)

dublin_locations <- c("South Dublin", "Dublin City", "Fingal")
age_data$Area <- age_data$Area[age_data$Area %in% dublin_locations] <- "Dublin"
net_data$Area <- net_data$Area[net_data$Area %in% dublin_locations] <- "Dublin"
work_data$Area <- work_data$Area[work_data$Area %in% dublin_locations] <- "Dublin"

head(net_data)
head(work_data)
head(age_data)