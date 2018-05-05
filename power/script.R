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
power_changes <- pwr.p.test(h = effect.sizes, n=20,
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